import QtQuick
import QtQuick.Controls

RoundButton {
    id: root
    property bool checkedColor: checked
    checkable: false
    highlighted: checked
}
