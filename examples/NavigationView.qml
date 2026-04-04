// FluentWinUI3 NavigationView - WinUI 3 style collapsible sidebar
// Usage:
//   NavigationView {
//       model: ListModel {
//           ListElement { title: "Home"; icon: "\u2630" }
//           ListElement { title: "Settings"; icon: "\u2699" }
//       }
//       currentIndex: 0
//       onCurrentIndexChanged: { /* navigate */ }
//       Item { ... }  // content area (default property)
//   }

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    // Public API
    property alias model: repeater.model
    property int currentIndex: 0
    property bool compact: false
    property real expandedWidth: 240
    property real compactWidth: 48
    property real navigationWidth: compact ? compactWidth : expandedWidth
    property color accentColor: "#005fb8"
    property color sidebarBackground: "#f3f3f3"
    property color sidebarHoverColor: "#e5e5e5"
    property color sidebarActiveColor: "#e0e0e0"
    property color textColor: "#1a1a1a"
    property color textSecondaryColor: "#616161"
    property color dividerColor: "#e0e0e0"
    property real topPadding: 4
    property real itemHeight: 40

    // Signals
    signal backButtonClicked()

    // Content area (default property)
    default property alias content: contentContainer.data

    Behavior on navigationWidth {
        NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
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
                NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
            }

            // Vertical layout for sidebar contents
            Item {
                anchors.fill: parent

                // Toggle button area
                Rectangle {
                    id: toggleArea
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: root.itemHeight + root.topPadding

                    // Hamburger / Collapse button
                    Rectangle {
                        id: toggleBtn
                        anchors.top: parent.top
                        anchors.topMargin: root.topPadding
                        anchors.left: parent.left
                        anchors.leftMargin: root.compact ? 4 : 8
                        width: root.itemHeight
                        height: root.itemHeight
                        radius: 4
                        color: toggleMouse.containsMouse ? root.sidebarHoverColor : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: root.compact ? "\u2630" : "\u00AB"
                            font.pixelSize: 14
                            color: root.textColor
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

                // Top divider
                Rectangle {
                    id: topDivider
                    anchors.top: toggleArea.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: root.compact ? 12 : 8
                    anchors.rightMargin: root.compact ? 12 : 8
                    height: 1
                    color: root.dividerColor
                }

                // Navigation items list
                Column {
                    id: navItems
                    anchors.top: topDivider.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: bottomDivider.top
                    topPadding: 4

                    Repeater {
                        id: repeater

                        Rectangle {
                            id: navItem
                            required property int index
                            required property string title
                            required property string icon
                            width: navItems.width
                            height: root.itemHeight
                            color: "transparent"

                            // Active indicator (left accent bar)
                            Rectangle {
                                width: 3
                                height: navItem.height - 10
                                anchors.left: parent.left
                                anchors.leftMargin: 2
                                anchors.verticalCenter: parent.verticalCenter
                                radius: 1.5
                                color: root.accentColor
                                visible: navItem.index === root.currentIndex
                            }

                            // Hover / Active background
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 2
                                radius: 4
                                color: {
                                    if (navItem.index === root.currentIndex) return root.sidebarActiveColor
                                    if (itemMouse.containsMouse) return root.sidebarHoverColor
                                    return "transparent"
                                }
                            }

                            // Content row (icon + text)
                            Row {
                                anchors.left: parent.left
                                anchors.leftMargin: root.compact ? 4 : 8
                                anchors.right: parent.right
                                anchors.rightMargin: root.compact ? 4 : 8
                                anchors.verticalCenter: parent.verticalCenter
                                height: root.itemHeight - 8
                                spacing: 12

                                // Icon
                                Text {
                                    width: root.itemHeight - 8
                                    height: parent.height
                                    text: navItem.icon
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: navItem.index === root.currentIndex ? root.accentColor : root.textColor
                                }

                                // Title
                                Text {
                                    text: navItem.title
                                    font.pixelSize: 13
                                    height: parent.height
                                    verticalAlignment: Text.AlignVCenter
                                    color: navItem.index === root.currentIndex ? root.accentColor : root.textColor
                                    elide: Text.ElideRight
                                    width: root.compact ? 0 : implicitWidth
                                    clip: true
                                    visible: !root.compact

                                    Behavior on width {
                                        NumberAnimation { duration: 150 }
                                    }
                                }
                            }

                            // Click handler
                            MouseArea {
                                id: itemMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.currentIndex = navItem.index
                            }

                            // Tooltip for compact mode
                            ToolTip {
                                text: navItem.title
                                visible: root.compact && itemMouse.containsMouse
                                delay: 500
                            }
                        }
                    }
                }

                // Bottom divider
                Rectangle {
                    id: bottomDivider
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: footerArea.top
                    anchors.leftMargin: root.compact ? 12 : 8
                    anchors.rightMargin: root.compact ? 12 : 8
                    height: 1
                    color: root.dividerColor
                }

                // Footer area (settings button)
                Rectangle {
                    id: footerArea
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    height: root.itemHeight + 8

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 2
                        radius: 4
                        color: footerMouse.containsMouse ? root.sidebarHoverColor : "transparent"

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: root.compact ? 4 : 8
                            anchors.verticalCenter: parent.verticalCenter
                            height: root.itemHeight
                            spacing: 12

                            Text {
                                width: root.itemHeight - 8
                                height: parent.height
                                text: "\u2699"
                                font.pixelSize: 16
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: root.textColor
                            }

                            Text {
                                text: "Settings"
                                font.pixelSize: 13
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                                color: root.textColor
                                elide: Text.ElideRight
                                visible: !root.compact
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
        Item {
            id: contentContainer
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
