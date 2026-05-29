import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Expander {
    id: root
    property alias icon: settingIcon.icon
    property alias description: descLabel.text
    property alias headerExtra: headerExtraRow.data

    header: Item {
        implicitHeight: 56
        implicitWidth: root.width

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 16

            Icon {
                id: settingIcon
                size: 20
                Layout.alignment: Qt.AlignVCenter
            }

            Column {
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
                Label {
                    text: root.title
                    font.pixelSize: Fluent.typography.body
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textPrimary
                }
                Label {
                    id: descLabel
                    visible: text !== ""
                    font.pixelSize: Fluent.typography.caption
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textSecondary
                }
            }

            Row {
                id: headerExtraRow
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                spacing: 8
            }
        }
    }
}
