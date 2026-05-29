import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("SelectorBar")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("SelectorBar is used to modify the content shown by allowing users to select and switch between a small, finite set of data.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A Basic SelectorBar")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SelectorBar {
            width: 360
            SelectorBarItem { text: qsTr("Recent"); fluentIcon: "ic_fluent_clock_20_regular" }
            SelectorBarItem { text: qsTr("Shared"); fluentIcon: "ic_fluent_share_20_regular" }
            SelectorBarItem { text: qsTr("Favorites"); fluentIcon: "ic_fluent_star_20_regular" }
        }

        Label {
            text: qsTr("SelectorBar with More Items")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SelectorBar {
            width: 500
            SelectorBarItem { text: qsTr("All") }
            SelectorBarItem { text: qsTr("Active") }
            SelectorBarItem { text: qsTr("Completed") }
            SelectorBarItem { text: qsTr("Archived") }
        }
    }
}
