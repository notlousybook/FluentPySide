import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    property string text: ""
    property int severity: 0
    property int timeout: -1
    property bool closable: true
    property bool isDynamic: false
    property int position: Position.top
    default property alias customContent: customRow.data

    color: severity === 1 ? Fluent.systemSuccessBackground
        : severity === 2 ? Fluent.systemCautionBackground
        : severity === 3 ? Fluent.systemCriticalBackground
        : Fluent.systemAttentionBackground
    border.color: severity === 1 ? Fluent.success
        : severity === 2 ? Fluent.caution
        : severity === 3 ? Fluent.critical
        : Fluent.informational
    border.width: 1
    radius: Fluent.appearance.buttonRadius
    implicitHeight: mainLayout.height + 16
    width: parent ? parent.width : 400

    function close() {
        exitAnimation.start()
    }

    Timer {
        id: autoCloseTimer
        interval: timeout
        running: timeout >= 0 && visible
        repeat: false
        onTriggered: exitAnimation.start()
    }

    RowLayout {
        id: mainLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 12
        spacing: 12

        Icon {
            id: iconWidget
            Layout.preferredHeight: 38
            Layout.alignment: Qt.AlignTop
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

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 4

            RowLayout {
                Layout.fillWidth: true
                spacing: 8
                Label {
                    id: titleText
                    visible: root.title !== ""
                    text: root.title
                    font.pixelSize: Fluent.typography.body
                    font.family: Fluent.typography.fontFamily
                    font.weight: Font.DemiBold
                    color: Fluent.textPrimary
                    Layout.alignment: Qt.AlignTop
                }
                Label {
                    id: bodyText
                    Layout.fillWidth: true
                    text: root.text
                    font.pixelSize: Fluent.typography.body
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textSecondary
                    wrapMode: Text.WordWrap
                    onLinkActivated: Qt.openUrlExternally(link)
                    Layout.alignment: Qt.AlignTop
                }
            }
            Row {
                id: customRow
                spacing: 6
            }
        }

        ToolButton {
            Layout.alignment: Qt.AlignVCenter
            flat: true
            icon.name: "ic_fluent_dismiss_20_regular"
            visible: closable
            onClicked: exitAnimation.start()
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Close")
            ToolTip.delay: 500
        }
    }

    opacity: 0

    Component.onCompleted: enterAnimation.start()

    onVisibleChanged: if (visible && opacity === 0) enterAnimation.start()

    ParallelAnimation {
        id: enterAnimation
        NumberAnimation { target: root; property: "opacity"; from: 0; to: 1; duration: Fluent.anim.speed; easing.type: Easing.OutQuart }
    }

    SequentialAnimation {
        id: exitAnimation
        ParallelAnimation {
            NumberAnimation { target: root; property: "opacity"; from: 1; to: 0; duration: Fluent.anim.appearance; easing.type: Easing.OutQuart }
        }
        ScriptAction {
            script: {
                if (root.isDynamic) root.destroy()
                else { root.visible = false; root.opacity = 1 }
            }
        }
    }

    Behavior on color { ColorAnimation { duration: Fluent.anim.appearance; easing.type: Easing.OutQuart } }
}
