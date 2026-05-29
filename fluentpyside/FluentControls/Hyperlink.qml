import QtQuick
import QtQuick.Controls

Label {
    id: root
    property url url: ""
    property alias openUrl: root.url
    color: mouseArea.containsMouse ? Fluent.accentHover : Fluent.accent
    font.underline: mouseArea.containsMouse

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (root.url.toString().length > 0) Qt.openUrlExternally(root.url)
        }
    }

    Behavior on color { ColorAnimation { duration: Fluent.anim.fast } }
}
