// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    readonly property string __currentState: [
        !control.enabled && "disabled",
        control.enabled && control.pressed && "pressed",
        control.enabled && control.hovered && "hovered"
    ].filter(Boolean).join("_") || "normal"
    readonly property var __config: Config.controls.dial ? Config.controls.dial[__currentState] : {}

    readonly property real __angleRange: control.endAngle - control.startAngle
    readonly property real __handleAngle: control.startAngle
                                            + (control.value - control.from)
                                              / (control.to - control.from) * __angleRange
    readonly property real __handleRadius: width / 2 - Fluent.spacingXL
    readonly property real __trackWidth: 4

    background: Canvas {
        implicitWidth: 200
        implicitHeight: 200

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var cx = width / 2
            var cy = height / 2
            var radius = Math.min(cx, cy) - Fluent.spacingXL

            // Clear
            ctx.clearRect(0, 0, width, height)

            // Draw background track (full arc)
            ctx.beginPath()
            ctx.arc(cx, cy, radius,
                    (control.startAngle - 90) * Math.PI / 180,
                    (control.endAngle - 90) * Math.PI / 180, false)
            ctx.lineWidth = control.__trackWidth
            ctx.strokeStyle = control.enabled ? Fluent.inputBorder : Fluent.borderDisabled
            ctx.lineCap = "round"
            ctx.stroke()

            // Draw active track (value arc)
            if (control.value !== control.from) {
                ctx.beginPath()
                ctx.arc(cx, cy, radius,
                        (control.startAngle - 90) * Math.PI / 180,
                        (control.__handleAngle - 90) * Math.PI / 180, false)
                ctx.lineWidth = control.__trackWidth
                ctx.strokeStyle = control.enabled
                                  ? (control.pressed ? Fluent.accentPressed : Fluent.accent)
                                  : Fluent.accentDisabled
                ctx.lineCap = "round"
                ctx.stroke()
            }

            // Draw tick marks
            var numTicks = 12
            for (var i = 0; i <= numTicks; i++) {
                var angle = (control.startAngle + (control.__angleRange * i / numTicks) - 90) * Math.PI / 180
                var innerR = radius - 10
                var outerR = radius - 6
                var x1 = cx + innerR * Math.cos(angle)
                var y1 = cy + innerR * Math.sin(angle)
                var x2 = cx + outerR * Math.cos(angle)
                var y2 = cy + outerR * Math.sin(angle)

                ctx.beginPath()
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.lineWidth = 1.5
                ctx.strokeStyle = control.enabled ? Fluent.textTertiary : Fluent.borderDisabled
                ctx.lineCap = "round"
                ctx.stroke()
            }
        }
    }

    handle: Rectangle {
        id: handle
        x: control.background.x + control.background.width / 2
           - handle.width / 2
           + Math.cos((control.__handleAngle - 90) * Math.PI / 180) * control.__handleRadius
        y: control.background.y + control.background.height / 2
           - handle.height / 2
           + Math.sin((control.__handleAngle - 90) * Math.PI / 180) * control.__handleRadius
        width: control.pressed ? 18 : 16
        height: control.pressed ? 18 : 16
        radius: width / 2
        color: control.enabled
               ? (control.pressed ? Fluent.accentPressed : Fluent.accent)
               : Fluent.accentDisabled
        border.color: control.enabled ? Fluent.textOnAccent : "transparent"
        border.width: 1

        Behavior on width {
            NumberAnimation { duration: 83; easing.type: Easing.OutCubic }
        }
        Behavior on height {
            NumberAnimation { duration: 83; easing.type: Easing.OutCubic }
        }
        Behavior on color {
            ColorAnimation { duration: 83 }
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 4
            radius: width / 2
            color: "transparent"
            border.width: 1
            border.color: control.enabled
                           ? (control.pressed
                              ? (Fluent.isDark ? "#ffffff30" : "#00000020")
                              : (Fluent.isDark ? "#ffffff15" : "#00000010"))
                           : "transparent"
        }
    }

    // Repaint when value changes
    onValueChanged: control.background.requestPaint()
}
