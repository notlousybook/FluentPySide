import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Settings")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Appearance")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SettingItem {
            width: parent.width
            text: qsTr("Theme")
            iconName: "ic_fluent_dark_20_regular"
            description: qsTr("Switch between light and dark mode")
            actionItem: ComboBox {
                property var themes: ["Auto", "Light", "Dark"]
                model: themes
                currentIndex: {
                    if (typeof _themeMode !== "undefined") {
                        if (_themeMode === "dark") return 2
                        if (_themeMode === "light") return 1
                    }
                    return 0
                }
                onActivated: {
                    var mode = themes[currentIndex].toLowerCase()
                    Fluent.isDark = mode === "dark" ? true : mode === "light" ? false : Application.styleHints.colorScheme === Qt.Dark
                    if (typeof _themeManager !== "undefined") {
                        _themeManager.setTheme(mode)
                    }
                }
            }
        }

        SettingItem {
            width: parent.width
            text: qsTr("Backdrop Effect")
            iconName: "ic_fluent_window_20_regular"
            description: qsTr("Enable Mica or Acrylic backdrop")
            actionItem: Switch {
                checked: Fluent.backdropEnabled
                onToggled: Fluent.backdropEnabled = checked
            }
        }

        SettingItem {
            width: parent.width
            text: qsTr("Accent Color")
            iconName: "ic_fluent_color_20_regular"
            description: qsTr("Customize the accent color")
            actionItem: Row {
                spacing: 8
                Rectangle {
                    width: 24
                    height: 24
                    radius: 4
                    color: Fluent.accent
                    border.color: Fluent.cardBorder
                    border.width: 1
                    anchors.verticalCenter: parent.verticalCenter
                }
                Button {
                    text: qsTr("Pick Color")
                    onClicked: accentPopup.open()
                    Popup {
                        id: accentPopup
                        y: parent.height + 4
                        padding: 12
                        background: Rectangle {
                            color: Fluent.popupBackground
                            border.color: Fluent.flyoutBorder
                            border.width: 1
                            radius: Fluent.appearance.buttonRadius
                        }
                        ColorPicker {
                            id: accentPicker
                            color: Fluent.accent
                            colorSliderVisible: true
                            hexInputVisible: true
                            colorChannelInputVisible: false
                            alphaEnabled: false
                            onColorChanged: {
                                Fluent.primaryColor = color
                                if (typeof _themeManager !== "undefined") {
                                    _themeManager.setAccentColor(color.toString())
                                }
                            }
                        }
                    }
                }
            }
        }

        Label {
            text: qsTr("About")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        SettingExpander {
            width: parent.width
            title: qsTr("About FluentPySide")
            icon: "ic_fluent_info_20_regular"
            description: qsTr("FluentPySide version and credits")
            Column {
                width: parent.width
                spacing: 8
                Label {
                    text: "FluentPySide v0.1.0"
                    font.pixelSize: Fluent.typography.body
                    color: Fluent.textPrimary
                }
                Label {
                    text: "Fluent Design components for PySide6"
                    font.pixelSize: Fluent.typography.caption
                    color: Fluent.textSecondary
                }
                Hyperlink {
                    text: qsTr("View on GitHub")
                    url: "https://github.com"
                    font.pixelSize: Fluent.typography.caption
                }
                Label {
                    text: "Navigation and window system adapted from RinUI (MIT License)"
                    font.pixelSize: Fluent.typography.caption
                    color: Fluent.textSecondary
                    wrapMode: Text.WordWrap
                    width: parent.width
                }
            }
        }
    }
}
