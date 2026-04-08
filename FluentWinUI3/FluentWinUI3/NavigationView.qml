// NavigationView — RinUI-inspired collapsible sidebar for FluentPySide
// Features: smooth expand/collapse animations, accent indicator pill,
// hover/press states with scale animation, compact mode with tooltips,
// top/middle/bottom sections with separators.
//
// Usage:
//   NavigationView {
//       model: ListModel {
//           ListElement { title: "Home"; icon: "\uE10F" }
//           ListElement { title: "Settings"; icon: "\uE713"; position: 2 }
//       }
//       currentIndex: 0
//       onCurrentIndexChanged: { }
//       onSettingsClicked: { }
//       Item { ... }  // default property -> content area
//   }
// position: 0=top, 1=middle(default), 2=bottom

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
    signal pageChanged()

    // --- Dimensions ---
    property real expandedWidth: 260
    property real compactWidth: 48
    property real itemHeight: 38
    property real iconSize: 16
    property real topMargin: 10

    // --- NEW FEATURES CONFIGURATION ---
    property bool autoCollapseEnabled: true
    property real autoCollapseThreshold: 900
    property bool overlayModeEnabled: true

    // --- Runtime states ---
    property bool _overlayOpen: false

    // --- Auto dark/light detection ---
    readonly property bool darkMode: {
        try { return Application.styleHints.colorScheme === Qt.ColorScheme.Dark }
        catch (e) { return true }
    }

    // --- Theme Colors (RinUI-inspired, WinUI 3 Fluent 2) ---
    readonly property color accentColor: darkMode ? "#60cdff" : "#005fb8"
    readonly property color sidebarBackground: darkMode ? "#2b2b2b" : "#f3f3f3"
    readonly property color hoverBackgroundColor: darkMode ? "#ffffff0d" : "#00000008"
    readonly property color pressedBackgroundColor: darkMode ? "#ffffff14" : "#0000000f"
    readonly property color selectedBackgroundColor: darkMode ? "#ffffff0a" : "#00000006"
    readonly property color textColor: darkMode ? "#e4e4e4" : "#1a1a1a"
    readonly property color textSecondaryColor: darkMode ? "#9d9d9d" : "#616161"
    readonly property color dividerColor: darkMode ? "#3d3d3d" : "#e5e5e5"
    readonly property color separatorColor: darkMode ? "#404040" : "#e0e0e0"

    // --- Computed sidebar width with animation ---
    property real _sidebarWidth: compact ? compactWidth : expandedWidth

    Behavior on _sidebarWidth {
        NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
    }

    // --- Helper: is this the first item (Home)? ---
    function isFirstItem(idx) { return idx === 0 }

    // --- Helper: is this a bottom-pinned item? ---
    function isBottomItem(itemData) {
        return itemData.position === 2
    }

    // --- Helper: get title for real index ---
    function titleForIndex(idx) {
        if (!repeater.model || !repeater.model.get) return ""
        return repeater.model.get(idx).title || ""
    }

    // --- Overlay close when clicking outside ---
    MouseArea {
        id: overlayDismissArea
        anchors.fill: parent
        z: 9
        visible: _overlayOpen
        onClicked: _overlayOpen = false
        activeFocusOnTab: false
        focusPolicy: Qt.NoFocus
        focusPolicy: Qt.NoFocus

        Rectangle {
            anchors.fill: parent
            color: "#00000040"
            opacity: 0
            Behavior on opacity { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
        }
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
            z: 10
            Layout.fillHeight: true
            Layout.preferredWidth: root._sidebarWidth
            color: root.sidebarBackground

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
            }

            // Subtle border on right edge when expanded
            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: -1
                border.color: root.darkMode ? "#404040" : "#d0d0d0"
                border.width: 1
                visible: !root.compact
                Behavior on visible { NumberAnimation { duration: 150 } }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                // --- Top margin spacer ---
                Item { Layout.preferredHeight: root.topMargin }

                // --- Toggle button (hamburger / navigation icon) ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight + 4

                    Rectangle {
                        id: toggleBtn
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: root.compact ? (root.compactWidth - 8) : root.itemHeight
                        height: root.itemHeight
                        radius: 6
                        color: toggleMA.containsMouse ? root.hoverBackgroundColor
                             : toggleMA.pressed ? root.pressedBackgroundColor
                             : "transparent"

                        Behavior on color { ColorAnimation { duration: 100 } }

                        Text {
                            anchors.centerIn: parent
                            text: root.compact ? "\uE700" : "\uE70E"
                            font.family: "Segoe MDL2 Assets"
                            font.pixelSize: 16
                            color: root.textColor
                        }

                        MouseArea {
                            id: toggleMA
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            activeFocusOnTab: false
                            focusPolicy: Qt.NoFocus
                            focusPolicy: Qt.NoFocus
                            onClicked: {
                                if (width < autoCollapseThreshold && compact) {
                                    _overlayOpen = true
                                } else {
                                    root.compact = !root.compact
                                }
                            }
                        }

                        ToolTip {
                            text: root.compact ? "Expand" : "Collapse"
                            visible: root.compact && toggleMA.containsMouse
                            delay: 500
                        }
                    }
                }

                // --- Separator below toggle ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    color: root.separatorColor
                }

                // --- Main navigation items (scrollable) ---
                Flickable {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentWidth: width
                    contentHeight: navColumn.implicitHeight
                    clip: true

                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

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
                                property int itemPosition: (typeof position !== "undefined") ? position : 1
                                property bool isBottom: itemPosition === 2
                                property bool isFirst: index === 0

                                width: navColumn.width
                                height: root.itemHeight

                                // --- Separator ABOVE this item if it's the first non-top item ---
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.leftMargin: 12
                                    anchors.rightMargin: 12
                                    height: 1
                                    color: root.separatorColor
                                    visible: !isFirst && !isBottom
                                }

                                // --- Hover / pressed / selected background ---
                                Rectangle {
                                    anchors.fill: parent
                                    anchors.leftMargin: root.compact ? 4 : 6
                                    anchors.rightMargin: root.compact ? 4 : 6
                                    anchors.topMargin: isFirst ? 0 : 1
                                    radius: 6
                                    color: navItemDelegate.isSelected ? root.selectedBackgroundColor
                                         : navMA.containsMouse && !navMA.pressed ? root.hoverBackgroundColor
                                         : navMA.pressed ? root.pressedBackgroundColor
                                         : "transparent"

                                    Behavior on color { ColorAnimation { duration: 100 } }
                                }

                                // --- Selected indicator: accent pill on LEFT edge ---
                                Rectangle {
                                    width: 3
                                    height: 18
                                    radius: 1.5
                                    anchors.left: parent.left
                                    anchors.leftMargin: root.compact ? 0 : 2
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: root.accentColor
                                    visible: navItemDelegate.isSelected
                                    opacity: navItemDelegate.isSelected ? 1.0 : 0.0

                                    Behavior on opacity {
                                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                                    }
                                    Behavior on height {
                                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                                    }
                                }

                                // --- Icon ---
                                Text {
                                    id: navIcon
                                    anchors.left: parent.left
                                    anchors.leftMargin: root.compact ? ((root.compactWidth - root.iconSize) / 2) : 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: navItemDelegate.icon
                                    font.family: "Segoe MDL2 Assets"
                                    font.pixelSize: root.iconSize
                                    color: navItemDelegate.isSelected ? root.accentColor : root.textColor
                                    opacity: navItemDelegate.isSelected ? 1.0 : (navMA.containsMouse ? 1.0 : 0.85)

                                    Behavior on color { ColorAnimation { duration: 150 } }
                                    Behavior on opacity { NumberAnimation { duration: 150 } }
                                }

                                // --- Label text (smooth fade in compact mode) ---
                                Text {
                                    anchors.left: navIcon.right
                                    anchors.leftMargin: 12
                                    anchors.right: parent.right
                                    anchors.rightMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: navItemDelegate.title
                                    font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                                    font.pixelSize: 13
                                    font.weight: navItemDelegate.isSelected ? Font.Medium : Font.Normal
                                    color: navItemDelegate.isSelected ? root.accentColor : root.textColor
                                    elide: Text.ElideRight
                                    visible: !root.compact
                                    opacity: root.compact ? 0 : 1

                                    Behavior on color { ColorAnimation { duration: 150 } }
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200; easing.type: Easing.InOutQuint }
                                    }
                                }

                                // --- Mouse interaction ---
                                MouseArea {
                                    id: navMA
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    activeFocusOnTab: false
                                    focusPolicy: Qt.NoFocus
                                    focusPolicy: Qt.NoFocus
                                    onClicked: {
                                        root.currentIndex = navItemDelegate.index
                                        root.pageChanged()
                                        if (_overlayOpen) _overlayOpen = false
                                    }
                                }

                                // --- Tooltip in compact mode ---
                                ToolTip {
                                    text: navItemDelegate.title
                                    visible: root.compact && navMA.containsMouse
                                    delay: 500
                                }

                                // Computed isSelected
                                readonly property bool isSelected: root.currentIndex === navItemDelegate.index
                            }
                        }
                    }
                }

                // --- Bottom separator (before Settings) ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    color: root.separatorColor
                    visible: hasBottomItems()
                }

                // --- Settings button at bottom ---
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.itemHeight
                    Layout.bottomMargin: 4

                    Rectangle {
                        id: settingsBg
                        anchors.fill: parent
                        anchors.leftMargin: root.compact ? 4 : 6
                        anchors.rightMargin: root.compact ? 4 : 6
                        radius: 6
                        color: settingsMouseArea.containsMouse ? root.hoverBackgroundColor
                             : settingsMouseArea.pressed ? root.pressedBackgroundColor
                             : "transparent"

                        Behavior on color { ColorAnimation { duration: 100 } }

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
                            activeFocusOnTab: false
                            focusPolicy: Qt.NoFocus
                            focusPolicy: Qt.NoFocus
                            onClicked: {
                                root.settingsClicked()
                                if (_overlayOpen) _overlayOpen = false
                            }
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

    // Helper: check if any model item has position 2
    function hasBottomItems() {
        if (!repeater.model || !repeater.model.count) return false
        for (var i = 0; i < repeater.model.count; i++) {
            var pos = repeater.model.get(i).position
            if (pos !== undefined && pos === 2) return true
        }
        return false
    }

    // Overlay positioning for small screens
    states: [
        State {
            name: "overlay"
            when: _overlayOpen
            PropertyChanges {
                target: sidebar
                x: 0
                Layout.preferredWidth: expandedWidth
                z: 10
                color: root.sidebarBackground
            }
            PropertyChanges {
                target: overlayDismissArea
                opacity: 1
            }
        }
    ]

    Component.onCompleted: {
        // COMPLETELY DISABLE QT'S FORCED YELLOW HIGHLIGHT
        palette.highlight = Qt.rgba(0,0,0,0)
        palette.highlightedText = root.textColor
        palette.window = root.sidebarBackground
    }
}
