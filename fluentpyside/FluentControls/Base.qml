import QtQuick
import QtQuick.Controls

Item {
    id: root
    implicitWidth: 100
    implicitHeight: 40

    property color backgroundColor: Fluent.controlFill
    property color borderColor: Fluent.controlBorder
    property color textColor: Fluent.textPrimary
    property real controlRadius: Fluent.appearance.buttonRadius

    property bool hovered: false
    property bool pressed: false
    property bool enabled: true
    property bool interactive: true

    onEnabledChanged: updateStyle()
    Component.onCompleted: updateStyle()

    function updateStyle() {
        backgroundColor = Fluent.controlFill
        borderColor = Fluent.controlBorder
        textColor = Fluent.textPrimary
        controlRadius = Fluent.appearance.buttonRadius
    }

    Behavior on backgroundColor { ColorAnimation { duration: 200; easing.type: Easing.OutQuart } }
    Behavior on textColor { ColorAnimation { duration: 200; easing.type: Easing.OutQuart } }
    Behavior on borderColor { ColorAnimation { duration: 200; easing.type: Easing.OutQuart } }

    MouseArea {
        id: mouseArea
        visible: interactive
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onPressed: root.pressed = true
        onReleased: root.pressed = false
        onClicked: {
            if (!root.enabled) { mouse.accepted = true; return }
            root.clicked()
        }
    }

    signal clicked()
}
