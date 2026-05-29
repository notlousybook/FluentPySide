import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property int count: -1
    property string badgeText: {
        if (count < 0) return ""
        if (count > maxCount) return maxCount + "+"
        return count.toString()
    }
    property int maxCount: 99
    property string badgeIcon: {
        switch (severity) {
            case 1: return "ic_fluent_checkmark_20_filled"
            case 2: return "ic_fluent_error_circle_20_filled"
            case 3: return "ic_fluent_dismiss_20_filled"
            default: return "ic_fluent_text_asterisk_20_filled"
        }
    }
    property bool dot: false
    property int severity: 0
    property bool solid: true
    property color badgeColor: {
        switch (severity) {
            case 1: return Fluent.success
            case 2: return Fluent.caution
            case 3: return Fluent.critical
            default: return Fluent.informational
        }
    }

    width: dot ? 6 : Math.max(contents.implicitWidth + 8, 20)
    height: dot ? 6 : Math.max(contents.implicitHeight + 4, 20)
    radius: height / 2

    color: solid ? badgeColor : "transparent"
    border.width: solid ? 0 : Fluent.appearance.borderWidth
    border.color: solid ? "transparent" : badgeColor

    RowLayout {
        id: contents
        anchors.centerIn: parent
        spacing: 4
        visible: !root.dot

        Icon {
            icon: root.badgeIcon
            size: 10
            color: solid ? Fluent.textOnAccent : root.badgeColor
            visible: !root.badgeText && root.badgeIcon
            Layout.preferredWidth: visible ? 10 : 0
            Layout.preferredHeight: visible ? 10 : 0
            Layout.alignment: Qt.AlignVCenter
        }

        Label {
            text: root.badgeText
            font.pixelSize: 11
            font.family: Fluent.typography.fontFamily
            font.weight: Font.Bold
            color: solid ? Fluent.textOnAccent : root.badgeColor
            visible: root.badgeText !== ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignVCenter
        }
    }

    Behavior on color { ColorAnimation { duration: Fluent.anim.appearance; easing.type: Easing.OutQuint } }
}
