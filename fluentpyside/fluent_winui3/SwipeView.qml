// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.SwipeView {
    id: control

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.swipeview ? Config.controls.swipeview[__currentState] : {}

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    clip: true

    contentItem: ListView {
        id: listView
        model: control.contentModel
        currentIndex: control.currentIndex
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 250
        highlightMoveVelocity: -1
        boundsBehavior: Flickable.StopAtBounds

        preferredHighlightBegin: 0
        preferredHighlightEnd: width

        maximumFlickVelocity: 4 * (width / 0.25)

        Behavior on x {
            enabled: !listView.moving
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }
    }

    background: Rectangle {
        color: "transparent"
    }
}
