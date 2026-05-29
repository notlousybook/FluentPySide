import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property int titleBarHeight: Fluent.appearance.windowTitleBarHeight
    property alias title: titleLabel.text
    property alias icon: iconLabel.icon
    property alias backgroundColor: bgRect.color

    property bool titleEnabled: true
    property alias iconEnabled: iconLabel.visible
    property bool minimizeEnabled: true
    property bool maximizeEnabled: true
    property bool closeEnabled: true
    property bool minimizeVisible: true
    property bool maximizeVisible: true
    property bool closeVisible: true

    property bool isMacOS: Qt.platform.os === "osx" || Qt.platform.os === "macos" || Qt.platform.os === "darwin"
    property bool useNativeMacControls: false

    default property alias content: contentItem.data
    property alias contentHost: contentItem

    height: titleBarHeight
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    clip: true
    z: 999

    property var window: null
    function toggleMaximized() {
        if (!maximizeEnabled) return
        if (typeof WindowManager_maximizeWindow === "function") WindowManager_maximizeWindow(window)
        else if (window.visibility === Window.Maximized) window.showNormal()
        else window.showMaximized()
    }

    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: "transparent"

        MouseArea {
            enabled: !root.useNativeMacControls
            anchors.fill: parent
            anchors.leftMargin: root.isMacOS ? 80 : 0
            anchors.margins: Fluent.windowDragArea
            propagateComposedEvents: true
            acceptedButtons: Qt.LeftButton
            property point clickPos: Qt.point(0, 0)
            onPressed: (mouse) => {
                clickPos = Qt.point(mouseX, mouseY)
                if (typeof WindowManager_sendDragEvent === "function") {
                    WindowManager_sendDragEvent(window)
                }
            }
            onDoubleClicked: toggleMaximized()
            onPositionChanged: (mouse) => {
                if (window.visibility === Window.Maximized || window.visibility === Window.FullScreen) return
                if (typeof WindowManager_sendDragEvent === "function") return
                let delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
                window.setX(window.x + delta.x)
                window.setY(window.y + delta.y)
            }
        }
    }

    RowLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        spacing: root.isMacOS ? 12 : 0

        Row {
            visible: root.isMacOS && !root.useNativeMacControls
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 20
            spacing: 8

            CtrlBtn { id: macCloseBtn; mode: 2; width: 12; height: 12; enabled: root.closeEnabled; visible: root.closeVisible; isMacStyle: true; macGroupHovered: macCloseBtn._localHovered || macMinBtn._localHovered || macMaxBtn._localHovered }
            CtrlBtn { id: macMinBtn; mode: 1; width: 12; height: 12; enabled: root.minimizeEnabled; visible: root.minimizeVisible; isMacStyle: true; macGroupHovered: macCloseBtn._localHovered || macMinBtn._localHovered || macMaxBtn._localHovered }
            CtrlBtn { id: macMaxBtn; mode: 0; width: 12; height: 12; enabled: root.maximizeEnabled; visible: root.maximizeVisible; isMacStyle: true; macGroupHovered: macCloseBtn._localHovered || macMinBtn._localHovered || macMaxBtn._localHovered }
        }

        RowLayout {
            visible: root.titleEnabled
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: root.isMacOS ? (root.useNativeMacControls ? 80 : 0) : 16
            spacing: 16

            Icon {
                id: iconLabel
                size: 16
                Layout.alignment: Qt.AlignVCenter
                visible: icon !== ""
            }

            Label {
                id: titleLabel
                Layout.alignment: Qt.AlignVCenter
                font.pixelSize: Fluent.typography.caption
                font.family: Fluent.typography.fontFamily
                color: Fluent.textPrimary
                elide: Text.ElideRight
            }
        }

        Item {
            id: contentItem
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
        }

        Row {
            visible: !root.isMacOS
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignRight
            spacing: 0

            CtrlBtn { id: minBtn; mode: 1; enabled: root.minimizeEnabled; visible: root.minimizeVisible }
            CtrlBtn { id: maxBtn; mode: 0; enabled: root.maximizeEnabled; visible: root.maximizeVisible }
            CtrlBtn { id: closeBtn; mode: 2; enabled: root.closeEnabled; visible: root.closeVisible }
        }
    }
}
