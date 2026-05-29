import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ContextMenu")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A ContextMenu shows a lightweight popup menu when the user right-clicks or long-presses an element. Use it to provide quick access to contextual actions.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Right-click to show ContextMenu")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Rectangle {
            width: parent.width
            height: 120
            radius: Fluent.appearance.buttonRadius
            color: Fluent.cardBackground
            border.color: Fluent.cardBorder
            border.width: 1

            Label {
                anchors.centerIn: parent
                text: qsTr("Right-click this area")
                font.pixelSize: Fluent.typography.body
                color: Fluent.textTertiary
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: contextMenu.popup()
            }

            Menu {
                id: contextMenu
                MenuItem { text: qsTr("Cut") }
                MenuItem { text: qsTr("Copy") }
                MenuItem { text: qsTr("Paste") }
                MenuSeparator {}
                MenuItem { text: qsTr("Select All") }
            }
        }
    }
}
