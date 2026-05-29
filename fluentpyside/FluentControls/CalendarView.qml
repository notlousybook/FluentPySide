import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property var selectedDate: new Date()
    property int currentMonth: selectedDate.getMonth()
    property int currentYear: selectedDate.getFullYear()

    width: 320
    height: 340
    color: Fluent.cardBackground
    border.color: Fluent.cardBorder
    border.width: 1
    radius: Fluent.appearance.buttonRadius

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        RowLayout {
            Layout.fillWidth: true

            RoundButton {
                flat: true
                implicitWidth: 32
                implicitHeight: 32
                icon.width: 0
                icon.height: 0
                contentItem: Icon {
                    icon: "ic_fluent_chevron_left_20_regular"
                    size: 14
                    color: Fluent.textPrimary
                    anchors.centerIn: parent
                }
                onClicked: { currentMonth--; if (currentMonth < 0) { currentMonth = 11; currentYear-- } }
            }

            Label {
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: {
                    var months = [qsTr("January"),qsTr("February"),qsTr("March"),qsTr("April"),qsTr("May"),qsTr("June"),qsTr("July"),qsTr("August"),qsTr("September"),qsTr("October"),qsTr("November"),qsTr("December")]
                    return months[currentMonth] + " " + currentYear
                }
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
                color: Fluent.textPrimary
            }

            RoundButton {
                flat: true
                implicitWidth: 32
                implicitHeight: 32
                icon.width: 0
                icon.height: 0
                contentItem: Icon {
                    icon: "ic_fluent_chevron_right_20_regular"
                    size: 14
                    color: Fluent.textPrimary
                    anchors.centerIn: parent
                }
                onClicked: { currentMonth++; if (currentMonth > 11) { currentMonth = 0; currentYear++ } }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0
            Repeater {
                model: [qsTr("Su"),qsTr("Mo"),qsTr("Tu"),qsTr("We"),qsTr("Th"),qsTr("Fr"),qsTr("Sa")]
                Label {
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData
                    font.pixelSize: Fluent.typography.caption
                    font.family: Fluent.typography.fontFamily
                    color: Fluent.textSecondary
                }
            }
        }

        GridLayout {
            id: dayGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 7
            columnSpacing: 0
            rowSpacing: 0

            model: {
                var first = new Date(currentYear, currentMonth, 1)
                var startDay = first.getDay()
                var daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate()
                var items = []
                for (var i = 0; i < startDay; i++) items.push(0)
                for (var d = 1; d <= daysInMonth; d++) items.push(d)
                // Fill the rest of the grid slots to maintain 7 columns correctly
                var totalCells = items.length;
                var remaining = (7 - (totalCells % 7)) % 7;
                for (var j = 0; j < remaining; j++) items.push(0);
                return items
            }

            Repeater {
                model: dayGrid.model
                delegate: Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    implicitHeight: 36

                    Rectangle {
                        anchors.centerIn: parent
                        width: 30
                        height: 30
                        radius: 15
                    color: modelData === selectedDate.getDate() && currentMonth === selectedDate.getMonth() && currentYear === selectedDate.getFullYear()
                        ? Fluent.accent : mouseArea.containsMouse && modelData > 0
                        ? Fluent.subtleSecondary : "transparent"

                    Label {
                        anchors.centerIn: parent
                        text: modelData > 0 ? modelData : ""
                        font.pixelSize: Fluent.typography.caption
                        font.family: Fluent.typography.fontFamily
                        color: modelData === selectedDate.getDate() && currentMonth === selectedDate.getMonth() && currentYear === selectedDate.getFullYear()
                            ? Fluent.textOnAccent : Fluent.textPrimary
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (modelData > 0) selectedDate = new Date(currentYear, currentMonth, modelData)
                        }
                    }
                }
            }
        }
    }
}
