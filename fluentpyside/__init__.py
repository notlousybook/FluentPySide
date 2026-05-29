"""fluentpyside public API

One-liner to enable the FluentWinUI3 theme in PySide6 apps,
plus FluentControls module for custom Fluent Design components.
"""

from __future__ import annotations

import sys
from pathlib import Path
from typing import Optional, TYPE_CHECKING

from ._installer import install_assets, find_installed_style, default_style_path
from ._loader import set_style
if TYPE_CHECKING:
    from ._theme import ThemeManager
    from ._window import WindowManager

_theme_manager: Optional["ThemeManager"] = None
_window_manager: Optional["WindowManager"] = None
_frameless_filter = None


def apply(
    accent_color: Optional[str] = None,
    theme: Optional[str] = None,
) -> str:
    """Convenience one-liner to enable the FluentWinUI3 theme.

    - Finds the FluentWinUI3 QML import tree (prefers package-local copy,
      falls back to an installed PySide6 location)
    - Adds the QML import path and attempts to set QQuickStyle to "FluentWinUI3"
    - Also registers the FluentControls module import path

    Args:
        accent_color: Optional hex color string for the accent (e.g. "#605ed2").
        theme: Optional theme mode: "dark", "light", or "auto" (default).

    Returns the path used for the FluentWinUI3 style (string).
    """
    global _theme_manager, _window_manager

    from ._theme import ThemeManager
    from ._window import WindowManager

    p = default_style_path()
    if not p.exists():
        found = find_installed_style()
        if found:
            p = found

    try:
        set_style(path=p)
    except Exception:
        pass

    _theme_manager = ThemeManager()
    _window_manager = WindowManager()

    if accent_color:
        _theme_manager.setAccentColor(accent_color)
    if theme and theme in ("dark", "light", "auto"):
        _theme_manager.setTheme(theme)

    return str(p)


def theme_manager() -> Optional[ThemeManager]:
    return _theme_manager


def window_manager() -> Optional[WindowManager]:
    return _window_manager


def controls_path() -> str:
    p = Path(__file__).parent / "FluentControls"
    return str(p)


def setup_windows(engine) -> None:
    """Install the native frameless filter and DWM effects on all Fluent windows.

    Call this after engine.load() has succeeded and root objects are available.
    """
    global _frameless_filter
    if engine is None or sys.platform != "win32":
        return
    try:
        import ctypes
        from PySide6.QtQuick import QQuickWindow
        from ._frameless import make_frameless

        roots = engine.rootObjects()
        if not roots:
            return
        all_windows = []
        for root in roots:
            all_windows.append(root)
            all_windows.extend(root.findChildren(QQuickWindow))
        fluent_windows = [w for w in all_windows if w.property("isFluentWindow")]
        if fluent_windows:
            _frameless_filter = make_frameless(fluent_windows)
            user32 = ctypes.windll.user32
            for w in fluent_windows:
                if not w.isVisible():
                    w.setVisible(True)
                hwnd = int(w.winId())
                user32.SetWindowPos(
                    hwnd,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0x0002 | 0x0001 | 0x0040 | 0x0020,
                )
    except Exception:
        pass


def register_context(engine) -> None:
    if engine is None:
        return
    if _theme_manager is not None:
        engine.rootContext().setContextProperty("_themeManager", _theme_manager)
        engine.rootContext().setContextProperty(
            "_accentColor", _theme_manager.accentColor()
        )
        engine.rootContext().setContextProperty("_themeMode", _theme_manager.theme())

        def _on_accent_changed(color):
            engine.rootContext().setContextProperty("_accentColor", color)

        def _on_theme_changed(mode):
            engine.rootContext().setContextProperty("_themeMode", mode)

        _theme_manager.accentColorChanged.connect(_on_accent_changed)
        _theme_manager.themeChanged.connect(_on_theme_changed)

    if _window_manager is not None:
        engine.rootContext().setContextProperty("_windowManager", _window_manager)
        from PySide6.QtCore import Slot
        from PySide6.QtQuick import QQuickWindow

        def _send_drag(w):
            if _window_manager:
                _window_manager.sendDragEvent(w)

        def _maximize(w):
            if _window_manager:
                _window_manager.maximizeWindow(w)

        engine.rootContext().setContextProperty(
            "WindowManager_sendDragEvent", _send_drag
        )
        engine.rootContext().setContextProperty(
            "WindowManager_maximizeWindow", _maximize
        )

    try:
        from PySide6.QtQml import QQmlApplicationEngine

        cp = controls_path()
        engine.addImportPath(str(Path(cp).parent))
    except Exception:
        pass


__all__ = [
    "install_assets",
    "find_installed_style",
    "set_style",
    "default_style_path",
    "apply",
    "ThemeManager",
    "WindowManager",
    "theme_manager",
    "window_manager",
    "controls_path",
    "register_context",
    "setup_windows",
]


def __getattr__(name: str):
    if name == "ThemeManager":
        from ._theme import ThemeManager

        return ThemeManager
    if name == "WindowManager":
        from ._window import WindowManager

        return WindowManager
    raise AttributeError(f"module '{__name__}' has no attribute '{name}'")
