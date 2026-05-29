import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("FluentPySide Gallery")
    wrapperWidth: 1200

    property var navItems: [
        { title: "Basic Input", icon: "ic_fluent_checkbox_checked_20_regular", desc: "Buttons, switches, sliders", category: "Basic Input" },
        { title: "Text", icon: "ic_fluent_text_font_20_regular", desc: "Labels, links, text fields", category: "Text" },
        { title: "Status & Info", icon: "ic_fluent_info_20_regular", desc: "Progress, badges, notifications", category: "Status & Info" },
        { title: "Navigation", icon: "ic_fluent_navigation_20_regular", desc: "Sidebars, selectors, segments", category: "Navigation" },
        { title: "Dialogs & Flyouts", icon: "ic_fluent_chat_20_regular", desc: "Dialogs, flyouts, tips", category: "Dialogs & Flyouts" },
        { title: "Layout", icon: "ic_fluent_content_view_20_regular", desc: "Expanders, settings cards", category: "Layout" },
        { title: "Date & Time", icon: "ic_fluent_calendar_clock_20_regular", desc: "Calendar, date/time pickers", category: "Date & Time" },
        { title: "Media", icon: "ic_fluent_video_clip_20_regular", desc: "Avatar, images", category: "Media" }
    ]

    Column {
        spacing: 24
        width: parent.width

        Rectangle {
            width: parent.width
            height: 180
            radius: Fluent.appearance.buttonRadius
            color: Fluent.accent
            clip: true

            Column {
                anchors.centerIn: parent
                spacing: 8
                Label {
                    text: "FluentPySide"
                    font.pixelSize: Fluent.typography.display
                    font.family: Fluent.typography.fontFamily
                    font.weight: Font.Bold
                    color: Fluent.textOnAccent
                }
                Label {
                    text: "Fluent Design for PySide6 — lightweight, beautiful, fast"
                    font.pixelSize: Fluent.typography.subtitle
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textOnAccent
                    opacity: 0.9
                }
            }
        }

        Label {
            text: qsTr("Categories")
            font.pixelSize: Fluent.typography.subtitle
            font.family: Fluent.typography.fontFamily
            font.weight: Font.Bold
            color: Fluent.textPrimary
        }

        GridLayout {
            width: parent.width
            columns: Math.max(1, Math.floor(parent.width / 200))
            columnSpacing: 12
            rowSpacing: 12

            Repeater {
                model: navItems

                delegate: Rectangle {
                    Layout.fillWidth: true
                    height: 80
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.cardBackground
                    border.color: Fluent.cardBorder
                    border.width: 1

                    property bool hovered: ma.containsMouse

                    Row {
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 16

                        Icon {
                            icon: modelData.icon
                            size: 28
                            color: Fluent.effectiveAccent
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            Label {
                                text: modelData.title
                                font.pixelSize: Fluent.typography.body
                                font.family: Fluent.typography.fontFamily
                                font.weight: Font.Bold
                                color: Fluent.textPrimary
                            }
                            Label {
                                text: modelData.desc
                                font.pixelSize: Fluent.typography.caption
                                font.family: Fluent.typography.fontFamily
                                color: Fluent.textSecondary
                            }
                        }
                    }

                    MouseArea {
                        id: ma
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            var items = navigationView.navigationItems
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].title === modelData.category) {
                                    if (items[i].page) {
                                        navigationView.push(items[i].page)
                                    } else if (items[i].subItems && items[i].subItems.length > 0) {
                                        navigationView.push(items[i].subItems[0].page)
                                    }
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
