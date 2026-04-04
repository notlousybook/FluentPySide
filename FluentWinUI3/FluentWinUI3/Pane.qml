// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Pane {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.pane ? Config.controls.pane[__currentState] : {}

    topPadding: Fluent.spacingL
    bottomPadding: Fluent.spacingL
    leftPadding: Fluent.spacingL
    rightPadding: Fluent.spacingL

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 100
        color: Fluent.cardBackground
        radius: Fluent.radiusMedium
        border.color: Fluent.border
        border.width: 1
    }
}
