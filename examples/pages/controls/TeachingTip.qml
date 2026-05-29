import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("TeachingTip")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("TeachingTip is a semi-rich notification bubble that can include a title, message, and icon. It can be attached to a target element or shown as a standalone notification.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Teaching Tip")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Show Teaching Tip")
            onClicked: sampleTip.open()

            TeachingTip {
                id: sampleTip
                tipTitle: qsTr("New Feature")
                tipText: qsTr("This teaching tip highlights a new feature. Click 'Got it' to dismiss.")
                tipIcon: "ic_fluent_lightbulb_20_regular"
            }
        }

        Label {
            text: qsTr("Informational Tip")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Show Info Tip")
            onClicked: infoTip.open()

            TeachingTip {
                id: infoTip
                tipTitle: qsTr("Did you know?")
                tipText: qsTr("You can customize the accent color in Settings. Try it out!")
                tipIcon: "ic_fluent_info_20_regular"
            }
        }
    }
}
