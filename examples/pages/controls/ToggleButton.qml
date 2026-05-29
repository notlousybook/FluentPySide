import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ToggleButton")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A ToggleButton looks like a Button, but works like a CheckBox. It has two states \u2014 checked (pressed) and unchecked (unpressed).")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Toggle Buttons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            ToggleButton { text: qsTr("Bold"); checked: true }
            ToggleButton { text: qsTr("Italic") }
            ToggleButton { text: qsTr("Underline") }
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        ToggleButton {
            text: qsTr("Disabled")
            enabled: false
        }
    }
}
