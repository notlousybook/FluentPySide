// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.ScrollView {
    id: control
    Component.onCompleted: console.log("FluentWinUI3 ScrollView loaded from FluentWinUI3 module")

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.scrollview ? Config.controls.scrollview[__currentState] : {}

    ScrollBar.vertical: ScrollBar {
        id: verticalScrollBar
        policy: control.ScrollBar.AsNeeded
        minimumSize: 0.1
        verticalPadding: 15
        enabled: size < 1.0

        ToolButton {
            background: Item {}
            width: 15; height: 15; size: 8
            color: Fluent.textSecondary
            icon.name: "ic_fluent_triangle_up_20_filled"
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: verticalScrollBar.decrease()
            visible: verticalScrollBar.size < 1.0
            opacity: background.opacity
        }

        ToolButton {
            background: Item {}
            width: 15; height: 15; size: 8
            color: Fluent.textSecondary
            icon.name: "ic_fluent_triangle_down_20_filled"
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            onClicked: verticalScrollBar.increase()
            visible: verticalScrollBar.size < 1.0
            opacity: background.opacity
        }

        contentItem: Item {
            id: item
            property bool collapsed: (verticalScrollBar.policy === ScrollBar.AlwaysOn || (verticalScrollBar.active))

            implicitWidth: verticalScrollBar.interactive ? verticalScrollBar.expandWidth : verticalScrollBar.minimumWidth
            implicitHeight: verticalScrollBar.interactive ? verticalScrollBar.expandWidth : verticalScrollBar.minimumWidth

            Rectangle{
                id: bar
                width:  vertical ? verticalScrollBar.minimumWidth : parent.width
                height: horizontal ? verticalScrollBar.minimumWidth : parent.height
                color: Fluent.thumbColor
                anchors{
                    right: vertical ? parent.right : undefined
                    bottom: horizontal ? parent.bottom : undefined
                }
                radius: Fluent.radiusCircle
                visible: verticalScrollBar.size < 1.0

                Behavior on color { ColorAnimation { duration: 167; easing.type: Easing.OutCubic } }
            }

            states: [
                State{
                    name: "collapsed"
                    when: item.collapsed
                    PropertyChanges { target: bar; width:  vertical ? verticalScrollBar.expandWidth : parent.width; height: horizontal ? verticalScrollBar.expandWidth : parent.height }
                },
                State{
                    name: "minimum"
                    when: !item.collapsed
                    PropertyChanges { target: bar; width:  vertical ? verticalScrollBar.minimumWidth : parent.width; height: horizontal ? verticalScrollBar.minimumWidth : parent.height }
                }
            ]

            transitions:[
                Transition {
                    to: "minimum"
                    SequentialAnimation {
                        PauseAnimation { duration: 450 }
                        NumberAnimation { target: bar; properties: vertical ? "width"  : "height"; duration: 167; easing.type: Easing.OutCubic }
                    }
                },
                Transition {
                    to: "collapsed"
                    SequentialAnimation {
                        PauseAnimation { duration: 150 }
                        NumberAnimation { target: bar; properties: vertical ? "width"  : "height"; duration: 167; easing.type: Easing.OutCubic }
                    }
                }
            ]
        }

        background: Rectangle{
            id: background
            radius: 5
            color: Fluent.layerBackground
            opacity: 0
            visible: verticalScrollBar.size < 1.0

            states: [
                State{ name: "show"; when: contentItem.collapsed; PropertyChanges { target: background; opacity: 1 } },
                State{ name: "hide"; when: !contentItem.collapsed; PropertyChanges { target: background; opacity: 0 } }
            ]

            transitions:[
                Transition {
                    to: "hide"
                    SequentialAnimation {
                        PauseAnimation { duration: 450 }
                        NumberAnimation { target: background; properties: "opacity"; duration: 167; easing.type: Easing.OutCubic }
                    }
                },
                Transition {
                    to: "show"
                    SequentialAnimation {
                        PauseAnimation { duration: 150 }
                        NumberAnimation { target: background; properties: "opacity"; duration: 167; easing.type: Easing.OutCubic }
                    }
                }
            ]
        }
    }

    ScrollBar.horizontal: ScrollBar {
        id: horizontalScrollBar
        policy: control.ScrollBar.AsNeeded
        minimumSize: 0.1
        horizontalPadding: 15
        enabled: size < 1.0

        ToolButton {
            background: Item {}
            width: 15; height: 15; size: 8
            color: Fluent.textSecondary
            icon.name: "ic_fluent_triangle_left_20_filled"
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
            }
            onClicked: horizontalScrollBar.decrease()
            visible: horizontalScrollBar.size < 1.0
            opacity: background.opacity
        }

        ToolButton {
            background: Item {}
            width: 15; height: 15; size: 8
            color: Fluent.textSecondary
            icon.name: "ic_fluent_triangle_right_20_filled"
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            onClicked: horizontalScrollBar.increase()
            visible: horizontalScrollBar.size < 1.0
            opacity: background.opacity
        }

        contentItem: Item {
            id: itemH
            property bool collapsed: (horizontalScrollBar.policy === ScrollBar.AlwaysOn || (horizontalScrollBar.active))

            implicitWidth: horizontalScrollBar.interactive ? horizontalScrollBar.expandWidth : horizontalScrollBar.minimumWidth
            implicitHeight: horizontalScrollBar.interactive ? horizontalScrollBar.expandWidth : horizontalScrollBar.minimumWidth

            Rectangle{
                id: bar
                width:  horizontal ? horizontalScrollBar.minimumWidth : parent.width
                height: horizontal ? horizontalScrollBar.minimumWidth : parent.height
                color: Fluent.thumbColor
                anchors{
                    right: vertical ? parent.right : undefined
                    bottom: horizontal ? parent.bottom : undefined
                }
                radius: Fluent.radiusCircle
                visible: horizontalScrollBar.size < 1.0

                Behavior on color { ColorAnimation { duration: 167; easing.type: Easing.OutCubic } }
            }

            states: [
                State{
                    name: "collapsed"
                    when: itemH.collapsed
                    PropertyChanges { target: bar; width:  horizontal ? horizontalScrollBar.expandWidth : parent.width; height: horizontal ? horizontalScrollBar.expandWidth : parent.height }
                },
                State{
                    name: "minimum"
                    when: !itemH.collapsed
                    PropertyChanges { target: bar; width:  horizontal ? horizontalScrollBar.minimumWidth : parent.width; height: horizontal ? horizontalScrollBar.minimumWidth : parent.height }
                }
            ]

            transitions:[
                Transition {
                    to: "minimum"
                    SequentialAnimation {
                        PauseAnimation { duration: 450 }
                        NumberAnimation { target: bar; properties: horizontal ? "width"  : "height"; duration: 167; easing.type: Easing.OutCubic }
                    }
                },
                Transition {
                    to: "collapsed"
                    SequentialAnimation {
                        PauseAnimation { duration: 150 }
                        NumberAnimation { target: bar; properties: horizontal ? "width"  : "height"; duration: 167; easing.type: Easing.OutCubic }
                    }
                }
            ]
        }

        background: Rectangle{
            id: background
            radius: 5
            color: Fluent.layerBackground
            opacity: 0
            visible: horizontalScrollBar.size < 1.0

            states: [
                State{ name: "show"; when: contentItem.collapsed; PropertyChanges { target: background; opacity: 1 } },
                State{ name: "hide"; when: !contentItem.collapsed; PropertyChanges { target: background; opacity: 0 } }
            ]

            transitions:[
                Transition {
                    to: "hide"
                    SequentialAnimation {
                        PauseAnimation { duration: 450 }
                        NumberAnimation { target: background; properties: "opacity"; duration: 167; easing.type: Easing.OutCubic }
                    }
                },
                Transition {
                    to: "show"
                    SequentialAnimation {
                        PauseAnimation { duration: 150 }
                        NumberAnimation { target: background; properties: "opacity"; duration: 167; easing.type: Easing.OutCubic }
                    }
                }
            ]
        }
    }

    background: null
}
