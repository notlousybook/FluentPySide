// FluentWinUI3 NavigationView — WinUI 3 style collapsible sidebar
// Usage:
//   NavigationView {
//       model: ListModel { ... }  // items with "title", "icon" roles
//       currentIndex: 0
//       onCurrentIndexChanged: { /* navigate */ }
//       Item { ... }  // content area
//   }

import QtQuick
import QtQuick.Controls
import QtQuick.Controls.FluentWinUI3
import QtQuick.Layouts

Item {
    id: root

    // Public API
    property alias model: repeater.model
    property int currentIndex: 0
    property bool compact: false
    property real expandedWidth: 220
    property real compactWidth: 48
    property real navigationWidth: compact ? compactWidth : expandedWidth
    property color accentColor: "#005fb8"
    property color sidebarBackground: "#f3f3f3"
    property color sidebarHoverColor: "#e5e5e5"
    property color sidebarActiveColor: "#e0e0e0"
    property color textColor: "#1a1a1a"
    property color textSecondaryColor: "#666666"
    property color dividerColor: "#e0e0e0"
    property real topPadding: 4
    property real toggleSize: 40

    // Back button support
    signal backButtonClicked()

    // Default content item
    default property alias content: contentContainer.data

    readonly property real panelMargin: compact ? 12 : 8

    Behavior on navigationWidth {
        NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        // ===== SIDEBAR =====
        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: navigationWidth
            color: sidebarBackground

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 200; easing.type: Easing.InOutCubic }
            }

            Column {
                width: parent.width
                height: parent.height

                // Toggle button
                Item {
                    width: parent.width
                    height: toggleSize + topPadding

                    Button {
                        id: toggleBtn
                        anchors.top: parent.top
                        anchors.topMargin: topPadding
                        anchors.left: parent.left
                        anchors.leftMargin: panelMargin
                        width: toggleSize; height: toggleSize
                        flat: true
                        text: compact ? "\u2630" : "\u00AB"
                        font.pixelSize: 14
                        onClicked: root.compact = !root.compact
                    }
                }

                // Divider
                Rectangle {
                    width: parent.width - (compact ? 24 : 16)
                    height: 1
                    color: dividerColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Navigation items
                Column {
                    width: parent.width
                    topPadding: 4
                    Repeater {
                        id: repeater

                        ItemDelegate {
                            required property int index
                            required property string title
                            required property string icon

                            width: parent.width
                            height: toggleSize
                            leftPadding: panelMargin
                            rightPadding: panelMargin
                            highlighted: false
                            flat: true

                            // Active indicator (left accent bar)
                            Rectangle {
                                width: 3
                                height: parent.height - 10
                                anchors.left: parent.left
                                anchors.leftMargin: 2
                                anchors.verticalCenter: parent.verticalCenter
                                radius: 1.5
                                color: root.accentColor
                                visible: index === root.currentIndex
                            }

                            // Hover background
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 2
                                radius: 4
                                color: {
                                    if (index === root.currentIndex) return root.sidebarActiveColor
                                    if (mouseArea.containsMouse) return root.sidebarHoverColor
                                    return "transparent"
                                }
                            }

                            Row {
                                width: parent.width
                                height: parent.height
                                spacing: 12

                                // Icon area
                                Text {
                                    width: toggleSize - 16
                                    height: parent.height
                                    text: icon
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    color: index === root.currentIndex ? root.accentColor : root.textColor
                                }

                                // Title text
                                Text {
                                    text: title
                                    font.pixelSize: 13
                                    height: parent.height
                                    verticalAlignment: Text.AlignVCenter
                                    color: index === root.currentIndex ? root.accentColor : root.textColor
                                    elide: Text.ElideRight
                                    visible: !root.compact
                                    opacity: root.compact ? 0 : 1

                                    Behavior on opacity {
                                        NumberAnimation { duration: 150 }
                                    }
                                }
                            }

                            // Tooltip when compact
                            ToolTip.text: title
                            ToolTip.visible: root.compact && mouseArea.containsMouse
                            ToolTip.delay: 400

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: root.currentIndex = index
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }
                }

                Item { Layout.fillHeight: true; width: parent.width }

                // Bottom divider
                Rectangle {
                    width: parent.width - (compact ? 24 : 16)
                    height: 1
                    color: dividerColor
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Footer area (optional settings button)
                Item {
                    width: parent.width
                    height: toggleSize
                    bottomPadding: 8

                    Button {
                        anchors.fill: parent
                        anchors.leftMargin: panelMargin
                        anchors.rightMargin: panelMargin
                        anchors.bottomMargin: 8
                        flat: true
                        text: "\u2699"
                        font.pixelSize: 16
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
