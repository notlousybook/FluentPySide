import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Slider")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Use a Slider when you want your users to be able to set defined, contiguous values (such as volume or brightness) or a range of discrete values (such as screen resolution settings).")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("A simple Slider")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 12
            Slider { width: 200; from: 0; to: 100; value: 50; enabled: !disableSliderSwitch.checked }
            CheckBox { id: disableSliderSwitch; text: qsTr("Disable"); anchors.verticalCenter: parent.verticalCenter }
        }

        Label {
            text: qsTr("A Slider with range and step specified")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Column {
            spacing: 8
            Slider {
                width: 300
                from: minSlider.value
                to: maxSlider.value
                stepSize: stepSlider.value
                value: 800
            }
            Row { spacing: 12
                Label { text: qsTr("Min:"); anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
                Slider { id: minSlider; from: 0; to: 1000; stepSize: 10; value: 500; width: 120 }
            }
            Row { spacing: 12
                Label { text: qsTr("Max:"); anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
                Slider { id: maxSlider; from: 0; to: 1000; stepSize: 10; value: 800; width: 120 }
            }
            Row { spacing: 12
                Label { text: qsTr("Step:"); anchors.verticalCenter: parent.verticalCenter; color: Fluent.textSecondary; font.pixelSize: Fluent.typography.caption }
                Slider { id: stepSlider; from: 1; to: 100; stepSize: 1; value: 10; width: 120 }
            }
        }

        Label {
            text: qsTr("Vertical Slider")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            Slider { orientation: Qt.Vertical; height: 120; from: 0; to: 100; value: 70 }
            Slider { orientation: Qt.Vertical; height: 120; from: 0; to: 100; value: 30 }
            Slider { orientation: Qt.Vertical; height: 120; from: 0; to: 100; value: 50; enabled: false }
        }
    }
}
