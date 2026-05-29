import QtQuick
import QtQuick.Controls
import FluentControls

FluentWindow {
    id: gallery
    width: 1200
    height: 700
    minimumWidth: 600
    minimumHeight: 400
    title: "FluentPySide Gallery"

    navigationView.navExpandWidth: 280

    navigationItems: [
        {
            title: qsTr("Home"),
            page: Qt.resolvedUrl("pages/Home.qml"),
            icon: "ic_fluent_home_20_regular",
            position: Position.top
        },
        {
            title: qsTr("Design Guidance"),
            icon: "ic_fluent_design_ideas_20_regular",
            position: Position.top,
            subItems: [
                { title: qsTr("Iconography"), page: Qt.resolvedUrl("pages/Iconography.qml"), icon: "ic_fluent_symbols_20_regular" }
            ]
        },
        {
            title: qsTr("Basic Input"),
            icon: "ic_fluent_checkbox_checked_20_regular",
            subItems: [
                { title: qsTr("Button"), page: Qt.resolvedUrl("pages/controls/Button.qml"), icon: "ic_fluent_button_20_regular" },
                { title: qsTr("CheckBox"), page: Qt.resolvedUrl("pages/controls/CheckBox.qml"), icon: "ic_fluent_checkbox_checked_20_regular" },
                { title: qsTr("ComboBox"), page: Qt.resolvedUrl("pages/controls/ComboBox.qml"), icon: "ic_fluent_chevron_down_20_regular" },
                { title: qsTr("RadioButton"), page: Qt.resolvedUrl("pages/controls/RadioButton.qml"), icon: "ic_fluent_radiobutton_20_regular" },
                { title: qsTr("Slider"), page: Qt.resolvedUrl("pages/controls/Slider.qml"), icon: "ic_fluent_data_usage_20_regular" },
                { title: qsTr("Switch"), page: Qt.resolvedUrl("pages/controls/Switch.qml"), icon: "ic_fluent_toggle_multiple_20_regular" },
                { title: qsTr("TextField"), page: Qt.resolvedUrl("pages/controls/TextField.qml"), icon: "ic_fluent_text_field_20_regular" },
                { title: qsTr("SpinBox"), page: Qt.resolvedUrl("pages/controls/SpinBox.qml"), icon: "ic_fluent_number_symbol_20_regular" },
                { title: qsTr("ToggleButton"), page: Qt.resolvedUrl("pages/controls/ToggleButton.qml"), icon: "ic_fluent_toggle_right_20_regular" },
                { title: qsTr("PillButton"), page: Qt.resolvedUrl("pages/controls/PillButton.qml"), icon: "ic_fluent_button_20_regular" },
                { title: qsTr("DropDownButton"), page: Qt.resolvedUrl("pages/controls/DropDownButton.qml"), icon: "ic_fluent_chevron_down_20_regular" },
                { title: qsTr("ColorPicker"), page: Qt.resolvedUrl("pages/controls/ColorPicker.qml"), icon: "ic_fluent_color_20_regular" },
                { title: qsTr("RoundButton"), page: Qt.resolvedUrl("pages/controls/RoundButton.qml"), icon: "ic_fluent_circle_20_regular" }
            ]
        },
        {
            title: qsTr("Text"),
            icon: "ic_fluent_text_font_20_regular",
            subItems: [
                { title: qsTr("Label"), page: Qt.resolvedUrl("pages/controls/Label.qml"), icon: "ic_fluent_text_20_regular" },
                { title: qsTr("Hyperlink"), page: Qt.resolvedUrl("pages/controls/Hyperlink.qml"), icon: "ic_fluent_link_20_regular" },
                { title: qsTr("AutoSuggestBox"), page: Qt.resolvedUrl("pages/controls/AutoSuggestBox.qml"), icon: "ic_fluent_search_20_regular" },
                { title: qsTr("TextArea"), page: Qt.resolvedUrl("pages/controls/TextAreaPage.qml"), icon: "ic_fluent_text_field_20_regular" }
            ]
        },
        {
            title: qsTr("Status & Info"),
            icon: "ic_fluent_info_20_regular",
            subItems: [
                { title: qsTr("ProgressBar"), page: Qt.resolvedUrl("pages/controls/ProgressBar.qml"), icon: "ic_fluent_spinner_ios_20_regular" },
                { title: qsTr("ProgressRing"), page: Qt.resolvedUrl("pages/controls/ProgressRing.qml"), icon: "ic_fluent_spinner_ios_20_regular" },
                { title: qsTr("InfoBar"), page: Qt.resolvedUrl("pages/controls/InfoBar.qml"), icon: "ic_fluent_info_20_regular" },
                { title: qsTr("InfoBadge"), page: Qt.resolvedUrl("pages/controls/InfoBadge.qml"), icon: "ic_fluent_alert_20_regular" },
                { title: qsTr("ToolTip"), page: Qt.resolvedUrl("pages/controls/ToolTip.qml"), icon: "ic_fluent_comment_20_regular" }
            ]
        },
        {
            title: qsTr("Navigation"),
            icon: "ic_fluent_navigation_20_regular",
            subItems: [
                { title: qsTr("NavigationView"), page: Qt.resolvedUrl("pages/controls/NavigationView.qml"), icon: "ic_fluent_navigation_20_regular" },
                { title: qsTr("SelectorBar"), page: Qt.resolvedUrl("pages/controls/SelectorBar.qml"), icon: "ic_fluent_chevron_down_20_regular" },
                { title: qsTr("Segmented"), page: Qt.resolvedUrl("pages/controls/Segmented.qml"), icon: "ic_fluent_toggle_multiple_20_regular" }
            ]
        },
        {
            title: qsTr("Dialogs & Flyouts"),
            icon: "ic_fluent_chat_20_regular",
            subItems: [
                { title: qsTr("Dialog"), page: Qt.resolvedUrl("pages/controls/Dialog.qml"), icon: "ic_fluent_window_20_regular" },
                { title: qsTr("Flyout"), page: Qt.resolvedUrl("pages/controls/Flyout.qml"), icon: "ic_fluent_window_20_regular" },
                { title: qsTr("TeachingTip"), page: Qt.resolvedUrl("pages/controls/TeachingTip.qml"), icon: "ic_fluent_info_20_regular" },
                { title: qsTr("Popup"), page: Qt.resolvedUrl("pages/controls/PopupPage.qml"), icon: "ic_fluent_window_20_regular" }
            ]
        },
        {
            title: qsTr("Menus & Toolbars"),
            icon: "ic_fluent_save_20_regular",
            subItems: [
                { title: qsTr("Menu"), page: Qt.resolvedUrl("pages/controls/MenuPage.qml"), icon: "ic_fluent_line_horizontal_3_20_regular" },
                { title: qsTr("MenuBar"), page: Qt.resolvedUrl("pages/controls/MenuBarPage.qml"), icon: "ic_fluent_line_horizontal_3_20_regular" },
                { title: qsTr("ContextMenu"), page: Qt.resolvedUrl("pages/controls/ContextMenuPage.qml"), icon: "ic_fluent_save_20_regular" }
            ]
        },
        {
            title: qsTr("Layout"),
            icon: "ic_fluent_content_view_20_regular",
            subItems: [
                { title: qsTr("Expander"), page: Qt.resolvedUrl("pages/controls/Expander.qml"), icon: "ic_fluent_chevron_down_20_regular" },
                { title: qsTr("SettingExpander"), page: Qt.resolvedUrl("pages/controls/SettingExpander.qml"), icon: "ic_fluent_settings_20_regular" }
            ]
        },
        {
            title: qsTr("Date & Time"),
            icon: "ic_fluent_calendar_clock_20_regular",
            subItems: [
                { title: qsTr("CalendarView"), page: Qt.resolvedUrl("pages/controls/CalendarView.qml"), icon: "ic_fluent_calendar_20_regular" },
                { title: qsTr("DatePicker"), page: Qt.resolvedUrl("pages/controls/DatePicker.qml"), icon: "ic_fluent_calendar_date_20_regular" },
                { title: qsTr("TimePicker"), page: Qt.resolvedUrl("pages/controls/TimePicker.qml"), icon: "ic_fluent_clock_20_regular" }
            ]
        },
        {
            title: qsTr("Media"),
            icon: "ic_fluent_video_clip_20_regular",
            subItems: [
                { title: qsTr("Avatar"), page: Qt.resolvedUrl("pages/controls/Avatar.qml"), icon: "ic_fluent_person_20_regular" }
            ]
        },
        {
            title: qsTr("Settings"),
            page: Qt.resolvedUrl("pages/Settings.qml"),
            icon: "ic_fluent_settings_20_regular",
            position: Position.bottom
        }
    ]
}
