import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import FluentControls

FluentPage {
    title: qsTr("Iconography")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Fluent System Icons")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
        }

        Flow {
            width: parent.width
            spacing: 12

            Repeater {
                model: [
                    "ic_fluent_home_20_regular", "ic_fluent_search_20_regular",
                    "ic_fluent_settings_20_regular", "ic_fluent_navigation_20_regular",
                    "ic_fluent_add_20_regular", "ic_fluent_delete_20_regular",
                    "ic_fluent_edit_20_regular", "ic_fluent_share_20_regular",
                    "ic_fluent_mail_20_regular", "ic_fluent_calendar_20_regular",
                    "ic_fluent_people_20_regular", "ic_fluent_star_20_regular",
                    "ic_fluent_heart_20_regular", "ic_fluent_moon_20_regular",
                    "ic_fluent_sun_20_regular", "ic_fluent_alert_20_regular",
                    "ic_fluent_checkmark_20_regular", "ic_fluent_dismiss_20_regular",
                    "ic_fluent_info_20_regular", "ic_fluent_warning_20_regular",
                    "ic_fluent_error_circle_20_regular", "ic_fluent_folder_20_regular",
                    "ic_fluent_document_20_regular", "ic_fluent_link_20_regular",
                    "ic_fluent_image_20_regular", "ic_fluent_video_20_regular",
                    "ic_fluent_camera_20_regular", "ic_fluent_mic_20_regular",
                    "ic_fluent_location_20_regular", "ic_fluent_pin_20_regular",
                    "ic_fluent_flag_20_regular", "ic_fluent_shield_20_regular",
                    "ic_fluent_lock_closed_20_regular", "ic_fluent_key_20_regular",
                    "ic_fluent_arrow_left_20_regular", "ic_fluent_arrow_right_20_regular",
                    "ic_fluent_print_20_regular", "ic_fluent_save_20_regular",
                    "ic_fluent_download_20_regular", "ic_fluent_upload_20_regular",
                    "ic_fluent_copy_20_regular", "ic_fluent_filter_20_regular",
                    "ic_fluent_list_20_regular", "ic_fluent_grid_20_regular",
                    "ic_fluent_table_20_regular", "ic_fluent_chat_20_regular",
                    "ic_fluent_megaphone_20_regular", "ic_fluent_toolbox_20_regular"
                ]

                delegate: Rectangle {
                    width: 80
                    height: 80
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.cardBackground
                    border.color: Fluent.cardBorder
                    border.width: 1

                    Column {
                        anchors.centerIn: parent
                        spacing: 4
                        Icon {
                            icon: modelData
                            size: 24
                            color: Fluent.textPrimary
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Label {
                            text: {
                                var parts = modelData.split("_")
                                parts.length > 2 ? parts[2] : modelData
                            }
                            font.pixelSize: 9
                            font.family: Fluent.typography.fontFamily
                            color: Fluent.textSecondary
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight
                            width: 70
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                    }
                }
            }
        }
    }
}
