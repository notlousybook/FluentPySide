import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: baseWindow
    visible: !isWindows
    property bool isFluentWindow: true
    property bool isMacOS: Qt.platform.os === "osx" || Qt.platform.os === "macos" || Qt.platform.os === "darwin"
    property bool isWindows: Qt.platform.os === "windows"
    property bool useNativeMacFrame: isMacOS
    property bool _useDwmCorners: isWindows

    flags: {
        var f = Qt.Window | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint | Qt.WindowCloseButtonHint
        if (useNativeMacFrame) {
            f |= Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowSystemMenuHint
            if (typeof Qt.ExpandedClientAreaHint !== "undefined") f |= Qt.ExpandedClientAreaHint
            if (typeof Qt.NoTitleBarBackgroundHint !== "undefined") f |= Qt.NoTitleBarBackgroundHint
        } else if (isWindows) {
            f |= Qt.CustomizeWindowHint
        } else {
            f |= Qt.FramelessWindowHint
        }
        return f
    }

    color: Fluent.backdropEnabled ? "transparent" : Fluent.background

    property var windowIcon: ""
    property alias titleEnabled: titleBar.titleEnabled
    property alias minimizeEnabled: titleBar.minimizeEnabled
    property bool maximizeEnabled: maximumHeight === 16777215 && maximumWidth === 16777215
    property alias closeEnabled: titleBar.closeEnabled
    property alias minimizeVisible: titleBar.minimizeVisible
    property alias maximizeVisible: titleBar.maximizeVisible
    property alias closeVisible: titleBar.closeVisible

    property int titleBarHeight: Fluent.appearance.windowTitleBarHeight
    property alias titleBarArea: titleBar.contentHost
    property alias titleBarHost: titleBar.contentHost

    default property alias content: contentArea.children
    property alias floatLayer: floatLayer

    onVisibilityChanged: {
        if (useNativeMacFrame) {
            bgRect.radius = 0
            bgRect.border.width = 0
            return
        }
        if (_useDwmCorners) {
            bgRect.radius = 0
        } else {
            bgRect.radius = (baseWindow.visibility === Window.Maximized) ? 0 : Fluent.appearance.windowRadius
        }
        bgRect.border.width = 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.bottomMargin: baseWindow.useNativeMacFrame ? 0 : Fluent.windowDragArea
        anchors.leftMargin: baseWindow.useNativeMacFrame ? 0 : Fluent.windowDragArea
        anchors.rightMargin: baseWindow.useNativeMacFrame ? 0 : Fluent.windowDragArea
        spacing: 0

        Item {
            Layout.preferredHeight: titleBar.height
            Layout.fillWidth: true
        }

        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    TitleBar {
        id: titleBar
        window: baseWindow
        icon: baseWindow.windowIcon || ""
        title: baseWindow.title || ""
        useNativeMacControls: baseWindow.useNativeMacFrame
        Layout.fillWidth: true
        height: baseWindow.titleBarHeight
        maximizeEnabled: baseWindow.maximizeEnabled
    }

    background: Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Fluent.backdropEnabled ? "transparent" : Fluent.background
        border.color: Fluent.windowBorder
        border.width: baseWindow.useNativeMacFrame ? 0 : 1
        radius: {
            if (baseWindow.useNativeMacFrame) return 0
            if (baseWindow._useDwmCorners) return 0
            return Fluent.appearance.windowRadius
        }
        z: -1
        clip: true

        Behavior on color { ColorAnimation { duration: Fluent.backdropEnabled ? 0 : 150 } }
    }

    Behavior on color { ColorAnimation { duration: Fluent.anim.appearance } }

    FloatLayer {
        id: floatLayer
        anchors.topMargin: titleBarHeight
        z: 998
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: !baseWindow.useNativeMacFrame && baseWindow.visibility !== Window.Maximized
        z: -1
        cursorShape: {
            if (baseWindow.useNativeMacFrame || baseWindow.visibility === Window.Maximized) return Qt.ArrowCursor
            var p = Qt.point(mouseX, mouseY)
            var b = Fluent.windowDragArea
            if (p.x < b && p.y < b) return Qt.SizeFDiagCursor
            if (p.x >= width - b && p.y >= height - b) return Qt.SizeFDiagCursor
            if (p.x >= width - b && p.y < b) return Qt.SizeBDiagCursor
            if (p.x < b && p.y >= height - b) return Qt.SizeBDiagCursor
            if (p.x < b || p.x >= width - b) return Qt.SizeHorCursor
            if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor
            return Qt.ArrowCursor
        }
        acceptedButtons: Qt.NoButton
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        enabled: !baseWindow.useNativeMacFrame && Qt.platform.os !== "windows"
        onActiveChanged: if (active && baseWindow.visibility !== Window.Maximized) {
            var p = resizeHandler.centroid.position
            var b = Fluent.windowDragArea
            var e = 0
            if (p.x < b) e |= Qt.LeftEdge
            if (p.x >= width - b) e |= Qt.RightEdge
            if (p.y < b) e |= Qt.TopEdge
            if (p.y >= height - b) e |= Qt.BottomEdge
            if (e !== 0) baseWindow.startSystemResize(e)
        }
    }

    Component.onCompleted: {
        if (typeof _themeManager !== "undefined" && _themeManager) {
            _themeManager.registerWindow(baseWindow)
        }
    }
}
