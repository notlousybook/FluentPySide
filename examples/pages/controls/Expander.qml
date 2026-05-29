import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Expander")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("The Expander has a header and can expand to show a body with more content. Use an Expander when some content is only relevant some of the time, like advanced options.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Simple Expander")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Expander {
            width: parent.width
            title: qsTr("Getting Started")
            Column {
                width: parent.width
                spacing: 8
                Label {
                    text: qsTr("FluentPySide provides Fluent Design components for PySide6 applications. This is content inside an Expander.")
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textSecondary
                    wrapMode: Text.WordWrap
                    width: parent.width
                }
            }
        }

        Expander {
            width: parent.width
            title: qsTr("Advanced Options")
            expanded: true
            Column {
                width: parent.width
                spacing: 8
                CheckBox { text: qsTr("Enable notifications") }
                CheckBox { text: qsTr("Auto-save drafts") }
                CheckBox { text: qsTr("Show previews") }
            }
        }

        Label {
            text: qsTr("Expander with custom content")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Expander {
            width: parent.width
            title: qsTr("Network Settings")
            Column {
                width: parent.width
                spacing: 8
                Switch { text: qsTr("Wi-Fi"); checked: true }
                Switch { text: qsTr("Bluetooth") }
                Label {
                    text: qsTr("Connected to: Home-Network")
                    font.pixelSize: Fluent.typography.caption
                    color: Fluent.textSecondary
                }
            }
        }
    }
}
