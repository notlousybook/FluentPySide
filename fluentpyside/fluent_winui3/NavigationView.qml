// NavigationView — Optimized collapsible sidebar for FluentPySide
// Features: smooth expand/collapse animations, sliding accent indicator pill,
// hover/press states, compact mode with tooltips, subItems expansion,
// top/middle/bottom sections with separators.
//
// Usage:
//   NavigationView {
//       // Model can be an Array of JS objects to support nested subItems easily
//       model: [
//           { title: "Home", icon: "\uE10F" },
//           { title: "Data", icon: "\uE189", subItems: [
//               { title: "Metrics", icon: "\uE193" }
//           ]},
//           { title: "Settings", icon: "\uE713", position: 2 }
//       ]
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
    property var model: []
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

    // --- Auto dark/light detection (hardened) ---
    readonly property bool darkMode: {
        try { 
            let mode = Application.styleHints.colorScheme;
            if (mode === Qt.ColorScheme.Unknown) return true; // Default to dark instead of white if unknown
            return mode === Qt.ColorScheme.Dark;
        } catch (e) { 
            return true; 
        }
    }

    // --- Theme Colors ---
    property string iconFont: "Segoe MDL2 Assets"
    readonly property color accentColor: darkMode ? "#60cdff" : "#005fb8"
    readonly property color sidebarBackground: darkMode ? "#2b2b2b" : "#f3f3f3"
    readonly property color hoverBackgroundColor: darkMode ? "#0dffffff" : "#08000000"
    readonly property color pressedBackgroundColor: darkMode ? "#14ffffff" : "#0f000000"
    readonly property color selectedBackgroundColor: darkMode ? "#0affffff" : "#06000000"
    readonly property color textColor: darkMode ? "#e4e4e4" : "#1a1a1a"
    readonly property color textSecondaryColor: darkMode ? "#9d9d9d" : "#616161"
    readonly property color dividerColor: darkMode ? "#3d3d3d" : "#e5e5e5"
    readonly property color separatorColor: darkMode ? "#404040" : "#e0e0e0"

    // --- Computed sidebar width with RinUI-like animation ---
    property real _sidebarWidth: compact ? compactWidth : expandedWidth

    Behavior on _sidebarWidth {
        NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
    }

    // --- Overlay close when clicking outside ---
    MouseArea {
        id: overlayDismissArea
        anchors.fill: parent
        z: 9
        visible: _overlayOpen
        onClicked: _overlayOpen = false
        activeFocusOnTab: false

        Rectangle {
            anchors.fill: parent
            color: "#00000040"
            opacity: _overlayOpen ? 1 : 0
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
                color: "transparent"
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
                    id: mainNavFlickable
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    contentWidth: width
                    contentHeight: navColumn.implicitHeight
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds

                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                    Column {
                        id: navColumn
                        width: parent.width
                        topPadding: 4
                        bottomPadding: 4

                        Repeater {
                            id: repeater
                            model: root.model
                            
                            delegate: Item {
                                id: navItemDelegate
                                // Required properties depending on model type (JS array vs ListModel)
                                property string titleText: typeof modelData !== "undefined" && modelData.title ? modelData.title : (typeof title !== "undefined" ? title : "")
                                property string iconText: typeof modelData !== "undefined" && modelData.icon ? modelData.icon : (typeof icon !== "undefined" ? icon : "")
                                property int itemPosition: typeof modelData !== "undefined" && typeof modelData.position !== "undefined" ? modelData.position : (typeof position !== "undefined" ? position : 1)
                                property bool isBottom: itemPosition === 2
                                property bool isFirst: index === 0
                                property var subItemsArray: typeof modelData !== "undefined" && modelData.subItems ? modelData.subItems : []
                                property bool hasSubItems: subItemsArray.length > 0
                                property bool isItemExpanded: false
                                property bool isSelected: root.currentIndex === index

                                width: navColumn.width
                                height: root.itemHeight + (isItemExpanded && !root.compact ? subItemsColumn.implicitHeight : 0)
                                visible: !isBottom

                                Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutQuint } }

                                // Reset subItems expansion when compact
                                Connections {
                                    target: root
                                    function onCompactChanged() {
                                        if (root.compact) isItemExpanded = false;
                                    }
                                }

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
                                    id: itemBg
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    height: root.itemHeight
                                    anchors.leftMargin: root.compact ? 4 : 6
                                    anchors.rightMargin: root.compact ? 4 : 6
                                    anchors.topMargin: isFirst ? 0 : 1
                                    radius: 6
                                    color: navItemDelegate.isSelected ? root.selectedBackgroundColor
                                         : navMA.containsMouse && !navMA.pressed ? root.hoverBackgroundColor
                                         : navMA.pressed ? root.pressedBackgroundColor
                                         : "transparent"

                                    Behavior on color { ColorAnimation { duration: 100 } }

                                    // --- Selected indicator tracking (local fallback for nested views if global is hard)---
                                    // For simplicity in single-file architecture, keeping an animating pill per root item
                                    // but with RinUI vertical expanding animation instead of fade.
                                    Rectangle {
                                        width: 3
                                        height: navItemDelegate.isSelected ? 18 : 0
                                        radius: 1.5
                                        anchors.left: parent.left
                                        anchors.leftMargin: root.compact ? 0 : 2
                                        anchors.verticalCenter: parent.verticalCenter
                                        color: root.accentColor
                                        
                                        Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutQuint } }
                                    }

                                    // --- Icon ---
                                    Text {
                                        id: navIcon
                                        anchors.left: parent.left
                                        anchors.leftMargin: root.compact ? ((root.compactWidth - root.iconSize) / 2) - 4 : 16 - 6
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: navItemDelegate.iconText
                                        font.family: root.iconFont
                                        font.pixelSize: root.iconSize
                                        color: navItemDelegate.isSelected ? root.accentColor : root.textColor
                                        opacity: navItemDelegate.isSelected ? 1.0 : (navMA.containsMouse ? 1.0 : 0.85)

                                        Behavior on color { ColorAnimation { duration: 150 } }
                                        Behavior on opacity { NumberAnimation { duration: 150 } }
                                    }

                                    // --- Label text ---
                                    Text {
                                        id: navTitle
                                        anchors.left: navIcon.right
                                        anchors.leftMargin: 12
                                        anchors.right: expandBtn.visible ? expandBtn.left : parent.right
                                        anchors.rightMargin: 16
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: navItemDelegate.titleText
                                        font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                                        font.pixelSize: 13
                                        font.weight: navItemDelegate.isSelected ? Font.Medium : Font.Normal
                                        color: navItemDelegate.isSelected ? root.accentColor : root.textColor
                                        elide: Text.ElideRight
                                        visible: !root.compact
                                        opacity: root.compact ? 0 : 1

                                        Behavior on color { ColorAnimation { duration: 150 } }
                                        Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuint } }
                                    }

                                    // --- SubItems expand chevron ---
                                    Text {
                                        id: expandBtn
                                        anchors.right: parent.right
                                        anchors.rightMargin: 16
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: "\uE70D" // Chevron Down
                                        font.family: "Segoe MDL2 Assets"
                                        font.pixelSize: 12
                                        color: root.textColor
                                        opacity: 0.7
                                        visible: hasSubItems && !root.compact

                                        transform: Rotation {
                                            origin.x: expandBtn.width / 2
                                            origin.y: expandBtn.height / 2
                                            angle: navItemDelegate.isItemExpanded ? 180 : 0
                                            Behavior on angle { NumberAnimation { duration: 250; easing.type: Easing.OutQuint } }
                                        }
                                    }

                                    MouseArea {
                                        id: navMA
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            if (hasSubItems) {
                                                navItemDelegate.isItemExpanded = !navItemDelegate.isItemExpanded;
                                                if (root.compact) {
                                                    root.compact = false; 
                                                    navItemDelegate.isItemExpanded = true;
                                                }
                                            } else {
                                                root.currentIndex = index;
                                                root.pageChanged();
                                                if (_overlayOpen) _overlayOpen = false;
                                            }
                                        }
                                    }

                                    ToolTip {
                                        text: navItemDelegate.titleText
                                        visible: root.compact && navMA.containsMouse
                                        delay: 500
                                    }
                                }

                                // --- Expandable SubItems Column ---
                                Column {
                                    id: subItemsColumn
                                    anchors.top: itemBg.bottom
                                    width: parent.width
                                    visible: !root.compact && navItemDelegate.hasSubItems
                                    opacity: navItemDelegate.isItemExpanded ? 1 : 0
                                    
                                    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuint } }

                                    Repeater {
                                        model: navItemDelegate.subItemsArray
                                        delegate: Item {
                                            width: subItemsColumn.width
                                            height: root.itemHeight
                                            
                                            // Handle nested subitem structure natively
                                            property var subModel: typeof modelData !== "undefined" ? modelData : {}
                                            property bool isSubSelected: root.currentIndex === ((index + 1) * 100) // basic nesting index id

                                            Rectangle {
                                                anchors.fill: parent
                                                anchors.leftMargin: 26
                                                anchors.rightMargin: 6
                                                radius: 6
                                                color: isSubSelected ? root.selectedBackgroundColor
                                                     : subMA.containsMouse && !subMA.pressed ? root.hoverBackgroundColor
                                                     : subMA.pressed ? root.pressedBackgroundColor
                                                     : "transparent"
                                                
                                                Behavior on color { ColorAnimation { duration: 100 } }

                                                Rectangle {
                                                    width: 3
                                                    height: isSubSelected ? 18 : 0
                                                    radius: 1.5
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 2
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    color: root.accentColor
                                                    Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.OutQuint } }
                                                }

                                                Text {
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 16
                                                    anchors.right: parent.right
                                                    anchors.rightMargin: 16
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: subModel.title || ""
                                                    font.family: "Segoe UI Variable, Segoe UI, sans-serif"
                                                    font.pixelSize: 13
                                                    font.weight: isSubSelected ? Font.Medium : Font.Normal
                                                    color: isSubSelected ? root.accentColor : root.textColor
                                                    elide: Text.ElideRight
                                                }

                                                MouseArea {
                                                    id: subMA
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: {
                                                        console.log("SubItem clicked");
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // --- Bottom separator ---
                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    color: root.separatorColor
                }

                // --- Settings button at bottom ---
                Item {
                    id: bottomSettingsArea
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

                            Behavior on color { ColorAnimation { duration: 150 } }
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
                            color: root.textColor
                            elide: Text.ElideRight
                            visible: !root.compact
                            opacity: root.compact ? 0 : 1

                            Behavior on opacity { NumberAnimation { duration: 120 } }
                        }

                        MouseArea {
                            id: settingsMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            activeFocusOnTab: false
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
        // Fix Qt's forced yellow highlight by passing valid standard color
        palette.highlight = "transparent"
        palette.highlightedText = root.textColor
        palette.window = root.sidebarBackground
    }
}
