#!/usr/bin/env python3
"""FluentWinUI3 Gallery Launcher - showcases every single control."""

import sys
import os

# Add parent directory so fluentpyside package is importable
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from PySide6.QtGui import QGuiApplication, QFontDatabase
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import fluentpyside
from fluentpyside._mica import (
    apply_mica,
    change_header_color,
    change_title_color,
    get_accent_color,
)

# Apply the Fluent WinUI 3 theme
fluentpyside.apply()

app = QGuiApplication(sys.argv)
app.setApplicationName("FluentWinUI3 Gallery")

# Load Fluent System Icons font (official Fluent 2 icons from Microsoft)
fonts_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "fonts")
if os.path.isdir(fonts_dir):
    for font_file in ["FluentSystemIcons-Regular.ttf", "FluentSystemIcons-Filled.ttf"]:
        font_path = os.path.join(fonts_dir, font_file)
        if os.path.exists(font_path):
            font_id = QFontDatabase.addApplicationFont(font_path)
            if font_id >= 0:
                families = QFontDatabase.applicationFontFamilies(font_id)
                print(f"Loaded font: {font_file} -> {families}")
            else:
                print(f"Warning: Failed to load {font_file}")

# Use the Fluent style
QQuickStyle.setStyle("FluentWinUI3")

engine = QQmlApplicationEngine()

# Add examples dir to import path so co-located modules resolve
examples_dir = os.path.dirname(os.path.abspath(__file__))
engine.addImportPath(examples_dir)

qml_path = os.path.join(examples_dir, "gallery.qml")
engine.load(qml_path)

if not engine.rootObjects():
    print(f"Error: Failed to load {qml_path}", file=sys.stderr)
    sys.exit(1)

# Apply Mica backdrop effect to the main window
root = engine.rootObjects()[0]
if root:
    # Try to get the window from QML
    try:
        from PySide6.QtWidgets import QApplication
        from PySide6.QtCore import QWindow

        # Find the QWindow from QML
        window = root
        if hasattr(root, "window"):
            window = root.window()
        elif hasattr(root, "winId"):
            from PySide6.QtWidgets import QWidget

            window = QWidget.find(int(root.winId()))

        if window:
            is_dark = hasattr(root, "isDark") and root.isDark
            apply_mica(window, dark=is_dark)
            # Optionally set header color to match accent
            accent = get_accent_color()
            if accent:
                change_header_color(window, accent)
    except Exception as e:
        print(f"Note: Could not apply Mica (Windows 11 required): {e}", file=sys.stderr)

sys.exit(app.exec())
