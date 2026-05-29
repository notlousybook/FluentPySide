import QtQuick
import QtQuick.Controls

Button {
    id: root
    property color checkedColor: Fluent.accent
    property color uncheckedColor: Fluent.controlFill

    highlighted: checked
    checkable: true

    background: Rectangle {
        color: root.checked ? root.checkedColor : root.uncheckedColor
        radius: Fluent.appearance.buttonRadius
        border.color: root.checked ? "transparent" : Fluent.controlBorder
        border.width: root.checked ? 0 : Fluent.appearance.borderWidth

        Behavior on color { ColorAnimation { duration: Fluent.anim.fast; easing.type: Easing.OutQuart } }
    }
}
