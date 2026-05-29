import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("MenuBar")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("MenuBar provides a horizontal menu bar at the top of a window. It contains pull-down menu items for navigation and commands.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Embedded MenuBar Demo")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Rectangle {
            width: parent.width
            height: 120
            radius: Fluent.appearance.buttonRadius
            color: Fluent.background
            border.color: Fluent.cardBorder
            border.width: 1
            clip: true

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                MenuBar {
                    Layout.fillWidth: true
                    Menu {
                        title: qsTr("File")
                        MenuItem { text: qsTr("New") }
                        MenuItem { text: qsTr("Open") }
                        MenuSeparator {}
                        MenuItem { text: qsTr("Save") }
                        MenuItem { text: qsTr("Save As...") }
                        MenuSeparator {}
                        MenuItem { text: qsTr("Exit") }
                    }
                    Menu {
                        title: qsTr("Edit")
                        MenuItem { text: qsTr("Cut"); icon.name: "ic_fluent_cut_20_regular" }
                        MenuItem { text: qsTr("Copy"); icon.name: "ic_fluent_copy_20_regular" }
                        MenuItem { text: qsTr("Paste"); icon.name: "ic_fluent_clipboard_paste_20_regular" }
                    }
                    Menu {
                        title: qsTr("View")
                        MenuItem { checkable: true; checked: true; text: qsTr("Status Bar") }
                        MenuItem { checkable: true; text: qsTr("Ruler") }
                    }
                }

                Label {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: qsTr("Use the menu bar above")
                    font.pixelSize: Fluent.typography.caption
                    color: Fluent.textTertiary
                }
            }
        }
    }
}
