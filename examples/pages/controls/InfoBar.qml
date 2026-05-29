import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("InfoBar")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use an InfoBar control when a user should be informed of, acknowledge, or take action on a changed application state. By default the notification will remain in the content area until closed by the user.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Severity Levels")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        InfoBar {
            width: parent.width
            title: qsTr("Information")
            text: qsTr("This is an informational message.")
            severity: Severity.info
            closable: false
            timeout: -1
        }

        InfoBar {
            width: parent.width
            title: qsTr("Success")
            text: qsTr("Operation completed successfully.")
            severity: Severity.success
            closable: false
            timeout: -1
        }

        InfoBar {
            width: parent.width
            title: qsTr("Caution")
            text: qsTr("Please review before continuing.")
            severity: Severity.caution
            closable: false
            timeout: -1
        }

        InfoBar {
            width: parent.width
            title: qsTr("Error")
            text: qsTr("Something went wrong. Please try again.")
            severity: Severity.error
            closable: false
            timeout: -1
        }

        Label {
            text: qsTr("Interactive InfoBar")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            ComboBox {
                id: severityCombo
                model: ["Info", "Success", "Caution", "Error"]
                currentIndex: 0
            }
            CheckBox { id: closableCheck; text: qsTr("Closable"); checked: true }
            CheckBox { id: visibleCheck; text: qsTr("Visible"); checked: true }
        }

        InfoBar {
            width: parent.width
            title: qsTr("Interactive InfoBar")
            text: qsTr("Use the controls above to change this InfoBar's properties.")
            severity: severityCombo.currentIndex
            closable: closableCheck.checked
            visible: visibleCheck.checked
            timeout: -1
        }

        Label {
            text: qsTr("Popup InfoBar")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Button {
                text: qsTr("Show InfoBar")
                onClicked: {
                    var win = Window.window
                    if (win && win.floatLayer) {
                        win.floatLayer.createInfoBar({
                            title: qsTr("Popup!"),
                            text: qsTr("This is a popup InfoBar from floatLayer."),
                            severity: severityCombo.currentIndex,
                            closable: true,
                            timeout: 3000
                        })
                    }
                }
            }
        }

        Label {
            text: qsTr("Closable InfoBar")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        InfoBar {
            width: parent.width
            title: qsTr("Dismissable")
            text: qsTr("Click the close button to dismiss this InfoBar.")
            severity: Severity.info
            closable: true
            timeout: -1
        }
    }
}
