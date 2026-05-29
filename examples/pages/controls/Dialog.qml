import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Dialog")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Dialogs are modal UI overlays that provide app-related content. They often ask users to take an action. Use a Dialog to notify the user of important information or to request confirmation before proceeding.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Standard Dialog")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Open Dialog")
            onClicked: standardDialog.open()
        }

        FluentDialog {
            id: standardDialog
            title: qsTr("Information")
            modal: true
            standardButtons: Dialog.Ok
            Column {
                spacing: 8
                Label {
                    text: qsTr("This is a standard dialog message.")
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textPrimary
                    wrapMode: Text.WordWrap
                    width: 300
                }
            }
        }

        Label {
            text: qsTr("Confirm Dialog")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Open Confirm Dialog")
            onClicked: confirmDialog.open()
        }

        FluentDialog {
            id: confirmDialog
            title: qsTr("Confirm Action")
            modal: true
            standardButtons: Dialog.Yes | Dialog.No
            Column {
                spacing: 8
                Label {
                    text: qsTr("Are you sure you want to proceed?")
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textPrimary
                    wrapMode: Text.WordWrap
                    width: 300
                }
            }
        }
    }
}
