import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Flyout")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("A Flyout is a lightweight contextual popup that shows UI related to what the user is doing. It dismisses when clicking outside of it or when the user takes a qualifying action.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Flyout Popup")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Show Flyout")
            onClicked: sampleFlyout.open()

            Flyout {
                id: sampleFlyout
                x: parent.width / 2 - 140
                y: parent.height + 4

                Column {
                    spacing: 8
                    Label {
                        text: qsTr("Flyout Content")
                        font.pixelSize: Fluent.typography.body
                        font.weight: Font.Bold
                        color: Fluent.textPrimary
                    }
                    Label {
                        text: qsTr("This is a lightweight popup that dismisses when clicking outside.")
                        font.pixelSize: Fluent.typography.caption
                        color: Fluent.textSecondary
                        wrapMode: Text.WordWrap
                        width: 240
                    }
                }
            }
        }

        Label {
            text: qsTr("Flyout with Actions")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Button {
            text: qsTr("Show Action Flyout")
            onClicked: actionFlyout.open()

            Flyout {
                id: actionFlyout
                x: parent.width / 2 - 140
                y: parent.height + 4

                Column {
                    spacing: 12
                    Label {
                        text: qsTr("Choose an action")
                        font.pixelSize: Fluent.typography.body
                        color: Fluent.textPrimary
                    }
                    Row {
                        spacing: 8
                        Button { text: qsTr("Accept"); highlighted: true; onClicked: actionFlyout.close() }
                        Button { text: qsTr("Cancel"); flat: true; onClicked: actionFlyout.close() }
                    }
                }
            }
        }
    }
}
