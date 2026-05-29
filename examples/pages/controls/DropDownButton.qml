import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("DropDownButton")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A DropDownButton is a button that shows a dropdown menu with a chevron indicator. Use it to present a set of related commands in a compact format.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Drop Down Buttons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        DropDownButton {
            text: qsTr("File")

            MenuItem { text: qsTr("New") }
            MenuItem { text: qsTr("Open") }
            MenuSeparator {}
            MenuItem { text: qsTr("Save") }
            MenuItem { text: qsTr("Save As...") }
        }

        DropDownButton {
            text: qsTr("Edit")

            MenuItem { text: qsTr("Cut") }
            MenuItem { text: qsTr("Copy") }
            MenuItem { text: qsTr("Paste") }
        }

        Label {
            text: qsTr("Disabled")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        DropDownButton {
            text: qsTr("Disabled")
            enabled: false
        }
    }
}
