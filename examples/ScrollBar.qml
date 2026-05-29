import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15

// Examples-level ScrollBar override adapted from RinUI and bound to Fluent tokens
ScrollBar {
    id: scrollBar

    property int minimumWidth: Fluent.scrollBarMinWidth
    property int expandWidth: Fluent.scrollBarWidth

    implicitWidth: horizontal
        ? availableWidth
        : implicitContentWidth + leftPadding + rightPadding

    implicitHeight: vertical
        ? availableHeight
        : implicitContentHeight + topPadding + bottomPadding

    anchors.verticalCenter: vertical && parent ? parent.verticalCenter : undefined
    anchors.horizontalCenter: horizontal && parent ? parent.horizontalCenter : undefined
    anchors.right: vertical && parent ? parent.right : undefined
    anchors.bottom: horizontal && parent ? parent.bottom : undefined

    verticalPadding : vertical ? 15 : 3
    horizontalPadding : horizontal ? 15 : 3
    enabled: size < 1.0

    ToolButton {
        background: Item {}
        width: 15
        height: 15
        size: 8
        color: Fluent.textSecondary
        icon.name: vertical ? "ic_fluent_triangle_up_20_filled" : "ic_fluent_triangle_left_20_filled"
        anchors {
            top: vertical ? parent.top : undefined
            left: horizontal ? parent.left : undefined
            horizontalCenter: vertical ? parent.horizontalCenter : undefined
            verticalCenter: horizontal ? parent.verticalCenter : undefined
        }
        onClicked: scrollBar.decrease()

        visible: scrollBar.size < 1.0
        opacity: background.opacity
    }

    ToolButton {
        background: Item {}
        width: 15
        height: 15
        size: 8
        color: Fluent.textSecondary
        icon.name: vertical ? "ic_fluent_triangle_down_20_filled" : "ic_fluent_triangle_right_20_filled"
        anchors {
            bottom: vertical ? parent.bottom : undefined
            right: horizontal ? parent.right : undefined
            horizontalCenter: vertical ? parent.horizontalCenter : undefined
            verticalCenter: horizontal ? parent.verticalCenter : undefined
        }
        onClicked: scrollBar.increase()

        visible: scrollBar.size < 1.0
        opacity: background.opacity
    }

    contentItem: Item {
        id: item
        property bool collapsed: (
            scrollBar.policy === ScrollBar.AlwaysOn || (scrollBar.active)
        )

        implicitWidth: scrollBar.interactive ? scrollBar.expandWidth : scrollBar.minimumWidth
        implicitHeight: scrollBar.interactive ? scrollBar.expandWidth : scrollBar.minimumWidth

        Rectangle{
            id: bar
            width:  vertical ? scrollBar.minimumWidth : parent.width
            height: horizontal ? scrollBar.minimumWidth : parent.height
            color: Fluent.thumbColor
            anchors{
                right: vertical ? parent.right : undefined
                bottom: horizontal ? parent.bottom : undefined
            }
            radius: Fluent.radiusCircle
            visible: scrollBar.size < 1.0

            Behavior on color {
                ColorAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
        }

        states: [
            State{
                name: "collapsed"
                when: item.collapsed
                PropertyChanges {
                    target: bar
                    width:  vertical ? scrollBar.expandWidth : parent.width
                    height: horizontal ? scrollBar.expandWidth : parent.height
                }
            },
            State{
                name: "minimum"
                when: !item.collapsed
                PropertyChanges {
                    target: bar
                    width:  vertical ? scrollBar.minimumWidth : parent.width
                    height: horizontal ? scrollBar.minimumWidth : parent.height
                }
            }
        ]
        transitions:[
            Transition {
                to: "minimum"
                SequentialAnimation {
                    PauseAnimation { duration: 450 }
                    NumberAnimation {
                        target: bar
                        properties: vertical ? "width"  : "height"
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
            },
            Transition {
                to: "collapsed"
                SequentialAnimation {
                    PauseAnimation { duration: 150 }
                    NumberAnimation {
                        target: bar
                        properties: vertical ? "width"  : "height"
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
            }
        ]
    }

    background: Rectangle{
        id: background
        radius: 5
        color: Fluent.scrollBarTrackColor
        opacity: 0
        visible: scrollBar.size < 1.0

        states: [
            State{
                name: "show"
                when: contentItem.collapsed
                PropertyChanges { target: background; opacity: 1 }
            },
            State{
                name: "hide"
                when: !contentItem.collapsed
                PropertyChanges { target: background; opacity: 0 }
            }
        ]

        transitions:[
            Transition {
                to: "hide"
                SequentialAnimation {
                    PauseAnimation { duration: 450 }
                    NumberAnimation {
                        target: background
                        properties: "opacity"
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
            },
            Transition {
                to: "show"
                SequentialAnimation {
                    PauseAnimation { duration: 150 }
                    NumberAnimation {
                        target: background
                        properties: "opacity"
                        duration: 167
                        easing.type: Easing.OutCubic
                    }
                }
            }
        ]
    }
}
