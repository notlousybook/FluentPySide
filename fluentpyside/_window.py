from __future__ import annotations

import ctypes
import sys

from PySide6.QtCore import QObject, Slot


_is_win = sys.platform == "win32"

if _is_win:
    user32 = ctypes.windll.user32
    WM_SYSCOMMAND = 0x0112
    SC_RESTORE = 0xF120
    SC_MAXIMIZE = 0xF030
    SC_MINIMIZE = 0xF020
    HTCAPTION = 0x2
    SW_MAXIMIZE = 3
    SW_RESTORE = 9

    def _is_maximized(hwnd: int) -> bool:
        try:
            from win32gui import GetWindowPlacement

            placement = GetWindowPlacement(hwnd)
            return placement[1] == SW_MAXIMIZE
        except Exception:
            rc = ctypes.wintypes.RECT()
            user32.GetWindowRect(hwnd, ctypes.byref(rc))
            mi = ctypes.wintypes.RECT()
            mi_cb = ctypes.wintypes.DWORD(ctypes.sizeof(mi))
            monitor = user32.MonitorFromWindow(hwnd, 2)
            user32.GetMonitorInfoW(monitor, ctypes.byref(mi))
            work_w = mi.right - mi.left
            work_h = mi.bottom - mi.top
            win_w = rc.right - rc.left
            win_h = rc.bottom - rc.top
            return win_w >= work_w and win_h >= work_h


class WindowManager(QObject):
    @Slot(object)
    def sendDragEvent(self, window):
        if not _is_win or window is None:
            if window is not None:
                window.startSystemMove()
            return
        try:
            hwnd = int(window.winId())
            user32.ReleaseCapture()
            user32.SendMessageW(hwnd, WM_SYSCOMMAND, SC_RESTORE | HTCAPTION, 0)
        except Exception:
            try:
                window.startSystemMove()
            except Exception:
                pass

    @Slot(object)
    def maximizeWindow(self, window):
        if window is None:
            return
        if not _is_win:
            if window.visibility == 2:
                window.showNormal()
            else:
                window.showMaximized()
            return
        try:
            hwnd = int(window.winId())
            if _is_maximized(hwnd):
                user32.ShowWindow(hwnd, SW_RESTORE)
            else:
                user32.ShowWindow(hwnd, SW_MAXIMIZE)
        except Exception:
            if window.visibility == 2:
                window.showNormal()
            else:
                window.showMaximized()
