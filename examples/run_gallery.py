#!/usr/bin/env python3
"""FluentWinUI3 Gallery Launcher - showcases every single control."""
import sys
import os

# Add parent directory so fluentpyside package is importable
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQuickControls2 import QQuickStyle
import fluentpyside

# Apply the Fluent WinUI 3 theme
fluentpyside.apply()

app = QGuiApplication(sys.argv)
app.setApplicationName("FluentWinUI3 Gallery")

# Use the Fluent style
QQuickStyle.setStyle("FluentWinUI3")

engine = QQmlApplicationEngine()
qml_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "gallery.qml")
engine.load(qml_path)

if not engine.rootObjects():
    print(f"Error: Failed to load {qml_path}", file=sys.stderr)
    sys.exit(1)

sys.exit(app.exec())
