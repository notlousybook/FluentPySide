import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Hyperlink")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Hyperlink allows users to navigate to an external URL. It appears as colored, underlined text that users can click to open the link in a browser.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("Hyperlink")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Hyperlink {
            text: qsTr("Fluent Design System")
            url: "https://fluent2.microsoft.design/"
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
        }

        Hyperlink {
            text: qsTr("PySide6 Documentation")
            url: "https://doc.qt.io/qtforpython-6/"
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
        }

        Label {
            text: qsTr("Inline Hyperlinks")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 4
            Label {
                text: qsTr("Visit the")
                font.pixelSize: Fluent.typography.body
                color: Fluent.textPrimary
            }
            Hyperlink {
                text: qsTr("GitHub repository")
                url: "https://github.com"
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
            }
            Label {
                text: qsTr("for more info.")
                font.pixelSize: Fluent.typography.body
                color: Fluent.textPrimary
            }
        }
    }
}
