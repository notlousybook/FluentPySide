from __future__ import annotations

import ctypes
import sys
from typing import TYPE_CHECKING, Optional

if TYPE_CHECKING:
    from PySide6.QtWidgets import QWidget

_mica_available = False

_DWMWA_SYSTEMBACKDROP_TYPE = 38
_DWMSBT_MAINWINDOW = 2
_DWMSBT_AUTO = 0
_DWMWA_USE_IMMERSIVE_DARK_MODE = 20
_DWMWA_WINDOW_CORNER_PREFERENCE = 33
_DWMWCP_ROUND = 2
_DWMWA_NCRENDERING_POLICY = 2
_DWMNCRENDERINGPOLICY_ENABLED = 2

try:
    import pywinstyles

    _mica_available = True
except ImportError:
    pywinstyles = None


def apply_mica(window: "QWidget", dark: bool = False) -> bool:
    hwnd = _get_hwnd(window)
    if hwnd and _is_win11():
        _set_dark_mode(hwnd, dark)
        if _apply_dwm_backdrop(hwnd, _DWMSBT_MAINWINDOW):
            return True

    if _mica_available and _is_win11():
        try:
            pywinstyles.apply_style(window, "mica")
            if dark:
                pywinstyles.apply_style(window, "dark")
            return True
        except Exception:
            pass

    return False


def apply_acrylic(window: "QWidget", dark: bool = False) -> bool:
    hwnd = _get_hwnd(window)
    if hwnd and _is_win11():
        _set_dark_mode(hwnd, dark)
        from ctypes import c_int

        backdrop_type = c_int(3)  # DWMSBT_TRANSIENTWINDOW = 3
        try:
            ctypes.windll.dwmapi.DwmSetWindowAttribute(
                ctypes.c_void_p(hwnd),
                _DWMWA_SYSTEMBACKDROP_TYPE,
                ctypes.byref(backdrop_type),
                ctypes.sizeof(backdrop_type),
            )
            return True
        except Exception:
            pass

    if _mica_available and _is_win11():
        try:
            pywinstyles.apply_style(window, "acrylic")
            if dark:
                pywinstyles.apply_style(window, "dark")
            return True
        except Exception:
            pass

    return False


def remove_backdrop(window: "QWidget") -> bool:
    hwnd = _get_hwnd(window)
    if hwnd and _is_win11():
        try:
            value = ctypes.c_int(_DWMSBT_AUTO)
            ctypes.windll.dwmapi.DwmSetWindowAttribute(
                ctypes.c_void_p(hwnd),
                _DWMWA_SYSTEMBACKDROP_TYPE,
                ctypes.byref(value),
                ctypes.sizeof(value),
            )
            return True
        except Exception:
            pass
    return False


def change_header_color(window: "QWidget", color: str) -> bool:
    if not _mica_available:
        return False
    try:
        pywinstyles.change_header_color(window, color)
        return True
    except Exception:
        return False


def change_title_color(window: "QWidget", color: str) -> bool:
    if not _mica_available:
        return False
    try:
        pywinstyles.change_title_color(window, color)
        return True
    except Exception:
        return False


def get_accent_color() -> Optional[str]:
    if not _mica_available:
        return None
    try:
        return pywinstyles.get_accent_color()
    except Exception:
        return None


def _is_win11() -> bool:
    if sys.platform != "win32":
        return False
    try:
        return sys.getwindowsversion().build >= 22000
    except Exception:
        return False


def _get_hwnd(window: "QWidget") -> int | None:
    if window is None:
        return None
    if isinstance(window, int):
        return window
    if hasattr(window, "winId"):
        try:
            return int(window.winId())
        except Exception:
            return None
    return None


def _apply_dwm_backdrop(hwnd: int, backdrop_type: int) -> bool:
    try:
        ncrp = ctypes.c_int(_DWMNCRENDERINGPOLICY_ENABLED)
        ctypes.windll.dwmapi.DwmSetWindowAttribute(
            ctypes.c_void_p(hwnd),
            _DWMWA_NCRENDERING_POLICY,
            ctypes.byref(ncrp),
            ctypes.sizeof(ncrp),
        )

        value = ctypes.c_int(backdrop_type)
        ctypes.windll.dwmapi.DwmSetWindowAttribute(
            ctypes.c_void_p(hwnd),
            _DWMWA_SYSTEMBACKDROP_TYPE,
            ctypes.byref(value),
            ctypes.sizeof(value),
        )

        corner_pref = ctypes.c_int(_DWMWCP_ROUND)
        ctypes.windll.dwmapi.DwmSetWindowAttribute(
            ctypes.c_void_p(hwnd),
            _DWMWA_WINDOW_CORNER_PREFERENCE,
            ctypes.byref(corner_pref),
            ctypes.sizeof(corner_pref),
        )

        return True
    except Exception:
        return False


def _set_dark_mode(hwnd: int, dark: bool) -> bool:
    try:
        value = ctypes.c_int(1 if dark else 0)
        ctypes.windll.dwmapi.DwmSetWindowAttribute(
            ctypes.c_void_p(hwnd),
            _DWMWA_USE_IMMERSIVE_DARK_MODE,
            ctypes.byref(value),
            ctypes.sizeof(value),
        )
        return True
    except Exception:
        return False


__all__ = [
    "apply_mica",
    "apply_acrylic",
    "remove_backdrop",
    "change_header_color",
    "change_title_color",
    "get_accent_color",
]
