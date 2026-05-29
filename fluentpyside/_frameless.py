import ctypes
from ctypes import wintypes
import sys

from PySide6.QtCore import QAbstractNativeEventFilter, QByteArray
from PySide6.QtGui import QGuiApplication
from PySide6.QtQuick import QQuickWindow

_is_win = sys.platform == "win32"

if _is_win:
    user32 = ctypes.windll.user32

    WM_NCCALCSIZE = 0x0083
    WM_NCHITTEST = 0x0084
    WM_SYSCOMMAND = 0x0112
    WM_GETMINMAXINFO = 0x0024

    WS_CAPTION = 0x00C00000
    WS_THICKFRAME = 0x00040000

    SW_MAXIMIZE = 3

    class MINMAXINFO(ctypes.Structure):
        _fields_ = [
            ("ptReserved", wintypes.POINT),
            ("ptMaxSize", wintypes.POINT),
            ("ptMaxPosition", wintypes.POINT),
            ("ptMinTrackSize", wintypes.POINT),
            ("ptMaxTrackSize", wintypes.POINT),
        ]

    class PWINDOWPOS(ctypes.Structure):
        _fields_ = [
            ("hWnd", wintypes.HWND),
            ("hwndInsertAfter", wintypes.HWND),
            ("x", ctypes.c_int),
            ("y", ctypes.c_int),
            ("cx", ctypes.c_int),
            ("cy", ctypes.c_int),
            ("flags", wintypes.UINT),
        ]

    class NCCALCSIZE_PARAMS(ctypes.Structure):
        _fields_ = [("rgrc", wintypes.RECT * 3), ("lppos", ctypes.POINTER(PWINDOWPOS))]

    class APPBARDATA(ctypes.Structure):
        _fields_ = [
            ("cbSize", wintypes.UINT),
            ("hWnd", wintypes.HWND),
            ("uCallbackMessage", wintypes.UINT),
            ("uEdge", wintypes.UINT),
            ("rc", wintypes.RECT),
            ("lParam", wintypes.LPARAM),
        ]

    class MONITORINFO(ctypes.Structure):
        _fields_ = [
            ("cbSize", wintypes.DWORD),
            ("rcMonitor", wintypes.RECT),
            ("rcWork", wintypes.RECT),
            ("dwFlags", wintypes.DWORD),
        ]

    DWMWA_USE_IMMERSIVE_DARK_MODE = 20
    DWMWA_NCRENDERING_POLICY = 2
    DWMNCRENDERINGPOLICY_ENABLED = 2
    DWMWA_WINDOW_CORNER_PREFERENCE = 33
    DWMWCP_DEFAULT = 0
    DWMWCP_DONOTROUND = 1
    DWMWCP_ROUND = 2
    DWMWCP_ROUNDSMALL = 3
    DWMWA_SYSTEMBACKDROP_TYPE = 38
    DWMSBT_NONE = 1
    DWMSBT_MAINWINDOW = 2
    DWMSBT_TRANSIENTWINDOW = 3
    DWMSBT_TABBEDWINDOW = 4

    def _is_win11() -> bool:
        try:
            return sys.getwindowsversion().build >= 22000
        except Exception:
            return False

    def _apply_dwm_effects(hwnd: int, dark: bool = False):
        dwm = ctypes.windll.dwmapi
        ncrp = ctypes.c_int(DWMNCRENDERINGPOLICY_ENABLED)
        dwm.DwmSetWindowAttribute(
            hwnd,
            DWMWA_NCRENDERING_POLICY,
            ctypes.byref(ncrp),
            ctypes.sizeof(ncrp),
        )
        if _is_win11():
            corner = ctypes.c_int(DWMWCP_ROUND)
            dwm.DwmSetWindowAttribute(
                hwnd,
                DWMWA_WINDOW_CORNER_PREFERENCE,
                ctypes.byref(corner),
                ctypes.sizeof(corner),
            )
            dark_val = ctypes.c_int(1 if dark else 0)
            dwm.DwmSetWindowAttribute(
                hwnd,
                DWMWA_USE_IMMERSIVE_DARK_MODE,
                ctypes.byref(dark_val),
                ctypes.sizeof(dark_val),
            )

    def _is_composition_enabled() -> bool:
        result = ctypes.c_int(0)
        ctypes.windll.dwmapi.DwmIsCompositionEnabled(ctypes.byref(result))
        return bool(result.value)

    def _is_maximized(hwnd: int) -> bool:
        try:
            from win32gui import GetWindowPlacement

            placement = GetWindowPlacement(hwnd)
            return placement[1] == SW_MAXIMIZE
        except Exception:
            return False

    def _get_resize_border(hwnd: wintypes.HWND, horizontal: bool = True) -> int:
        import win32con

        frame = win32con.SM_CXSIZEFRAME if horizontal else win32con.SM_CYSIZEFRAME
        try:
            from win32api import GetSystemMetrics

            result = GetSystemMetrics(frame) + GetSystemMetrics(92)
            if result > 0:
                return result
        except Exception:
            pass
        thickness = 8 if _is_composition_enabled() else 4
        try:
            windows = QGuiApplication.topLevelWindows()
            for w in windows:
                if w and int(w.winId()) == hwnd:
                    return round(thickness * w.devicePixelRatio())
        except Exception:
            pass
        return thickness


