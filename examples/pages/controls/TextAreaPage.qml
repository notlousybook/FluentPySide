import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("TextArea")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A TextArea is a multi-line text input control. It supports text wrapping, selection, and scrolling for longer content.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Basic TextArea")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TextArea {
            width: parent.width
            height: 100
            placeholderText: qsTr("Enter multi-line text here...")
            wrapMode: Text.WordWrap
        }

        Label {
            text: qsTr("Read-Only TextArea")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TextArea {
            width: parent.width
            height: 80
            readOnly: true
            text: qsTr("This is a read-only text area. The content cannot be edited by the user, but can be selected and copied.")
            wrapMode: Text.WordWrap
        }
    }
}
