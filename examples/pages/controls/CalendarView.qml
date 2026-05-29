import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("CalendarView")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("CalendarView provides a full calendar display for selecting a date. Navigate between months using the arrow buttons.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Calendar View")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        CalendarView {
            width: 320
            height: 340
        }

        Label {
            text: qsTr("The CalendarView provides month navigation with day selection. Use the arrows to navigate between months.")
            font.pixelSize: Fluent.typography.caption
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }
    }
}
