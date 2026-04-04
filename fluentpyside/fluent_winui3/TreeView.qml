// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.TreeView {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            200)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             200)

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.treeview ? Config.controls.treeview[__currentState] : {}

    readonly property real __indent: 20
    readonly property real __rowHeight: 32

    topPadding: Fluent.spacingXS
    bottomPadding: Fluent.spacingXS
    leftPadding: Fluent.spacingS
    rightPadding: Fluent.spacingS

    clip: true

    contentItem: ListView {
        id: listView
        clip: true
        model: control.model
        currentIndex: control.currentIndex

        boundsBehavior: Flickable.StopAtBounds

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AsNeeded
            minimumSize: 0.1

            contentItem: Rectangle {
                implicitWidth: 4
                radius: width / 2
                color: parent.hovered || parent.pressed
                       ? Fluent.accent : Fluent.borderStrong
                opacity: parent.active || parent.hovered || parent.pressed ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
                }
                Behavior on color {
                    ColorAnimation { duration: 83 }
                }
            }

            background: null
        }

        delegate: Item {
            id: treeDelegate
            width: listView.width
            height: control.__rowHeight
            implicitWidth: width

            readonly property int depth: model !== undefined && model.depth !== undefined
                                          ? model.depth : 0
            readonly property bool expanded: model !== undefined && model.hasChildren !== undefined
                                              ? (treeDelegate.TreeView.isExpanded || !model.hasChildren) : true
            readonly property bool hasChildren: model !== undefined && model.hasChildren !== undefined
                                               ? model.hasChildren : false
            readonly property bool isCurrent: treeDelegate.TreeView.isCurrentItem

            readonly property bool hovered: mouseArea.containsMouse

            // Background
            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                radius: Fluent.radiusSmall
                color: {
                    if (treeDelegate.isCurrent)
                        return Fluent.accentSelected
                    if (treeDelegate.hovered)
                        return Fluent.controlAltBackgroundTransparentHover
                    return "transparent"
                }

                Behavior on color {
                    ColorAnimation { duration: 83 }
                }
            }

            // Expand/collapse chevron
            Text {
                id: chevron
                x: Fluent.spacingS + treeDelegate.depth * control.__indent
                anchors.verticalCenter: parent.verticalCenter
                text: treeDelegate.hasChildren ? "\u25B6" : ""
                font.family: Fluent.fontFamily
                font.pixelSize: Fluent.fontCaptionSize
                color: treeDelegate.hovered ? Fluent.textPrimary : Fluent.textSecondary
                rotation: treeDelegate.expanded ? 90 : 0
                width: treeDelegate.hasChildren ? 16 : 0

                Behavior on rotation {
                    NumberAnimation { duration: 167; easing.type: Easing.OutCubic }
                }
                Behavior on color {
                    ColorAnimation { duration: 83 }
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -4
                    enabled: treeDelegate.hasChildren
                    onClicked: treeDelegate.TreeView.isExpanded = !treeDelegate.TreeView.isExpanded
                }
            }

            // Content text
            Text {
                id: contentText
                x: chevron.x + chevron.width + Fluent.spacingS
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - x - Fluent.spacingS
                text: {
                    if (control.model !== undefined) {
                        var display = control.model.data(treeDelegate.TreeView.index,
                                                          Qt.DisplayRole)
                        return display !== undefined ? display : ""
                    }
                    return modelData !== undefined ? modelData : ""
                }
                font.family: Fluent.fontFamily
                font.pixelSize: Fluent.fontBodySize
                color: !control.enabled ? Fluent.textDisabled
                       : Fluent.textPrimary
                elide: Text.ElideRight
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.currentIndex = treeDelegate.TreeView.index
            }
        }
    }

    background: Rectangle {
        color: Fluent.cardBackground
        radius: Fluent.radiusMedium
        border.color: Fluent.border
        border.width: 1
    }
}
