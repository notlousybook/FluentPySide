import QtQuick
import QtQuick.Layouts

Item {
    id: floatLayer
    anchors.fill: parent
    anchors.margins: 32
    property int margins: 32
    property int spacing: 12

    ColumnLayout {
        id: topLeft
        anchors.top: parent.top
        anchors.left: parent.left
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }
    ColumnLayout {
        id: topCenter
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }
    ColumnLayout {
        id: topRight
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }
    ColumnLayout {
        id: bottomLeft
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }
    ColumnLayout {
        id: bottomCenter
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }
    ColumnLayout {
        id: bottomRight
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        spacing: floatLayer.spacing
        width: floatLayer.width / 2
    }

    function determinePosition(pos) {
        switch(pos) {
            case 0: return topLeft
            case 1: return topCenter
            case 2: return topRight
            case 3: return bottomLeft
            case 4: return bottomCenter
            case 5: return bottomRight
            default: return topCenter
        }
    }

    function createInfoBar(options) {
        var container = determinePosition(options.position !== undefined ? options.position : 1)
        var bar = infoBarComp.createObject(container, {
            title: options.title || "",
            text: options.text || "",
            severity: options.severity !== undefined ? options.severity : 0,
            timeout: options.timeout !== undefined ? options.timeout : 3000,
            closable: options.closable !== undefined ? options.closable : true
        })
    }

    property Component infoBarComp: Component { InfoBar { Layout.fillWidth: true } }
}