class FramelessFilter(QAbstractNativeEventFilter):
    def __init__(self, windows: list):
        super().__init__()
        self.windows = windows
        self.hwnds = {}
        self.resize_border = 8

        for window in self.windows:
            window.visibleChanged.connect(
                lambda visible, w=window: self._on_visible_changed(visible, w)
            )
            if window.isVisible():
                self._init_window_handle(window)

    def _on_visible_changed(self, visible: bool, window: QQuickWindow):
        if visible and self.hwnds.get(window) is None:
            self._init_window_handle(window)

    def _init_window_handle(self, window: QQuickWindow):
        hwnd = int(window.winId())
        self.hwnds[window] = hwnd
        self._apply_frame(hwnd)

    def _apply_frame(self, hwnd: int):
        style = user32.GetWindowLongPtrW(hwnd, -16)
        style |= WS_CAPTION | WS_THICKFRAME
        user32.SetWindowLongPtrW(hwnd, -16, style)
        user32.SetWindowPos(hwnd, 0, 0, 0, 0, 0, 0x0002 | 0x0001 | 0x0040)

        _apply_dwm_effects(hwnd)

    def nativeEventFilter(self, event_type: QByteArray, message):
        if not _is_win or event_type != b"windows_generic_MSG":
            return False, 0

        try:
            message_addr = int(message)
        except Exception:
            buf = memoryview(message)
            message_addr = ctypes.addressof(ctypes.c_char.from_buffer(buf))

        hwnd = ctypes.c_void_p.from_address(message_addr).value
        message_id = wintypes.UINT.from_address(
            message_addr + ctypes.sizeof(ctypes.c_void_p)
        ).value
        w_param = wintypes.WPARAM.from_address(
            message_addr + 2 * ctypes.sizeof(ctypes.c_void_p)
        ).value
        l_param = wintypes.LPARAM.from_address(
            message_addr + 3 * ctypes.sizeof(ctypes.c_void_p)
        ).value

        for window in self.windows:
            hwnd_window = self.hwnds.get(window)
            if hwnd_window != hwnd:
                continue

            if message_id == WM_NCHITTEST:
                x = ctypes.c_short(l_param & 0xFFFF).value
                y = ctypes.c_short((l_param >> 16) & 0xFFFF).value

                rect = wintypes.RECT()
                user32.GetWindowRect(hwnd_window, ctypes.byref(rect))
                left, top, right, bottom = (
                    rect.left,
                    rect.top,
                    rect.right,
                    rect.bottom,
                )
                border = self.resize_border

                if left <= x < left + border:
                    if top <= y < top + border:
                        return True, 13
                    if bottom - border <= y < bottom:
                        return True, 16
                    return True, 10
                if right - border <= x < right:
                    if top <= y < top + border:
                        return True, 14
                    if bottom - border <= y < bottom:
                        return True, 17
                    return True, 11
                if top <= y < top + border:
                    return True, 12
                if bottom - border <= y < bottom:
                    return True, 15

                return False, 0

            if message_id == WM_NCCALCSIZE and w_param:
                client_rect = ctypes.cast(
                    l_param, ctypes.POINTER(NCCALCSIZE_PARAMS)
                ).contents.rgrc[0]
                if _is_maximized(hwnd):
                    ty = _get_resize_border(hwnd, False)
                    client_rect.top += ty
                    client_rect.bottom -= ty
                    tx = _get_resize_border(hwnd, True)
                    client_rect.left += tx
                    client_rect.right -= tx
                    try:
                        from win32com.shell.shellcon import ABM_GETSTATE, ABS_AUTOHIDE

                        abd = APPBARDATA()
                        ctypes.memset(ctypes.byref(abd), 0, ctypes.sizeof(abd))
                        abd.cbSize = ctypes.sizeof(APPBARDATA)
                        taskbar_state = ctypes.windll.shell32.SHAppBarMessage(
                            ABM_GETSTATE, ctypes.byref(abd)
                        )
                        if taskbar_state & ABS_AUTOHIDE:
                            try:
                                from win32gui import FindWindow
                                from win32api import MonitorFromWindow
                                from win32con import (
                                    MONITOR_DEFAULTTONEAREST,
                                    MONITOR_DEFAULTTOPRIMARY,
                                )

                                abd2 = APPBARDATA()
                                ctypes.memset(
                                    ctypes.byref(abd2), 0, ctypes.sizeof(abd2)
                                )
                                abd2.cbSize = ctypes.sizeof(APPBARDATA)
                                abd2.hWnd = FindWindow("Shell_TrayWnd", None)
                                if abd2.hWnd:
                                    window_monitor = MonitorFromWindow(
                                        hwnd, MONITOR_DEFAULTTONEAREST
                                    )
                                    taskbar_monitor = MonitorFromWindow(
                                        abd2.hWnd, MONITOR_DEFAULTTOPRIMARY
                                    )
                                    if (
                                        taskbar_monitor
                                        and taskbar_monitor == window_monitor
                                    ):
                                        from win32com.shell.shellcon import (
                                            ABM_GETTASKBARPOS,
                                        )

                                        ctypes.windll.shell32.SHAppBarMessage(
                                            ABM_GETTASKBARPOS, ctypes.byref(abd2)
                                        )
                                        edge = abd2.uEdge
                                        if edge == 1:
                                            client_rect.top += 1
                                        elif edge == 3:
                                            client_rect.bottom -= 1
                                        elif edge == 0:
                                            client_rect.left += 1
                                        elif edge == 2:
                                            client_rect.right -= 1
                                        else:
                                            client_rect.bottom -= 1
                            except Exception:
                                client_rect.bottom -= 1
                    except ImportError:
                        pass
                return True, 0

            if message_id == WM_SYSCOMMAND:
                return False, 0

            if message_id == WM_GETMINMAXINFO:
                monitor = user32.MonitorFromWindow(hwnd_window, 2)
                monitor_info = MONITORINFO()
                monitor_info.cbSize = ctypes.sizeof(MONITORINFO)
                monitor_info.dwFlags = 0
                user32.GetMonitorInfoW(monitor, ctypes.byref(monitor_info))

                minmax_info = MINMAXINFO.from_address(l_param)

                minmax_info.ptMaxPosition.x = (
                    monitor_info.rcWork.left - monitor_info.rcMonitor.left
                )
                minmax_info.ptMaxPosition.y = (
                    monitor_info.rcWork.top - monitor_info.rcMonitor.top
                )
                minmax_info.ptMaxSize.x = (
                    monitor_info.rcWork.right - monitor_info.rcMonitor.left
                )
                minmax_info.ptMaxSize.y = (
                    monitor_info.rcWork.bottom - monitor_info.rcMonitor.top
                )

                def _get_int(window, name, default):
                    val = getattr(window, name, default)
                    if callable(val):
                        val = val()
                    if val is None:
                        val = default
                    return int(val)

                screen = window.screen()
                dp_ratio = screen.devicePixelRatio() if screen else 1.0

                min_w = int(_get_int(window, "minimumWidth", 0) * dp_ratio)
                min_h = int(_get_int(window, "minimumHeight", 0) * dp_ratio)
                max_w = int(
                    _get_int(
                        window,
                        "maximumWidth",
                        monitor_info.rcWork.right - monitor_info.rcWork.left,
                    )
                    * dp_ratio
                )
                max_h = int(
                    _get_int(
                        window,
                        "maximumHeight",
                        monitor_info.rcWork.bottom - monitor_info.rcWork.top,
                    )
                    * dp_ratio
                )

                minmax_info.ptMinTrackSize.x = min_w
                minmax_info.ptMinTrackSize.y = min_h
                minmax_info.ptMaxTrackSize.x = max_w
                minmax_info.ptMaxTrackSize.y = max_h

                return True, 0

        return False, 0


def make_frameless(windows: list):
    if not _is_win:
        return None
    if isinstance(windows, QQuickWindow):
        windows = [windows]
    f = FramelessFilter(windows)
    QGuiApplication.instance().installNativeEventFilter(f)
    return f
