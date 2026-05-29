import QtQuick
import QtQuick.Controls

ProgressBar {
    id: root

    property int state: 0
    property int strokeWidth: 4
    property alias ringSize: root.implicitWidth
    property color _ringColor: state === 1 ? Fluent.caution
        : state === 2 ? Fluent.critical
        : Fluent.accent
    property real _progress: (to - from) === 0
        ? 0
        : Math.max(0, Math.min(1, (value - from) / (to - from)))

    implicitWidth: 56
    implicitHeight: implicitWidth

    background: Item {}

    contentItem: Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        renderTarget: Canvas.Image

        property real startAngle: 0
        property real sweepAngle: 270
        property real _radius: (Math.min(width, height) - root.strokeWidth) / 2

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)
            ctx.lineWidth = root.strokeWidth
            ctx.lineCap = "round"

            var centerX = width / 2
            var centerY = height / 2

            ctx.strokeStyle = Fluent.controlBorder
            ctx.beginPath()
            ctx.arc(centerX, centerY, _radius, 0, 2 * Math.PI)
            ctx.stroke()

            ctx.strokeStyle = root._ringColor
            ctx.beginPath()
            if (root.indeterminate) {
                ctx.arc(centerX, centerY, _radius,
                    Math.PI * (startAngle - 90) / 180,
                    Math.PI * (startAngle - 90 + sweepAngle) / 180)
            } else {
                ctx.arc(centerX, centerY, _radius,
                    -Math.PI / 2,
                    -Math.PI / 2 + root._progress * 2 * Math.PI)
            }
            ctx.stroke()
        }

        onStartAngleChanged: requestPaint()
        onSweepAngleChanged: requestPaint()
        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()

        Component.onCompleted: requestPaint()

        SequentialAnimation on startAngle {
            running: root.indeterminate && root.state === 0
            loops: Animation.Infinite
            PropertyAnimation { from: 0; to: 450; duration: 1000 }
            PropertyAnimation { from: 450; to: 1080; duration: 1000 }
        }
        SequentialAnimation on sweepAngle {
            running: root.indeterminate && root.state === 0
            loops: Animation.Infinite
            PropertyAnimation { from: 0; to: 180; duration: 1000 }
            PropertyAnimation { from: 180; to: 0; duration: 1000 }
        }

        SequentialAnimation on startAngle {
            running: root.indeterminate && root.state !== 0
            PropertyAnimation { from: 0; to: 0; duration: 450; easing.type: Easing.InOutCubic }
        }
        SequentialAnimation on sweepAngle {
            running: root.indeterminate && root.state !== 0
            PropertyAnimation { from: 0; to: 360; duration: 450; easing.type: Easing.InOutCubic }
        }
    }

    Behavior on _progress { NumberAnimation { duration: Fluent.anim.speed; easing.type: Easing.InOutQuad } }
    Behavior on _ringColor { ColorAnimation { duration: Fluent.anim.speed; easing.type: Easing.OutCubic } }

    onStateChanged: if (!indeterminate) canvas.requestPaint()
    on_ProgressChanged: if (!indeterminate) canvas.requestPaint()
    on_RingColorChanged: canvas.requestPaint()
}
