// TopNavigationView - Horizontal navigation at the top (Fluent Design alternative)
// Provides tab-style navigation with pill indicator, header with hamburger menu,
// and content area below.
//
// Usage:
//   TopNavigationView {
//       model: ["Home", "Data", "Settings", "About"]
//       currentIndex: 0
//       onCurrentIndexChanged: { }
//       Item { ... }  // default property -> content area
//   }

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    // --- Public API ---
    property var model: []
    property int currentIndex: 0

    default property alias content: contentContainer.data

    signal settingsClicked()

    // --- Dimensions ---
    property real headerHeight: 48
    property real itemHeight: 44
    property real iconSize: 16

    // --- Runtime states ---
    property bool _compact: false

    // --- Auto dark/light detection ---
    readonly property bool darkMode: {
        try { 
            let mode = Application.styleHints.colorScheme;
            return mode === Qt.Dark;
        } catch (e) { 
            return true; 
        }
    }

    // --- Theme Colors ---
    property string iconFont: "Segoe MDL2 Assets"
    readonly property color accentColor: darkMode ? "#60cdff" : "#005fb8"
    readonly property color headerBackground: darkMode ? "#2d2d2d" : "#ffffff"
    readonly property color hoverBackgroundColor: darkMode ? "#0dffffff" : "#08000000"
    readonly property color pressedBackgroundColor: darkMode ? "#14ffffff" : "#0f000000"
    readonly property color selectedBackgroundColor: darkMode ? "#0affffff" : "#06000000"
    readonly property color textColor: darkMode ? "#e4e4e4" : "#1a1a1a"
    readonly property color textSecondaryColor: darkMode ? "#9d9d9d" : "#616161"
    readonly property color dividerColor: darkMode ? "#3d3d3d" : "#e5e5e5"
    readonly property color separatorColor: darkMode ? "#404040" : "#e0e0e0"

    // ================================================================
    // Root layout: header with nav tabs + content
    // ================================================================
    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ===== HEADER =====
        Rectangle {
            id: headerBar
            Layout.fillWidth: true
            Layout.preferredHeight: root.headerHeight
            color: root.headerBackground

            // Subtle bottom border
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: root.separatorColor
            }

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // --- Hamburger / Toggle button ---
                Item {
                    Layout.preferredWidth: root.headerHeight
                    Layout.preferredHeight: root.headerHeight

                    Rectangle {
                        id: toggleBtn
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        radius: 4
                        color: toggleMA.containsMouse ? root.hoverBackgroundColor
                             : toggleMA.pressed ? root.pressedBackgroundColor
                             : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: "\uE700"
                            font.family: "Segoe MDL2 Assets"
                            font.pixelSize: 14
                            color: root.textColor
                        }

                        MouseArea {
                            id: toggleMA
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root._compact = !root._compact
                            }
                        }
                    }
                }

                // --- App Title ---
                Text {
                    Layout.leftMargin: 8
                    text: "FluentPySide"
                    font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                    font.pixelSize: 14
                    font.weight: Font.Medium
                    color: root.textColor
                    visible: !root._compact
                }

                // Spacer
                Item { Layout.fillWidth: true }

                // --- Navigation Items with Pill ---
                Item {
                    id: navContainer
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.headerHeight
                    Layout.leftMargin: root._compact ? 8 : 24
                    Layout.rightMargin: root._compact ? 8 : 0

                    // Selection pill background
                    Rectangle {
                        id: navPill
                        height: 32
                        radius: 4
                        color: root.selectedBackgroundColor
                        visible: navRepeater.count > 0
                        y: (root.headerHeight - 32) / 2
                        x: 0
                        width: 0

                        Behavior on x {
                            NumberAnimation { duration: 300; easing.type: Easing.OutQuint }
                        }
                        Behavior on width {
                            NumberAnimation { duration: 300; easing.type: Easing.OutQuint }
                        }
                    }

                    Row {
                        id: navRow
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: root._compact ? 4 : 0

                        Repeater {
                            id: navRepeater
                            model: root.model

                            delegate: Item {
                                id: navItem
                                width: root._compact ? 44 : (root.headerWidth / navRepeater.count)
                                height: 44

                                property bool isSelected: root.currentIndex === index

                                Text {
                                    anchors.centerIn: parent
                                    text: typeof modelData === "object" ? modelData.title : modelData
                                    font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                                    font.pixelSize: 13
                                    font.weight: navItem.isSelected ? Font.Medium : Font.Normal
                                    color: navItem.isSelected ? root.accentColor : root.textColor
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        root.currentIndex = index
                                    }
                                }
                            }
                        }
                    }

                    // Update pill position based on selection
                    onChildrenChanged: Qt.callLater(updatePill)
                    Component.onCompleted: Qt.callLater(updatePill)

                    function updatePill() {
                        if (navRepeater.count === 0) return
                        var item = navRepeater.itemAt(root.currentIndex)
                        if (item) {
                            navPill.x = item.x
                            navPill.width = item.width
                        }
                    }
                }

                // --- Right side actions (settings, etc.) ---
                Item {
                    Layout.preferredWidth: root.headerHeight
                    Layout.preferredHeight: root.headerHeight

                    Rectangle {
                        id: settingsBtn
                        anchors.centerIn: parent
                        width: 32
                        height: 32
                        radius: 4
                        color: settingsMA.containsMouse ? root.hoverBackgroundColor
                             : settingsMA.pressed ? root.pressedBackgroundColor
                             : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: "\uE713"
                            font.family: "Segoe MDL2 Assets"
                            font.pixelSize: 14
                            color: root.textColor
                        }

                        MouseArea {
                            id: settingsMA
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.settingsClicked()
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

    // Update pill when currentIndex changes
    onCurrentIndexChanged: {
        var item = navRepeater.itemAt(currentIndex)
        if (item) {
            navPill.x = item.x
            navPill.width = item.width
        }
    }
}