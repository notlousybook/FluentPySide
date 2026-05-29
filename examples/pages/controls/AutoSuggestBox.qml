import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("AutoSuggestBox")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("AutoSuggestBox provides a text input with a dropdown list of suggested values as the user types. It combines a text field with a filtered list view.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Auto Suggest")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        AutoSuggestBox {
            width: 300
            placeholderText: qsTr("Type a color...")
            suggestions: ["Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink"]
        }

        Label {
            text: qsTr("Country Search")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        AutoSuggestBox {
            width: 300
            placeholderText: qsTr("Search countries...")
            suggestions: ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Japan", "China"]
        }
    }
}
