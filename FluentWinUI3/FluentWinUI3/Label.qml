// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Label {
    id: control

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.label ? Config.controls.label[__currentState] : {}

    color: !control.enabled ? Fluent.textDisabled : Fluent.textPrimary
    linkColor: Fluent.accent

    font.family: Fluent.fontFamily
    font.pixelSize: Fluent.fontBodySize

    background: Item {}
}
