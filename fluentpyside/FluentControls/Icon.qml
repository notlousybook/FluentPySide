import QtQuick
import "FluentSystemIcons-Index.js" as Icons

Item {
    id: root
    property string icon: ""
    property alias name: root.icon
    property string source: ""
    property alias color: iconText.color
    property int size: 16
    property bool enableColorOverlay: false

    property bool isFontIcon: source === ""
    property bool isSvg: source.toString().toLowerCase().endsWith(".svg")

    implicitWidth: size
    implicitHeight: size

    Behavior on color { ColorAnimation { duration: 250; easing.type: Easing.OutQuart } }

    Text {
        id: iconText
        anchors.centerIn: parent
        text: {
            if (!isFontIcon || !icon) return ""
            if (icon.length === 1) return icon
            var code = Icons.FluentIcons[icon]
            return code !== undefined ? String.fromCharCode(code) : ""
        }
        font.family: iconFontLoader.name.length > 0
            ? iconFontLoader.name
            : Fluent.typography.fontIconFamily
        font.pixelSize: size
        visible: isFontIcon
        color: Fluent.textPrimary
    }

    Image {
        id: iconImage
        anchors.centerIn: parent
        source: root.source
        width: size
        height: size
        mipmap: true
        fillMode: Image.PreserveAspectFit
        visible: !isFontIcon
    }

    FontLoader {
        id: iconFontLoader
        source: "FluentSystemIcons-Resizable.ttf"
    }
}
