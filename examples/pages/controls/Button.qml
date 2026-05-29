import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Button")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("The Button control provides a Click event to respond to user input from a touch, mouse, keyboard, or other input device. You can put different kinds of content in a button, such as text or an image.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A simple Button with text content")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button { text: qsTr("Standard Button"); enabled: !disableBtnSwitch.checked }
            Button { text: qsTr("Disabled"); enabled: false }
            CheckBox { id: disableBtnSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("Accent style applied to Button")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button { text: qsTr("Accent Button"); highlighted: true; enabled: !disableAccentSwitch.checked }
            CheckBox { id: disableAccentSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("Flat style applied to Button")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button { text: qsTr("Flat Button"); flat: true; enabled: !disableFlatSwitch.checked }
            CheckBox { id: disableFlatSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("A Button with graphical content")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("Button with Icon")
                Icon { icon: "ic_fluent_add_20_regular"; size: 14; color: Fluent.textOnAccent; anchors.verticalCenter: parent.verticalCenter; x: 12 }
            }
        }

        Label {
            text: qsTr("ToolButton")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 8
            ToolButton {
                Icon { icon: "ic_fluent_add_20_regular"; size: 16; color: Fluent.textPrimary; anchors.centerIn: parent }
            }
            ToolButton {
                Icon { icon: "ic_fluent_edit_20_regular"; size: 16; color: Fluent.textPrimary; anchors.centerIn: parent }
            }
            ToolButton {
                Icon { icon: "ic_fluent_delete_20_regular"; size: 16; color: Fluent.textPrimary; anchors.centerIn: parent }
            }
        }

        Label {
            text: qsTr("DelayButton & RoundButton")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            DelayButton { text: qsTr("Hold"); delay: 1000 }
            RoundButton { text: "+" }
            RoundButton {
                Icon { icon: "ic_fluent_search_20_regular"; size: 14; color: Fluent.textPrimary; anchors.centerIn: parent }
            }
        }
    }
}
