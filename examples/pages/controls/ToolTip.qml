import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ToolTip")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("ToolTip shows a small informational popup when the user hovers over or focuses on a control. Use it to provide brief, helpful descriptions.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Hover to Show ToolTip")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16

            Button {
                text: qsTr("Hover me")
                ToolTip.visible: hovered
                ToolTip.text: qsTr("A simple tooltip")
                ToolTip.delay: 300
            }

            Button {
                text: qsTr("Longer tip")
                ToolTip.visible: hovered
                ToolTip.text: qsTr("This tooltip has more descriptive text for the button")
                ToolTip.delay: 300
            }

            Icon {
                icon: "ic_fluent_info_20_regular"
                size: 20
                color: Fluent.textSecondary
                ToolTip.visible: tipArea.containsMouse
                ToolTip.text: qsTr("Informational icon")

                MouseArea {
                    id: tipArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }

        Label {
            text: qsTr("ToolTip on Controls")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Slider {
            from: 0; to: 100; value: 50
            ToolTip.visible: pressed
            ToolTip.text: qsTr("Value: %1").arg(Math.round(value))
        }
    }
}
