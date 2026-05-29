import QtQuick
import QtQuick.Controls

Dialog {
    id: root

    anchors.centerIn: Overlay.overlay
    closePolicy: Popup.NoAutoClose

    padding: 24
    topPadding: 24
    bottomPadding: 24
    implicitWidth: Math.max(320, Math.min(implicitContentWidth + leftPadding + rightPadding, 600))

    background: Rectangle {
        color: Fluent.popupBackground
        border.color: Fluent.windowBorder
        border.width: 1
        radius: Fluent.appearance.windowRadius
    }

    Overlay.modal: Rectangle {
        color: Fluent.backgroundSmoke
    }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.appearance; easing.type: Easing.InOutQuart }
            NumberAnimation { property: "scale"; from: 1.05; to: 1; duration: Fluent.anim.middle; easing.type: Easing.OutQuint }
        }
    }
    exit: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 100; easing.type: Easing.InOutQuart }
            NumberAnimation { property: "scale"; from: 1; to: 1.05; duration: Fluent.anim.middle; easing.type: Easing.OutQuint }
        }
    }
}
