import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("DatePicker")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use a DatePicker to let users set a date in your app, for example to schedule an appointment. The DatePicker displays three controls for month, date, and year.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Date Picker")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        DatePicker {
            id: datePicker
        }

        Label {
            text: qsTr("Selected date: %1").arg(datePicker.date)
            font.pixelSize: Fluent.typography.caption
            color: Fluent.textSecondary
        }

        Button {
            text: qsTr("Set Random Date")
            onClicked: {
                var y = Math.floor(Math.random() * (datePicker.endYear - datePicker.startYear) + datePicker.startYear)
                var m = Math.floor(Math.random() * 12 + 1)
                var d = Math.floor(Math.random() * 28 + 1)
                datePicker.setDate(y + "-" + m + "-" + d)
            }
        }
    }
}
