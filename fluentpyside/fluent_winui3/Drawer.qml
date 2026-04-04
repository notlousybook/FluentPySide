// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Drawer {
    id: control

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
    implicitHeight: implicitBackgroundHeight + topInset + bottomInset

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.drawer ? Config.controls.drawer[__currentState] : {}

    topPadding: Fluent.spacingL
    bottomPadding: Fluent.spacingL
    leftPadding: Fluent.spacingL
    rightPadding: Fluent.spacingL

    enter: Transition {
        NumberAnimation {
            property: "position"
            from: 0.0; to: 1.0
            easing.type: Easing.OutCubic
            duration: 250
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "position"
            from: 1.0; to: 0.0
            easing.type: Easing.OutCubic
            duration: 250
        }
    }

    background: Rectangle {
        implicitWidth: control.edge === Qt.TopEdge || control.edge === Qt.BottomEdge
                       ? parent.width : 320
        implicitHeight: control.edge === Qt.TopEdge || control.edge === Qt.BottomEdge
                        ? 320 : parent.height
        color: Fluent.cardBackground

        // Border on the edge facing content
        Rectangle {
            visible: true
            color: Fluent.border
            width: parent.width
            height: 1
            anchors.bottom: control.edge === Qt.TopEdge ? parent.bottom : undefined
            anchors.top: control.edge === Qt.BottomEdge ? parent.top : undefined
            anchors.right: control.edge === Qt.LeftEdge ? parent.right : undefined
            anchors.left: control.edge === Qt.RightEdge ? parent.left : undefined
        }

        // Shadow for edge drawers
        layer.enabled: true
        layer.effect: Item {
            // Shadow is handled by the drawer overlay
        }
    }

    T.Overlay.modal: Rectangle {
        color: Color.transparent(Fluent.isDark ? "#000000" : "#000000", 0.4)

        Behavior on opacity {
            NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
        }
    }

    T.Overlay.modeless: Rectangle {
        color: "transparent"
    }
}
