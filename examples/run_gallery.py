#!/usr/bin/env python3
"""FluentPySide Gallery Launcher - showcases every control and FluentControls component."""

import sys
import os
from typing import Optional

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from PySide6.QtCore import QTimer, Qt
from PySide6.QtGui import QGuiApplication, QFontDatabase
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import fluentpyside
from fluentpyside._mica import apply_mica, remove_backdrop

fluentpyside.apply()

app = QGuiApplication(sys.argv)
app.setApplicationName("FluentPySide Gallery")


def resolve_accent() -> Optional[str]:
    try:
        from fluentpyside._mica import get_accent_color

        return get_accent_color()
    except Exception:
        return None


fonts_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "fonts")
if os.path.isdir(fonts_dir):
    for font_file in [
        "FluentSystemIcons-Resizable.ttf",
        "FluentSystemIcons-Regular.ttf",
        "FluentSystemIcons-Filled.ttf",
    ]:
        font_path = os.path.join(fonts_dir, font_file)
        if os.path.exists(font_path):
            font_id = QFontDatabase.addApplicationFont(font_path)
            if font_id >= 0:
                families = QFontDatabase.applicationFontFamilies(font_id)
                print(f"Loaded font: {font_file} -> {families}")
            else:
                print(f"Warning: Failed to load {font_file}")

QQuickStyle.setStyle("FluentWinUI3")

engine = QQmlApplicationEngine()

examples_dir = os.path.dirname(os.path.abspath(__file__))
engine.addImportPath(examples_dir)
engine.addImportPath(os.path.dirname(fluentpyside.__file__))

fluentpyside.register_context(engine)

qml_path = os.path.join(examples_dir, "gallery.qml")
engine.load(qml_path)

if not engine.rootObjects():
    print(f"Error: Failed to load {qml_path}", file=sys.stderr)
    sys.exit(1)

fluentpyside.setup_windows(engine)

root = engine.rootObjects()[0]

attempts = {"count": 0}


def apply_backdrop() -> None:
    attempts["count"] += 1
    try:
        window = root
        if hasattr(root, "window") and callable(root.window):
            qml_window = root.window()
            if qml_window:
                window = qml_window

        if window:
            from fluentpyside._theme import ThemeManager

            tm = fluentpyside.theme_manager()
            is_dark = False
            if tm:
                is_dark = tm._resolve_dark()
            else:
                is_dark = (
                    QGuiApplication.styleHints().colorScheme() == Qt.ColorScheme.Dark
                )

            mica_ok = apply_mica(window, dark=is_dark)
            if not mica_ok and attempts["count"] < 5:
                QTimer.singleShot(200, apply_backdrop)
    except Exception as e:
        print(f"Note: Could not apply Mica: {e}", file=sys.stderr)


QTimer.singleShot(0, apply_backdrop)

sys.exit(app.exec())
