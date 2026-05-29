import QtQuick
import QtQuick.Controls

Item {
    Label {
        anchors.centerIn: parent
        text: "Failed to load page"
        color: Fluent.critical
        font.pixelSize: Fluent.typography.subtitle
        font.family: Fluent.typography.fontFamily
    }
}
