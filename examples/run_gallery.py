#!/usr/bin/env python3
"""FluentWinUI3 Gallery Launcher - showcases every single control."""
import sys
import os

# Add parent directory so fluentpyside package is importable
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from PySide6.QtGui import QGuiApplication, QFontDatabase, QColor, QPalette
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import fluentpyside

# Apply the Fluent WinUI 3 theme
fluentpyside.apply()

app = QGuiApplication(sys.argv)
app.setApplicationName("FluentWinUI3 Gallery")

# Override the system accent color to ensure proper blue accent
# (prevents the style from picking up the user's Windows accent color)
palette = app.palette()
# Dark mode accent: #60cdff  Light mode accent: #005fb8
palette.setColor(QPalette.ColorRole.Highlight, QColor("#005fb8"))
palette.setColor(QPalette.ColorRole.Accent, QColor("#005fb8"))
palette.setColor(QPalette.ColorRole.Button, QColor("#005fb8"))
app.setPalette(palette)

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

sys.exit(app.exec())
