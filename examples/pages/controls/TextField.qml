import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("TextField")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use a TextField to let a user enter simple text input in your app. You can add a placeholder text to let the user know what the TextField is for.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A simple TextField")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            TextField { width: 200; placeholderText: qsTr("Enter your name"); enabled: !readOnlyBox.checked }
            CheckBox { id: readOnlyBox; text: qsTr("ReadOnly"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("A TextField with a placeholder text")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TextField {
            width: 200
            placeholderText: qsTr("Search...")
        }

        Label {
            text: qsTr("Password Field")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TextField {
            width: 200
            placeholderText: qsTr("Enter password")
            echoMode: TextInput.Password
        }

        Label {
            text: qsTr("Disabled & Read-only")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            TextField { width: 200; text: qsTr("Disabled field"); enabled: false }
            TextField { width: 200; text: qsTr("Read-only field"); readOnly: true }
        }
    }
}
