import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("RoundButton")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A RoundButton is a button with fully rounded corners, suitable for icon-only or short text buttons.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Simple RoundButton")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            RoundButton { text: "A" }
            RoundButton { text: "B"; highlighted: true }
            RoundButton { icon.name: "ic_fluent_add_20_regular"; enabled: false }
        }

        Label {
            text: qsTr("Checkable RoundButtons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            RoundButton { text: "1"; checkable: true }
            RoundButton { text: "2"; checkable: true; checked: true }
            RoundButton { text: "3"; checkable: true }
        }
    }
}
