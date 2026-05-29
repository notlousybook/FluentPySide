import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Segmented")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Segmented control lets users choose from a small, mutually exclusive set of options. It is similar to a radio button group but uses a compact horizontal layout.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Segmented Control")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Segmented {
            items: [qsTr("Day"), qsTr("Week"), qsTr("Month")]
        }

        Label {
            text: qsTr("With Icons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Segmented {
            items: [
                { title: qsTr("List"), icon: "ic_fluent_list_20_regular" },
                { title: qsTr("Grid"), icon: "ic_fluent_grid_20_regular" },
                { title: qsTr("Table"), icon: "ic_fluent_table_20_regular" }
            ]
        }
    }
}
