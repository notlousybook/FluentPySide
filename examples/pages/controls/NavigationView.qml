import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("NavigationView")
    wrapperWidth: 1200

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("NavigationView provides a sidebar navigation pattern with collapsed (icon-only) and expanded modes, automatic switching based on window width, and hierarchical navigation items.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Embedded Demo")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Rectangle {
            width: parent.width
            height: 420
            radius: Fluent.appearance.buttonRadius
            color: Fluent.cardBackground
            border.color: Fluent.cardBorder
            border.width: 1
            clip: true

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 12

                Rectangle {
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width * 0.45
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.background
                    border.color: Fluent.cardBorder
                    border.width: 1
                    clip: true

                    Column {
                        anchors.fill: parent

                        Row {
                            width: parent.width
                            height: 40
                            leftPadding: 12
                            spacing: 8

                            Label {
                                anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("NavigationView Demo")
                                font.pixelSize: Fluent.typography.caption
                                font.family: Fluent.typography.fontFamily
                                font.weight: Font.Bold
                                color: Fluent.textPrimary
                            }
                        }

                        ListView {
                            id: demoNavList
                            width: parent.width
                            height: parent.height - 40
                            clip: true
                            model: ListModel {
                                ListElement { itemTitle: "Home"; itemIcon: "ic_fluent_home_20_regular" }
                                ListElement { itemTitle: "Basic Input"; itemIcon: "ic_fluent_checkbox_checked_20_regular" }
                                ListElement { itemTitle: "Navigation"; itemIcon: "ic_fluent_navigation_20_regular" }
                                ListElement { itemTitle: "Settings"; itemIcon: "ic_fluent_settings_20_regular" }
                            }
                            delegate: ItemDelegate {
                                width: demoNavList.width
                                height: 36
                                highlighted: ListView.isCurrentItem
                                onClicked: demoNavList.currentIndex = index

                                Row {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 10

                                    Icon {
                                        icon: model.itemIcon
                                        size: 16
                                        color: parent.parent.highlighted ? Fluent.accent : Fluent.textPrimary
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Label {
                                        text: model.itemTitle
                                        font.pixelSize: Fluent.typography.body
                                        font.family: Fluent.typography.fontFamily
                                        color: parent.parent.highlighted ? Fluent.accent : Fluent.textPrimary
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.backgroundTertiary
                    border.color: Fluent.cardBorder
                    border.width: 1

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8

                        Label {
                            text: qsTr("Page Content")
                            font.pixelSize: Fluent.typography.subtitle
                            font.family: Fluent.typography.fontFamily
                            font.weight: Font.Bold
                            color: Fluent.textPrimary
                        }

                        Label {
                            text: qsTr("This area shows the selected page content. The NavigationView on the left provides sidebar navigation with expand/collapse support.")
                            font.pixelSize: Fluent.typography.body
                            font.family: Fluent.typography.fontFamily
                            color: Fluent.textSecondary
                            wrapMode: Text.WordWrap
                            width: parent.width
                        }
                    }
                }
            }
        }

        Label {
            text: qsTr("Configuration")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            width: parent.width

            SettingItem {
                width: parent.width
                text: qsTr("Expand Width")
                iconName: "ic_fluent_arrow_sync_20_regular"
                description: qsTr("Width of the sidebar when expanded (default: 280)")
                actionItem: SpinBox {
                    from: 200
                    to: 400
                    stepSize: 20
                    value: 280
                }
            }

            SettingItem {
                width: parent.width
                text: qsTr("Minimum Expand Width")
                iconName: "ic_fluent_window_20_regular"
                description: qsTr("Window width threshold for auto-collapse (default: 900)")
                actionItem: SpinBox {
                    from: 600
                    to: 1200
                    stepSize: 50
                    value: 900
                }
            }
        }

        Label {
            text: qsTr("Properties")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 4
            Label { text: "  \u2022 navigationItems \u2014 list of navigation item objects"; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
            Label { text: "  \u2022 currentPage \u2014 currently active page key"; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
            Label { text: "  \u2022 navExpandWidth \u2014 expanded sidebar width"; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
            Label { text: "  \u2022 navMinimumExpandWidth \u2014 min window width for expand"; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
            Label { text: "  \u2022 push(page) / pop() \u2014 navigate between pages"; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
        }
    }
}
