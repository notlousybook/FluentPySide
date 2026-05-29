import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Menu")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A Menu displays lightweight UI that is light dismissed by clicking or tapping off of it. Use it to let the user choose from a contextual list of simple commands or options.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Simple Menu")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("Sort")
                onClicked: sortMenu.popup(this, 0, height)
                Menu {
                    id: sortMenu
                    MenuItem { text: qsTr("By rating") }
                    MenuItem { text: qsTr("By match") }
                    MenuItem { text: qsTr("By distance") }
                }
            }
        }

        Label {
            text: qsTr("Menu with Separators and Checkable Items")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("Options")
                onClicked: optionsMenu.popup(this, 0, height)
                Menu {
                    id: optionsMenu
                    MenuItem { text: qsTr("Reset") }
                    MenuSeparator {}
                    MenuItem { checkable: true; checked: true; text: qsTr("Repeat") }
                    MenuItem { checkable: true; checked: true; text: qsTr("Shuffle") }
                }
            }
        }

        Label {
            text: qsTr("Menu with Icons")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("Edit")
                onClicked: editMenu.popup(this, 0, height)
                Menu {
                    id: editMenu
                    MenuItem { icon.name: "ic_fluent_share_20_regular"; text: qsTr("Share") }
                    MenuItem { icon.name: "ic_fluent_copy_20_regular"; text: qsTr("Copy") }
                    MenuItem { icon.name: "ic_fluent_delete_20_regular"; text: qsTr("Delete") }
                    MenuSeparator {}
                    MenuItem { text: qsTr("Rename") }
                }
            }
        }

        Label {
            text: qsTr("Cascading Menu")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("File")
                onClicked: fileMenu.popup(this, 0, height)
                Menu {
                    id: fileMenu
                    MenuItem { text: qsTr("Open") }
                    Menu {
                        title: qsTr("Send to")
                        MenuItem { text: qsTr("Bluetooth") }
                        MenuItem { text: qsTr("Desktop (shortcut)") }
                    }
                }
            }
        }
    }
}
