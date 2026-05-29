import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Switch")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use Switch controls to present users with exactly two mutually exclusive options (like on/off), where choosing an option results in an immediate commit.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A simple Switch")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            Switch { text: qsTr("Wi-Fi"); checked: true; enabled: !disableSwitchSwitch.checked }
            Switch { text: qsTr("Bluetooth"); enabled: !disableSwitchSwitch.checked }
            Switch { text: qsTr("Airplane Mode"); enabled: !disableSwitchSwitch.checked }
            CheckBox { id: disableSwitchSwitch; text: qsTr("Disable all") }
        }

        Label {
            text: qsTr("Interactive demo")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Rectangle {
            width: parent.width
            height: 80
            radius: Fluent.appearance.buttonRadius
            color: Fluent.cardBackground
            border.color: Fluent.cardBorder
            border.width: 1

            Row {
                anchors.centerIn: parent
                spacing: 32
                Label {
                    text: qsTr("Toggle work")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textPrimary
                }
                Switch { id: toggleWorkSwitch; checked: true }
                ProgressBar {
                    indeterminate: true
                    visible: toggleWorkSwitch.checked
                    anchors.verticalCenter: parent.verticalCenter
                    width: 120
                }
            }
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            Switch { text: qsTr("Disabled On"); checked: true; enabled: false }
            Switch { text: qsTr("Disabled Off"); checked: false; enabled: false }
        }
    }
}
