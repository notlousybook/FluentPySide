import QtQuick
import QtQuick.Controls

Item {
    id: navigationItem
    property var itemData
    readonly property bool hasSubItems: !!(itemData && itemData.subItems && itemData.subItems.length > 0)
    property var currentPage
    property bool highlighted: String(navigationBar.currentPage) === String(itemData.page) || (collapsed && subItemHighlighted)
    property bool subItemHighlighted: {
        if (!hasSubItems) return false
        for (var i = 0; i < itemData.subItems.length; i++) {
            if (String(itemData.subItems[i].page) === String(navigationBar.currentPage)) return true
        }
        return false
    }
    property bool collapsed: true

    height: 40 + (!collapsed && hasSubItems ? subItemsColumn.height : 0)
    width: parent ? parent.width : 200

    Indicator {
        id: indicator
        x: 0
        y: (itemBtn.height + 3) / 2 - indicator.height / 2
        currentItemHeight: itemBtn.height + 3
        visible: highlighted
        width: 3
        z: 1
    }

    Button {
        id: itemBtn
        width: parent.width
        height: 37
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        flat: true
        background.opacity: navigationItem.highlighted ? 1 : hovered ? 1 : 0

        FocusIndicator { control: parent; anchors.margins: 2 }

        Row {
            id: leftRow
            spacing: 16
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 11

            Icon {
                id: icon
                anchors.verticalCenter: parent.verticalCenter
                size: itemData.icon || itemData.source ? 19 : 0
                icon: itemData.icon || ""
                source: itemData.source || ""
            }

            Label {
                id: text
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: Fluent.typography.body
                font.family: Fluent.typography.fontFamily
                color: Fluent.textPrimary
                text: itemData.title
                clip: true
                opacity: navigationBar.collapsed ? 0 : 1
                elide: Text.ElideRight
                width: itemBtn.width - leftRow.anchors.leftMargin - x - (expandBtn.visible ? expandBtn.width : 0) - 10

                Behavior on opacity { NumberAnimation { duration: Fluent.anim.appearance } }
            }
        }

        ToolTip {
            visible: navigationBar.collapsed && itemBtn.hovered
            delay: 500
            text: itemData.title
        }

        ToolButton {
            id: expandBtn
            focusPolicy: Qt.NoFocus
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height
            height: parent.height
            icon.name: "ic_fluent_chevron_down_20_regular"

            transform: Rotation {
                angle: collapsed ? 0 : 180
                origin.x: 37 / 2; origin.y: 37 / 2
                Behavior on angle { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }
            }

            visible: hasSubItems && !navigationBar.collapsed
            opacity: 0.7

            onClicked: {
                collapsed = !collapsed
                if (navigationBar && typeof navigationBar.requestLayoutUpdate === "function")
                    Qt.callLater(navigationBar.requestLayoutUpdate)
            }
        }

        onClicked: {
            if (hasSubItems) {
                if (!navigationBar.collapsed) {
                    collapsed = !collapsed
                    if (navigationBar && typeof navigationBar.requestLayoutUpdate === "function")
                        Qt.callLater(navigationBar.requestLayoutUpdate)
                } else {
                    subMenu.open()
                }
            }
            if (itemData.page && String(navigationBar.currentPage) !== String(itemData.page)) {
                navigationView.safePush(itemData.page, false)
            }
        }
    }

    Behavior on height { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }

    Menu {
        id: subMenu
        Repeater {
            model: itemData.subItems
            delegate: MenuItem {
                text: modelData.title
                onClicked: { if (modelData.page) navigationView.safePush(modelData.page) }
            }
        }
    }

    Column {
        id: subItemsColumn
        opacity: !collapsed && hasSubItems ? 1 : 0
        spacing: 2
        anchors.top: itemBtn.bottom
        width: parent.width
        anchors.topMargin: 1

        Behavior on opacity { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }

        Repeater {
            model: itemData.subItems
            delegate: NavigationSubItem {
                itemData: modelData
                currentPage: navigationItem.currentPage
            }
        }

        Item { width: parent.width; height: 1 }
    }
}
