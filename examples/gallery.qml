import QtQuick
import QtQuick.Controls
import QtQuick.Controls.FluentWinUI3
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 1100
    height: 750
    title: qsTr("FluentWinUI3 Gallery")

    property int currentPage: 0

    ListModel {
        id: navModel
        ListElement { title: "Buttons"; icon: "\uD83D\uDD18" }
        ListElement { title: "Input"; icon: "\u270F" }
        ListElement { title: "Selection"; icon: "\u2611" }
        ListElement { title: "Progress"; icon: "\u25CE" }
        ListElement { title: "Containers"; icon: "\uD83D\uDDC2" }
        ListElement { title: "Navigation"; icon: "\u2796" }
        ListElement { title: "Pickers"; icon: "\uD83D\uDCC5" }
        ListElement { title: "Menus"; icon: "\u2630" }
    }

    NavigationView {
        id: navView
        anchors.fill: parent
        model: navModel
        currentIndex: root.currentPage
        onCurrentIndexChanged: root.currentPage = currentIndex

        StackLayout {
            currentIndex: root.currentPage

            // ========== PAGE 0: BUTTONS ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: btnCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: btnCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Buttons"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Standard buttons with Fluent styling." }

                    GroupBox {
                        title: "Button Variants"
                        width: parent.width
                        Column { spacing: 8
                            Row { spacing: 8
                                Button { text: "Normal" }
                                Button { text: "Checked"; checked: true }
                                Button { text: "Flat"; flat: true }
                                Button { text: "Disabled"; enabled: false }
                            }
                            Row { spacing: 8
                                Button { text: "Highlighted"; highlighted: true }
                                Button { text: "Flat + Checked"; flat: true; checked: true }
                            }
                        }
                    }

                    GroupBox {
                        title: "Round Button"
                        width: parent.width
                        Row { spacing: 8
                            RoundButton { text: "OK" }
                            RoundButton { text: "+" }
                            RoundButton { text: "?" }
                            RoundButton { text: "X"; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Delay Button (hold to confirm)"
                        width: parent.width
                        Row { spacing: 8
                            DelayButton { text: "Hold Me"; delay: 1500 }
                            DelayButton { text: "Disabled"; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Tool Buttons"
                        width: parent.width
                        Row { spacing: 8
                            ToolButton { text: "Open" }
                            ToolButton { text: "Save" }
                            ToolSeparator {}
                            ToolButton { text: "Cut" }
                            ToolButton { text: "Copy"; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Switch"
                        width: parent.width
                        Column { spacing: 8
                            Row { spacing: 20
                                Switch { text: "Wi-Fi" }
                                Switch { text: "Bluetooth"; checked: true }
                                Switch { text: "Disabled"; enabled: false }
                            }
                        }
                    }

                    GroupBox {
                        title: "Switch Delegate"
                        width: parent.width
                        Column { spacing: 2
                            SwitchDelegate { text: "Airplane Mode" }
                            SwitchDelegate { text: "Hotspot"; checked: true }
                            SwitchDelegate { text: "VPN" }
                        }
                    }

                    Item { height: 16 }
                }
            }

            // ========== PAGE 1: INPUT ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: inpCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: inpCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Input Controls"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Text entry, sliders, spin boxes, and text areas." }

                    GroupBox {
                        title: "Text Field"
                        width: parent.width
                        Column { spacing: 8
                            TextField { placeholderText: "Standard text field"; width: 350 }
                            TextField { placeholderText: "Disabled"; enabled: false; width: 350 }
                            Row { spacing: 8
                                TextField { placeholderText: "Username"; width: 170 }
                                TextField { placeholderText: "Password"; echoMode: TextInput.Password; width: 170 }
                            }
                        }
                    }

                    GroupBox {
                        title: "Text Area"
                        width: parent.width
                        Column { spacing: 8
                            TextArea {
                                placeholderText: "Multi-line text input area"
                                width: 400; height: 80
                                wrapMode: TextArea.Wrap
                            }
                        }
                    }

                    GroupBox {
                        title: "Search Field"
                        width: parent.width
                        Column { spacing: 8
                            SearchField { width: 300 }
                            SearchField { width: 300; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Slider"
                        width: parent.width
                        Column { spacing: 12
                            Label { text: "Continuous Slider" }
                            Slider { from: 0; to: 100; value: 30; width: 350 }
                            Label { text: "Snappy Slider (stepSize: 10)" }
                            Slider { from: 0; to: 100; value: 50; stepSize: 10; width: 350; live: true }
                            Slider { from: 0; to: 100; value: 70; width: 350; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Range Slider"
                        width: parent.width
                        Column { spacing: 12
                            RangeSlider { first.value: 0.25; second.value: 0.75; width: 350 }
                        }
                    }

                    GroupBox {
                        title: "Spin Box"
                        width: parent.width
                        Row { spacing: 16
                            SpinBox { value: 5; from: 0; to: 100 }
                            SpinBox { value: 0; from: -50; to: 50; editable: true }
                            SpinBox { value: 10; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Dial"
                        width: parent.width
                        Row { spacing: 30
                            Column { spacing: 4
                                Dial { id: dial1; value: 0.5; from: 0; to: 1; stepSize: 0.1; width: 100; height: 100 }
                                Label { text: "value: " + dial1.value.toFixed(1); width: 100; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: "#666" }
                            }
                            Column { spacing: 4
                                Dial { id: dial2; value: 0.75; from: 0; to: 1; width: 100; height: 100 }
                                Label { text: "value: " + dial2.value.toFixed(1); width: 100; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: "#666" }
                            }
                            Column { spacing: 4
                                Dial { id: dial3; value: 0.25; from: 0; to: 1; width: 100; height: 100; enabled: false }
                                Label { text: "Disabled"; width: 100; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: "#666" }
                            }
                        }
                    }

                    Item { height: 16 }
                }
            }

            // ========== PAGE 2: SELECTION ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: selCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: selCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Selection Controls"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Checkboxes, radio buttons, combo boxes, and delegates." }

                    GroupBox {
                        title: "Check Box"
                        width: parent.width
                        Column { spacing: 6
                            CheckBox { text: "Option A"; checked: true }
                            CheckBox { text: "Option B" }
                            CheckBox { text: "Option C"; tristate: true; checkState: Qt.PartiallyChecked }
                            CheckBox { text: "Disabled"; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Radio Button"
                        width: parent.width
                        ButtonGroup { id: radioGrp }
                        Column { spacing: 6
                            RadioButton { text: "Small"; checked: true; ButtonGroup.group: radioGrp }
                            RadioButton { text: "Medium"; ButtonGroup.group: radioGrp }
                            RadioButton { text: "Large"; ButtonGroup.group: radioGrp }
                            RadioButton { text: "Disabled"; enabled: false; ButtonGroup.group: radioGrp }
                        }
                    }

                    GroupBox {
                        title: "Combo Box"
                        width: parent.width
                        Column { spacing: 8
                            ComboBox { model: ["Apple", "Banana", "Cherry", "Durian"] }
                            ComboBox { model: ["Red", "Green", "Blue"]; enabled: false }
                            ComboBox { model: ["First", "Second", "Third"]; editable: true }
                        }
                    }

                    GroupBox {
                        title: "Item Delegate"
                        width: parent.width
                        Column { spacing: 2
                            ItemDelegate { text: "Click me"; width: 300 }
                            ItemDelegate { text: "Or me"; width: 300; highlighted: true }
                            ItemDelegate { text: "Or this one"; width: 300 }
                        }
                    }

                    GroupBox {
                        title: "Check Delegate"
                        width: parent.width
                        Column { spacing: 2
                            CheckDelegate { text: "Show notifications"; checked: true; width: 300 }
                            CheckDelegate { text: "Auto-save"; checked: true; width: 300 }
                            CheckDelegate { text: "Dark mode"; width: 300 }
                            CheckDelegate { text: "Beta features"; width: 300 }
                        }
                    }

                    GroupBox {
                        title: "Radio Delegate"
                        width: parent.width
                        ButtonGroup { id: radioDelGrp }
                        Column { spacing: 2
                            RadioDelegate { text: "Low priority"; ButtonGroup.group: radioDelGrp; checked: true; width: 300 }
                            RadioDelegate { text: "Medium priority"; ButtonGroup.group: radioDelGrp; width: 300 }
                            RadioDelegate { text: "High priority"; ButtonGroup.group: radioDelGrp; width: 300 }
                        }
                    }

                    Item { height: 16 }
                }
            }

            // ========== PAGE 3: PROGRESS ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: progCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: progCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Progress & Feedback"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Progress indicators, busy spinners, and page indicators." }

                    GroupBox {
                        title: "Progress Bar"
                        width: parent.width
                        Column { spacing: 10
                            ProgressBar { value: 0.3; width: 350 }
                            ProgressBar { value: 0.7; width: 350 }
                            ProgressBar { value: -1; width: 350 }
                            ProgressBar { value: 1.0; width: 350 }
                            ProgressBar { value: 0.5; width: 350; enabled: false }
                        }
                    }

                    GroupBox {
                        title: "Busy Indicator"
                        width: parent.width
                        Row { spacing: 24
                            Column { spacing: 4; width: 64
                                BusyIndicator { running: true; width: 40; height: 40 }
                                Label { text: "Running"; font.pixelSize: 11; color: "#666"; width: 64; horizontalAlignment: Text.AlignHCenter }
                            }
                            Column { spacing: 4; width: 64
                                BusyIndicator { running: false; width: 40; height: 40 }
                                Label { text: "Stopped"; font.pixelSize: 11; color: "#666"; width: 64; horizontalAlignment: Text.AlignHCenter }
                            }
                            Column { spacing: 4; width: 64
                                BusyIndicator { running: true; width: 64; height: 64 }
                                Label { text: "Large"; font.pixelSize: 11; color: "#666"; width: 64; horizontalAlignment: Text.AlignHCenter }
                            }
                        }
                    }

                    GroupBox {
                        title: "Page Indicator"
                        width: parent.width
                        Column { spacing: 16
                            PageIndicator { count: 5; currentIndex: 0 }
                            PageIndicator { count: 5; currentIndex: 2 }
                            PageIndicator { count: 10; currentIndex: 7 }
                        }
                    }

                    GroupBox {
                        title: "Tool Tip (hover over buttons)"
                        width: parent.width
                        Row { spacing: 16
                            Button {
                                text: "Hover me"
                                ToolTip.text: "I am a tooltip!"
                                ToolTip.visible: hovered
                                ToolTip.delay: 500
                            }
                            Button {
                                text: "Another tip"
                                ToolTip.text: "A longer tooltip with more info"
                                ToolTip.visible: hovered
                            }
                        }
                    }

                    Item { height: 16 }
                }
            }

            // ========== PAGE 4: CONTAINERS ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: contCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: contCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Containers & Layout"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Frames, panes, scroll views, split views, popups, and dialogs." }

                    GroupBox {
                        title: "Frame"
                        width: parent.width
                        Frame {
                            width: parent.width
                            height: 50
                            Label { text: "Content inside a Frame"; width: parent.width; height: parent.height; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                        }
                    }

                    GroupBox {
                        title: "Pane"
                        width: parent.width
                        Pane {
                            width: parent.width
                            implicitHeight: 60
                            Column { width: parent.width
                                Label { text: "A Pane container with content" }
                                Label { text: "Has background, padding, and border radius"; color: "#666666" }
                            }
                        }
                    }

                    GroupBox {
                        title: "Scroll View"
                        width: parent.width
                        ListView {
                            width: parent.width
                            height: 100
                            clip: true
                            model: 20
                            delegate: Label { text: "Scrollable item #" + (index + 1); padding: 4 }
                        }
                    }

                    GroupBox {
                        title: "Split View"
                        width: parent.width
                        SplitView {
                            width: parent.width
                            height: 120
                            Pane {
                                SplitView.minimumWidth: 80
                                SplitView.preferredWidth: 150
                                implicitHeight: 120
                                Label { text: "Left\nPanel"; width: parent.width; height: parent.height; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            }
                            Pane {
                                SplitView.minimumWidth: 80
                                SplitView.fillWidth: true
                                implicitHeight: 120
                                Label { text: "Right Panel (drag divider)"; width: parent.width; height: parent.height; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                            }
                        }
                    }

                    GroupBox {
                        title: "Popup"
                        width: parent.width
                        Column { spacing: 8
                            Button { text: "Open Popup"; onClicked: demoPopup.open() }
                        }
                    }

                    GroupBox {
                        title: "Dialog"
                        width: parent.width
                        Column { spacing: 8
                            Button { text: "Open Dialog"; onClicked: demoDialog.open() }
                        }
                    }

                    GroupBox {
                        title: "Drawer"
                        width: parent.width
                        Row { spacing: 8
                            Button { text: "Edge"; onClicked: edgeDrawer.open() }
                            Button { text: "Bottom"; onClicked: bottomDrawer.open() }
                            Button { text: "Modal"; onClicked: modalDrawer.open() }
                        }
                    }

                    Item { height: 16 }
                }

                Drawer {
                    id: edgeDrawer
                    width: 250; height: parent.height; edge: Qt.LeftEdge
                    Column { padding: 16; spacing: 8
                        Label { text: "Navigation Menu"; font.bold: true; font.pixelSize: 18 }
                        MenuSeparator { width: 220 }
                        ItemDelegate { text: "Home"; width: 220 }
                        ItemDelegate { text: "Documents"; width: 220 }
                        ItemDelegate { text: "Settings"; width: 220 }
                        ItemDelegate { text: "About"; width: 220 }
                    }
                }
                Drawer {
                    id: bottomDrawer
                    width: parent.width; height: 180; edge: Qt.BottomEdge
                    Column { padding: 16; spacing: 8
                        Label { text: "Bottom Drawer"; font.bold: true }
                        Label { text: "Slides up from the bottom" }
                    }
                }
                Drawer {
                    id: modalDrawer
                    width: 280; height: parent.height; edge: Qt.RightEdge; modal: true; dim: true
                    Column { padding: 16; spacing: 12
                        Label { text: "Modal Drawer"; font.bold: true; font.pixelSize: 18 }
                        MenuSeparator { width: 240 }
                        Label { text: "Dims background and blocks interaction."; wrapMode: Text.Wrap; width: 240 }
                        Button { text: "Close"; onClicked: modalDrawer.close() }
                    }
                }

                Popup {
                    id: demoPopup
                    parent: Overlay.overlay
                    anchors.centerIn: parent
                    width: 260; height: 140
                    modal: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                    Column { padding: 16; spacing: 12
                        Label { text: "This is a Popup"; font.bold: true; font.pixelSize: 16 }
                        Label { text: "With Fluent background and border radius."; wrapMode: Text.Wrap; width: 220 }
                        Button { text: "Close"; onClicked: demoPopup.close() }
                    }
                }
                Dialog {
                    id: demoDialog
                    title: "Fluent Dialog"
                    modal: true
                    anchors.centerIn: parent
                    standardButtons: Dialog.Ok | Dialog.Cancel
                    Label { text: "This is a modal dialog.\nClick OK or Cancel."; wrapMode: Text.Wrap; width: 300 }
                }
            }

            // ========== PAGE 5: NAVIGATION ==========
            SplitView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Pane {
                    SplitView.minimumWidth: 140
                    SplitView.preferredWidth: 180
                    implicitHeight: 400
                    Column { width: parent.width; spacing: 4; padding: 8
                        Label { text: "Pages"; font.bold: true; font.pixelSize: 16; bottomPadding: 8 }
                        MenuSeparator { width: parent.width - 16 }
                        Repeater {
                            model: ["Home", "Profile", "Settings", "Help"]
                            Button {
                                required property string modelData
                                required property int index
                                text: modelData
                                flat: true
                                width: parent.width - 16
                                onClicked: pageStack.push(navPageComp, { pageName: modelData })
                            }
                        }
                    }
                }
                StackView {
                    id: pageStack
                    SplitView.fillWidth: true
                    initialItem: navPageComp
                }
            }
            Component {
                id: navPageComp
                Pane {
                    property string pageName: "Home"
                    Column { padding: 24; spacing: 12
                        Label { text: pageName; font.pixelSize: 28; font.bold: true }
                        Label { text: "This is the " + pageName + " page."; color: "#666666"; wrapMode: Text.Wrap; width: 300 }
                        Row { spacing: 8
                            Button { text: "Go to Settings"; onClicked: pageStack.push(navPageComp, { pageName: "Settings" }) }
                            Button { text: "Go Back"; visible: pageStack.depth > 1; onClicked: pageStack.pop() }
                        }
                    }
                }
            }

            // ========== PAGE 6: PICKERS ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: pickCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: pickCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Pickers"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Calendar, tumbler wheel picker, and swipe view." }

                    GroupBox {
                        title: "Calendar"
                        width: parent.width
                        Column { spacing: 8
                            Label { text: "Calendar is a singleton type in PySide6 6.10+ and cannot be instantiated directly in QML." }
                            Label { text: "The FluentWinUI3 Calendar.qml skin is installed and applies automatically in standalone apps."; color: "#666666"; wrapMode: Text.Wrap; width: 400 }
                        }
                    }

                    GroupBox {
                        title: "Tumbler (Wheel Picker)"
                        width: parent.width
                        Column { spacing: 12
                            Label { text: "Time Picker:"; font.pixelSize: 14; font.bold: true }
                            Row { spacing: 6
                                Tumbler { model: ["AM", "PM"]; width: 80 }
                                Tumbler { model: ["1","2","3","4","5","6","7","8","9","10","11","12"]; width: 80 }
                                Tumbler { model: ["00","05","10","15","20","25","30","35","40","45","50","55"]; width: 80; wrap: true }
                            }
                        }
                    }

                    GroupBox {
                        title: "Swipe View"
                        width: parent.width
                        Column { spacing: 12
                            SwipeView {
                                id: swipeView
                                width: parent.width - 32
                                height: 140
                                Repeater { model: 5
                                    Item {
                                        width: swipeView.width
                                        height: swipeView.height
                                        Rectangle {
                                            width: parent.width; height: parent.height
                                            color: index % 2 === 0 ? "#e8f0fe" : "#f0e8fe"
                                            radius: 8
                                            Label { text: "Page " + (index + 1); font.pixelSize: 24; font.bold: true; width: parent.width; height: parent.height; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                                        }
                                    }
                                }
                            }
                            PageIndicator { count: 5; currentIndex: swipeView.currentIndex }
                        }
                    }

                    Item { height: 16 }
                }
            }

            // ========== PAGE 7: MENUS ==========
            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                contentWidth: width
                contentHeight: menuCol.implicitHeight + 32
                clip: true
                ScrollBar.vertical: ScrollBar {}

                Column {
                    id: menuCol
                    width: parent.width - 32
                    x: 16
                    spacing: 16

                    Label { text: "Menus & Data"; font.pixelSize: 24; font.bold: true }
                    Label { text: "Menu bars, context menus, and tree views." }

                    GroupBox {
                        title: "Menu Bar"
                        width: parent.width
                        MenuBar {
                            Menu { title: "File"
                                MenuItem { text: "New" }
                                MenuItem { text: "Open" }
                                MenuSeparator {}
                                MenuItem { text: "Save" }
                                MenuItem { text: "Exit" }
                            }
                            Menu { title: "Edit"
                                MenuItem { text: "Undo" }
                                MenuItem { text: "Cut" }
                                MenuItem { text: "Copy" }
                                MenuItem { text: "Paste" }
                            }
                            Menu { title: "View"
                                Menu { title: "Theme"
                                    MenuItem { text: "Light" }
                                    MenuItem { text: "Dark" }
                                }
                            }
                            Menu { title: "Help"
                                MenuItem { text: "About" }
                            }
                        }
                    }

                    GroupBox {
                        title: "Context Menu (right-click below)"
                        width: parent.width
                        Pane {
                            width: parent.width
                            implicitHeight: 60
                            Label { text: "Right-click me!"; width: parent.width; height: parent.height; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter; font.pixelSize: 16 }
                            MouseArea {
                                width: parent.width; height: parent.height
                                acceptedButtons: Qt.RightButton
                                onClicked: ctxMenu.popup()
                            }
                            Menu {
                                id: ctxMenu
                                MenuItem { text: "Option 1" }
                                MenuItem { text: "Option 2" }
                                MenuSeparator {}
                                Menu { title: "Submenu"
                                    MenuItem { text: "Sub A" }
                                    MenuItem { text: "Sub B" }
                                }
                            }
                        }
                    }

                    GroupBox {
                        title: "Tree View"
                        width: parent.width
                        ListView {
                            id: treeList
                            width: parent.width
                            height: 220
                            clip: true
                            model: ListModel { id: treeMdl }
                            delegate: Row {
                                required property int index
                                required property string name
                                required property string icon
                                required property int depth
                                required property bool hasChildren
                                required property bool expanded

                                leftPadding: 8 + depth * 20
                                width: treeList.width
                                height: 28

                                Text {
                                    text: hasChildren ? (expanded ? "\u25BC" : "\u25B6") : "  "
                                    width: 14; font.pixelSize: 9
                                }
                                Text { text: icon + " " + name; font.pixelSize: 13 }

                                Rectangle { width: parent.width; height: parent.height; visible: treeMouse.containsMouse; color: "#0a000000" }
                                MouseArea {
                                    id: treeMouse
                                    width: parent.width; height: parent.height
                                    hoverEnabled: true
                                    onClicked: {
                                        if (!hasChildren) return
                                        if (expanded) {
                                            var rc = 0
                                            for (var i = index + 1; i < treeMdl.count; i++) {
                                                if (treeMdl.get(i).depth > depth) rc++
                                                else break
                                            }
                                            treeMdl.remove(index + 1, rc)
                                            treeMdl.setProperty(index, "expanded", false)
                                        } else {
                                            var data = JSON.parse(treeMdl.get(index).childData)
                                            for (var j = data.length - 1; j >= 0; j--) {
                                                treeMdl.insert(index + 1, {
                                                    name: data[j].name, icon: data[j].icon,
                                                    depth: depth + 1, expanded: false,
                                                    hasChildren: data[j].children.length > 0,
                                                    childData: JSON.stringify(data[j].children)
                                                })
                                            }
                                            treeMdl.setProperty(index, "expanded", true)
                                        }
                                    }
                                }
                            }
                            property var treeData: [
                                { name: "Project Files", icon: "\uD83D\uDCC1", children: [
                                    { name: "src", icon: "\uD83D\uDCC1", children: [
                                        { name: "main.py", icon: "\uD83D\uDC0D", children: [] },
                                        { name: "app.qml", icon: "\uD83D\uDCC4", children: [] }
                                    ]},
                                    { name: "README.md", icon: "\uD83D\uDCDD", children: [] }
                                ]},
                                { name: "Dependencies", icon: "\uD83D\uDCE6", children: [
                                    { name: "PySide6", icon: "\uD83D\uDC0D", children: [] },
                                    { name: "fluentpyside", icon: "\u2728", children: [] }
                                ]}
                            ]
                            Component.onCompleted: {
                                for (var i = 0; i < treeData.length; i++) {
                                    treeMdl.append({
                                        name: treeData[i].name, icon: treeData[i].icon,
                                        depth: 0, expanded: false,
                                        hasChildren: treeData[i].children.length > 0,
                                        childData: JSON.stringify(treeData[i].children)
                                    })
                                }
                            }
                        }
                    }

                    Item { height: 16 }
                }
            }
        }
    }
}
