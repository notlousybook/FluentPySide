import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property bool expanded: false
    property alias title: headerLabel.text
    default property alias contentData: contentArea.data
    property alias content: contentArea.data
    property alias headerRow: headerBtn

    implicitWidth: parent ? parent.width : 300
    height: headerBtn.height + contentContainer.height

    Rectangle {
        z: -1
        anchors.fill: parent
        color: Fluent.cardBackground
        border.color: Fluent.cardBorder
        border.width: 1
        radius: Fluent.appearance.buttonRadius
        clip: true
    }

    Column {
        id: mainCol
        anchors.fill: parent

        Button {
            id: headerBtn
            width: parent.width
            height: 48
            flat: true
            onClicked: root.expanded = !root.expanded

            contentItem: Row {
                x: 16
                height: parent.height
                spacing: 12

                Icon {
                    icon: "ic_fluent_chevron_right_20_regular"
                    size: 14
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: root.expanded ? 90 : 0

                    Behavior on rotation {
                        NumberAnimation {
                            duration: Fluent.anim.speed
                            easing.type: Easing.OutQuint
                        }
                    }
                }

                Label {
                    id: headerLabel
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Fluent.typography.body
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textPrimary
                }
            }
        }

        Item {
            id: contentContainer
            width: parent.width
            height: root.expanded ? contentArea.implicitHeight + contentArea.topPadding + contentArea.bottomPadding : 0
            clip: true

            Behavior on height {
                NumberAnimation {
                    duration: Fluent.anim.expander
                    easing.type: Easing.OutQuint
                }
            }

            Column {
                id: contentArea
                width: parent.width
                padding: 16
            }
        }
    }
}
