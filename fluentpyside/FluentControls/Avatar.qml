import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property string initials: ""
    property alias source: avatarImage.source
    property int size: 64

    width: size
    height: size
    radius: size / 2
    color: Fluent.accent
    clip: true

    Image {
        id: avatarImage
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: source.toString() !== ""
    }

    Label {
        anchors.centerIn: parent
        visible: avatarImage.source.toString() === "" && initials !== ""
        text: initials.substring(0, 2).toUpperCase()
        font.pixelSize: root.size * 0.35
        font.family: Fluent.typography.fontFamily
        font.weight: Font.Bold
        color: Fluent.textOnAccent
    }
}
