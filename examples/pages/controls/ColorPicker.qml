import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("ColorPicker")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A selectable color spectrum. The ColorPicker provides an HSV color space with value and alpha sliders, hex input, and RGB/HSV channel inputs.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Color Picker")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        RowLayout {
            spacing: 24
            width: parent.width

            ColorPicker {
                id: picker
                color: Fluent.accent
                Layout.alignment: Qt.AlignTop
            }

            Column {
                Layout.alignment: Qt.AlignTop
                spacing: 8

                Label {
                    text: qsTr("Selected: %1").arg(picker.color.toString())
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textPrimary
                }
                Rectangle {
                    width: 60
                    height: 24
                    radius: 4
                    color: picker.color
                    border.color: Fluent.cardBorder
                    border.width: 1
                }
            }
        }

        Label {
            text: qsTr("With Alpha")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        ColorPicker {
            color: Fluent.accent
            alphaEnabled: true
        }
    }
}
