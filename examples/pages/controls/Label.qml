import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Label")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Label displays read-only text. Use the Fluent typography scale to create a clear visual hierarchy in your app.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Typography Scale")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Display — 68px")
            font.pixelSize: Fluent.typography.display
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Title Large — 40px")
            font.pixelSize: Fluent.typography.titleLarge
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Title — 28px")
            font.pixelSize: Fluent.typography.title
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Subtitle — 20px")
            font.pixelSize: Fluent.typography.subtitle
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Body — 14px")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }

        Label {
            text: qsTr("Caption — 12px")
            font.pixelSize: Fluent.typography.caption
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
        }

        Label {
            text: qsTr("Weight Variants")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            Label { text: qsTr("Normal"); font.weight: Font.Normal; font.pixelSize: Fluent.typography.body; color: Fluent.textPrimary }
            Label { text: qsTr("Bold"); font.weight: Font.Bold; font.pixelSize: Fluent.typography.body; color: Fluent.textPrimary }
        }
    }
}
