import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("CheckBox")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("CheckBox controls let the user select a combination of binary options. In contrast, RadioButton controls allow the user to select from mutually exclusive options. The indeterminate state is used to indicate that an option is set for some, but not all, child options.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A 2-state CheckBox")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            CheckBox { text: qsTr("Two-state CheckBox"); enabled: !disableCheckSwitch.checked }
            CheckBox { id: disableCheckSwitch; text: qsTr("Disable") }
        }

        Label {
            text: qsTr("A 3-state CheckBox")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            CheckBox { tristate: true; text: qsTr("Three-state CheckBox"); enabled: !disableCheck3Switch.checked }
            CheckBox { id: disableCheck3Switch; text: qsTr("Disable") }
        }

        Label {
            text: qsTr("Using a 3-state CheckBox (Select All)")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            ButtonGroup { id: childGroup; exclusive: false; checkState: parentBox.checkState }
            CheckBox { id: parentBox; text: qsTr("Select all"); checkState: childGroup.checkState; enabled: !disableGroupSwitch.checked }
            CheckBox { checked: true; text: qsTr("Option 1"); leftPadding: indicator.width; ButtonGroup.group: childGroup; enabled: !disableGroupSwitch.checked }
            CheckBox { text: qsTr("Option 2"); leftPadding: indicator.width; ButtonGroup.group: childGroup; enabled: !disableGroupSwitch.checked }
            CheckBox { text: qsTr("Option 3"); leftPadding: indicator.width; ButtonGroup.group: childGroup; enabled: !disableGroupSwitch.checked }
            CheckBox { id: disableGroupSwitch; text: qsTr("Disable all") }
        }
    }
}
