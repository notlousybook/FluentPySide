import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root

    property string tipTitle: ""
    property string tipText: ""
    property string tipIcon: "ic_fluent_info_20_regular"
    property bool isLightDismiss: true

    width: 320
    padding: 16
    closePolicy: isLightDismiss ? Popup.CloseOnEscape | Popup.CloseOnPressOutside : Popup.CloseOnEscape

    background: Rectangle {
        color: Fluent.popupBackground
        border.color: Fluent.flyoutBorder
        border.width: 1
        radius: Fluent.appearance.buttonRadius
    }

    contentItem: Column {
        spacing: 8

        Row {
            spacing: 8
            Icon { size: 20; icon: root.tipIcon; color: Fluent.informational; anchors.verticalCenter: parent.verticalCenter }
            Label {
                text: root.tipTitle
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
                font.weight: Font.Bold
                color: Fluent.textPrimary
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Label {
            text: root.tipText
            font.pixelSize: Fluent.typography.caption
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Button {
            highlighted: true
            text: qsTr("Got it")
            onClicked: root.close()
        }
    }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.speed; easing.type: Easing.OutQuint }
        }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.appearance }
    }
}
