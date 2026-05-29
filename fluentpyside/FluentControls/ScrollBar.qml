import QtQuick
import QtQuick.Templates as T

T.ScrollBar {
    id: scrollBar

    property int minimumWidth: Fluent.appearance.scrollBarMinWidth
    property int expandWidth: Fluent.appearance.scrollBarWidth

    implicitWidth: horizontal ? availableWidth : (implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: vertical ? availableHeight : (implicitContentHeight + topPadding + bottomPadding)

    anchors.verticalCenter: vertical && parent ? parent.verticalCenter : undefined
    anchors.horizontalCenter: horizontal && parent ? parent.horizontalCenter : undefined
    anchors.right: vertical && parent ? parent.right : undefined
    anchors.bottom: horizontal && parent ? parent.bottom : undefined

    verticalPadding: vertical ? 15 : 3
    horizontalPadding: horizontal ? 15 : 3
    enabled: size < 1.0

    contentItem: Item {
        id: scrollContent

        property bool isExpanded: scrollBar.active || scrollBar.policy === T.ScrollBar.AlwaysOn

        implicitWidth: scrollBar.interactive ? scrollBar.expandWidth : scrollBar.minimumWidth
        implicitHeight: scrollBar.interactive ? scrollBar.expandWidth : scrollBar.minimumWidth

        Rectangle {
            id: bar
            width: vertical ? (scrollContent.isExpanded ? scrollBar.expandWidth : scrollBar.minimumWidth) : parent.width
            height: horizontal ? (scrollContent.isExpanded ? scrollBar.expandWidth : scrollBar.minimumWidth) : parent.height
            color: Fluent.controlStrongFill
            anchors {
                right: vertical ? parent.right : undefined
                bottom: horizontal ? parent.bottom : undefined
            }
            radius: 9999
            visible: scrollBar.size < 1.0

            Behavior on width { NumberAnimation { duration: 167; easing.type: Easing.OutCubic } }
            Behavior on height { NumberAnimation { duration: 167; easing.type: Easing.OutCubic } }
            Behavior on color { ColorAnimation { duration: Fluent.anim.appearance; easing.type: Easing.OutCubic } }
        }

        Timer {
            id: shrinkTimer
            interval: 450
            onTriggered: scrollContent.isExpanded = false
        }

        Connections {
            target: scrollBar
            function onActiveChanged() {
                if (scrollBar.active) {
                    shrinkTimer.stop()
                    scrollContent.isExpanded = true
                } else if (scrollBar.policy !== T.ScrollBar.AlwaysOn) {
                    shrinkTimer.restart()
                }
            }
        }
    }

    background: Rectangle {
        id: scrollBg
        radius: 5
        color: Fluent.backgroundAcrylic
        opacity: scrollBar.active ? 1 : 0
        visible: scrollBar.size < 1.0

        Behavior on opacity {
            SequentialAnimation {
                PauseAnimation { duration: scrollBar.active ? 0 : 450 }
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
        }
    }
}
