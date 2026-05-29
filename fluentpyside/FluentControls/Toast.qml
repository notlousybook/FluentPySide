import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string message: ""
    property int severity: 0
    property int timeout: 4000

    color: Fluent.popupBackground
    border.color: Fluent.flyoutBorder
    border.width: 1
    radius: Fluent.appearance.buttonRadius
    width: 360
    height: mainLayout.height + 20

    RowLayout {
        id: mainLayout
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        Icon {
            size: 18
            icon: severity === 1 ? "ic_fluent_checkmark_circle_20_filled"
                : severity === 2 ? "ic_fluent_error_circle_20_filled"
                : severity === 3 ? "ic_fluent_dismiss_circle_20_filled"
                : "ic_fluent_info_20_filled"
            color: severity === 1 ? Fluent.success
                : severity === 2 ? Fluent.caution
                : severity === 3 ? Fluent.critical
                : Fluent.informational
        }

        Label {
            Layout.fillWidth: true
            text: root.message
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
            wrapMode: Text.WordWrap
        }

        ToolButton {
            flat: true
            icon.name: "ic_fluent_dismiss_20_regular"
            onClicked: root.close()
        }
    }

    opacity: 0

    function show() {
        opacity = 0
        enterAnimation.start()
        autoCloseTimer.start()
    }

    function close() {
        exitAnimation.start()
    }

    Timer {
        id: autoCloseTimer
        interval: root.timeout
        onTriggered: root.close()
    }

    NumberAnimation {
        id: enterAnimation
        target: root
        property: "opacity"
        from: 0
        to: 1
        duration: Fluent.anim.speed
        easing.type: Easing.OutQuart
    }

    SequentialAnimation {
        id: exitAnimation
        NumberAnimation { target: root; property: "opacity"; from: 1; to: 0; duration: Fluent.anim.appearance }
        ScriptAction { script: root.destroy() }
    }
}
