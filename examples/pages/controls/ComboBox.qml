import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ComboBox")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use a ComboBox when you need to conserve on-screen space and when users select only one option at a time. A ComboBox shows only the currently selected item.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A ComboBox with items defined inline")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            ComboBox {
                id: colorCombo
                width: 200
                model: ["Blue", "Green", "Red", "Yellow"]
                currentIndex: -1
                enabled: !disableComboSwitch.checked
            }
            Rectangle {
                width: 24
                height: 24
                radius: 4
                color: colorCombo.currentIndex === 0 ? "#0078d4"
                    : colorCombo.currentIndex === 1 ? "#107c10"
                    : colorCombo.currentIndex === 2 ? "#d13438"
                    : colorCombo.currentIndex === 3 ? "#ffb900"
                    : Fluent.controlFill
                border.color: Fluent.cardBorder
                border.width: 1
                anchors.verticalCenter: parent.verticalCenter
            }
            CheckBox { id: disableComboSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("A ComboBox with a font model")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            ComboBox {
                id: fontCombo
                width: 200
                model: ["Segoe UI", "Arial", "Courier New", "Times New Roman"]
                currentIndex: 0
                enabled: !disableFontSwitch.checked
            }
            Label {
                text: qsTr("The quick brown fox jumps over the lazy dog")
                font.family: fontCombo.currentText
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter
                color: Fluent.textPrimary
            }
            CheckBox { id: disableFontSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("An editable ComboBox")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            ComboBox {
                id: sizeCombo
                width: 200
                editable: true
                model: ListModel {
                    ListElement { text: "8" }
                    ListElement { text: "9" }
                    ListElement { text: "10" }
                    ListElement { text: "11" }
                    ListElement { text: "12" }
                    ListElement { text: "14" }
                    ListElement { text: "16" }
                    ListElement { text: "18" }
                    ListElement { text: "20" }
                    ListElement { text: "24" }
                    ListElement { text: "28" }
                    ListElement { text: "36" }
                    ListElement { text: "48" }
                    ListElement { text: "72" }
                }
                currentIndex: 5
                enabled: !disableSizeSwitch.checked
            }
            CheckBox { id: disableSizeSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        ComboBox {
            width: 200
            enabled: false
            model: [qsTr("Disabled item")]
        }
    }
}
