// gallery.qml — FluentPySide Gallery (RinUI-style)
// Complete rewrite with Home banner, top navigation, smooth transitions.
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.FluentWinUI3
import QtQuick.Layouts
import QtQuick.Effects

ApplicationWindow {
    id: root
    visible: true
    width: 1100
    height: 750
    title: qsTr("FluentPySide Gallery")
    color: Fluent.background

    // ===== THEME COLORS (referencing Fluent singleton) =====
    readonly property color accentColor: Fluent.accent
    readonly property color bgColor: Fluent.background
    readonly property color cardBg: Fluent.cardBackground
    readonly property color textPrimary: Fluent.textPrimary
    readonly property color textSecondary: Fluent.textSecondary
    readonly property color textTertiary: Fluent.textTertiary
    readonly property color dividerColor: Fluent.divider
    readonly property color hoverColor: Fluent.controlAltBackgroundTransparentHover
    readonly property color pressedColor: Fluent.controlAltBackgroundTransparentPressed

    // ===== NAVIGATION STATE =====
    property int currentPage: 0
    property string currentTitle: "Home"

    // ===== ICON FONT (official Fluent UI System Icons from Microsoft) =====
    readonly property string iconFont: "FluentSystemIcons-Regular"

    // ===== PAGE DEFINITIONS =====
    property var pages: [
        { title: "Home",        icon: "\uf10a" },
        { title: "Basic Input", icon: "\uf15c" },
        { title: "Selection",   icon: "\uf419" },
        { title: "Progress",    icon: "\uf40c" },
        { title: "Containers",  icon: "\uf8b3" },
        { title: "Pickers",     icon: "\uf3f2" },
        { title: "Menus",       icon: "\uf6ec" }
    ]

    // ================================================================
    // TOP HEADER BAR (RinUI-style top navigation)
    // ================================================================
    Rectangle {
        id: headerBar
        z: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 48
        color: Fluent.isDark ? "#2b2b2b" : "#f3f3f3"

        // Bottom border
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 1
            color: dividerColor
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            spacing: 0

            // App title / logo
            Text {
                text: "\uf77d"
                font.family: root.iconFont
                font.pixelSize: 18
                color: accentColor
                Layout.rightMargin: 8
            }

            Text {
                text: "FluentPySide"
                font.family: Fluent.fontFamily
                font.pixelSize: 14
                font.weight: Font.DemiBold
                color: textPrimary
                Layout.rightMargin: 24
            }

            // Navigation tabs
            Repeater {
                model: root.pages

                delegate: Item {
                    required property int index
                    required property string title
                    required property string icon

                    Layout.preferredWidth: navText.implicitWidth + 24
                    Layout.preferredHeight: 48

                    // Active indicator bar
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width - 8
                        height: 3
                        radius: 1.5
                        color: accentColor
                        visible: root.currentPage === index

                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    // Hover background
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        radius: 4
                        color: tabMouse.containsMouse
                               ? (root.currentPage === index ? pressedColor : hoverColor)
                               : "transparent"
                    }

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        Text {
                            text: parent.parent.icon
                            font.family: root.iconFont
                            font.pixelSize: 14
                            color: root.currentPage === index ? accentColor : textSecondary
                        }
                        Text {
                            id: navText
                            text: parent.parent.title
                            font.family: Fluent.fontFamily
                            font.pixelSize: 13
                            font.weight: root.currentPage === index ? Font.Medium : Font.Normal
                            color: root.currentPage === index ? accentColor : textPrimary
                        }
                    }

                    MouseArea {
                        id: tabMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            root.currentPage = index
                            root.currentTitle = title
                        }
                    }
                }
            }

            // Spacer
            Item { Layout.fillWidth: true }

            // Theme indicator
            Text {
                text: Fluent.isDark ? "\uf36e" : "\uf3f2"
                font.family: root.iconFont
                font.pixelSize: 16
                color: textSecondary
                ToolTip.text: Fluent.isDark ? "Dark Mode" : "Light Mode"
                ToolTip.visible: themeMouse.containsMouse
                ToolTip.delay: 500
                MouseArea {
                    id: themeMouse
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }
    }

    // ================================================================
    // MAIN CONTENT AREA
    // ================================================================
    StackLayout {
        id: pageStack
        anchors.top: headerBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        currentIndex: root.currentPage

        // ==================== PAGE 0: HOME ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: homeCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: homeCol
                width: parent.width
                spacing: 0

                // Hero banner
                Item {
                    width: parent.width
                    height: 280

                    Image {
                        id: bannerImg
                        anchors.fill: parent
                        source: Qt.resolvedUrl("banner.png")
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true

                        // Gradient overlay at bottom
                        Rectangle {
                            anchors.fill: parent
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "transparent" }
                                GradientStop { position: 0.6; color: "transparent" }
                                GradientStop { position: 1.0; color: Fluent.isDark ? "#202020" : "#f3f3f3" }
                            }
                        }
                    }

                    // Banner text overlay
                    Column {
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        anchors.leftMargin: 40
                        anchors.bottomMargin: 32
                        spacing: 8

                        Text {
                            text: "FluentPySide Gallery"
                            font.family: Fluent.fontFamily
                            font.pixelSize: 36
                            font.weight: Font.Bold
                            color: textPrimary
                            style: Text.Outline
                            styleColor: Fluent.isDark ? "#000000" : "#ffffff"
                        }
                        Text {
                            text: "A Fluent Design System showcase for PySide6"
                            font.family: Fluent.fontFamily
                            font.pixelSize: 16
                            color: textPrimary
                            opacity: 0.85
                            style: Text.Outline
                            styleColor: Fluent.isDark ? "#000000" : "#ffffff"
                        }
                        Row {
                            spacing: 12
                            topPadding: 8
                            Button {
                                text: "Get Started"
                                highlighted: true
                                onClicked: { root.currentPage = 1; root.currentTitle = "Basic Input" }
                            }
                            Button {
                                text: "View Source"
                                flat: true
                                onClicked: Qt.openUrlExternally("https://github.com/notlustybook/FluentPySide")
                            }
                        }
                    }
                }

                // Category cards grid
                Item {
                    width: parent.width
                    height: categoryGrid.implicitHeight + 48

                    Column {
                        width: parent.width
                        anchors.top: parent.top
                        anchors.topMargin: 32
                        anchors.left: parent.left
                        anchors.leftMargin: 40
                        anchors.right: parent.right
                        anchors.rightMargin: 40
                        spacing: 24

                        Text {
                            text: "Explore Controls"
                            font.family: Fluent.fontFamily
                            font.pixelSize: 20
                            font.weight: Font.SemiBold
                            color: textPrimary
                        }

                        Grid {
                            id: categoryGrid
                            columns: 3
                            columnSpacing: 16
                            rowSpacing: 16
                            width: parent.width

                            Repeater {
                                model: [
                                    { title: "Basic Input", desc: "Buttons, text fields, sliders, switches, and combo boxes.", icon: "\uf15c", page: 1 },
                                    { title: "Selection", desc: "Checkboxes, radio buttons, delegates, and toggle controls.", icon: "\uf419", page: 2 },
                                    { title: "Progress", desc: "Progress bars, busy indicators, and page indicators.", icon: "\uf40c", page: 3 },
                                    { title: "Containers", desc: "Frames, panes, scroll views, popups, and dialogs.", icon: "\uf8b3", page: 4 },
                                    { title: "Pickers", desc: "Tumbler wheel picker and swipe view controls.", icon: "\uf3f2", page: 5 },
                                    { title: "Menus", desc: "Menu bars, context menus, and tree views.", icon: "\uf6ec", page: 6 }
                                ]

                                delegate: Rectangle {
                                    width: (categoryGrid.width - categoryGrid.columnSpacing * (categoryGrid.columns - 1)) / categoryGrid.columns
                                    height: 100
                                    radius: 8
                                    color: cardBg
                                    border.width: 1
                                    border.color: dividerColor

                                    property color cardHoverColor: Fluent.isDark ? "#383838" : "#f0f0f0"

                                    Behavior on color { ColorAnimation { duration: 150 } }
                                    Behavior on border.color { ColorAnimation { duration: 150 } }

                                    states: State {
                                        name: "hovered"
                                        PropertyChanges {
                                            target: categoryDelegate
                                            color: categoryDelegate.cardHoverColor
                                            border.color: accentColor
                                        }
                                    }

                                    MouseArea {
                                        id: categoryDelegate
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onEntered: parent.state = "hovered"
                                        onExited: parent.state = ""
                                        onClicked: {
                                            root.currentPage = modelData.page
                                            root.currentTitle = modelData.title
                                        }
                                    }

                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 16
                                        spacing: 16

                                        Text {
                                            text: modelData.icon
                                            font.family: root.iconFont
                                            font.pixelSize: 28
                                            color: accentColor
                                            Layout.alignment: Qt.AlignTop
                                        }

                                        Column {
                                            Layout.fillWidth: true
                                            spacing: 4
                                            Text {
                                                text: modelData.title
                                                font.family: Fluent.fontFamily
                                                font.pixelSize: 15
                                                font.weight: Font.SemiBold
                                                color: textPrimary
                                            }
                                            Text {
                                                text: modelData.desc
                                                font.family: Fluent.fontFamily
                                                font.pixelSize: 12
                                                color: textSecondary
                                                wrapMode: Text.Wrap
                                                width: parent.width
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Footer spacer
                Item { height: 32 }
            }
        }

        // ==================== PAGE 1: BASIC INPUT ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: basicCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: basicCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Basic Input"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Standard controls for user input and interaction."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- Button Variants --
                GroupBox {
                    title: "Button Variants"
                    width: parent.width
                    Column { spacing: 10
                        Row { spacing: 8
                            Button { text: "Normal" }
                            Button { text: "Highlighted"; highlighted: true }
                            Button { text: "Flat"; flat: true }
                            Button { text: "Disabled"; enabled: false }
                        }
                        Row { spacing: 8
                            Button { text: "Checked"; checkable: true; checked: true }
                            Button { text: "Flat Checked"; flat: true; checkable: true; checked: true }
                        }
                    }
                }

                // -- Special Buttons --
                GroupBox {
                    title: "Special Buttons"
                    width: parent.width
                    Column { spacing: 10
                        Row { spacing: 8
                            RoundButton { text: "OK" }
                            RoundButton { text: "+" }
                            RoundButton { text: "?" }
                            RoundButton { text: "\uf191"; font.family: root.iconFont; font.pixelSize: 14 }
                        }
                        Row { spacing: 8
                            ToolButton { text: "\uf2a4"; font.family: root.iconFont; ToolTip.text: "Open"; ToolTip.visible: hovered }
                            ToolButton { text: "\uf299"; font.family: root.iconFont; ToolTip.text: "Save"; ToolTip.visible: hovered }
                            ToolSeparator {}
                            ToolButton { text: "\uf223"; font.family: root.iconFont; ToolTip.text: "Cut"; ToolTip.visible: hovered }
                            ToolButton { text: "\uf1df"; font.family: root.iconFont; ToolTip.text: "Copy"; ToolTip.visible: hovered; enabled: false }
                        }
                        Row { spacing: 8
                            DelayButton { text: "Hold Me (1.5s)"; delay: 1500 }
                            DelayButton { text: "Disabled"; enabled: false }
                        }
                    }
                }

                // -- Text Fields --
                GroupBox {
                    title: "Text Fields"
                    width: parent.width
                    Column { spacing: 10
                        TextField { placeholderText: "Standard text field"; width: 350 }
                        TextField { placeholderText: "Disabled"; enabled: false; width: 350 }
                        Row { spacing: 8
                            TextField { placeholderText: "Username"; width: 170 }
                            TextField { placeholderText: "Password"; echoMode: TextInput.Password; width: 170 }
                        }
                        TextArea {
                            placeholderText: "Multi-line text area with word wrapping enabled. Type something here to see how the text flows."
                            width: 450; height: 80
                            wrapMode: TextArea.Wrap
                        }
                    }
                }

                // -- Search Fields --
                GroupBox {
                    title: "Search Fields"
                    width: parent.width
                    Row { spacing: 12
                        TextField {
                            placeholderText: "\uf15c  Search..."
                            width: 300
                            font.family: Fluent.fontFamily
                        }
                        TextField {
                            placeholderText: "\uf15c  Disabled search..."
                            width: 300
                            font.family: Fluent.fontFamily
                            enabled: false
                        }
                    }
                }

                // -- Sliders --
                GroupBox {
                    title: "Sliders"
                    width: parent.width
                    Column { spacing: 16
                        Column { spacing: 6
                            Row { spacing: 12
                                Label { text: "Continuous"; width: 80; font.pixelSize: 12; color: textSecondary }
                                Label { text: sliderCont.value.toFixed(0); font.pixelSize: 12; color: textSecondary; width: 30 }
                            }
                            Slider { id: sliderCont; from: 0; to: 100; value: 30; width: 350; live: true }
                        }
                        Column { spacing: 6
                            Row { spacing: 12
                                Label { text: "Snappy (step 10)"; width: 80; font.pixelSize: 12; color: textSecondary }
                                Label { text: sliderSnap.value.toFixed(0); font.pixelSize: 12; color: textSecondary; width: 30 }
                            }
                            Slider { id: sliderSnap; from: 0; to: 100; value: 50; stepSize: 10; width: 350; live: true }
                        }
                        Column { spacing: 6
                            Row { spacing: 12
                                Label { text: "Disabled"; width: 80; font.pixelSize: 12; color: textSecondary }
                                Label { text: "70"; font.pixelSize: 12; color: textSecondary; width: 30 }
                            }
                            Slider { from: 0; to: 100; value: 70; width: 350; enabled: false }
                        }
                        Column { spacing: 6
                            Label { text: "Range Slider"; font.pixelSize: 13; font.weight: Font.Medium; color: textPrimary }
                            RangeSlider {
                                id: rangeSlider
                                first.value: 0.25; second.value: 0.75; width: 350
                                first.onMoved: rangeLabel.text = first.value.toFixed(2) + " — " + second.value.toFixed(2)
                                second.onMoved: rangeLabel.text = first.value.toFixed(2) + " — " + second.value.toFixed(2)
                            }
                            Label { id: rangeLabel; text: "0.25 — 0.75"; font.pixelSize: 12; color: textSecondary }
                        }
                    }
                }

                // -- Spin Box --
                GroupBox {
                    title: "Spin Box"
                    width: parent.width
                    Row { spacing: 16
                        SpinBox { value: 5; from: 0; to: 100 }
                        SpinBox { value: 0; from: -50; to: 50; editable: true }
                        SpinBox { value: 10; enabled: false }
                    }
                }

                // -- Dial --
                GroupBox {
                    title: "Dial"
                    width: parent.width
                    Row { spacing: 40
                        Column { spacing: 8; width: 120
                            Dial {
                                id: dial1
                                value: 0.5; from: 0; to: 1; stepSize: 0.1
                                width: 100; height: 100
                                background: Rectangle {
                                    implicitWidth: 100; implicitHeight: 100
                                    radius: 50
                                    color: Fluent.controlAltBackground
                                    border.color: dividerColor
                                    border.width: 1
                                }
                            }
                            Label { text: "value: " + dial1.value.toFixed(1); width: 120; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: textSecondary }
                        }
                        Column { spacing: 8; width: 120
                            Dial {
                                id: dial2
                                value: 0.75; from: 0; to: 1
                                width: 100; height: 100
                                background: Rectangle {
                                    implicitWidth: 100; implicitHeight: 100
                                    radius: 50
                                    color: accentColor
                                    opacity: 0.3
                                    border.color: accentColor
                                    border.width: 2
                                }
                            }
                            Label { text: "value: " + dial2.value.toFixed(1); width: 120; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: textSecondary }
                        }
                        Column { spacing: 8; width: 120
                            Dial {
                                value: 0.25; from: 0; to: 1; width: 100; height: 100; enabled: false
                                background: Rectangle {
                                    implicitWidth: 100; implicitHeight: 100
                                    radius: 50
                                    color: Fluent.controlAltBackground
                                    border.color: dividerColor
                                    border.width: 1
                                    opacity: 0.5
                                }
                            }
                            Label { text: "Disabled"; width: 120; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 11; color: textSecondary }
                        }
                    }
                }

                // -- Switch --
                GroupBox {
                    title: "Switch"
                    width: parent.width
                    Row { spacing: 24
                        Column { spacing: 4; width: 100
                            Switch { text: "Wi-Fi"; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Wi-Fi"; anchors.horizontalCenter: parent.horizontalCenter; font.pixelSize: 11; color: textSecondary }
                        }
                        Column { spacing: 4; width: 100
                            Switch { text: "Bluetooth"; checked: true; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Bluetooth"; anchors.horizontalCenter: parent.horizontalCenter; font.pixelSize: 11; color: textSecondary }
                        }
                        Column { spacing: 4; width: 100
                            Switch { text: "Disabled"; enabled: false; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Disabled"; anchors.horizontalCenter: parent.horizontalCenter; font.pixelSize: 11; color: textSecondary }
                        }
                    }
                }

                Item { height: 24 }
            }
        }

        // ==================== PAGE 2: SELECTION ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: selCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: selCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Selection Controls"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Controls that allow users to make selections from a set of options."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- CheckBox --
                GroupBox {
                    title: "Check Box"
                    width: parent.width
                    Column { spacing: 8
                        CheckBox { text: "Option A"; checked: true }
                        CheckBox { text: "Option B" }
                        CheckBox { text: "Option C (tristate)"; tristate: true; checkState: Qt.PartiallyChecked }
                        CheckBox { text: "Disabled unchecked"; enabled: false }
                        CheckBox { text: "Disabled checked"; enabled: false; checked: true }
                    }
                }

                // -- RadioButton --
                GroupBox {
                    title: "Radio Button"
                    width: parent.width
                    ButtonGroup { id: radioGrp }
                    Column { spacing: 8
                        RadioButton { text: "Small"; checked: true; ButtonGroup.group: radioGrp }
                        RadioButton { text: "Medium"; ButtonGroup.group: radioGrp }
                        RadioButton { text: "Large"; ButtonGroup.group: radioGrp }
                        RadioButton { text: "Disabled"; enabled: false; ButtonGroup.group: radioGrp }
                    }
                }

                // -- ComboBox --
                GroupBox {
                    title: "Combo Box"
                    width: parent.width
                    Column { spacing: 10
                        Row { spacing: 12
                            Label { text: "Standard:"; width: 80; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            ComboBox { model: ["Apple", "Banana", "Cherry", "Durian", "Elderberry"]; width: 200 }
                        }
                        Row { spacing: 12
                            Label { text: "Disabled:"; width: 80; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            ComboBox { model: ["Red", "Green", "Blue"]; enabled: false; width: 200 }
                        }
                        Row { spacing: 12
                            Label { text: "Editable:"; width: 80; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            ComboBox { model: ["First", "Second", "Third"]; editable: true; width: 200 }
                        }
                    }
                }

                // -- Delegates --
                GroupBox {
                    title: "Item Delegate"
                    width: parent.width
                    Column { spacing: 2
                        ItemDelegate { text: "\uf2a4  Open File"; width: 320; font.family: Fluent.fontFamily }
                        ItemDelegate { text: "\uf299  Save File"; width: 320; highlighted: true; font.family: Fluent.fontFamily }
                        ItemDelegate { text: "\uf10a  Settings"; width: 320; font.family: Fluent.fontFamily }
                        ItemDelegate { text: "\uf191  Close"; width: 320; font.family: Fluent.fontFamily; enabled: false }
                    }
                }

                GroupBox {
                    title: "Check Delegate"
                    width: parent.width
                    Column { spacing: 2
                        CheckDelegate { text: "Show notifications"; checked: true; width: 320 }
                        CheckDelegate { text: "Auto-save documents"; checked: true; width: 320 }
                        CheckDelegate { text: "Dark mode"; width: 320 }
                        CheckDelegate { text: "Beta features"; width: 320 }
                    }
                }

                GroupBox {
                    title: "Radio Delegate"
                    width: parent.width
                    ButtonGroup { id: radioDelGrp }
                    Column { spacing: 2
                        RadioDelegate { text: "Low priority"; ButtonGroup.group: radioDelGrp; checked: true; width: 320 }
                        RadioDelegate { text: "Medium priority"; ButtonGroup.group: radioDelGrp; width: 320 }
                        RadioDelegate { text: "High priority"; ButtonGroup.group: radioDelGrp; width: 320 }
                    }
                }

                GroupBox {
                    title: "Switch Delegate"
                    width: parent.width
                    Column { spacing: 2
                        SwitchDelegate { text: "Airplane Mode"; width: 320 }
                        SwitchDelegate { text: "Wi-Fi"; checked: true; width: 320 }
                        SwitchDelegate { text: "Mobile Hotspot"; width: 320 }
                        SwitchDelegate { text: "Bluetooth"; width: 320; enabled: false }
                    }
                }

                Item { height: 24 }
            }
        }

        // ==================== PAGE 3: PROGRESS ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: progCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: progCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Progress & Feedback"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Controls that indicate progress or provide status feedback."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- Progress Bar --
                GroupBox {
                    title: "Progress Bar"
                    width: parent.width
                    Column { spacing: 14
                        Column { spacing: 4
                            Row { spacing: 12
                                Label { text: "30%"; width: 30; font.pixelSize: 12; color: textSecondary }
                                ProgressBar { value: 0.3; width: 400 }
                            }
                        }
                        Column { spacing: 4
                            Row { spacing: 12
                                Label { text: "70%"; width: 30; font.pixelSize: 12; color: textSecondary }
                                ProgressBar { value: 0.7; width: 400 }
                            }
                        }
                        Column { spacing: 4
                            Row { spacing: 12
                                Label { text: "100%"; width: 30; font.pixelSize: 12; color: textSecondary }
                                ProgressBar { value: 1.0; width: 400 }
                            }
                        }
                        Column { spacing: 4
                            Row { spacing: 12
                                Label { text: "Indeterminate"; width: 80; font.pixelSize: 12; color: textSecondary }
                                ProgressBar { value: -1; width: 400 }
                            }
                        }
                        Column { spacing: 4
                            Row { spacing: 12
                                Label { text: "Disabled"; width: 60; font.pixelSize: 12; color: textSecondary }
                                ProgressBar { value: 0.5; width: 400; enabled: false }
                            }
                        }
                    }
                }

                // -- Busy Indicator --
                GroupBox {
                    title: "Busy Indicator"
                    width: parent.width
                    Row { spacing: 40
                        Column { spacing: 8; width: 80
                            BusyIndicator { running: true; width: 36; height: 36; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Running"; font.pixelSize: 11; color: textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                        }
                        Column { spacing: 8; width: 80
                            BusyIndicator { running: false; width: 36; height: 36; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Stopped"; font.pixelSize: 11; color: textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                        }
                        Column { spacing: 8; width: 80
                            BusyIndicator { running: true; width: 56; height: 56; anchors.horizontalCenter: parent.horizontalCenter }
                            Label { text: "Large"; font.pixelSize: 11; color: textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                        }
                    }
                }

                // -- Page Indicator --
                GroupBox {
                    title: "Page Indicator"
                    width: parent.width
                    Column { spacing: 16
                        Row { spacing: 16
                            Label { text: "5 pages, index 0:"; width: 120; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            PageIndicator { count: 5; currentIndex: 0 }
                        }
                        Row { spacing: 16
                            Label { text: "5 pages, index 2:"; width: 120; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            PageIndicator { count: 5; currentIndex: 2 }
                        }
                        Row { spacing: 16
                            Label { text: "10 pages, index 7:"; width: 130; font.pixelSize: 13; color: textSecondary; verticalAlignment: Text.AlignVCenter }
                            PageIndicator { count: 10; currentIndex: 7 }
                        }
                    }
                }

                // -- Tool Tip --
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
                            ToolTip.text: "A longer tooltip with more information about this button."
                            ToolTip.visible: hovered
                            ToolTip.delay: 500
                        }
                    }
                }

                Item { height: 24 }
            }
        }

        // ==================== PAGE 4: CONTAINERS ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: contCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: contCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Containers & Layout"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Containers that hold and organize other controls."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- Frame --
                GroupBox {
                    title: "Frame"
                    width: parent.width
                    Frame {
                        width: parent.width
                        height: 56
                        Label {
                            text: "Content inside a Frame — a bordered container with background"
                            width: parent.width; height: parent.height
                            horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                            color: textSecondary
                        }
                    }
                }

                // -- Pane --
                GroupBox {
                    title: "Pane"
                    width: parent.width
                    Pane {
                        width: parent.width
                        implicitHeight: 64
                        Column { spacing: 4
                            Label { text: "A Pane container with content"; font.weight: Font.Medium }
                            Label { text: "Has background, padding, and border radius"; color: textSecondary; font.pixelSize: 12 }
                        }
                    }
                }

                // -- Scroll View --
                GroupBox {
                    title: "Scroll View (ListView)"
                    width: parent.width
                    Rectangle {
                        width: parent.width
                        height: 120
                        radius: 6
                        color: Fluent.controlAltBackground
                        border.width: 1
                        border.color: dividerColor
                        clip: true

                        ListView {
                            anchors.fill: parent
                            anchors.margins: 4
                            clip: true
                            model: 20
                            spacing: 1
                            delegate: Rectangle {
                                width: parent.width
                                height: 28
                                radius: 4
                                color: listMouse.containsMouse ? hoverColor : "transparent"

                                Label {
                                    verticalAlignment: Text.AlignVCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 12
                                    text: "Scrollable item #" + (index + 1)
                                    font.pixelSize: 12
                                    color: textPrimary
                                }

                                MouseArea {
                                    id: listMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                }
                            }
                        }
                    }
                }

                // -- Split View --
                GroupBox {
                    title: "Split View (drag the divider)"
                    width: parent.width
                    SplitView {
                        width: parent.width
                        height: 140
                        handle: Rectangle {
                            implicitWidth: 4
                            implicitHeight: parent ? parent.height : 140
                            color: hoverHandle.containsMouse ? accentColor : dividerColor

                            Behavior on color { ColorAnimation { duration: 150 } }

                            MouseArea {
                                id: hoverHandle
                                anchors.fill: parent
                                hoverEnabled: true
                            }
                        }
                        Rectangle {
                            SplitView.minimumWidth: 80
                            SplitView.preferredWidth: 180
                            color: Fluent.controlAltBackground
                            radius: 6
                            Label { text: "Left\nPanel"; anchors.centerIn: parent; color: textSecondary; horizontalAlignment: Text.AlignHCenter }
                        }
                        Rectangle {
                            SplitView.minimumWidth: 80
                            SplitView.fillWidth: true
                            color: Fluent.controlAltBackground
                            radius: 6
                            Label { text: "Right Panel (drag divider)"; anchors.centerIn: parent; color: textSecondary }
                        }
                    }
                }

                // -- Popups, Dialogs, Drawers --
                GroupBox {
                    title: "Popups, Dialogs & Drawers"
                    width: parent.width
                    Row { spacing: 10
                        Button { text: "Popup"; onClicked: demoPopup.open() }
                        Button { text: "Dialog"; onClicked: demoDialog.open() }
                        Button { text: "Edge Drawer"; onClicked: edgeDrawer.open() }
                        Button { text: "Bottom Drawer"; onClicked: bottomDrawer.open() }
                        Button { text: "Modal Drawer"; onClicked: modalDrawer.open() }
                    }
                }

                Item { height: 24 }
            }
        }

        // ==================== PAGE 5: PICKERS ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: pickCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: pickCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Pickers"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Controls for selecting values from a set of options."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- Tumbler (Number Picker) --
                GroupBox {
                    title: "Tumbler (Number Picker)"
                    width: parent.width
                    Row { spacing: 24
                        Column { spacing: 8
                            Label { text: "Single Column:"; font.pixelSize: 13; font.weight: Font.Medium; color: textPrimary }
                            Tumbler {
                                model: 20
                                width: 80
                                visibleItemCount: 5
                            }
                        }
                        Column { spacing: 8
                            Label { text: "With stepSize:"; font.pixelSize: 13; font.weight: Font.Medium; color: textPrimary }
                            Tumbler {
                                model: ListModel {
                                    ListElement { display: "0" }
                                    ListElement { display: "5" }
                                    ListElement { display: "10" }
                                    ListElement { display: "15" }
                                    ListElement { display: "20" }
                                    ListElement { display: "25" }
                                    ListElement { display: "30" }
                                    ListElement { display: "35" }
                                    ListElement { display: "40" }
                                    ListElement { display: "45" }
                                    ListElement { display: "50" }
                                }
                                width: 80
                                visibleItemCount: 5
                            }
                        }
                    }
                }

                // -- Swipe View --
                GroupBox {
                    title: "Swipe View"
                    width: parent.width
                    Column { spacing: 12
                        SwipeView {
                            id: swipeView
                            width: parent.width
                            height: 180
                            currentIndex: swipeIndicator.currentIndex

                            Repeater {
                                model: ["Fluent Design", "Modern UI", "Clean & Clear", "WinUI 3 Style", "PySide6 + QML"]
                                Rectangle {
                                    property string pageText: modelData
                                    width: swipeView.width
                                    height: swipeView.height
                                    radius: 8
                                    color: index % 2 === 0
                                           ? (Fluent.isDark ? "#1a3a5c" : "#e8f4fd")
                                           : (Fluent.isDark ? "#3a1a5c" : "#f4e8fd")
                                    border.width: 1
                                    border.color: dividerColor

                                    Column {
                                        anchors.centerIn: parent
                                        spacing: 8
                                        Text {
                                            text: pageText
                                            font.family: Fluent.fontFamily
                                            font.pixelSize: 24
                                            font.weight: Font.Bold
                                            color: textPrimary
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                        Text {
                                            text: "Swipe or click indicator below"
                                            font.pixelSize: 13
                                            color: textSecondary
                                            anchors.horizontalCenter: parent.horizontalCenter
                                        }
                                    }
                                }
                            }
                        }
                        PageIndicator {
                            id: swipeIndicator
                            count: 5
                            currentIndex: swipeView.currentIndex
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                // -- Date/Time Picker Simulation --
                GroupBox {
                    title: "Date & Time Picker (Simulated)"
                    width: parent.width
                    Label { text: "Full DatePicker/TimePicker requires Qt Labs Calendar module (not always available). Here is a simulated time picker using Tumblers:"; color: textSecondary; font.pixelSize: 12; wrapMode: Text.Wrap; width: parent.width }

                    Row {
                        spacing: 4
                        topPadding: 12
                        Rectangle {
                            width: 240; height: 150
                            radius: 8
                            color: cardBg
                            border.width: 1
                            border.color: dividerColor

                            Row {
                                anchors.centerIn: parent
                                spacing: 0

                                // Hour
                                Column {
                                    spacing: 0
                                    Label { text: "Hour"; font.pixelSize: 10; color: textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                                    Tumbler {
                                        id: hourTumbler
                                        model: 12
                                        width: 60
                                        visibleItemCount: 5
                                    }
                                }

                                Text {
                                    text: ":"
                                    font.pixelSize: 24
                                    font.weight: Font.Bold
                                    color: textPrimary
                                    verticalAlignment: Text.AlignVCenter
                                }

                                // Minute
                                Column {
                                    spacing: 0
                                    Label { text: "Min"; font.pixelSize: 10; color: textSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                                    Tumbler {
                                        id: minuteTumbler
                                        model: 60
                                        width: 60
                                        visibleItemCount: 5
                                    }
                                }

                                // AM/PM
                                Column {
                                    spacing: 0
                                    Label { text: ""; font.pixelSize: 10; anchors.horizontalCenter: parent.horizontalCenter }
                                    Tumbler {
                                        id: ampmTumbler
                                        model: ["AM", "PM"]
                                        width: 60
                                        visibleItemCount: 3
                                    }
                                }
                            }

                            // Center highlight bar
                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                verticalAlignment: Text.AlignVCenter
                                width: parent.width - 16
                                height: 36
                                radius: 4
                                color: Fluent.controlAltBackground
                                border.width: 1
                                border.color: dividerColor
                            }
                        }
                    }
                }

                Item { height: 24 }
            }
        }

        // ==================== PAGE 6: MENUS ====================
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: width
            contentHeight: menuCol.implicitHeight + 48
            clip: true
            ScrollBar.vertical: ScrollBar {}

            Column {
                id: menuCol
                width: parent.width - 80
                x: 40
                spacing: 20
                topPadding: 24

                Text { text: "Menus & Data"; font.family: Fluent.fontFamily; font.pixelSize: 28; font.weight: Font.Bold; color: textPrimary }
                Text { text: "Menu bars, context menus, and tree views for organizing data."; font.family: Fluent.fontFamily; font.pixelSize: 14; color: textSecondary; wrapMode: Text.Wrap; width: parent.width }

                // -- Menu Bar --
                GroupBox {
                    title: "Menu Bar"
                    width: parent.width
                    MenuBar {
                        Menu { title: "File"
                            MenuItem { text: "\uf2a4  New"; onTriggered: console.log("New") }
                            MenuItem { text: "\uf8b3  Open"; onTriggered: console.log("Open") }
                            MenuSeparator {}
                            MenuItem { text: "\uf299  Save"; onTriggered: console.log("Save") }
                            MenuSeparator {}
                            MenuItem { text: "\uf191  Exit"; onTriggered: Qt.quit() }
                        }
                        Menu { title: "Edit"
                            MenuItem { text: "\uf690  Undo" }
                            MenuItem { text: "\uf223  Cut" }
                            MenuItem { text: "\uf1df  Copy" }
                            MenuItem { text: "\uf295  Paste" }
                        }
                        Menu { title: "View"
                            Menu { title: "Theme"
                                MenuItem { text: "\uf3f2  Light" }
                                MenuItem { text: "\uf36e  Dark" }
                            }
                        }
                        Menu { title: "Help"
                            MenuItem { text: "\uf40c  About" }
                        }
                    }
                }

                // -- Context Menu --
                GroupBox {
                    title: "Context Menu (right-click the area below)"
                    width: parent.width
                    Rectangle {
                        width: parent.width
                        height: 80
                        radius: 6
                        color: Fluent.controlAltBackground
                        border.width: 1
                        border.color: dividerColor

                        Label {
                            text: "Right-click here to open context menu"
                            anchors.centerIn: parent
                            color: textSecondary; font.pixelSize: 14
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            onClicked: ctxMenu.popup()
                        }

                        Menu {
                            id: ctxMenu
                            MenuItem { text: "\uf2a4  Open" }
                            MenuItem { text: "\uf299  Save As..." }
                            MenuSeparator {}
                            Menu { title: "Send to"
                                MenuItem { text: "\uf5be  Compress (zip)" }
                                MenuItem { text: "\uf489  Email recipient" }
                            }
                            MenuSeparator {}
                            MenuItem { text: "\uf710  Delete" }
                        }
                    }
                }

                // -- Tree View --
                GroupBox {
                    title: "Tree View"
                    width: parent.width
                    Rectangle {
                        width: parent.width
                        height: 240
                        radius: 6
                        color: Fluent.controlAltBackground
                        border.width: 1
                        border.color: dividerColor
                        clip: true

                        ListView {
                            id: treeList
                            anchors.fill: parent
                            anchors.margins: 4
                            clip: true
                            model: ListModel { id: treeMdl }
                            delegate: Rectangle {
                                id: treeDelegate
                                required property int index
                                required property string name
                                required property string icon
                                required property int depth
                                required property bool hasChildren
                                required property bool expanded

                                width: treeList.width
                                height: 30
                                radius: 4
                                color: treeMouse.containsMouse ? hoverColor : "transparent"

                                Row {
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: 12 + depth * 20
                                    spacing: 8

                                    // Expand/collapse arrow
                                    Text {
                                        text: hasChildren ? (expanded ? "\uf182" : "\uf86a") : "  "
                                        font.family: root.iconFont
                                        font.pixelSize: 12
                                        color: textTertiary
                                        width: 16
                                    }

                                    // Icon
                                    Text {
                                        text: icon
                                        font.pixelSize: 14
                                        width: 20
                                    }

                                    // Name
                                    Text {
                                        text: name
                                        font.pixelSize: 13
                                        color: textPrimary
                                    }
                                }

                                MouseArea {
                                    id: treeMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        if (!hasChildren) return
                                        if (expanded) {
                                            // Collapse: remove all children
                                            var rc = 0
                                            for (var i = index + 1; i < treeMdl.count; i++) {
                                                if (treeMdl.get(i).depth > depth) rc++
                                                else break
                                            }
                                            treeMdl.remove(index + 1, rc)
                                            treeMdl.setProperty(index, "expanded", false)
                                        } else {
                                            // Expand: insert children
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
                                        { name: "app.qml", icon: "\uD83D\uDCC4", children: [] },
                                        { name: "components", icon: "\uD83D\uDCC1", children: [
                                            { name: "Button.qml", icon: "\uD83D\uDCC4", children: [] },
                                            { name: "Card.qml", icon: "\uD83D\uDCC4", children: [] }
                                        ]}
                                    ]},
                                    { name: "assets", icon: "\uD83D\uDCC1", children: [
                                        { name: "banner.png", icon: "\uD83D\uDDBC\uFE0F", children: [] }
                                    ]},
                                    { name: "README.md", icon: "\uD83D\uDCDD", children: [] },
                                    { name: "pyproject.toml", icon: "\u2699\uFE0F", children: [] }
                                ]},
                                { name: "Dependencies", icon: "\uD83D\uDCE6", children: [
                                    { name: "PySide6", icon: "\uD83D\uDC0D", children: [] },
                                    { name: "fluentpyside", icon: "\u2728", children: [] }
                                ]},
                                { name: "Documentation", icon: "\uD83D\uDCD6", children: [
                                    { name: "Getting Started", icon: "\uD83D\uDCDD", children: [] },
                                    { name: "API Reference", icon: "\uD83D\uDCDD", children: [] }
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
                }

                Item { height: 24 }
            }
        }
    }

    // ================================================================
    // POPUPS, DIALOGS, DRAWERS
    // Direct children of ApplicationWindow for proper positioning
    // ================================================================

    Popup {
        id: demoPopup
        parent: Overlay.overlay
        anchors.centerIn: parent
        width: 300
        padding: 24
        modal: true
        dim: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        background: Rectangle {
            color: cardBg
            radius: 8
            border.width: 1
            border.color: dividerColor

            Rectangle {
                anchors.fill: parent
                radius: 8
                border.width: 1
                border.color: accentColor
                opacity: 0.3
            }
        }
        Column { spacing: 12
            Label { text: "This is a Popup"; font.family: Fluent.fontFamily; font.pixelSize: 18; font.weight: Font.SemiBold; color: textPrimary }
            Label { text: "With Fluent background, border radius, and dim overlay. Click outside or press Escape to close."; wrapMode: Text.Wrap; width: 250; font.pixelSize: 13; color: textSecondary }
            Button { text: "Close"; onClicked: demoPopup.close() }
        }
    }

    Dialog {
        id: demoDialog
        title: "Fluent Dialog"
        modal: true
        anchors.centerIn: parent
        standardButtons: Dialog.Ok | Dialog.Cancel
        Label { text: "This is a modal dialog with standard buttons.\nClick OK or Cancel to proceed."; wrapMode: Text.Wrap; width: 300; color: textSecondary }
    }

    Drawer {
        id: edgeDrawer
        width: 260
        height: root.height
        edge: Qt.LeftEdge
        background: Rectangle { color: cardBg; Rectangle { anchors.right: parent.right; width: 1; height: parent.height; color: dividerColor } }
        Column { padding: 20; spacing: 12; width: parent.width
            Label { text: "Navigation Menu"; font.family: Fluent.fontFamily; font.bold: true; font.pixelSize: 18; color: textPrimary }
            Rectangle { width: 220; height: 1; color: dividerColor }
            ItemDelegate { text: "\uf10a  Home"; width: 220; font.family: Fluent.fontFamily; onClicked: edgeDrawer.close() }
            ItemDelegate { text: "\uf2a4  Documents"; width: 220; font.family: Fluent.fontFamily; onClicked: edgeDrawer.close() }
            ItemDelegate { text: "\uf7e0  Downloads"; width: 220; font.family: Fluent.fontFamily; onClicked: edgeDrawer.close() }
            ItemDelegate { text: "\uf110  Settings"; width: 220; font.family: Fluent.fontFamily; onClicked: edgeDrawer.close() }
        }
    }

    Drawer {
        id: bottomDrawer
        width: root.width
        height: 180
        edge: Qt.BottomEdge
        background: Rectangle { color: cardBg; Rectangle { anchors.top: parent.top; width: parent.width; height: 1; color: dividerColor } }
        Column { padding: 20; spacing: 8; width: parent.width
            Label { text: "Bottom Drawer"; font.family: Fluent.fontFamily; font.bold: true; font.pixelSize: 16; color: textPrimary }
            Label { text: "Slides up from the bottom edge. Great for pickers and quick actions."; color: textSecondary; font.pixelSize: 13 }
            Button { text: "Close"; onClicked: bottomDrawer.close() }
        }
    }

    Drawer {
        id: modalDrawer
        width: 300
        height: root.height
        edge: Qt.RightEdge
        modal: true
        dim: true
        background: Rectangle { color: cardBg; Rectangle { anchors.left: parent.left; width: 1; height: parent.height; color: dividerColor } }
        Column { padding: 20; spacing: 12; width: parent.width
            Label { text: "Modal Drawer"; font.family: Fluent.fontFamily; font.bold: true; font.pixelSize: 18; color: textPrimary }
            Rectangle { width: 260; height: 1; color: dividerColor }
            Label { text: "This drawer dims the background and blocks interaction with other content."; wrapMode: Text.Wrap; width: 260; color: textSecondary; font.pixelSize: 13 }
            Switch { text: "Option A" }
            Switch { text: "Option B"; checked: true }
            Rectangle { width: 260; height: 1; color: dividerColor }
            Button { text: "Close"; onClicked: modalDrawer.close() }
        }
    }
}
