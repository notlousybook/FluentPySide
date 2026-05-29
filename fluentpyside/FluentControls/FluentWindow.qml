import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FluentWindowBase {
    id: window
    width: 900
    height: 600
    minimumWidth: 400
    minimumHeight: 300
    titleEnabled: false
    titleBarHeight: useNativeMacFrame ? 36 : Fluent.appearance.windowTitleBarHeight

    property alias navigationView: navigationView
    property alias navigationItems: navigationView.navigationItems
    property alias currentPage: navigationView.currentPage
    property alias defaultPage: navigationView.defaultPage
    property alias appLayerEnabled: navigationView.appLayerEnabled
    default property alias freeContent: freeContainer.data

    NavigationView {
        id: navigationView
        window: window
    }

    Item {
        id: freeContainer
        anchors.fill: parent
    }
}
