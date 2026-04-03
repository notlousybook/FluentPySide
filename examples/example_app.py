"""Minimal example that installs and applies the FluentWinUI3 style then loads a simple QML UI."""

import sys
from pathlib import Path

import fluentpyside
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine


def main() -> int:
    app = QApplication(sys.argv)

    # Ensure assets are present in the package folder
    try:
        fluentpyside.install_assets()
    except FileNotFoundError as e:
        print("Warning: could not copy assets from local PySide6 install:", e)

    # Apply the style (adds import path and attempts QQuickStyle.setStyle)
    fluentpyside.set_style()

    engine = QQmlApplicationEngine()
    # add import path explicitly for good measure
    style_path = Path(__file__).parent.parent / "fluent_winui3"
    if style_path.exists():
        engine.addImportPath(str(style_path))

    qml = """
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.FluentWinUI3 1.0

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: qsTr("FluentWinUI3 Example")

    Column {
        anchors.centerIn: parent
        spacing: 10

        Button { text: "Hello" }
        CheckBox { text: "Check me" }
    }
}
"""

    # load from string
    engine.loadData(qml.encode("utf-8"))
    if not engine.rootObjects():
        print("Failed to load QML")
        return 1

    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())
