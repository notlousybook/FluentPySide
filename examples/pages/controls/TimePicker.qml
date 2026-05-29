import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("TimePicker")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use a TimePicker to let users set a time in your app, for example to set a reminder. The TimePicker displays three controls for hours, minutes, and AM/PM.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("12-Hour Time Picker")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TimePicker {
            id: timePicker12
            use24Hour: false
        }

        Label {
            text: qsTr("Selected time: %1").arg(timePicker12.time)
            font.pixelSize: Fluent.typography.caption
            color: Fluent.textSecondary
        }

        Label {
            text: qsTr("24-Hour Time Picker")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        TimePicker {
            id: timePicker24
            use24Hour: true
        }

        Label {
            text: qsTr("Selected time: %1").arg(timePicker24.time)
            font.pixelSize: Fluent.typography.caption
            color: Fluent.textSecondary
        }
    }
}
