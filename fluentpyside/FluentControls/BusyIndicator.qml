import QtQuick
import QtQuick.Controls

ProgressRing {
    id: root
    property bool running: true
    indeterminate: running
}
