import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("RadioButton")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("RadioButton controls let users select one option from a set of mutually exclusive choices. Use RadioButtons when you want users to select a single item from a group of options.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A group of RadioButtons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            RadioButton { text: qsTr("Option 1"); checked: true }
            RadioButton { text: qsTr("Option 2") }
            RadioButton { text: qsTr("Option 3") }
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            RadioButton { text: qsTr("Disabled unchecked"); enabled: false }
            RadioButton { text: qsTr("Disabled checked"); checked: true; enabled: false }
        }
    }
}
