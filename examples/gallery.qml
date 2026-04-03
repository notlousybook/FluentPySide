import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.FluentWinUI3

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("FluentWinUI3 Gallery Demo")

    ScrollView {
        anchors.fill: parent
        contentItem: Column {
            width: parent.width
            spacing: 16
            padding: 16

            Row {
                spacing: 16
                Button { text: "Primary" }
                Button { text: "Secondary" }
                RoundButton { text: "R" }
            }

            Row {
                spacing: 16
                CheckBox { text: "Option A" }
                CheckBox { text: "Option B" }
                RadioButton { text: "Choice 1" }
                RadioButton { text: "Choice 2" }
            }

            Row {
                spacing: 16
                TextField { placeholderText: "Enter text" }
                TextArea { placeholderText: "Multiline" width: 300 }
            }

            Row {
                spacing: 16
                Slider { from: 0; to: 100; value: 30 }
                ProgressBar { value: 0.6 }
            }

            Row {
                spacing: 16
                ComboBox { model: ["One", "Two", "Three"] }
                SpinBox { value: 5 }
            }

            Row {
                spacing: 16
                ToolButton { text: "Tool" }
                ToolBar { }
            }

        }
    }
}
