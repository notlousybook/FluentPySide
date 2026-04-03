"""Quick demo: create a temporary QML file, apply FluentWinUI3, and run it."""

import os
import sys
import tempfile
from pathlib import Path

# Ensure local repo is on sys.path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import fluentpyside

QML_CONTENT = """\
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "FluentWinUI3 Demo"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Label {
            text: "FluentWinUI3 Theme"
            font.pixelSize: 20
            font.bold: true
        }

        TextField {
            placeholderText: "Type something..."
            Layout.fillWidth: true
        }

        Button {
            text: "Click me"
            onClicked: console.log("Button clicked!")
        }

        CheckBox {
            text: "Enable feature"
        }

        Switch {
            text: "Dark mode toggle"
        }

        ProgressBar {
            value: 0.6
            Layout.fillWidth: true
        }

        ComboBox {
            model: ["Option 1", "Option 2", "Option 3"]
            Layout.fillWidth: true
        }

        Item { Layout.fillHeight: true }
    }
}
"""


def main():
    # Write temp QML file
    with tempfile.NamedTemporaryFile(mode="w", suffix=".qml", delete=False) as f:
        f.write(QML_CONTENT)
        qml_path = f.name

    try:
        app = QGuiApplication([])
        engine = QQmlApplicationEngine()

        fluentpyside.apply()

        engine.load(qml_path)

        if not engine.rootObjects():
            print("ERROR: No root objects loaded from QML")
            for err in engine.takeWarnings():
                print(f"  WARNING: {err.toString()}")
            sys.exit(1)

        print("Demo window opened successfully. Close it to exit.")
        sys.exit(app.exec())
    finally:
        os.unlink(qml_path)


if __name__ == "__main__":
    main()
