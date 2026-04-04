// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.ScrollView {
    id: control

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

        contentItem: Rectangle {
            implicitWidth: 4
            radius: width / 2
            color: verticalScrollBar.hovered || verticalScrollBar.pressed
                   ? Fluent.accent : Fluent.borderStrong
            opacity: verticalScrollBar.active || verticalScrollBar.hovered || verticalScrollBar.pressed ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 83 }
            }
        }

        background: null
    }

    ScrollBar.horizontal: ScrollBar {
        id: horizontalScrollBar
        policy: control.ScrollBar.AsNeeded
        minimumSize: 0.1

        contentItem: Rectangle {
            implicitHeight: 4
            radius: height / 2
            color: horizontalScrollBar.hovered || horizontalScrollBar.pressed
                   ? Fluent.accent : Fluent.borderStrong
            opacity: horizontalScrollBar.active || horizontalScrollBar.hovered || horizontalScrollBar.pressed ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 83 }
            }
        }

        background: null
    }

    background: null
}
