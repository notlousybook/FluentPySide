import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    id: root
    spacing: 20
    implicitWidth: 324

    property color color: Qt.rgba(1, 0, 0, 1)
    property real hue: 0
    property real saturation: 1
    property real brightness: 1
    property real alpha: 1

    property bool ringMode: false
    property bool collapsed: true

    property bool moreVisible: false
    property bool colorSliderVisible: true
    property bool colorChannelInputVisible: true
    property bool hexInputVisible: true
    property bool alphaSliderVisible: true
    property bool alphaInputVisible: true
    property bool alphaEnabled: false

    readonly property int sliderHeight: 12
    property int channelFieldWidth: 120

    function updateColor() {
        var newCol = Qt.hsva(root.hue / 360, root.saturation, root.brightness, root.alpha)
        if (!Qt.colorEqual(root.color, newCol)) root.color = newCol
    }

    onColorChanged: {
        var h = root.color.hsvHue * 360
        var s = root.color.hsvSaturation
        var v = root.color.hsvValue
        var a = root.color.a
        if (h >= 0 && Math.abs(root.hue - h) > 0.5) root.hue = h
        if (!isNaN(s) && Math.abs(root.saturation - s) > 0.005) root.saturation = s
        if (!isNaN(v) && Math.abs(root.brightness - v) > 0.005) root.brightness = v
        if (Math.abs(root.alpha - a) > 0.005) root.alpha = a
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Rectangle {
            id: colorField
            Layout.preferredWidth: 256
            Layout.maximumWidth: 320
            Layout.minimumWidth: 160
            Layout.fillWidth: true
            Layout.preferredHeight: width
            Layout.maximumHeight: 320
            radius: Fluent.appearance.buttonRadius
            clip: true

            Canvas {
                id: pickerCanvas
                anchors.fill: parent
                renderTarget: Canvas.Image
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)

                    var stepX = 4
                    var stepY = 4
                    for (var y = 0; y < height; y += stepY) {
                        var sat = 1 - y / height
                        for (var x = 0; x < width; x += stepX) {
                            var h = (x / width) * 360
                            var c = Qt.hsva(h / 360, Math.max(0, Math.min(1, sat)), 1, 1)
                            ctx.fillStyle = c.toString()
                            ctx.fillRect(x, y, stepX, stepY)
                        }
                    }
                }
                onWidthChanged: requestPaint()
                onHeightChanged: requestPaint()
                Component.onCompleted: requestPaint()
            }

            Rectangle {
                id: pickerIndicator
                width: 14; height: 14; radius: 7; border.width: 2
                border.color: {
                    var c = Qt.hsva(root.hue / 360, root.saturation, 1, 1)
                    var L = 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b
                    return (L < 0.75) ? "white" : "black"
                }
                color: "transparent"
                x: Math.max(0, Math.min(colorField.width - width, (root.hue / 360) * colorField.width - 7))
                y: Math.max(0, Math.min(colorField.height - height, (1 - root.saturation) * colorField.height - 7))
            }

            MouseArea {
                id: pickerArea
                anchors.fill: parent
                preventStealing: true
                hoverEnabled: true
                onPressed: function(mouse) { root.forceActiveFocus(); updateFromMouse(mouse.x, mouse.y) }
                onPositionChanged: function(mouse) {
                    if (mouse.buttons !== Qt.NoButton) updateFromMouse(mouse.x, mouse.y)
                }
                function updateFromMouse(mx, my) {
                    root.hue = Math.max(0, Math.min(360, (mx / colorField.width) * 360))
                    root.saturation = Math.max(0, Math.min(1, 1 - (my / colorField.height)))
                    root.updateColor()
                }
            }
        }

        Rectangle {
            id: preview
            Layout.preferredWidth: 44
            Layout.fillHeight: true
            color: root.color
            radius: Fluent.appearance.buttonRadius
            border.width: 1
            border.color: Fluent.divider
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 22

        Slider {
            id: valueSlider
            visible: root.colorSliderVisible
            Layout.fillWidth: true
            from: 0; to: 1; value: root.brightness
            implicitHeight: sliderHeight
            Layout.preferredHeight: sliderHeight
            Layout.minimumHeight: sliderHeight
            onMoved: { root.brightness = visualPosition; root.updateColor() }
            background: Rectangle {
                anchors.fill: parent; radius: sliderHeight / 2
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: "black" }
                    GradientStop { position: 1; color: Qt.hsva(root.hue / 360, root.saturation, 1, 1) }
                }
            }
            handle: Rectangle {
                implicitWidth: 18; implicitHeight: 18; radius: 9
                x: valueSlider.visualPosition * (valueSlider.width - 18)
                y: (valueSlider.height - 18) / 2
                color: Fluent.textPrimary; border.width: 4; border.color: Fluent.controlSolid
            }
        }

        Slider {
            id: alphaSlider
            visible: root.alphaEnabled && root.alphaSliderVisible
            Layout.fillWidth: true
            from: 0; to: 1; value: root.alpha
            implicitHeight: sliderHeight
            Layout.preferredHeight: sliderHeight
            Layout.minimumHeight: sliderHeight
            onMoved: { root.alpha = visualPosition; root.updateColor() }
            background: Rectangle {
                anchors.fill: parent; radius: sliderHeight / 2
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: Qt.rgba(root.color.r, root.color.g, root.color.b, 0) }
                    GradientStop { position: 1; color: Qt.rgba(root.color.r, root.color.g, root.color.b, 1) }
                }
            }
            handle: Rectangle {
                implicitWidth: 18; implicitHeight: 18; radius: 9
                x: alphaSlider.visualPosition * (alphaSlider.width - 18)
                y: (alphaSlider.height - 18) / 2
                color: Fluent.textPrimary; border.width: 4; border.color: Fluent.controlSolid
            }
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 12

        RowLayout {
            visible: moreVisible
            Layout.fillWidth: true
            Item { Layout.fillWidth: true }
            Button {
                Layout.alignment: Qt.AlignRight
                flat: true
                text: collapsed ? qsTr("More") : qsTr("Less")
                onClicked: collapsed = !collapsed
            }
        }

        RowLayout {
            visible: !moreVisible || !collapsed
            Layout.fillWidth: true
            spacing: 16
            ComboBox {
                id: channelMode
                visible: root.colorChannelInputVisible
                model: ["RGB", "HSV"]
                Layout.preferredWidth: root.channelFieldWidth
            }
            Item { Layout.fillWidth: true }
            TextField {
                id: hexInput
                visible: root.hexInputVisible
                Layout.preferredWidth: 132
                leftPadding: 22
                text: activeFocus ? text : (function() {
                    var r = Math.round(root.color.r * 255).toString(16).padStart(2, '0')
                    var g = Math.round(root.color.g * 255).toString(16).padStart(2, '0')
                    var b = Math.round(root.color.b * 255).toString(16).padStart(2, '0')
                    return (r + g + b).toUpperCase()
                })()
                onTextEdited: {
                    if (text.length === 6 || text.length === 8) {
                        var tempColor = Qt.color("#" + text)
                        if (tempColor.toString() !== "#000000" || text.startsWith("000000"))
                            root.color = tempColor
                    }
                }
                Label {
                    text: "#"; anchors.left: parent.left; anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: Fluent.typography.body; color: Fluent.textSecondary
                }
            }
        }

        ColumnLayout {
            visible: root.colorChannelInputVisible && (!moreVisible || !collapsed)
            Layout.fillWidth: true; spacing: 12
            Repeater {
                model: channelMode.currentText === "RGB"
                    ? [{ label: qsTr("Red"), m: "r" }, { label: qsTr("Green"), m: "g" }, { label: qsTr("Blue"), m: "b" }]
                    : [{ label: qsTr("Hue"), m: "h" }, { label: qsTr("Saturation"), m: "s" }, { label: qsTr("Value"), m: "v" }]
                RowLayout {
                    spacing: 8
                    TextField {
                        id: channelInput
                        Layout.preferredWidth: root.channelFieldWidth
                        text: activeFocus ? text : (channelMode.currentText === "RGB"
                            ? Math.round(root.color[modelData.m] * 255).toString()
                            : (modelData.m === "h" ? Math.round(root.hue).toString()
                              : (modelData.m === "s" ? Math.round(root.saturation * 100).toString()
                              : Math.round(root.brightness * 100).toString())))
                        onTextEdited: {
                            var val = parseFloat(text); if (isNaN(val)) return
                            if (channelMode.currentText === "RGB") {
                                var r = (modelData.m === 'r' ? val / 255 : root.color.r)
                                var g = (modelData.m === 'g' ? val / 255 : root.color.g)
                                var b = (modelData.m === 'b' ? val / 255 : root.color.b)
                                root.color = Qt.rgba(r, g, b, root.alpha)
                            } else {
                                if (modelData.m === "h") root.hue = Math.max(0, Math.min(360, val))
                                else if (modelData.m === "s") root.saturation = Math.max(0, Math.min(100, val)) / 100
                                else if (modelData.m === "v") root.brightness = Math.max(0, Math.min(100, val)) / 100
                                root.updateColor()
                            }
                        }
                    }
                    Label {
                        text: modelData.label; Layout.fillWidth: true
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: Fluent.typography.body; color: Fluent.textPrimary
                    }
                }
            }

            RowLayout {
                visible: root.alphaEnabled && root.alphaInputVisible; spacing: 8
                TextField {
                    id: alphaInput; Layout.preferredWidth: root.channelFieldWidth; rightPadding: 28
                    text: activeFocus ? text : Math.round(root.alpha * 100).toString()
                    onTextEdited: {
                        var val = parseFloat(text)
                        if (!isNaN(val)) { root.alpha = Math.max(0, Math.min(100, val)) / 100; root.updateColor() }
                    }
                    Label { text: "%"; anchors.right: parent.right; anchors.rightMargin: 8; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: Fluent.typography.caption; color: Fluent.textSecondary }
                }
                Label { text: qsTr("Opacity"); Layout.fillWidth: true; verticalAlignment: Text.AlignVCenter; font.pixelSize: Fluent.typography.body; color: Fluent.textPrimary }
            }
        }
    }
}
