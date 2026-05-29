import QtQuick
import QtQuick.Controls
import FluentControls

FluentPage {
    title: qsTr("Avatar")
    wrapperWidth: 800

    Column {
        spacing: 16
        width: parent.width

        Label {
            text: qsTr("Avatar displays a user's image or initials. When no image is available, initials are shown on an accent-colored circle.")
            font.pixelSize: Fluent.typography.body
            font.family: Fluent.typography.fontFamily
            color: Fluent.textSecondary
            wrapMode: Text.WordWrap
            width: parent.width
        }

        Label {
            text: qsTr("With Initials")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            Avatar { initials: "JD"; size: 32 }
            Avatar { initials: "AB"; size: 48 }
            Avatar { initials: "XY"; size: 64 }
            Avatar { initials: "MK"; size: 80 }
        }

        Label {
            text: qsTr("With Image")
            font.weight: Font.Bold
            font.pixelSize: Fluent.typography.body
            color: Fluent.textPrimary
        }

        Row {
            spacing: 16
            Avatar {
                size: 64
                initials: "U"
            }
            Avatar {
                size: 48
                initials: "A"
            }
        }
    }
}
