import QtQuick
import QtQuick.Controls

Frame {
    id: root
    property alias contentData: innerContent.data

    padding: 0
    background: Rectangle {
        color: Fluent.cardBackground
        border.color: Fluent.cardBorder
        border.width: 1
        radius: Fluent.appearance.buttonRadius
    }

    contentItem: Item {
        Column {
            id: innerContent
            anchors.fill: parent
            spacing: 0
        }
    }
}
