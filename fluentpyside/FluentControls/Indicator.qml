import QtQuick
import QtQuick.Controls

Rectangle {
    id: indicator

    property int currentItemHeight: 38
    property var orientation: Qt.Vertical

    implicitWidth: orientation === Qt.Horizontal ? 16 : 3
    implicitHeight: orientation === Qt.Horizontal ? 3 : currentItemHeight - 23
    radius: 10
    color: Fluent.accent

    y: orientation === Qt.Horizontal ? parent.height - height : (parent.height - height) / 2
    x: orientation === Qt.Horizontal ? (parent.width - width) / 2 : 0

    onVisibleChanged: {
        if (visible) {
            enterAnimation.start()
        }
    }

    ParallelAnimation {
        id: enterAnimation
        PropertyAnimation {
            target: indicator
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: Fluent.anim.speed
            easing.type: Easing.OutQuad
        }
        ScriptAction {
            script: {
                if (indicator.orientation === Qt.Horizontal) {
                    enterAnimationHorizontal.start()
                } else {
                    enterAnimationVertical.start()
                }
            }
        }
    }

    ParallelAnimation {
        id: enterAnimationVertical
        PropertyAnimation {
            target: indicator
            property: "height"
            from: 0
            to: indicator.implicitHeight
            duration: Fluent.anim.middle
            easing.type: Easing.OutQuint
        }
        PropertyAnimation {
            target: indicator
            property: "y"
            from: parent.height / 2
            to: (parent.height - indicator.implicitHeight) / 2
            duration: Fluent.anim.middle
            easing.type: Easing.OutQuint
        }
    }

    ParallelAnimation {
        id: enterAnimationHorizontal
        PropertyAnimation {
            target: indicator
            property: "width"
            from: 0
            to: indicator.implicitWidth
            duration: Fluent.anim.middle
            easing.type: Easing.OutQuint
        }
        PropertyAnimation {
            target: indicator
            property: "x"
            from: parent.width / 2
            to: (parent.width - indicator.implicitWidth) / 2
            duration: Fluent.anim.middle
            easing.type: Easing.OutQuint
        }
    }

    Behavior on color {
        ColorAnimation { duration: Fluent.anim.appearance; easing.type: Easing.OutQuint }
    }
}
