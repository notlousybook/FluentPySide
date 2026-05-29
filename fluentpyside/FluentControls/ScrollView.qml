import QtQuick.Controls
import FluentControls

ScrollView {
    ScrollBar.vertical: FluentScrollBar { policy: ScrollBar.AsNeeded }
    ScrollBar.horizontal: FluentScrollBar { policy: ScrollBar.AsNeeded }
}
