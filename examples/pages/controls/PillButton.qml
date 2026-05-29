import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("PillButton")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("PillButton is a button styled with rounded pill-shaped ends. It supports checkable state for toggle behavior.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Pill Buttons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            PillButton { text: qsTr("Primary") }
            PillButton { text: qsTr("Checked"); checked: true; checkable: true }
            PillButton { text: qsTr("Disabled"); enabled: false }
        }

        Label {
            text: qsTr("Checkable Pill Buttons (mutually exclusive)")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            PillButton {
                id: optA
                text: qsTr("Option A"); checkable: true
                onCheckedChanged: if (checked) { optB.checked = false; optC.checked = false }
            }
            PillButton {
                id: optB
                text: qsTr("Option B"); checkable: true
                onCheckedChanged: if (checked) { optA.checked = false; optC.checked = false }
            }
            PillButton {
                id: optC
                text: qsTr("Option C"); checkable: true; checked: true
                onCheckedChanged: if (checked) { optA.checked = false; optB.checked = false }
            }
        }
    }
}
