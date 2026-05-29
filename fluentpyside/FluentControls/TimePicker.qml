import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: timePickerButton

    property string amText: qsTr("AM")
    property string pmText: qsTr("PM")
    property string hourText: qsTr("hour")
    property string minuteText: qsTr("minute")

    property bool use24Hour: false

    property alias hour: pickerView.value1
    property alias minute: pickerView.value2
    property alias hourSystem: pickerView.value3

    implicitWidth: 250
    padding: 0

    property string time: {
        if (!pickerView.gotData) return ""
        var h = parseInt(hour)
        if (!use24Hour) {
            if (hourSystem === pmText && h < 12) h += 12
            if (hourSystem === amText && h === 12) h = 0
        }
        var hh = h < 10 ? "0" + h : "" + h
        var mm = parseInt(minute)
        var mmStr = mm < 10 ? "0" + mm : "" + mm
        return hh + ":" + mmStr
    }

    function setTime(hhmm) {
        if (!hhmm || typeof hhmm !== "string" || !hhmm.match(/^\d{2}:\d{2}$/)) return
        var parts = hhmm.split(":")
        var h = parseInt(parts[0]); var m = parseInt(parts[1])
        if (h >= 0 && h < 24 && m >= 0 && m < 60) {
            if (use24Hour) {
                pickerView.value1 = h.toString()
                pickerView.value2 = m.toString()
                pickerView.value3 = undefined
            } else {
                pickerView.value1 = ((h % 12 === 0) ? 12 : h % 12).toString()
                pickerView.value2 = m.toString()
                pickerView.value3 = h >= 12 ? pmText : amText
            }
            pickerView.gotData = true
        }
    }

    onClicked: pickerView.open()

    contentItem: RowLayout {
        anchors.fill: parent
        spacing: 0

        Label {
            Layout.fillWidth: true
            Layout.maximumWidth: use24Hour ? timePickerButton.implicitWidth / 2 : timePickerButton.implicitWidth / 3
            color: pickerView.gotData ? Fluent.textPrimary : Fluent.textSecondary
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: pickerView.gotData ? pickerView.value1 : hourText
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
        }
        ToolSeparator { implicitHeight: 32 }
        Label {
            Layout.fillWidth: true
            Layout.maximumWidth: use24Hour ? timePickerButton.implicitWidth / 2 : timePickerButton.implicitWidth / 3
            color: pickerView.gotData ? Fluent.textPrimary : Fluent.textSecondary
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: pickerView.gotData ? pickerView.value2 : minuteText
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
        }
        ToolSeparator { implicitHeight: 32; visible: !use24Hour }
        Label {
            Layout.fillWidth: true
            Layout.maximumWidth: timePickerButton.implicitWidth / 3
            color: pickerView.gotData ? Fluent.textPrimary : Fluent.textSecondary
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: pickerView.gotData ? (pickerView.value3 !== undefined ? pickerView.value3 : "") : amText
            visible: !use24Hour
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
        }
    }

    Popup {
        id: pickerView
        y: timePickerButton.height + 4
        width: timePickerButton.width
        height: 330
        padding: 0

        property var value1: undefined
        property var value2: undefined
        property var value3: undefined
        property alias index1: hoursTumbler.currentIndex
        property alias index2: minutesTumbler.currentIndex
        property alias index3: addedTumbler.currentIndex
        property var model1: use24Hour ? 24 : 12
        property var model2: 60
        property var model3: use24Hour ? undefined : [amText, pmText]
        property bool gotData: false

        signal valueChanged(var v1, var v2, var v3)

        function formatText(count, modelData) {
            var data = modelData
            return data.toString().length < 2 && count === 60 ? "0" + data
                : data === 0 && count === 12 ? 12 : data
        }

        background: Rectangle {
            color: Fluent.popupBackground
            border.color: Fluent.flyoutBorder
            border.width: 1
            radius: Fluent.appearance.windowRadius
        }

        contentItem: ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Frame {
                Layout.fillWidth: true
                Layout.fillHeight: true
                padding: 0
                leftPadding: 4
                rightPadding: 4
                background: Rectangle {
                    anchors.centerIn: parent
                    height: 40
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.accent
                    width: parent.width - parent.leftPadding - parent.rightPadding
                }

                RowLayout {
                    anchors.fill: parent

                    Tumbler {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        id: hoursTumbler
                        model: pickerView.model1
                        visibleItemCount: 7
                        delegate: Label {
                            readonly property bool highlighted: Tumbler.displacement < 0.5 && Tumbler.displacement > -0.5
                            text: pickerView.formatText(Tumbler.tumbler.count, modelData)
                            color: highlighted ? Fluent.textOnAccent : Fluent.textPrimary
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: Fluent.typography.body
                            font.family: Fluent.typography.fontFamily
                            MouseArea {
                                anchors.fill: parent
                                onClicked: hoursTumbler.currentIndex = index
                            }
                        }
                    }
                    ToolSeparator { Layout.fillHeight: true }
                    Tumbler {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        id: minutesTumbler
                        model: pickerView.model2
                        visibleItemCount: 7
                        delegate: Label {
                            readonly property bool highlighted: Tumbler.displacement < 0.5 && Tumbler.displacement > -0.5
                            text: pickerView.formatText(Tumbler.tumbler.count, modelData)
                            color: highlighted ? Fluent.textOnAccent : Fluent.textPrimary
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: Fluent.typography.body
                            font.family: Fluent.typography.fontFamily
                            MouseArea {
                                anchors.fill: parent
                                onClicked: minutesTumbler.currentIndex = index
                            }
                        }
                    }
                    ToolSeparator { Layout.fillHeight: true; visible: addedTumbler.visible }
                    Tumbler {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        id: addedTumbler
                        model: pickerView.model3
                        visibleItemCount: 7
                        visible: typeof pickerView.model3 !== "undefined"
                        delegate: Label {
                            readonly property bool highlighted: Tumbler.displacement < 0.5 && Tumbler.displacement > -0.5
                            text: modelData
                            color: highlighted ? Fluent.textOnAccent : Fluent.textPrimary
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: Fluent.typography.body
                            font.family: Fluent.typography.fontFamily
                            MouseArea {
                                anchors.fill: parent
                                onClicked: addedTumbler.currentIndex = index
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 1
                color: Fluent.divider
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 4
                Layout.rightMargin: 4
                spacing: 0

                ToolButton {
                    Layout.fillWidth: true
                    flat: true
                    icon.name: "ic_fluent_checkmark_20_regular"
                    onClicked: {
                        pickerView.value1 = hoursTumbler.currentItem.text
                        pickerView.value2 = minutesTumbler.currentItem.text
                        if (addedTumbler.visible) pickerView.value3 = addedTumbler.currentItem.text
                        pickerView.gotData = true
                        pickerView.valueChanged(pickerView.value1, pickerView.value2, pickerView.value3)
                        pickerView.close()
                    }
                }
                ToolSeparator { implicitHeight: 40 }
                ToolButton {
                    Layout.fillWidth: true
                    flat: true
                    icon.name: "ic_fluent_dismiss_20_regular"
                    onClicked: pickerView.close()
                }
            }
        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.appearance; easing.type: Easing.OutQuint }
                NumberAnimation { property: "height"; from: implicitHeight / 2; to: implicitHeight; duration: Fluent.anim.middle * 0.8; easing.type: Easing.OutQuint }
            }
        }
        exit: Transition {
            NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.appearance }
        }
    }
}
