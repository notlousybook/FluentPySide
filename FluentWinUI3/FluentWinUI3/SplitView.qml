// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.SplitView {
    id: control

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.splitview ? Config.controls.splitview[__currentState] : {}

    handle: Rectangle {
        implicitWidth: control.orientation === Qt.Horizontal ? 8 : control.width
        implicitHeight: control.orientation === Qt.Vertical ? 8 : control.height
        color: "transparent"

        // Visible divider line
        Rectangle {
            width: control.orientation === Qt.Horizontal ? 1 : parent.width
            height: control.orientation === Qt.Vertical ? 1 : parent.height
            anchors.centerIn: parent
            color: __handleItem.hovered ? Fluent.accent : Fluent.divider

            Behavior on color {
                ColorAnimation { duration: 167 }
            }
        }

        // Small grip indicator in center
        Item {
            anchors.centerIn: parent
            width: control.orientation === Qt.Horizontal ? 16 : 4
            height: control.orientation === Qt.Vertical ? 16 : 4
            visible: __handleItem.hovered

            opacity: __handleItem.hovered ? 1.0 : 0.0
            Behavior on opacity {
                NumberAnimation { duration: 83 }
            }

            Row {
                anchors.centerIn: parent
                visible: control.orientation === Qt.Horizontal
                spacing: 2

                Repeater {
                    model: 2
                    Rectangle {
                        width: 1
                        height: 16
                        color: Fluent.textTertiary
                    }
                }
            }

            Column {
                anchors.centerIn: parent
                visible: control.orientation === Qt.Vertical
                spacing: 2

                Repeater {
                    model: 2
                    Rectangle {
                        width: 16
                        height: 1
                        color: Fluent.textTertiary
                    }
                }
            }
        }

        property bool hovered: false

        // Wider hit area for easy grabbing
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: __handleItem.hovered = hovered
        }
    }
}
