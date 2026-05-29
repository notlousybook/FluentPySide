import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    property alias text: flyoutText.text
    property alias buttonBox: buttonLayout.data
    default property alias content: customContent.data

    padding: 16

    contentItem: ColumnLayout {
        spacing: 0

        ColumnLayout {
            id: customContent
            spacing: 8
            Layout.fillWidth: true

            Label {
                id: flyoutText
                Layout.fillWidth: true
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
                color: Fluent.textPrimary
                wrapMode: Text.WordWrap
                visible: text.length > 0
            }
        }

        Item {
            height: 16
            visible: buttonLayout.children.length > 0
        }

        RowLayout {
            Layout.fillWidth: true
            id: buttonLayout
            spacing: 8
        }
    }

    background: Rectangle {
        color: Fluent.popupBackground
        border.color: Fluent.flyoutBorder
        border.width: 1
        radius: Fluent.appearance.buttonRadius
    }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.speed; easing.type: Easing.OutQuint }
            NumberAnimation { property: "y"; from: y - 15; to: y; duration: Fluent.anim.middle; easing.type: Easing.OutQuint }
        }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.speed; easing.type: Easing.OutQuint }
    }

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
}
