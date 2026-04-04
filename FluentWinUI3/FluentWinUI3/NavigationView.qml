// FluentWinUI3 NavigationView - WinUI 3 style collapsible sidebar
// Auto-detects dark/light mode. Uses Fluent ItemDelegate for nav items.
// Usage:
//   NavigationView {
//       model: ListModel {
//           ListElement { title: "Home"; icon: "\uE700" }
//       }
//       currentIndex: 0
//       onCurrentIndexChanged: { }
//       Item { ... }  // content area
//   }

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property alias model: repeater.model
    property int currentIndex: 0
    property bool compact: false
    property real expandedWidth: 240
    property real compactWidth: 48
    property real navigationWidth: compact ? compactWidth : expandedWidth
    property real topPadding: 4
    property real itemHeight: 36

    signal backButtonClicked()

    default property alias content: contentContainer.data

    // Auto dark/light
    readonly property bool darkMode: {
        try { return Application.styleHints.colorScheme === Qt.ColorScheme.Dark }
        catch (e) { return true }
    }

    // Fluent WinUI 3 colors
    property color accentColor: darkMode ? "#60cdff" : "#005fb8"
    property color accentHoverColor: darkMode ? "#78d0ff" : "#106ebe"
    property color sidebarBackground: darkMode ? "#2b2b2b" : "#f3f3f3"
    property color sidebarHoverColor: darkMode ? "#3a3a3a" : "#e9e9e9"
    property color sidebarActiveColor: darkMode ? "#3d3d3d" : "#e5e5e5"
    property color textColor: darkMode ? "#e4e4e4" : "#1a1a1a"
    property color textSecondaryColor: darkMode ? "#9d9d9d" : "#616161"
    property color dividerColor: darkMode ? "#3d3d3d" : "#e0e0e0"
    property color windowBackground: darkMode ? "#1c1c1c" : "#ffffff"
    property color iconColor: darkMode ? "#e4e4e4" : "#1a1a1a"

    Behavior on navigationWidth {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ===== SIDEBAR =====
        Rectangle {
            id: sidebar
            Layout.fillHeight: true
            Layout.preferredWidth: root.navigationWidth
            color: root.sidebarBackground

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // --- Toggle button ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight + root.topPadding + 4

                    Rectangle {
                        id: toggleBtn
                        anchors.top: parent.top
                        anchors.topMargin: root.topPadding + 2
                        anchors.left: parent.left
                        anchors.leftMargin: root.compact ? 4 : 8
                        width: root.itemHeight
                        height: root.itemHeight
                        radius: 4
                        color: toggleMouse.containsMouse ? root.sidebarHoverColor : "transparent"

                        // Fluent chevron/hamburger icon
                        Canvas {
                            id: toggleIcon
                            anchors.centerIn: parent
                            width: 16
                            height: 16
                            antialiasing: true

                            property real progress: root.compact ? 0 : 1

                            Behavior on progress {
                                NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
                            }

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.reset()
                                ctx.strokeStyle = root.textColor
                                ctx.lineWidth = 1.5
                                ctx.lineCap = "round"

                                // Draw hamburger (3 lines) that morphs to chevron-left
                                var cx = 8
                                var cy = 8
                                var len = 6
                                var spread = 3

                                if (progress < 0.5) {
                                    // Hamburger
                                    var t = progress * 2
                                    for (var i = -1; i <= 1; i++) {
                                        var y = cy + i * spread
                                        ctx.beginPath()
                                        ctx.moveTo(cx - len, y)
                                        ctx.lineTo(cx + len, y)
                                        ctx.stroke()
                                    }
                                } else {
                                    // Chevron left
                                    ctx.beginPath()
                                    ctx.moveTo(cx + 3, cy - spread)
                                    ctx.lineTo(cx - 3, cy)
                                    ctx.lineTo(cx + 3, cy + spread)
                                    ctx.stroke()
                                }
                            }

                            Behavior on progress {
                                NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
                            }
                        }

                        MouseArea {
                            id: toggleMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.compact = !root.compact
                        }
                    }
                }

                // --- Top divider ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: root.compact ? 12 : 8
                    Layout.rightMargin: root.compact ? 12 : 8
                    color: root.dividerColor
                }

                // --- Navigation items ---
                Column {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    topPadding: 4

                    Repeater {
                        id: repeater

                        Item {
                            width: parent.width
                            height: root.itemHeight
                            visible: true

                            // Active indicator pill
                            Rectangle {
                                id: activePill
                                width: root.compact ? (navItemMouse.containsMouse ? parent.width - 8 : parent.width - 8) : 3
                                height: root.compact ? parent.height - 4 : parent.height - 8
                                anchors.left: parent.left
                                anchors.leftMargin: root.compact ? 4 : 2
                                anchors.verticalCenter: parent.verticalCenter
                                radius: root.compact ? 4 : 1.5
                                color: {
                                    if (navItem.index === root.currentIndex) return root.accentColor
                                    if (navItemMouse.containsMouse) return root.sidebarHoverColor
                                    return "transparent"
                                }
                                opacity: (navItem.index === root.currentIndex || navItemMouse.containsMouse) ? 1.0 : 0.0

                                Behavior on width {
                                    NumberAnimation { duration: 100; easing.type: Easing.OutCubic }
                                }
                                Behavior on color {
                                    ColorAnimation { duration: 100 }
                                }
                            }

                            // Icon
                            Text {
                                id: navIcon
                                anchors.left: parent.left
                                anchors.leftMargin: root.compact ? 6 : 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: navItem.icon
                                font.pixelSize: 15
                                font.family: "Segoe MDL2 Assets, Segoe UI Emoji, Noto Color Emoji, sans-serif"
                                color: navItem.index === root.currentIndex ? root.accentColor : root.iconColor

                                Behavior on color {
                                    ColorAnimation { duration: 100 }
                                }
                            }

                            // Title text
                            Text {
                                anchors.left: navIcon.right
                                anchors.leftMargin: 10
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: navItem.title
                                font.pixelSize: 13
                                font.weight: navItem.index === root.currentIndex ? Font.Medium : Font.Normal
                                color: navItem.index === root.currentIndex ? root.accentColor : root.textColor
                                elide: Text.ElideRight
                                visible: !root.compact
                                opacity: root.compact ? 0 : 1

                                Behavior on color {
                                    ColorAnimation { duration: 100 }
                                }
                                Behavior on opacity {
                                    NumberAnimation { duration: 100 }
                                }
                            }

                            MouseArea {
                                id: navItemMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.currentIndex = navItem.index
                            }

                            // Tooltip for compact
                            ToolTip {
                                text: navItem.title
                                visible: root.compact && navItemMouse.containsMouse
                                delay: 500
                            }
                        }
                    }
                }

                // --- Bottom divider ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: root.compact ? 12 : 8
                    Layout.rightMargin: root.compact ? 12 : 8
                    color: root.dividerColor
                }

                // --- Footer (Settings) ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight + 4
                    Layout.bottomMargin: 4

                    Rectangle {
                        id: footerBg
                        anchors.fill: parent
                        anchors.margins: root.compact ? 2 : 0
                        anchors.leftMargin: root.compact ? 4 : 0
                        anchors.rightMargin: root.compact ? 4 : 0
                        radius: 4
                        color: footerMouse.containsMouse ? root.sidebarHoverColor : "transparent"

                        Text {
                            id: footerIcon
                            anchors.left: parent.left
                            anchors.leftMargin: root.compact ? 6 : 12
                            anchors.verticalCenter: parent.verticalCenter
                            text: "\u2699"
                            font.pixelSize: 15
                            font.family: "Segoe MDL2 Assets, Segoe UI Emoji, Noto Color Emoji, sans-serif"
                            color: root.iconColor
                        }

                        Text {
                            anchors.left: footerIcon.right
                            anchors.leftMargin: 10
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Settings"
                            font.pixelSize: 13
                            color: root.textColor
                            elide: Text.ElideRight
                            visible: !root.compact
                            opacity: root.compact ? 0 : 1

                            Behavior on opacity {
                                NumberAnimation { duration: 100 }
                            }
                        }

                        MouseArea {
                            id: footerMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }

        // ===== CONTENT AREA =====
        Rectangle {
            id: contentContainer
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: root.windowBackground
        }
    }
}
