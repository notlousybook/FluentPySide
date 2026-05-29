import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Popup")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A Popup is a lightweight overlay that appears on top of existing content. It can be used for tooltips, dialogs, or custom overlays.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Simple Popup")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Show Popup")
            onClicked: simplePopup.open()
        }

        Popup {
            id: simplePopup
            anchors.centerIn: Overlay.overlay
            width: 250
            height: 150
            modal: true

            background: Rectangle {
                color: Fluent.popupBackground
                border.color: Fluent.flyoutBorder
                border.width: 1
                radius: Fluent.appearance.buttonRadius
            }

            contentItem: Column {
                spacing: 12
                Label {
                    text: qsTr("Popup Title")
                    font.pixelSize: Fluent.typography.body
                    font.weight: Font.Bold
                    color: Fluent.textPrimary
                }
                Label {
                    text: qsTr("This is a simple popup with some content.")
                    font.pixelSize: Fluent.typography.caption
                    color: Fluent.textSecondary
                    wrapMode: Text.WordWrap
                    width: parent.width
                }
                Button {
                    text: qsTr("Close")
                    onClicked: simplePopup.close()
                }
            }
        }
    }
}
