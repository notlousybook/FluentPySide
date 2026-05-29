import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: navigationView
    property bool appLayerEnabled: true
    property alias navExpandWidth: navigationBar.expandWidth
    property alias navMinimumExpandWidth: navigationBar.minimumExpandWidth
    property alias navigationBar: navigationBar
    property alias navigationItems: navigationBar.navigationItems
    property alias currentPage: navigationBar.currentPage
    property var lastPages: []
    property string defaultPage: ""
    property var window: parent
    property var componentCache: ({})

    signal pageChanged()

    anchors.fill: parent

    Connections {
        target: window
        function onWidthChanged() {
            if (navigationBar.isNotOverMinimumWidth()) {
                if (!navigationBar.collapsed) {
                    navigationBar.collapsed = true
                    navigationBar.collapsedByAutoResize = true
                }
            } else if (navigationBar.collapsed && navigationBar.collapsedByAutoResize) {
                navigationBar.collapsed = false
                navigationBar.collapsedByAutoResize = false
            }
        }
    }

    Component.onCompleted: {
        if (navigationBar.isNotOverMinimumWidth()) {
            navigationBar.collapsed = true
            navigationBar.collapsedByAutoResize = true
        }
    }

    NavigationBar {
        id: navigationBar
        window: navigationView.window
        windowTitle: window.title
        windowIcon: window.windowIcon || ""
        windowWidth: window.width
        closeButtonVisible: window && window.closeVisible !== undefined ? window.closeVisible : true
        minimizeButtonVisible: window && window.minimizeVisible !== undefined ? window.minimizeVisible : true
        maximizeButtonVisible: window && window.maximizeVisible !== undefined ? window.maximizeVisible : true
        useNativeMacControls: window && window.useNativeMacFrame !== undefined ? window.useNativeMacFrame : false
        stackView: stackView
        z: 999
        Layout.fillHeight: true
    }

    Item {
        Layout.fillWidth: true
        Layout.fillHeight: true

        MouseArea {
            id: collapseCatcher
            anchors.fill: parent
            z: 1
            hoverEnabled: true
            acceptedButtons: Qt.AllButtons
            visible: !navigationBar.collapsed && navigationBar.isNotOverMinimumWidth()
            onClicked: {
                navigationBar.collapsed = true
                navigationBar.collapsedByAutoResize = false
            }
        }

        Rectangle {
            id: appLayer
            width: parent.width + Fluent.windowDragArea + radius
            height: parent.height + Fluent.windowDragArea + radius
            color: Fluent.layerBackground
            border.color: Fluent.cardBorder
            border.width: 1
            opacity: (window && window.appLayerEnabled !== undefined) ? window.appLayerEnabled : navigationView.appLayerEnabled
            radius: Fluent.appearance.windowRadius
        }

        StackView {
            id: stackView
            anchors.fill: parent
            anchors.leftMargin: 1
            anchors.topMargin: 1

            pushEnter: Transition {
                PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.appearance; easing.type: Easing.InOutQuad }
                PropertyAnimation { property: "y"; from: stackView.height; to: 0; duration: Fluent.anim.middle; easing.type: Easing.OutQuint }
            }
            pushExit: Transition {
                PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.speed; easing.type: Easing.InOutQuad }
            }
            popExit: Transition {
                SequentialAnimation {
                    PauseAnimation { duration: Fluent.anim.fast * 0.6 }
                    PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.appearance; easing.type: Easing.InOutQuad }
                }
                PropertyAnimation { property: "y"; from: 0; to: stackView.height; duration: Fluent.anim.speed; easing.type: Easing.InQuint }
            }
            popEnter: Transition {
                SequentialAnimation {
                    PauseAnimation { duration: Fluent.anim.speed }
                    PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            initialItem: Item {}
        }

        Component.onCompleted: {
            if (navigationItems.length > 0) {
                var page = defaultPage !== "" ? defaultPage : navigationItems[0].page
                safePush(page, true)
            }
        }
    }

    function safePush(page, fromNav) {
        if (!page) return
        if (fromNav === undefined) fromNav = false

        var pageKey = String(page)
        if (!fromNav && navigationBar.currentPage === pageKey) return

        if (navigationBar.currentPage !== "" && !fromNav) {
            if (lastPages.length < 2) lastPages = lastPages.concat([navigationBar.currentPage])
            else lastPages = [lastPages[1], navigationBar.currentPage]
        }

        navigationBar.currentPage = pageKey
        pageChanged()

        var component
        if (componentCache[pageKey]) {
            component = componentCache[pageKey]
        } else {
            component = Qt.createComponent(page, Component.Asynchronous)
            if (component.status === Component.Error) {
                console.error("Failed to load:", page, component.errorString())
                stackView.push(errorPageComp, { errorMessage: component.errorString() })
                return
            }
            if (component.status === Component.Ready) {
                componentCache[pageKey] = component
            } else {
                component.statusChanged.connect(function() {
                    if (component.status === Component.Ready) {
                        componentCache[pageKey] = component
                        var instance = component.createObject(stackView, { objectName: pageKey })
                        if (instance) stackView.push(instance)
                    } else {
                        console.error("Failed to load:", page, component.errorString())
                    }
                })
                return
            }
        }

        var instance = component.createObject(stackView, { objectName: pageKey })
        if (instance) stackView.push(instance)
    }

    function safePop() {
        if (lastPages.length > 0) {
            var prev = lastPages[lastPages.length - 1]
            lastPages = lastPages.slice(0, -1)
            navigationBar.currentPage = prev
            pageChanged()
            if (stackView.depth > 1) stackView.pop()
            else safePush(prev, true)
        }
    }

    function push(page) { safePush(page, false) }
    function pop() { safePop() }

    property Component errorPageComp: Component {
        Item {
            property string errorMessage: ""
            Label {
                anchors.centerIn: parent
                text: "Error: " + errorMessage
                color: Fluent.critical
            }
        }
    }
}
