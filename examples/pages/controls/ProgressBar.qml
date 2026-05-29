import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ProgressBar")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("ProgressBar controls show progress by filling a percentage of a bar. They can be determinate (specific %) or indeterminate (ongoing).")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Determinate")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            ProgressBar { width: 200; from: 0; to: 100; value: 25 }
            Label { text: "25%"; anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
        }
        Row {
            spacing: 12
            ProgressBar { width: 200; from: 0; to: 100; value: 50 }
            Label { text: "50%"; anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
        }
        Row {
            spacing: 12
            ProgressBar { width: 200; from: 0; to: 100; value: 75 }
            Label { text: "75%"; anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
        }

        Label {
            text: qsTr("Indeterminate")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        ProgressBar {
            width: 200
            indeterminate: true
        }

        Label {
            text: qsTr("Interactive demo")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            ProgressBar { width: 300; from: 0; to: 100; value: progressSlider.value }
            Row {
                spacing: 8
                Label { text: qsTr("Progress:"); anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
                Slider { id: progressSlider; from: 0; to: 100; value: 42; width: 200 }
            }
        }
    }
}
