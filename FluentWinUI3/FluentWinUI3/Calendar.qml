// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.FluentWinUI3.impl as Impl
import QtQuick.Templates as T

T.Calendar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    topPadding: Fluent.spacingM
    bottomPadding: Fluent.spacingM
    leftPadding: Fluent.spacingL
    rightPadding: Fluent.spacingL

    readonly property string __currentState: !control.enabled ? "disabled" : "normal"
    readonly property var __config: Config.controls.calendar ? Config.controls.calendar[__currentState] : {}

    font.family: Fluent.fontFamily
    font.pixelSize: Fluent.fontBodySize
    locale: Qt.locale()

    background: Rectangle {
        implicitWidth: 280
        implicitHeight: 300
        color: Fluent.cardBackground
        radius: Fluent.radiusMedium
        border.color: Fluent.border
        border.width: 1
    }

    contentItem: Column {
        spacing: Fluent.spacingS

        // Month/Year header with navigation
        Row {
            id: headerRow
            width: parent.width
            height: Fluent.fontSubtitleSize + Fluent.spacingL

            Text {
                id: prevMonthBtn
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\u25C0"
                font.family: Fluent.fontFamily
                font.pixelSize: 10
                color: control.enabled ? Fluent.textPrimary : Fluent.textDisabled

                property bool hovered: false

                Rectangle {
                    anchors.fill: parent
                    radius: Fluent.radiusSmall
                    color: prevMonthBtn.hovered && control.enabled
                           ? Fluent.controlAltBackgroundHover : "transparent"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: control.enabled
                    hoverEnabled: true
                    onHoveredChanged: prevMonthBtn.hovered = hovered
                    onClicked: control.showPreviousMonth()
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 64
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: control.locale.toString(control.visibleDate, "MMMM yyyy")
                font.family: Fluent.fontFamily
                font.pixelSize: Fluent.fontSubtitleSize
                font.weight: Font.SemiBold
                color: Fluent.textPrimary
            }

            Text {
                id: nextMonthBtn
                anchors.verticalCenter: parent.verticalCenter
                width: 32
                height: 32
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\u25B6"
                font.family: Fluent.fontFamily
                font.pixelSize: 10
                color: control.enabled ? Fluent.textPrimary : Fluent.textDisabled

                property bool hovered: false

                Rectangle {
                    anchors.fill: parent
                    radius: Fluent.radiusSmall
                    color: nextMonthBtn.hovered && control.enabled
                           ? Fluent.controlAltBackgroundHover : "transparent"
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: control.enabled
                    hoverEnabled: true
                    onHoveredChanged: nextMonthBtn.hovered = hovered
                    onClicked: control.showNextMonth()
                }
            }
        }

        // Day of week names header
        Row {
            width: parent.width
            height: 28
            spacing: 0

            Repeater {
                model: control.__dayOfWeekNames

                Text {
                    width: parent.width / 7
                    height: 28
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: modelData
                    font.family: Fluent.fontFamily
                    font.pixelSize: Fluent.fontCaptionSize
                    font.weight: Font.Medium
                    color: Fluent.textSecondary
                }
            }
        }

        // Grid of days
        Grid {
            id: dayGrid
            width: parent.width
            columns: 7
            spacing: 0

            Repeater {
                model: control.__dayModel

                Rectangle {
                    id: dayCell
                    width: dayGrid.width / 7
                    height: dayGrid.width / 7
                    color: {
                        if (!control.enabled && modelData.selected)
                            return Fluent.accentDisabled
                        if (modelData.selected)
                            return Fluent.accent
                        if (dayCell.hovered && control.enabled)
                            return Fluent.controlAltBackgroundHover
                        return "transparent"
                    }
                    radius: Fluent.radiusSmall

                    property bool hovered: false

                    Behavior on color {
                        ColorAnimation { duration: 83 }
                    }

                    // Today indicator ring
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 2
                        radius: Fluent.radiusSmall
                        color: "transparent"
                        border.width: modelData.today && !modelData.selected ? 1.5 : 0
                        border.color: Fluent.accent
                        visible: modelData.today && !modelData.selected
                    }

                    Text {
                        anchors.centerIn: parent
                        text: modelData.day
                        font.family: Fluent.fontFamily
                        font.pixelSize: Fluent.fontBodySize
                        font.weight: modelData.today ? Font.SemiBold : Font.Normal
                        color: {
                            if (!control.enabled)
                                return Fluent.textDisabled
                            if (modelData.selected)
                                return Fluent.textOnAccent
                            if (modelData.today)
                                return Fluent.accent
                            if (modelData.otherMonth)
                                return Fluent.textTertiary
                            return Fluent.textPrimary
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: control.enabled
                        hoverEnabled: true
                        onHoveredChanged: dayCell.hovered = hovered
                        onClicked: {
                            if (modelData.date)
                                control.selectedDate = modelData.date
                        }
                    }
                }
            }
        }
    }

    // Build day of week names based on locale (Monday first)
    readonly property var __dayOfWeekNames: {
        var names = []
        for (var i = 1; i <= 7; i++) {
            var d = new Date(2023, 0, i) // Jan 2023 starts on Sunday
            // Adjust so index 0 = Monday
            var dow = (d.getDay() + 6) % 7 + 1
            var date = new Date(2023, 0, 1 + ((i % 7 === 0 ? 7 : i % 7) + 6) % 7)
            names.push(control.locale.dayName(((i % 7 === 0 ? 7 : i % 7)), Locale.ShortFormat))
        }
        return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    }

    // Build the 6x7 grid of day cells
    property var __dayModel: {
        var days = []
        var visibleYear = control.visibleDate.getFullYear()
        var visibleMonth = control.visibleDate.getMonth()

        var firstDay = new Date(visibleYear, visibleMonth, 1)
        var startDow = (firstDay.getDay() + 6) % 7

        var startDate = new Date(firstDay)
        startDate.setDate(startDate.getDate() - startDow)

        var today = new Date()
        var todayDate = new Date(today.getFullYear(), today.getMonth(), today.getDate())
        var selectedDate = new Date(control.selectedDate.getFullYear(),
                                     control.selectedDate.getMonth(),
                                     control.selectedDate.getDate())

        for (var row = 0; row < 6; row++) {
            for (var col = 0; col < 7; col++) {
                var currentDate = new Date(startDate)
                currentDate.setDate(currentDate.getDate() + row * 7 + col)

                var cellDate = new Date(currentDate.getFullYear(),
                                        currentDate.getMonth(),
                                        currentDate.getDate())
                var isToday = cellDate.getTime() === todayDate.getTime()
                var isSelected = cellDate.getTime() === selectedDate.getTime()
                var isOtherMonth = currentDate.getMonth() !== visibleMonth

                days.push({
                    day: currentDate.getDate(),
                    date: cellDate,
                    today: isToday,
                    selected: isSelected,
                    otherMonth: isOtherMonth
                })
            }
        }
        return days
    }
}
