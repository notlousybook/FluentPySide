import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.FluentWinUI3
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 1000
    height: 750
    title: qsTr("FluentWinUI3 — Complete Gallery")

    // ========================================
    // TOP-LEVEL TAB NAVIGATION
    // ========================================
    TabBar {
        id: tabBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        TabButton { text: "Buttons" }
        TabButton { text: "Input" }
        TabButton { text: "Selection" }
        TabButton { text: "Progress" }
        TabButton { text: "Containers" }
        TabButton { text: "Navigation" }
        TabButton { text: "Pickers" }
        TabButton { text: "Menus & Tooltips" }
    }

    StackLayout {
        anchors.top: tabBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: tabBar.currentIndex

        // ============================================================
        // PAGE 1: BUTTONS
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Buttons"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Standard buttons with Fluent styling. Supports normal, hovered, pressed, checked, disabled, and flat states." }

                // Row 1: Basic buttons
                GroupBox {
                    title: "Button Variants"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        Row {
                            spacing: 12
                            Button { text: "Normal" }
                            Button { text: "Checked"; checked: true }
                            Button { text: "Flat"; flat: true }
                            Button { text: "Disabled"; enabled: false }
                        }
                        Row {
                            spacing: 12
                            Button {
                                text: "Highlighted"; highlighted: true
                            }
                            Button {
                                text: "Flat + Checked"; flat: true; checked: true
                            }
                        }
                    }
                }

                GroupBox {
                    title: "Round Button"
                    width: parent.width - 40
                    Row {
                        spacing: 12
                        RoundButton { text: "OK" }
                        RoundButton { text: "+" }
                        RoundButton { text: "?" }
                        RoundButton { text: "X"; enabled: false }
                    }
                }

                GroupBox {
                    title: "Delay Button (hold to confirm)"
                    width: parent.width - 40
                    Row {
                        spacing: 12
                        DelayButton { text: "Hold Me"; delay: 1500 }
                        DelayButton { text: "Disabled"; enabled: false }
                    }
                }

                GroupBox {
                    title: "Tool Buttons"
                    width: parent.width - 40
                    Row {
                        spacing: 12
                        ToolButton { text: "Open" }
                        ToolButton { text: "Save" }
                        ToolButton { text: "Cut" }
                        ToolButton { text: "Copy"; enabled: false }
                    }
                }

                GroupBox {
                    title: "Tool Separator"
                    width: parent.width - 40
                    Row {
                        spacing: 12
                        ToolButton { text: "A" }
                        ToolSeparator {}
                        ToolButton { text: "B" }
                        ToolSeparator { orientation: Qt.Vertical; height: 30 }
                        ToolButton { text: "C" }
                    }
                }

                GroupBox {
                    title: "Switch & Switch Delegate"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        Row {
                            spacing: 24
                            Switch { text: "Wi-Fi" }
                            Switch { text: "Bluetooth"; checked: true }
                            Switch { text: "Disabled"; enabled: false }
                        }
                        Repeater {
                            model: ["Airplane Mode", "Hotspot", "VPN"]
                            SwitchDelegate { text: modelData; checked: index === 1 }
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 2: INPUT
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Input Controls"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Text entry controls, sliders, spin boxes, and text areas with full Fluent theming." }

                GroupBox {
                    title: "Text Field"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        TextField { placeholderText: "Standard text field" }
                        TextField { placeholderText: "Disabled"; enabled: false }
                        Row {
                            spacing: 12
                            TextField { placeholderText: "Username"; echoMode: TextInput.Normal }
                            TextField { placeholderText: "Password"; echoMode: TextInput.Password }
                        }
                    }
                }

                GroupBox {
                    title: "Text Area"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        TextArea {
                            placeholderText: "Multi-line text input area\nSupports word wrap"
                            width: 400
                            wrapMode: TextArea.Wrap
                        }
                        TextArea {
                            text: "Read-only text area"
                            width: 400
                            readOnly: true
                        }
                    }
                }

                GroupBox {
                    title: "Search Field"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        SearchField { }
                        SearchField { enabled: false }
                    }
                }

                GroupBox {
                    title: "Slider"
                    width: parent.width - 40
                    Column {
                        spacing: 12
                        Slider { from: 0; to: 100; value: 30; width: 400 }
                        Slider { from: 0; to: 100; value: 70; width: 400; enabled: false }
                        Slider { from: 0; to: 1; value: 0.5; stepSize: 0.1; width: 400 }
                    }
                }

                GroupBox {
                    title: "Range Slider"
                    width: parent.width - 40
                    Column {
                        spacing: 12
                        RangeSlider {
                            first.value: 0.25
                            second.value: 0.75
                            width: 400
                        }
                    }
                }

                GroupBox {
                    title: "Spin Box"
                    width: parent.width - 40
                    Row {
                        spacing: 24
                        SpinBox { value: 5; from: 0; to: 100 }
                        SpinBox { value: 0; from: -50; to: 50; editable: true }
                        SpinBox { value: 10; enabled: false }
                    }
                }

                GroupBox {
                    title: "Dial"
                    width: parent.width - 40
                    Row {
                        spacing: 40
                        Dial {
                            value: 0.5
                            from: 0; to: 1
                            width: 120; height: 120
                        }
                        Dial {
                            value: 0.25
                            from: 0; to: 1
                            width: 120; height: 120
                            enabled: false
                        }
                        Dial {
                            value: 0.75
                            from: 0; to: 1
                            stepSize: 0.1
                            width: 120; height: 120
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 3: SELECTION
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Selection Controls"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Checkboxes, radio buttons, combo boxes, and delegates for user selection." }

                GroupBox {
                    title: "Check Box"
                    width: parent.width - 40
                    Column {
                        spacing: 8
                        CheckBox { text: "Option A"; checked: true }
                        CheckBox { text: "Option B" }
                        CheckBox { text: "Option C"; tristate: true; checkState: Qt.PartiallyChecked }
                        CheckBox { text: "Disabled"; enabled: false }
                    }
                }

                GroupBox {
                    title: "Check Delegate"
                    width: parent.width - 40
                    Column {
                        spacing: 4
                        Repeater {
                            model: ["Show notifications", "Auto-save", "Dark mode", "Beta features"]
                            CheckDelegate { text: modelData; checked: index < 2 }
                        }
                    }
                }

                GroupBox {
                    title: "Radio Button"
                    width: parent.width - 40
                    Column {
                        spacing: 8
                        RadioButton { text: "Small"; checked: true }
                        RadioButton { text: "Medium" }
                        RadioButton { text: "Large" }
                        RadioButton { text: "Disabled"; enabled: false }
                    }
                }

                GroupBox {
                    title: "Radio Delegate"
                    width: parent.width - 40
                    ButtonGroup { id: radioGroup }
                    Column {
                        spacing: 4
                        Repeater {
                            model: ["Low priority", "Medium priority", "High priority"]
                            RadioDelegate { text: modelData; ButtonGroup.group: radioGroup; checked: index === 1 }
                        }
                    }
                }

                GroupBox {
                    title: "Combo Box"
                    width: parent.width - 40
                    Column {
                        spacing: 12
                        ComboBox { model: ["Apple", "Banana", "Cherry", "Durian"] }
                        ComboBox {
                            model: ["Red", "Green", "Blue"]
                            enabled: false
                        }
                        ComboBox {
                            model: ["First", "Second", "Third"]
                            editable: true
                        }
                    }
                }

                GroupBox {
                    title: "Item Delegate"
                    width: parent.width - 40
                    Column {
                        spacing: 2
                        Repeater {
                            model: ["Click me", "Or me", "Or this one"]
                            ItemDelegate {
                                text: modelData
                                width: 300
                                highlighted: index === 1
                            }
                        }
                    }
                }

                GroupBox {
                    title: "Swipe Delegate"
                    width: parent.width - 40
                    Column {
                        spacing: 2
                        Repeater {
                            model: ["Swipe left to reveal actions", "Another swipeable item"]
                            SwipeDelegate {
                                text: modelData
                                width: 400
                                swipe.left: Label {
                                    text: "Delete"
                                    color: "red"
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 4: PROGRESS & FEEDBACK
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Progress & Feedback"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Progress indicators, busy spinners, and page indicators." }

                GroupBox {
                    title: "Progress Bar"
                    width: parent.width - 40
                    Column {
                        spacing: 12
                        ProgressBar { value: 0.3; width: 400 }
                        ProgressBar { value: 0.7; width: 400 }
                        ProgressBar { value: -1; width: 400 } // Indeterminate
                        ProgressBar { value: 1.0; width: 400 }
                        ProgressBar { value: 0.5; width: 400; enabled: false }
                    }
                }

                GroupBox {
                    title: "Busy Indicator"
                    width: parent.width - 40
                    Row {
                        spacing: 30
                        BusyIndicator { running: true }
                        BusyIndicator { running: false }
                        BusyIndicator { running: true; width: 60; height: 60 }
                    }
                }

                GroupBox {
                    title: "Page Indicator"
                    width: parent.width - 40
                    Column {
                        spacing: 16
                        PageIndicator { count: 5; currentIndex: 0 }
                        PageIndicator { count: 5; currentIndex: 2 }
                        PageIndicator { count: 10; currentIndex: 7 }
                    }
                }

                GroupBox {
                    title: "Tool Tip (hover over buttons)"
                    width: parent.width - 40
                    Row {
                        spacing: 20
                        Button {
                            text: "Hover me"
                            ToolTip.text: "I'm a tooltip!"
                            ToolTip.visible: hovered
                            ToolTip.delay: 500
                        }
                        Button {
                            text: "Another tip"
                            ToolTip.text: "A longer tooltip with more info\nSecond line of text"
                            ToolTip.visible: hovered
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 5: CONTAINERS
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Containers & Layout"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Frames, panes, group boxes, scroll views, split views, and popups." }

                GroupBox {
                    title: "Frame"
                    width: parent.width - 40
                    Frame {
                        width: parent.width
                        height: 60
                        Label { text: "Content inside a Frame"; anchors.centerIn: parent }
                    }
                }

                GroupBox {
                    title: "Pane"
                    width: parent.width - 40
                    Pane {
                        width: parent.width
                        height: 80
                        Column {
                            anchors.fill: parent
                            Label { text: "A Pane container with content" }
                            Label { text: "Has background, padding, and border radius"; color: Fluent.textSecondary }
                        }
                    }
                }

                GroupBox {
                    title: "Scroll View"
                    width: parent.width - 40
                    ScrollView {
                        width: parent.width
                        height: 120
                        contentItem: Column {
                            spacing: 8
                            Repeater {
                                model: 20
                                Label { text: "Scrollable item #" + (index + 1) }
                            }
                        }
                    }
                }

                GroupBox {
                    title: "Split View"
                    width: parent.width - 40
                    SplitView {
                        width: parent.width
                        height: 150
                        Pane {
                            SplitView.minimumWidth: 80
                            SplitView.preferredWidth: 150
                            Label { text: "Left\nPanel"; anchors.centerIn: parent }
                        }
                        Pane {
                            SplitView.minimumWidth: 80
                            SplitView.fillWidth: true
                            Label { text: "Right Panel (drag the divider!)"; anchors.centerIn: parent }
                        }
                    }
                }

                GroupBox {
                    title: "Popup & Dialog"
                    width: parent.width - 40
                    Row {
                        spacing: 16
                        Button {
                            text: "Open Popup"
                            onClicked: popup.open()
                        }
                        Popup {
                            id: popup
                            x: 100; y: 100
                            width: 250
                            height: 120
                            Column {
                                anchors.fill: parent
                                padding: 12
                                Label { text: "This is a Popup"; font.bold: true }
                                Label { text: "With Fluent background\nand border radius" }
                                Button { text: "Close"; onClicked: popup.close() }
                            }
                        }

                        Button {
                            text: "Open Dialog"
                            onClicked: dialog.open()
                        }
                        Dialog {
                            id: dialog
                            title: "Fluent Dialog"
                            modal: true
                            anchors.centerIn: parent
                            Label { text: "This is a modal dialog with Fluent styling." }
                            DialogButtonBox {
                                Button { text: "Cancel"; DialogButtonBox.role: DialogButtonBox.RejectRole }
                                Button { text: "OK"; DialogButtonBox.role: DialogButtonBox.AcceptRole }
                            }
                        }
                    }
                }

                GroupBox {
                    title: "Drawer"
                    width: parent.width - 40
                    Row {
                        spacing: 16
                        Button {
                            text: "Open Drawer (Edge)"
                            onClicked: edgeDrawer.open()
                        }
                        Button {
                            text: "Open Drawer (Bottom)"
                            onClicked: bottomDrawer.open()
                        }
                        Button {
                            text: "Open Drawer (Modal)"
                            onClicked: modalDrawer.open()
                        }
                    }
                    Drawer {
                        id: edgeDrawer
                        width: 280
                        height: parent.height
                        edge: Qt.LeftEdge
                        Column {
                            padding: 16
                            spacing: 8
                            Label { text: "Navigation Menu"; font.bold: true; font.pixelSize: 18 }
                            MenuSeparator { width: 240 }
                            Repeater {
                                model: ["Home", "Documents", "Settings", "About"]
                                ItemDelegate { text: modelData; width: 240 }
                            }
                        }
                    }
                    Drawer {
                        id: bottomDrawer
                        width: parent.width
                        height: 200
                        edge: Qt.BottomEdge
                        Column {
                            anchors.centerIn: parent
                            spacing: 8
                            Label { text: "Bottom Drawer"; font.bold: true }
                            Label { text: "Slides up from the bottom" }
                        }
                    }
                    Drawer {
                        id: modalDrawer
                        width: 300
                        height: parent.height
                        edge: Qt.RightEdge
                        modal: true
                        dim: true
                        Column {
                            padding: 16
                            spacing: 12
                            Label { text: "Modal Drawer"; font.bold: true; font.pixelSize: 18 }
                            MenuSeparator { width: 260 }
                            Label { text: "This drawer dims the background\nand blocks interaction with it." }
                            Button { text: "Close"; onClicked: modalDrawer.close() }
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 6: NAVIGATION
        // ============================================================
        Item {
            SplitView {
                anchors.fill: parent
                Pane {
                    SplitView.minimumWidth: 160
                    SplitView.preferredWidth: 200
                    Column {
                        anchors.fill: parent
                        padding: 8
                        spacing: 4
                        Label { text: "Pages"; font.bold: true; font.pixelSize: 16 }
                        MenuSeparator { width: parent.width - 16 }
                        Repeater {
                            model: ["Home", "Profile", "Settings", "Help"]
                            Button {
                                text: modelData
                                flat: true
                                width: parent.width - 16
                                onClicked: pageStack.push(pageComponent, { pageName: modelData })
                            }
                        }
                    }
                }

                StackView {
                    id: pageStack
                    SplitView.fillWidth: true
                    initialItem: pageComponent

                    property Component pageComponent: Component {
                        Pane {
                            property string pageName: "Home"
                            Column {
                                anchors.fill: parent
                                padding: 24
                                Label {
                                    text: pageName
                                    font.pixelSize: 32
                                    font.bold: true
                                }
                                Label {
                                    text: "This is the " + pageName + " page.\nNavigate using the sidebar or the button below."
                                    color: Fluent.textSecondary
                                }
                                Button {
                                    text: "Go to Settings"
                                    onClicked: pageStack.push(pageComponent, { pageName: "Settings" })
                                }
                                Button {
                                    text: "Go Back"
                                    visible: pageStack.depth > 1
                                    onClicked: pageStack.pop()
                                }
                            }
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 7: PICKERS (Calendar, Tumbler)
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Pickers"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Calendar date picker and Tumbler wheel picker." }

                GroupBox {
                    title: "Calendar"
                    width: parent.width - 40
                    Column {
                        spacing: 10
                        Label { text: "Calendar (FluentWinUI3 Calendar.qml skin is installed and active)"; font.pixelSize: 14; font.bold: true }
                        Label { text: "Note: In PySide6 6.10+, Calendar is a composite singleton type\nand cannot be instantiated directly in QML. The FluentWinUI3 Calendar\nskin will be applied automatically when Calendar is used in a real app."; color: "#888"; wrapMode: Text.Wrap; width: 400 }
                        Rectangle {
                            width: 300; height: 180
                            color: Fluent.cardBackground
                            radius: 8
                            border.color: Fluent.border
                            border.width: 1
                            Label { anchors.centerIn: parent; text: "Calendar Preview\n(see above)"; color: Fluent.textSecondary; horizontalAlignment: Text.AlignHCenter }
                        }
                    }
                }

                GroupBox {
                    title: "Tumbler (Wheel Picker)"
                    width: parent.width - 40
                    Row {
                        spacing: 20
                        Tumbler {
                            model: ["AM", "PM"]
                            width: 100
                        }
                        Tumbler {
                            model: ListModel {
                                ListElement { txt: "1" }
                                ListElement { txt: "2" }
                                ListElement { txt: "3" }
                                ListElement { txt: "4" }
                                ListElement { txt: "5" }
                                ListElement { txt: "6" }
                                ListElement { txt: "7" }
                                ListElement { txt: "8" }
                                ListElement { txt: "9" }
                                ListElement { txt: "10" }
                                ListElement { txt: "11" }
                                ListElement { txt: "12" }
                            }
                            delegate: Label {
                                text: txt
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                            }
                            width: 100
                        }
                        Tumbler {
                            model: ListModel {
                                ListElement { txt: "00" }
                                ListElement { txt: "05" }
                                ListElement { txt: "10" }
                                ListElement { txt: "15" }
                                ListElement { txt: "20" }
                                ListElement { txt: "25" }
                                ListElement { txt: "30" }
                                ListElement { txt: "35" }
                                ListElement { txt: "40" }
                                ListElement { txt: "45" }
                                ListElement { txt: "50" }
                                ListElement { txt: "55" }
                            }
                            delegate: Label {
                                text: txt
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 18
                            }
                            wrap: true
                            width: 100
                        }
                        Label {
                            text: "← Time picker example"
                            anchors.verticalCenter: parent.verticalCenter
                            color: Fluent.textSecondary
                        }
                    }
                }

                GroupBox {
                    title: "Swipe View with Page Indicator"
                    width: parent.width - 40
                    Column {
                        spacing: 12
                        SwipeView {
                            id: swipeView
                            width: parent.width - 40
                            height: 150
                            currentIndex: pageInd.currentIndex
                            Repeater {
                                model: 5
                                Pane {
                                    width: swipeView.width
                                    height: swipeView.height
                                    Label {
                                        anchors.centerIn: parent
                                        text: "Page " + (index + 1)
                                        font.pixelSize: 28
                                        font.bold: true
                                    }
                                }
                            }
                        }
                        PageIndicator {
                            id: pageInd
                            count: 5
                            currentIndex: swipeView.currentIndex
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }
        }

        // ============================================================
        // PAGE 8: MENUS, TREE VIEW
        // ============================================================
        ScrollView {
            contentItem: Column {
                width: parent ? parent.width : 1000
                spacing: 20
                padding: 20

                Label {
                    text: "Menus & Data Views"
                    font.pixelSize: 24
                    font.bold: true
                }
                Label { text: "Menu bars, context menus, and tree views." }

                GroupBox {
                    title: "Menu Bar"
                    width: parent.width - 40
                    MenuBar {
                        MenuBarItem { text: "File"; menu: fileMenu }
                        MenuBarItem { text: "Edit"; menu: editMenu }
                        MenuBarItem { text: "View"; menu: viewMenu }
                        MenuBarItem { text: "Help"; menu: helpMenu }
                    }

                    Menu {
                        id: fileMenu
                        title: "File"
                        MenuItem { text: "New" }
                        MenuItem { text: "Open" }
                        MenuSeparator {}
                        MenuItem { text: "Save" }
                        MenuItem { text: "Save As..." }
                        MenuSeparator {}
                        MenuItem { text: "Exit" }
                    }
                    Menu {
                        id: editMenu
                        title: "Edit"
                        MenuItem { text: "Undo" }
                        MenuItem { text: "Redo" }
                        MenuSeparator {}
                        MenuItem { text: "Cut" }
                        MenuItem { text: "Copy" }
                        MenuItem { text: "Paste" }
                    }
                    Menu {
                        id: viewMenu
                        title: "View"
                        MenuItem { text: "Zoom In" }
                        MenuItem { text: "Zoom Out" }
                        MenuSeparator {}
                        Menu {
                            title: "Theme"
                            MenuItem { text: "Light" }
                            MenuItem { text: "Dark" }
                            MenuItem { text: "System" }
                        }
                    }
                    Menu {
                        id: helpMenu
                        title: "Help"
                        MenuItem { text: "Documentation" }
                        MenuItem { text: "About" }
                    }
                }

                GroupBox {
                    title: "Context Menu (right-click below)"
                    width: parent.width - 40
                    Pane {
                        width: parent.width
                        height: 80
                        Label { text: "Right-click me!"; anchors.centerIn: parent; font.pixelSize: 16 }

                        Menu {
                            id: contextMenu
                            MenuItem { text: "Option 1" }
                            MenuItem { text: "Option 2" }
                            MenuSeparator {}
                            Menu {
                                title: "Submenu"
                                MenuItem { text: "Sub A" }
                                MenuItem { text: "Sub B" }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            onClicked: contextMenu.popup()
                        }
                    }
                }

                GroupBox {
                    title: "Tree View"
                    width: parent.width - 40
                    // Custom tree using ExpandableRepeater (pure QML, no model needed)
                    ListView {
                        id: treeListView
                        width: parent.width
                        height: 250
                        clip: true
                        model: treeModel
                        delegate: treeDelegateComp
                        property var treeData: [
                            { name: "Project Files", icon: "📁", children: [
                                { name: "src", icon: "📁", children: [
                                    { name: "main.py", icon: "🐍", children: [] },
                                    { name: "app.qml", icon: "📄", children: [] },
                                    { name: "utils", icon: "📁", children: [
                                        { name: "helpers.py", icon: "🐍", children: [] }
                                    ]}
                                ]},
                                { name: "assets", icon: "📁", children: [
                                    { name: "logo.png", icon: "🖼️", children: [] },
                                    { name: "icon.ico", icon: "🖼️", children: [] }
                                ]},
                                { name: "README.md", icon: "📝", children: [] }
                            ]},
                            { name: "Dependencies", icon: "📦", children: [
                                { name: "PySide6", icon: "🐍", children: [] },
                                { name: "fluentpyside", icon: "✨", children: [] }
                            ]}
                        ]
                        ListModel {
                            id: treeModel
                        }
                        Component.onCompleted: {
                            treeModel.clear()
                            for (var i = 0; i < treeListView.treeData.length; i++) {
                                treeModel.append({
                                    name: treeListView.treeData[i].name,
                                    icon: treeListView.treeData[i].icon,
                                    depth: 0,
                                    expanded: false,
                                    hasChildren: treeListView.treeData[i].children.length > 0,
                                    childData: JSON.stringify(treeListView.treeData[i].children)
                                })
                            }
                        }
                        function toggleExpand(index) {
                            var item = treeModel.get(index)
                            if (!item.hasChildren) return
                            if (item.expanded) {
                                var removeCount = 0
                                for (var i = index + 1; i < treeModel.count; i++) {
                                    if (treeModel.get(i).depth > item.depth)
                                        removeCount++
                                    else
                                        break
                                }
                                treeModel.remove(index + 1, removeCount)
                                treeModel.setProperty(index, "expanded", false)
                            } else {
                                treeModel.setProperty(index, "expanded", true)
                                var children = JSON.parse(item.childData)
                                insertChildren(children, index + 1, item.depth + 1)
                            }
                        }
                        function insertChildren(children, insertAt, depth) {
                            for (var i = 0; i < children.length; i++) {
                                var child = children[i]
                                var childStr = (child.children && child.children.length > 0)
                                    ? JSON.stringify(child.children) : "[]"
                                treeModel.insert(insertAt + i, {
                                    name: child.name,
                                    icon: child.icon,
                                    depth: depth,
                                    expanded: false,
                                    hasChildren: child.children && child.children.length > 0,
                                    childData: childStr
                                })
                            }
                        }
                    }
                    Component {
                        id: treeDelegateComp
                        ItemDelegate {
                            id: treeRow
                            width: ListView.view.width
                            height: 32
                            leftPadding: 8 + depth * 24
                            contentItem: Row {
                                spacing: 6
                                Text {
                                    text: hasChildren ? (expanded ? "▼" : "▶") : "  "
                                    width: 14
                                    font.pixelSize: 9
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Fluent.textSecondary
                                }
                                Text {
                                    text: icon + " " + name
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 13
                                    color: hovered ? Fluent.textPrimary : Fluent.textPrimary
                                }
                            }
                            background: Rectangle {
                                color: treeRow.hovered ? Fluent.controlAltBackgroundTransparentHover : "transparent"
                                Rectangle {
                                    visible: treeRow.hovered
                                    anchors.left: parent.left
                                    anchors.top: parent.top
                                    anchors.bottom: parent.bottom
                                    width: 3
                                    color: Fluent.accent
                                }
                            }
                            onClicked: treeListView.toggleExpand(index)
                        }
                    }
                }

                GroupBox {
                    title: "Fluent Design Tokens"
                    width: parent.width - 40
                    Label { text: "The Fluent singleton provides all WinUI 3 design tokens:"; font.bold: true }
                    Grid {
                        columns: 4
                        columnSpacing: 12
                        rowSpacing: 8
                        anchors.topMargin: 12

                        // Color swatches
                        Repeater {
                            model: ListModel {
                                ListElement { name: "accent"; colorProp: "accent" }
                                ListElement { name: "background"; colorProp: "background" }
                                ListElement { name: "cardBackground"; colorProp: "cardBackground" }
                                ListElement { name: "controlBackground"; colorProp: "controlBackground" }
                                ListElement { name: "textPrimary"; colorProp: "textPrimary" }
                                ListElement { name: "textSecondary"; colorProp: "textSecondary" }
                                ListElement { name: "inputBackground"; colorProp: "inputBackground" }
                                ListElement { name: "inputBorder"; colorProp: "inputBorder" }
                                ListElement { name: "success"; colorProp: "success" }
                                ListElement { name: "warning"; colorProp: "warning" }
                                ListElement { name: "critical"; colorProp: "critical" }
                                ListElement { name: "informational"; colorProp: "informational" }
                            }
                            delegate: Column {
                                spacing: 2
                                Rectangle {
                                    width: 60; height: 40
                                    radius: 4
                                    color: Fluent[colorProp]
                                    border.color: Fluent.border
                                    border.width: 1
                                }
                                Label {
                                    text: name
                                    font.pixelSize: 10
                                    color: Fluent.textSecondary
                                    horizontalAlignment: Text.AlignHCenter
                                    width: 60
                                    elide: Text.ElideRight
                                }
                            }
                        }
                    }
                    Label {
                        text: "Font: " + Fluent.fontFamily + " | Body: " + Fluent.fontBodySize + "px | Title: " + Fluent.fontTitleSize + "px"
                        color: Fluent.textSecondary
                        anchors.topMargin: 12
                    }
                    Label {
                        text: "Spacing: XS=" + Fluent.spacingXS + " S=" + Fluent.spacingS + " M=" + Fluent.spacingM + " L=" + Fluent.spacingL + " XL=" + Fluent.spacingXL
                        color: Fluent.textSecondary
                    }
                    Label {
                        text: "Radius: Small=" + Fluent.radiusSmall + " Medium=" + Fluent.radiusMedium + " Large=" + Fluent.radiusLarge
                        color: Fluent.textSecondary
                    }
                }
            }
        }
    }
}
