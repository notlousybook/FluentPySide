import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    property int currentIndex: 0
    property var items: []

    spacing: 0

    Repeater {
        model: root.items

        Rectangle {
            id: segItem
            property bool isSelected: index === root.currentIndex
            property string label: modelData.title || modelData
            property string icon: modelData.icon || ""
            width: implicitWidth
            height: 36
            implicitWidth: labelRow.width + 24
            radius: Fluent.appearance.buttonRadius
            color: isSelected ? Fluent.accent
                : mouseArea.containsMouse ? Fluent.subtleSecondary
                : "transparent"

            Behavior on color { ColorAnimation { duration: Fluent.anim.fast; easing.type: Easing.OutQuart } }

            Row {
                id: labelRow
                anchors.centerIn: parent
                spacing: 6
                Icon {
                    visible: icon !== ""
                    icon: segItem.icon
                    size: 14
                    color: isSelected ? Fluent.textOnAccent : Fluent.textPrimary
                    anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    text: segItem.label
                    font.pixelSize: Fluent.typography.caption
                    font.family: Fluent.typography.fontFamily
                    font.weight: isSelected ? Font.Bold : Font.Normal
                    color: isSelected ? Fluent.textOnAccent : Fluent.textPrimary
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: root.currentIndex = index
            }
        }
    }
}
