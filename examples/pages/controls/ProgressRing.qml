import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("ProgressRing")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("ProgressRing shows progress by animating a ring. Like ProgressBar, it can be determinate or indeterminate. Use ProgressRing when space is limited or to show progress inline with other content.")
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
            spacing: 24
            ProgressRing { ringSize: 48; value: 0.25 }
            ProgressRing { ringSize: 48; value: 0.5 }
            ProgressRing { ringSize: 48; value: 0.75 }
            ProgressRing { ringSize: 48; value: 1.0 }
        }

        Label {
            text: qsTr("Indeterminate")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 24
            ProgressRing { ringSize: 32; indeterminate: true }
            ProgressRing { ringSize: 48; indeterminate: true }
            ProgressRing { ringSize: 64; indeterminate: true }
        }
    }
}
