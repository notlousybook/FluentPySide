import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

TabButton {
    id: root

    property string fluentIcon: ""

    implicitWidth: Math.max(row.implicitWidth + 26, 40)
    implicitHeight: 32

    background: Item {}

    contentItem: Item {
        clip: true
        anchors.fill: parent

        Row {
            id: row
            spacing: 8
            anchors.centerIn: parent

            Icon {
                id: iconWidget
                size: fluentIcon !== "" ? textLabel.font.pixelSize * 1.3 : 0
                icon: root.fluentIcon
                visible: root.fluentIcon !== ""
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: textLabel
                text: root.text
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
                color: Fluent.textPrimary
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Indicator {
            anchors {
                bottom: parent.bottom
                bottomMargin: Fluent.appearance.borderWidth
                horizontalCenter: parent.horizontalCenter
            }
            visible: root.checked
            orientation: Qt.Horizontal
        }
    }

    opacity: !enabled ? 0.65 : pressed ? 0.67 : hovered ? 0.875 : 1.0

    Behavior on opacity { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.InOutQuint } }
}
