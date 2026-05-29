import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ItemDelegate {
    id: root
    property alias iconName: settingIcon.icon
    property alias description: descLabel.text
    property alias actionItem: actionRow.data
    implicitWidth: parent ? parent.width : 300
    height: 56

    background: Rectangle {
        color: Fluent.cardBackground
        border.color: Fluent.cardBorder
        border.width: 1
        radius: Fluent.appearance.buttonRadius

        Behavior on color { ColorAnimation { duration: Fluent.anim.appearance } }
    }

    contentItem: Row {
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        spacing: 16

        Icon { id: settingIcon; size: 20; anchors.verticalCenter: parent.verticalCenter }
        Column {
            anchors.verticalCenter: parent.verticalCenter
            Label {
                text: root.text
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
        Item { width: 1; Layout.fillWidth: true }
        Row { id: actionRow; anchors.verticalCenter: parent.verticalCenter }
    }
}
