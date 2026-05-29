import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("SettingExpander")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("SettingExpander is a specialized Expander for settings pages. It combines an icon, title, description, and expandable content in a card-style layout.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Setting Expanders")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SettingExpander {
            width: parent.width
            title: qsTr("Display")
            icon: "ic_fluent_dark_20_regular"
            description: qsTr("Configure display preferences")
            Column {
                width: parent.width
                spacing: 8
                RadioButton { text: qsTr("Light"); checked: !Fluent.isDark }
                RadioButton { text: qsTr("Dark"); checked: Fluent.isDark }
                RadioButton { text: qsTr("Use system setting") }
            }
        }

        SettingExpander {
            width: parent.width
            title: qsTr("Notifications")
            icon: "ic_fluent_alert_20_regular"
            description: qsTr("Manage notification settings")
            Column {
                width: parent.width
                spacing: 8
                Switch { text: qsTr("Push notifications"); checked: true }
                Switch { text: qsTr("Email notifications") }
                Switch { text: qsTr("Sound alerts"); checked: true }
            }
        }
    }
}
