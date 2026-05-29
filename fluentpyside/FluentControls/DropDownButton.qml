import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: root
    default property alias dropdownContent: dropdownMenu.contentData

    display: AbstractButton.TextBesideIcon
    icon.name: ""
    icon.width: 0
    icon.height: 0

    contentItem: Row {
        spacing: 6
        Label {
            text: root.text
            font: root.font
            color: root.palette.buttonText
            anchors.verticalCenter: parent.verticalCenter
        }
        Icon {
            icon: "ic_fluent_chevron_down_20_filled"
            size: 12
            color: root.palette.buttonText
            anchors.verticalCenter: parent.verticalCenter
            rotation: dropdownMenu.visible ? 180 : 0
            Behavior on rotation { NumberAnimation { duration: Fluent.anim.fast; easing.type: Easing.OutQuart } }
        }
    }

    onClicked: if (dropdownMenu.count > 0) dropdownMenu.popup(root, 0, root.height)

    Menu {
        id: dropdownMenu
    }
}
