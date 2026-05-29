from __future__ import annotations

import sys
from pathlib import Path
from typing import Optional

from PySide6.QtCore import QObject, Signal, Slot

from ._mica import apply_mica, apply_acrylic, _set_dark_mode, _get_hwnd


class ThemeManager(QObject):
    themeChanged = Signal(str)
    backdropChanged = Signal(bool)
    accentColorChanged = Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._theme = "auto"
        self._backdrop = True
        self._last_window = None
        self._accent_color = "#605ed2"

    @Slot(str)
    def setTheme(self, theme: str):
        self._theme = theme
        self.themeChanged.emit(theme)

    @Slot(result=str)
    def theme(self) -> str:
        return self._theme

    @Slot(bool)
    def setBackdrop(self, enabled: bool):
        self._backdrop = enabled
        self.backdropChanged.emit(enabled)

    @Slot(result=bool)
    def backdrop(self) -> bool:
        return self._backdrop

    @Slot(str)
    def setAccentColor(self, color: str):
        self._accent_color = color
        self.accentColorChanged.emit(color)

    @Slot(result=str)
    def accentColor(self) -> str:
        return self._accent_color

    @Slot(object, bool)
    def applyBackdrop(self, window, dark: bool):
        if window is None:
            return
        if self._backdrop and sys.platform == "win32":
            apply_mica(window, dark=dark)

    @Slot()
    def reapplyBackdrop(self):
        if self._last_window is not None:
            is_dark = self._resolve_dark()
            self.applyBackdrop(self._last_window, is_dark)
            if sys.platform == "win32":
                hwnd = _get_hwnd(self._last_window)
                if hwnd:
                    _set_dark_mode(hwnd, is_dark)

    def _resolve_dark(self) -> bool:
        if self._theme == "dark":
            return True
        if self._theme == "light":
            return False
        from PySide6.QtCore import Qt
        from PySide6.QtGui import QGuiApplication

        return QGuiApplication.styleHints().colorScheme() == Qt.ColorScheme.Dark

    @Slot('QObject*')
    def registerWindow(self, window):
        self._last_window = window
