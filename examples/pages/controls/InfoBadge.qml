import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("InfoBadge")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("InfoBadge is a small UI element used to indicate new or unread content, counts, or status. It is often attached to icons or navigation items.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Badge Counts")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            Row {
                spacing: 4
                Icon { icon: "ic_fluent_mail_20_regular"; size: 24; color: Fluent.textPrimary }
                InfoBadge { count: 3 }
            }
            Row {
                spacing: 4
                Icon { icon: "ic_fluent_chat_20_regular"; size: 24; color: Fluent.textPrimary }
                InfoBadge { count: 12 }
            }
            Row {
                spacing: 4
                Icon { icon: "ic_fluent_alert_20_regular"; size: 24; color: Fluent.textPrimary }
                InfoBadge { count: 99 }
            }
        }

        Label {
            text: qsTr("Severity Variants")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            InfoBadge { count: 1; severity: Severity.info }
            InfoBadge { count: 5; severity: Severity.success }
            InfoBadge { count: 8; severity: Severity.caution }
            InfoBadge { count: 3; severity: Severity.error }
        }

        Label {
            text: qsTr("Dot Badge")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            Row {
                spacing: 4
                Icon { icon: "ic_fluent_mail_20_regular"; size: 24; color: Fluent.textPrimary }
                InfoBadge { dot: true }
            }
            Row {
                spacing: 4
                Icon { icon: "ic_fluent_chat_20_regular"; size: 24; color: Fluent.textPrimary }
                InfoBadge { dot: true; severity: Severity.error }
            }
        }
    }
}
