// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Tumbler {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             __visibleItemCount * __itemHeight)

    readonly property int __visibleItemCount: 5
    readonly property real __itemHeight: 40

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.tumbler ? Config.controls.tumbler[__currentState] : {}

    topPadding: (Math.floor(__visibleItemCount / 2)) * __itemHeight
    bottomPadding: (Math.floor(__visibleItemCount / 2)) * __itemHeight
    leftPadding: Fluent.spacingM
    rightPadding: Fluent.spacingM

    font.family: Fluent.fontFamily
    font.pixelSize: Fluent.fontBodySize

    contentItem: PathView {
        id: pathView
        model: control.model
        currentIndex: control.currentIndex
        clip: true

        implicitWidth: control.availableWidth
        implicitHeight: control.__visibleItemCount * control.__itemHeight

        delegate: Text {
            id: tumblerDelegate
            text: control.textRole ? (Array.isArray(control.model)
                                        ? modelData[control.textRole]
                                        : model[control.textRole])
                                     : modelData
            width: pathView.width
            height: control.__itemHeight
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font: control.font
            color: {
                if (!control.enabled)
                    return Fluent.textDisabled
                if (tumblerDelegate.PathView.isCurrentItem)
                    return Fluent.textPrimary
                return Fluent.textTertiary
            }
            opacity: tumblerDelegate.PathView.isCurrentItem ? 1.0 : 0.5
            scale: tumblerDelegate.PathView.isCurrentItem ? 1.0 : 0.85

            Behavior on opacity {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
            Behavior on scale {
                NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
            }
        }

        path: Path {
            id: tumblerPath
            startX: pathView.width / 2
            startY: 0

            PathLine {
                x: pathView.width / 2
                y: pathView.height
            }
        }

        preferredHighlightBegin: control.__itemHeight / 2
        preferredHighlightEnd: pathView.height - control.__itemHeight / 2
    }

    // Top fade gradient
    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: control.topPadding
        z: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: Fluent.cardBackground }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    // Bottom fade gradient
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: control.bottomPadding
        z: 1
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: Fluent.cardBackground }
        }
    }

    // Top separator line (above selected item)
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: control.topPadding - control.__itemHeight / 2
        width: parent.width - Fluent.spacingM * 2
        height: 1
        color: Fluent.divider
        z: 2
    }

    // Bottom separator line (below selected item)
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        y: control.height - control.bottomPadding + control.__itemHeight / 2 - 1
        width: parent.width - Fluent.spacingM * 2
        height: 1
        color: Fluent.divider
        z: 2
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: control.__visibleItemCount * control.__itemHeight
        color: "transparent"
        border.color: Fluent.border
        border.width: 1
        radius: Fluent.radiusMedium
    }
}
