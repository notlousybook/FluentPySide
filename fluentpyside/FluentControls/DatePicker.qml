import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Button {
    id: datePicker

    property bool yearVisible: true

    property alias year: pickerView.value3
    property alias month: pickerView.value1
    property alias monthIndex: pickerView.index1
    property alias day: pickerView.value2

    property int startYear: 1925
    property int endYear: 2125

    readonly property var monthModel: (new Array(12)).fill(0).map((_, i) => Qt.locale().monthName(i))

    function calculateMaxDays(y, mIdx) {
        return new Date(y, mIdx + 1, 0).getDate()
    }

    implicitWidth: 250
    padding: 0

    property var selectedDate: new Date()
    property string date: {
        if (!pickerView.gotData) return ""
        var y = typeof year === "number" ? parseInt(year) : new Date().getFullYear()
        var monthIdx = monthModel.indexOf(month)
        var m = monthIdx >= 0 ? monthIdx + 1 : new Date().getMonth() + 1
        var d = parseInt(day) || new Date().getDate()
        return y + "-" + (m < 10 ? "0" + m : m) + "-" + (d < 10 ? "0" + d : d)
    }

    function setDate(yyyymmdd) {
        if (!yyyymmdd || typeof yyyymmdd !== "string" || !yyyymmdd.match(/^\d{4}[-\/]\d{1,2}[-\/]\d{1,2}$/)) return false
        var parts = yyyymmdd.split(/[-\/]/)
        var y = parseInt(parts[0]); var m = parseInt(parts[1]); var d = parseInt(parts[2])
        if (y < startYear || y > endYear || m < 1 || m > 12) return false
        var maxD = calculateMaxDays(y, m - 1)
        if (d < 1 || d > maxD) return false
        pickerView.value3 = y.toString()
        pickerView.value1 = getMonthName(m)
        pickerView.value2 = d.toString()
        pickerView.gotData = true
        return true
    }

    readonly property var dateOrder: {
        var fmt = datePicker.locale.dateFormat(Locale.ShortFormat)
        var order = []
        if (fmt.indexOf("y") < fmt.indexOf("M") && fmt.indexOf("M") < fmt.indexOf("d"))
            order = ["year", "month", "day"]
        else if (fmt.indexOf("M") < fmt.indexOf("d") && fmt.indexOf("d") < fmt.indexOf("y"))
            order = ["month", "day", "year"]
        else if (fmt.indexOf("d") < fmt.indexOf("M") && fmt.indexOf("M") < fmt.indexOf("y"))
            order = ["day", "month", "year"]
        else order = ["year", "month", "day"]
        if (!yearVisible) order = order.filter(function(item) { return item !== "year" })
        if (order.length === 0) order = ["month", "day"]
        return order
    }

    function getMonthName(num) { return datePicker.locale.monthName(num - 1) }

    onClicked: pickerView.open()

    contentItem: RowLayout {
        anchors.fill: parent
        spacing: 0

        Repeater {
            model: dateOrder

            delegate: Item {
                Layout.fillWidth: true
                Layout.maximumWidth: datePicker.implicitWidth / model.length
                implicitHeight: 32

                Label {
                    anchors.centerIn: parent
                    color: pickerView.gotData ? Fluent.textPrimary : Fluent.textSecondary
                    text: {
                        var type = modelData
                        if (!pickerView.gotData) {
                            if (type === "year") return qsTr("year")
                            if (type === "month") return qsTr("month")
                            if (type === "day") return qsTr("day")
                        }
                        if (type === "year") return year
                        if (type === "month") return month
                        if (type === "day") return day
                        return ""
                    }
                    font.pixelSize: Fluent.typography.body
                    font.family: Fluent.typography.fontFamily
                }
                ToolSeparator {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    implicitHeight: parent.implicitHeight
                    visible: index !== dateOrder.length - 1
                }
            }
        }
    }

    Popup {
        id: pickerView
        y: datePicker.height + 4
        width: datePicker.width
        height: 330
        padding: 0

        property var value1: undefined
        property var value2: undefined
        property var value3: undefined
        property alias index1: hoursTumbler.currentIndex
        property alias index2: minutesTumbler.currentIndex
        property alias index3: yearsTumbler.currentIndex
        property var model1: monthModel
        property var model2: {
            var yv = yearVisible && yearsTumbler.model ? parseInt(yearsTumbler.model[yearsTumbler.currentIndex]) : new Date().getFullYear()
            var mIdx = typeof index1 !== "undefined" ? index1 : new Date().getMonth()
            return Array.apply(null, {length: calculateMaxDays(yv, mIdx)}).map(function(_, i) { return i + 1 })
        }
        property var model3: yearVisible
            ? Array.apply(null, {length: endYear - startYear + 1}).map(function(_, i) { return startYear + i })
            : undefined
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
                    id: highlightBackground
                    anchors.centerIn: parent
                    height: 40
                    radius: Fluent.appearance.buttonRadius
                    color: Fluent.accent
                    width: parent.width - parent.leftPadding - parent.rightPadding
                }

                RowLayout {
                    id: tumblerRow
                    anchors.fill: parent

                    Tumbler {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        id: yearsTumbler
                        model: pickerView.model3
                        visibleItemCount: 7
                        visible: yearVisible
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
                                onClicked: yearsTumbler.currentIndex = index
                            }
                        }
                    }
                    ToolSeparator {
                        Layout.fillHeight: true
                        visible: yearsTumbler.visible
                    }
                    Tumbler {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        id: hoursTumbler
                        model: pickerView.model1
                        visibleItemCount: 7
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
                            text: modelData
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
                        pickerView.value3 = yearVisible ? pickerView.model3[yearsTumbler.currentIndex].toString() : undefined
                        pickerView.value1 = pickerView.model1[hoursTumbler.currentIndex]
                        pickerView.value2 = pickerView.model2[minutesTumbler.currentIndex].toString()
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
