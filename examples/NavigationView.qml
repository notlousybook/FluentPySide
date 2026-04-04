// NavigationView - WinUI 3 style collapsible sidebar navigation
// Faithfully replicates the Windows 11 NavigationView control.
// Uses Segoe MDL2 Assets for icons, auto-detects dark/light mode.
//
// Usage:
//   NavigationView {
//       model: ListModel {
//           ListElement { title: "Home"; icon: "\uE700" }
//       }
//       currentIndex: 0
//       onCurrentIndexChanged: { }
//       onSettingsClicked: { }
//       Item { ... }  // default property -> content area
//   }

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    // --- Public API ---
    property alias model: repeater.model
    property int currentIndex: 0
    property bool compact: false

    default property alias content: contentContainer.data

    signal settingsClicked()

    // --- Dimensions ---
    property real expandedWidth: 240
    property real compactWidth: 48
    property real itemHeight: 40
    property real iconSize: 16

    // --- Auto dark/light detection ---
    readonly property bool darkMode: {
        try { return Application.styleHints.colorScheme === Qt.ColorScheme.Dark }
        catch (e) { return true }
    }

    // --- WinUI 3 Dark Mode Colors ---
    readonly property color accentColor: darkMode ? "#60cdff" : "#005fb8"
    readonly property color sidebarBackground: darkMode ? "#2b2b2b" : "#f3f3f3"
    readonly property color hoverBackgroundColor: darkMode ? "#ffffff0d" : "#00000008"
    readonly property color textColor: darkMode ? "#e4e4e4" : "#1a1a1a"
    readonly property color textDisabledColor: darkMode ? "#5c5c5c" : "#a0a0a0"
    readonly property color dividerColor: darkMode ? "#3d3d3d" : "#e0e0e0"
    readonly property color windowBackground: darkMode ? "#1c1c1c" : "#ffffff"

    // --- Computed sidebar width with animation ---
    property real _sidebarWidth: compact ? compactWidth : expandedWidth

    Behavior on _sidebarWidth {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
    }

    // ================================================================
    // Root layout: sidebar + content
    // ================================================================
    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ===== SIDEBAR =====
        Rectangle {
            id: sidebar
            Layout.fillHeight: true
            Layout.preferredWidth: root._sidebarWidth
            color: root.sidebarBackground

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // --- Toggle button (hamburger / chevron-left) ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight + 8

                    Rectangle {
                        id: toggleBtn
                        anchors.top: parent.top
                        anchors.topMargin: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: root.compact ? (root.compactWidth - 8) : (root.itemHeight + 4)
                        height: root.itemHeight
                        radius: 4
                        color: toggleMouseArea.containsMouse ? root.hoverBackgroundColor : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: root.compact ? "\uE700" : "\uE70E"
                            font.family: "Segoe MDL2 Assets"
                            font.pixelSize: root.iconSize
                            color: root.textColor
                        }

                        MouseArea {
                            id: toggleMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.compact = !root.compact
                        }

                        ToolTip {
                            text: root.compact ? "Expand" : "Collapse"
                            visible: root.compact && toggleMouseArea.containsMouse
                            delay: 500
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

                // --- Navigation items (scrollable) ---
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Column {
                        id: navColumn
                        width: parent.width
                        topPadding: 4
                        bottomPadding: 4

                        Repeater {
                            id: repeater

                            delegate: Item {
                                id: navItemDelegate
                                required property string title
                                required property string icon
                                required property int index

                                width: navColumn.width
                                height: root.itemHeight

                                // Hover background highlight
                                Rectangle {
                                    anchors.fill: parent
                                    anchors.leftMargin: root.compact ? 4 : 0
                                    anchors.rightMargin: root.compact ? 4 : 0
                                    radius: 4
                                    color: root.hoverBackgroundColor
                                    visible: navMouseArea.containsMouse && navItemDelegate.index !== root.currentIndex
                                }

                                // Selected indicator: small accent pill on LEFT edge
                                Rectangle {
                                    width: 3
                                    height: 16
                                    radius: 1.5
                                    anchors.left: parent.left
                                    anchors.leftMargin: 4
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: root.accentColor
                                    visible: navItemDelegate.index === root.currentIndex

                                    Behavior on opacity {
                                        NumberAnimation { duration: 150 }
                                    }
                                }

                                // Icon
                                Text {
                                    id: navIconText
                                    anchors.left: parent.left
                                    anchors.leftMargin: root.compact ? ((root.compactWidth - root.iconSize) / 2) : 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: navItemDelegate.icon
                                    font.family: "Segoe MDL2 Assets"
                                    font.pixelSize: root.iconSize
                                    color: navItemDelegate.index === root.currentIndex ? root.accentColor : root.textColor

                                    Behavior on color {
                                        ColorAnimation { duration: 150 }
                                    }
                                }

                                // Label text (hidden in compact mode)
                                Text {
                                    anchors.left: navIconText.right
                                    anchors.leftMargin: 12
                                    anchors.right: parent.right
                                    anchors.rightMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: navItemDelegate.title
                                    font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                                    font.pixelSize: 13
                                    font.weight: navItemDelegate.index === root.currentIndex ? Font.Medium : Font.Normal
                                    color: navItemDelegate.index === root.currentIndex ? root.accentColor : root.textColor
                                    elide: Text.ElideRight
                                    visible: !root.compact
                                    opacity: root.compact ? 0 : 1

                                    Behavior on color {
                                        ColorAnimation { duration: 150 }
                                    }
                                    Behavior on opacity {
                                        NumberAnimation { duration: 120 }
                                    }
                                }

                                MouseArea {
                                    id: navMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.currentIndex = navItemDelegate.index
                                }

                                // Tooltip in compact mode
                                ToolTip {
                                    text: navItemDelegate.title
                                    visible: root.compact && navMouseArea.containsMouse
                                    delay: 500
                                }
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

                // --- Settings button at bottom ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight
                    Layout.bottomMargin: 4

                    Rectangle {
                        id: settingsBg
                        anchors.fill: parent
                        anchors.leftMargin: root.compact ? 4 : 0
                        anchors.rightMargin: root.compact ? 4 : 0
                        radius: 4
                        color: settingsMouseArea.containsMouse ? root.hoverBackgroundColor : "transparent"

                        Text {
                            id: settingsIconText
                            anchors.left: parent.left
                            anchors.leftMargin: root.compact ? ((root.compactWidth - root.iconSize) / 2) : 16
                            anchors.verticalCenter: parent.verticalCenter
                            text: "\uE713"
                            font.family: "Segoe MDL2 Assets"
                            font.pixelSize: root.iconSize
                            color: root.textColor

                            Behavior on color {
                                ColorAnimation { duration: 150 }
                            }
                        }

                        Text {
                            anchors.left: settingsIconText.right
                            anchors.leftMargin: 12
                            anchors.right: parent.right
                            anchors.rightMargin: 16
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Settings"
                            font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                            font.pixelSize: 13
                            font.weight: Font.Normal
                            color: root.textColor
                            elide: Text.ElideRight
                            visible: !root.compact
                            opacity: root.compact ? 0 : 1

                            Behavior on opacity {
                                NumberAnimation { duration: 120 }
                            }
                        }

                        MouseArea {
                            id: settingsMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.settingsClicked()
                        }

                        ToolTip {
                            text: "Settings"
                            visible: root.compact && settingsMouseArea.containsMouse
                            delay: 500
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
