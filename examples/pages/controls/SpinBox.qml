import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("SpinBox")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A SpinBox allows the user to select an integer value by incrementing or decrementing it with buttons, or by typing a value directly.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Standard SpinBox")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SpinBox {
            from: 0
            to: 100
            value: 42
        }

        Label {
            text: qsTr("Custom Range")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SpinBox {
            from: -50
            to: 50
            value: 0
            stepSize: 5
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SpinBox {
            from: 0
            to: 100
            value: 50
            enabled: false
        }
    }
}
