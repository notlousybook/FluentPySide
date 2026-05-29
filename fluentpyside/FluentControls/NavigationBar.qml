import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: navigationBar
    height: parent.height

    property bool collapsed: false
    property var navigationItems: []
    property bool isMacOS: Qt.platform.os === "osx" || Qt.platform.os === "macos" || Qt.platform.os === "darwin"
    property bool closeButtonVisible: true
    property bool minimizeButtonVisible: true
    property bool maximizeButtonVisible: true
    property bool useNativeMacControls: false
    property var window: null

    property int macControlSize: 12
    property int macControlSpacing: 8
    property int macControlLeftMargin: 20
    property int macDragGap: 12
    property int macNativeControlExtraInset: useNativeMacControls ? 18 : 0
    property int titleBarHeight: window && window.titleBarHeight !== undefined
        ? window.titleBarHeight
        : Fluent.appearance.windowTitleBarHeight
    property int macVisibleControlCount: isMacOS
        ? (useNativeMacControls ? 3 : (closeButtonVisible ? 1 : 0) + (minimizeButtonVisible ? 1 : 0) + (maximizeButtonVisible ? 1 : 0))
        : 0
    property int macTitleSafeInset: isMacOS && macVisibleControlCount > 0
        ? macControlLeftMargin + (macVisibleControlCount * macControlSize) + ((macVisibleControlCount - 1) * macControlSpacing) + macDragGap + macNativeControlExtraInset
        : 0

    property bool titleBarEnabled: true
    property int expandWidth: 0
    property int minimumExpandWidth: 900
    property int minNavbarWidth: 200
    property int maxNavbarWidth: 400
    property bool enableDragResize: false
    property int userResizedWidth: 0

    property alias windowTitle: titleLabel.text
    property alias windowIcon: iconLabel.icon
    property int windowWidth: minimumExpandWidth
    property var stackView: null
    property string currentPage: ""
    property bool collapsedByAutoResize: false
    property int cachedOptimalWidth: 280

    function isNotOverMinimumWidth() { return windowWidth < minimumExpandWidth }

    function getEffectiveWidth() {
        if (enableDragResize && userResizedWidth > 0) return userResizedWidth
        if (expandWidth > 0) return expandWidth
        return cachedOptimalWidth
    }

    function calculateOptimalWidth() {
        var maxWidth = minNavbarWidth
        var sections = [topRepeater, mainRepeater, bottomRepeater]
        for (var s = 0; s < sections.length; s++) {
            for (var i = 0; i < sections[s].count; i++) {
                var item = sections[s].itemAt(i)
                if (item && item.itemData) {
                    navTextMetrics.text = item.itemData.title || ""
                    var expandBtnWidth = (item.itemData.subItems && item.itemData.subItems.length > 0) ? 28 : 0
                    maxWidth = Math.max(maxWidth, navTextMetrics.width + 66 + expandBtnWidth)
                }
            }
        }
        return Math.min(Math.ceil(Math.max(maxWidth, minNavbarWidth) / 4) * 4, maxNavbarWidth)
    }

    function requestLayoutUpdate() {
        if (expandWidth <= 0 && !collapsed) {
            Qt.callLater(function() { cachedOptimalWidth = calculateOptimalWidth() })
        }
    }

    Component.onCompleted: {
        if (expandWidth <= 0) {
            Qt.callLater(function() { cachedOptimalWidth = calculateOptimalWidth() })
        }
    }

    TextMetrics {
        id: navTextMetrics
        font.pixelSize: 14
        font.family: Fluent.typography.fontFamily
    }

    width: collapsed ? 40 : getEffectiveWidth()
    implicitWidth: isNotOverMinimumWidth() ? 40 : (collapsed ? 40 : getEffectiveWidth())

    Behavior on width { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }
    Behavior on implicitWidth { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutQuint } }

    Rectangle {
        id: navBackground
        anchors.fill: parent
        anchors.margins: -5
        anchors.topMargin: 0
        radius: Fluent.appearance.windowRadius
        color: Fluent.backgroundAcrylic
        border.color: Fluent.flyoutBorder
        z: -1
        visible: isNotOverMinimumWidth() && !collapsed
        Behavior on visible { NumberAnimation { duration: collapsed ? Fluent.anim.speed / 2 : 50 } }
    }

    Row {
        id: title
        parent: navigationBar.window && navigationBar.window.titleBarHost
            ? navigationBar.window.titleBarHost
            : navigationBar
        anchors.left: parent.left
        anchors.leftMargin: navigationBar.macTitleSafeInset
        anchors.verticalCenter: parent.verticalCenter
        height: titleBarHeight
        spacing: 16
        visible: navigationBar.titleBarEnabled
        z: 2

        ToolButton {
            flat: true
            anchors.verticalCenter: parent.verticalCenter
            onClicked: navigationView.safePop()
            width: 40
            height: 40
            enabled: navigationView.lastPages.length > 0

            Icon {
                icon: "ic_fluent_arrow_left_20_regular"
                size: 16
                anchors.centerIn: parent
                color: parent.enabled ? Fluent.textPrimary : Fluent.textDisabled
            }

            ToolTip {
                parent: parent
                delay: 500
                visible: parent.hovered
                text: qsTr("Back")
            }
        }

        Icon {
            id: iconLabel
            size: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: titleLabel
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Fluent.typography.caption
            font.family: Fluent.typography.fontFamily
            color: Fluent.textPrimary
        }
    }

    ToolButton {
        id: collapseButton
        flat: true
        width: 40
        height: 38
        y: -2

        Icon {
            icon: "ic_fluent_navigation_20_regular"
            size: 16
            anchors.centerIn: parent
            color: Fluent.textPrimary
        }

        onClicked: {
            collapsed = !collapsed
            collapsedByAutoResize = false
        }

        ToolTip {
            parent: parent
            delay: 500
            visible: parent.hovered && !parent.pressed
            text: collapsed ? qsTr("Open Navigation") : qsTr("Close Navigation")
        }
    }

    function getTopItems() { return navigationItems.filter(function(i) { return i.position === Position.top }) }
    function getMiddleItems() { return navigationItems.filter(function(i) { return !i.position || i.position === Position.center || i.position === Position.none }) }
    function getBottomItems() { return navigationItems.filter(function(i) { return i.position === Position.bottom }) }

    Flickable {
        id: navFlickable
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 38
        anchors.bottom: parent.bottom
        contentHeight: navContent.implicitHeight
        clip: true

        Column {
            id: navContent
            width: navFlickable.width
            spacing: 2

            Repeater {
                id: topRepeater
                model: navigationBar.getTopItems()
                delegate: NavigationItem {
                    id: topItem
                    itemData: modelData
                    currentPage: navigationBar.currentPage
                    Connections {
                        target: navigationBar
                        function onCollapsedChanged() { if (navigationBar.collapsed) topItem.collapsed = true }
                    }
                }
            }

            Rectangle {
                height: 1
                width: parent.width
                color: Fluent.dividerBorder
                visible: navigationBar.getTopItems().length > 0
            }

            Repeater {
                id: mainRepeater
                model: navigationBar.getMiddleItems()
                delegate: NavigationItem {
                    id: mainItem
                    itemData: modelData
                    currentPage: navigationBar.currentPage
                    Connections {
                        target: navigationBar
                        function onCollapsedChanged() { if (navigationBar.collapsed) mainItem.collapsed = true }
                    }
                }
            }

            Rectangle {
                height: 1
                width: parent.width
                color: Fluent.dividerBorder
                visible: navigationBar.getBottomItems().length > 0
            }

            Repeater {
                id: bottomRepeater
                model: navigationBar.getBottomItems()
                delegate: NavigationItem {
                    id: bottomItem
                    itemData: modelData
                    currentPage: navigationBar.currentPage
                    Connections {
                        target: navigationBar
                        function onCollapsedChanged() { if (navigationBar.collapsed) bottomItem.collapsed = true }
                    }
                }
            }
        }

        ScrollBar.vertical: FluentScrollBar { policy: ScrollBar.AsNeeded }
    }

    MouseArea {
        id: resizeHandle
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 4
        cursorShape: Qt.SizeHorCursor
        enabled: enableDragResize && !collapsed
        visible: enabled
        z: 1000

        property int startX: 0
        property int startWidth: 0
        onPressed: function(mouse) { startX = mouse.x; startWidth = getEffectiveWidth() }
        onPositionChanged: function(mouse) {
            if (pressed) {
                var nw = Math.round(Math.max(minNavbarWidth, Math.min(maxNavbarWidth, startWidth + mouse.x - startX)) / 4) * 4
                navigationBar.userResizedWidth = nw
            }
        }
    }
}
