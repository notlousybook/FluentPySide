import QtQuick
import QtQuick.Controls

Item {
    id: root
    property int mode: 0
    property bool isMacStyle: Qt.platform.os === "osx" || Qt.platform.os === "macos" || Qt.platform.os === "darwin"
    property bool macGroupHovered: false
    property bool macWindowActive: !isMacStyle || !window || window.active
    property bool macGlyphVisible: isMacStyle && enabled && macWindowActive && (macGroupHovered || hoverHandler.hovered || mouseArea.pressed)
    property color macGlyphColor: "#1f1f1f"
    property bool _localHovered: hoverHandler.hovered
    property bool _localPressed: mouseArea.pressed

    implicitWidth: isMacStyle ? 12 : 46
    implicitHeight: isMacStyle ? 12 : 40

    ToolTip {
        visible: !isMacStyle && hoverHandler.hovered
        delay: 500
        text: mode === 0 ? qsTr("Maximize") : mode === 1 ? qsTr("Minimize") : qsTr("Close")
    }

    function toggleControl() {
        if (mode === 0) {
            if (typeof WindowManager_maximizeWindow === "function") WindowManager_maximizeWindow(window)
            else if (window.visibility === Window.Maximized) window.showNormal()
            else window.showMaximized()
        } else if (mode === 1) {
            window.showMinimized()
        } else if (mode === 2) {
            window.close()
        }
    }

    function macButtonColor() {
        if (!macWindowActive) return "#D0D0D0"
        if (mode === 2) return "#FF5F56"
        if (mode === 1) return "#FFBD2E"
        return "#27C93F"
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        color: isMacStyle ? macButtonColor() : (mode === 2 ? Fluent.captionClose : Fluent.subtleSecondary)
        radius: isMacStyle ? width / 2 : 0
        border.width: isMacStyle ? 1 : 0
        border.color: isMacStyle ? Qt.darker(bg.color, 1.15) : "transparent"
        opacity: {
            if (isMacStyle) return enabled ? 1 : 0.28
            if (mouseArea.pressed) return 0.8
            if (hoverHandler.hovered) return 1
            return 0
        }
        scale: (isMacStyle && mouseArea.pressed) ? 0.95 : (isMacStyle && hoverHandler.hovered) ? 1.05 : 1

        Behavior on opacity { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
        Behavior on scale { NumberAnimation { duration: 100; easing.type: Easing.InOutQuad } }
        Behavior on color { ColorAnimation { duration: Fluent.anim.appearance } }
    }

    Icon {
        icon: mode === 0
            ? (window && window.visibility === Window.Maximized ? "ic_fluent_square_multiple_20_regular" : "ic_fluent_square_20_regular")
            : mode === 1 ? "ic_fluent_subtract_20_regular"
            : "ic_fluent_dismiss_20_regular"
        size: mode === 0 ? 14 : 16
        visible: !isMacStyle
        color: mode === 2 && hoverHandler.hovered ? Fluent.captionCloseText : Fluent.textPrimary
        anchors.centerIn: parent
    }

    Item {
        id: macGlyph
        anchors.centerIn: parent
        width: 7
        height: 7
        visible: macGlyphVisible
        opacity: visible ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 80 } }

        Rectangle {
            visible: mode === 2; width: 7; height: 1.4; radius: 0.7
            color: macGlyphColor; anchors.centerIn: parent; rotation: 45; antialiasing: true
        }
        Rectangle {
            visible: mode === 2; width: 7; height: 1.4; radius: 0.7
            color: macGlyphColor; anchors.centerIn: parent; rotation: -45; antialiasing: true
        }
        Rectangle {
            visible: mode === 1; width: 7; height: 1.4; radius: 0.7
            color: macGlyphColor; anchors.centerIn: parent; antialiasing: true
        }
        Rectangle {
            visible: mode === 0; width: 7; height: 1.4; radius: 0.7
            color: macGlyphColor; anchors.centerIn: parent; antialiasing: true
        }
        Rectangle {
            visible: mode === 0; width: 1.4; height: 7; radius: 0.7
            color: macGlyphColor; anchors.centerIn: parent; antialiasing: true
        }
    }

    HoverHandler { id: hoverHandler; enabled: root.enabled; acceptedDevices: PointerDevice.Mouse }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        enabled: root.enabled
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: toggleControl()
    }
}
