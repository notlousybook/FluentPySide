// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.StackView {
    id: control

    readonly property string __currentState: "normal"
    readonly property var __config: Config.controls.stackview ? Config.controls.stackview[__currentState] : {}

    popEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: (control.mirrored ? 1 : -1) * -control.width * 0.33
            to: 0
            duration: 250
            easing.type: Easing.OutCubic
        }
        PropertyAnimation {
            property: "opacity"
            from: 0.5
            to: 1.0
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    popExit: Transition {
        PropertyAnimation {
            property: "x"
            from: 0
            to: (control.mirrored ? -1 : 1) * control.width * 0.33
            duration: 250
            easing.type: Easing.OutCubic
        }
        PropertyAnimation {
            property: "opacity"
            from: 1.0
            to: 0.5
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    pushEnter: Transition {
        PropertyAnimation {
            property: "x"
            from: (control.mirrored ? -1 : 1) * control.width * 0.33
            to: 0
            duration: 250
            easing.type: Easing.OutCubic
        }
        PropertyAnimation {
            property: "opacity"
            from: 0.5
            to: 1.0
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    pushExit: Transition {
        PropertyAnimation {
            property: "x"
            from: 0
            to: (control.mirrored ? 1 : -1) * control.width * 0.33
            duration: 250
            easing.type: Easing.OutCubic
        }
        PropertyAnimation {
            property: "opacity"
            from: 1.0
            to: 0.5
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    replaceEnter: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    replaceExit: Transition {
        PropertyAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 250
            easing.type: Easing.OutCubic
        }
    }
}
