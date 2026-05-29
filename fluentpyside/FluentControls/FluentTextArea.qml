import QtQuick
import QtQuick.Controls

TextArea {
    id: root
    property bool frameless: false

    selectByMouse: true
    wrapMode: Text.WordWrap
    verticalAlignment: Text.AlignTop

    font.pixelSize: Fluent.typography.body
    font.family: Fluent.typography.fontFamily
    color: Fluent.textPrimary
    selectionColor: Fluent.accent
    selectedTextColor: Fluent.textOnAccent
    placeholderTextColor: Fluent.textTertiary

    leftPadding: 12
    rightPadding: 12
    topPadding: 5
    bottomPadding: 7

    background: Rectangle {
        radius: Fluent.appearance.buttonRadius
        color: frameless ? "transparent" : Fluent.controlFill
        border.width: Fluent.appearance.borderWidth
        border.color: root.activeFocus ? Fluent.textControlBorderFocused : Fluent.controlBorder

        Rectangle {
            width: parent.width
            anchors.bottom: parent.bottom
            height: root.activeFocus ? 2 : Fluent.appearance.borderWidth
            color: root.activeFocus ? Fluent.accent : Fluent.controlBorder

            Behavior on color { ColorAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }
            Behavior on height { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }
        }

        Behavior on color { ColorAnimation { duration: Fluent.anim.appearance } }
    }
}
