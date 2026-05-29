import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: page
    default property alias content: scrollContent.data
    property alias contentHeader: headerContainer.data
    property alias customHeader: headerRow.data
    property alias extraHeaderItems: extraHeaderRow.data
    property int pageRadius: Fluent.appearance.windowRadius
    property int wrapperWidth: 1000
    horizontalPadding: 56
    bottomPadding: 24
    spacing: 0
    property alias contentSpacing: scrollContent.spacing

    header: Item {
        height: page.title !== "" ? 36 + 44 : 0

        RowLayout {
            id: headerRow
            width: Math.min(page.width - page.horizontalPadding * 2, page.wrapperWidth)
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height

            Label {
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                font.pixelSize: Fluent.typography.title
                font.family: Fluent.typography.fontFamily
                font.weight: Font.Bold
                color: Fluent.textPrimary
                text: page.title
                visible: page.title !== ""
            }

            Row {
                id: extraHeaderRow
                spacing: 4
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
            }
        }
    }

    background: Item {}

    Flickable {
        anchors.fill: parent
        clip: true
        contentHeight: scrollContent.height + 18 + headerContainer.height

        ScrollBar.vertical: FluentScrollBar {}

        Row {
            id: headerContainer
            width: page.width
        }

        Column {
            id: scrollContent
            anchors.top: headerContainer.bottom
            anchors.topMargin: 18
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.min(page.width - page.horizontalPadding * 2, page.wrapperWidth)
            spacing: 14
        }
    }
}
