import QtQuick
import QtQuick.Controls

TextField {
    id: root
    property var suggestions: []
    property string textRole: "text"
    property var filteredSuggestions: []
    property bool _suppressPopup: false

    function resolveText(item) {
        if (typeof item === "string") return item
        if (item && item[textRole] !== undefined) return String(item[textRole])
        if (item && item.text !== undefined) return String(item.text)
        return ""
    }

    function updateSuggestions() {
        var query = text.toLowerCase()
        var results = []

        if (suggestions && suggestions.count !== undefined && suggestions.get) {
            for (var i = 0; i < suggestions.count; i++) {
                var item = suggestions.get(i)
                var label = resolveText(item)
                if (!label) continue
                if (!query || label.toLowerCase().indexOf(query) !== -1) results.push(label)
            }
        } else if (Array.isArray(suggestions)) {
            for (var j = 0; j < suggestions.length; j++) {
                var value = resolveText(suggestions[j])
                if (!value) continue
                if (!query || value.toLowerCase().indexOf(query) !== -1) results.push(value)
            }
        }

        filteredSuggestions = results
    }

    Popup {
        id: suggestPopup
        y: root.height
        width: root.width
        padding: 0

        background: Rectangle {
            color: Fluent.popupBackground
            border.color: Fluent.cardBorder
            border.width: 1
            radius: Fluent.appearance.buttonRadius
        }

        implicitHeight: Math.min(suggestList.contentHeight, 200)

        contentItem: ListView {
            id: suggestList
            implicitHeight: contentHeight
            height: Math.min(contentHeight, 200)
            model: root.filteredSuggestions
            clip: true
            delegate: ItemDelegate {
                width: suggestList.width
                text: modelData
                onClicked: {
                    root._suppressPopup = true
                    root.text = modelData
                    suggestPopup.close()
                }
            }
        }

        enter: Transition { NumberAnimation { property: "opacity"; from: 0; to: 1; duration: Fluent.anim.fast } }
        exit: Transition { NumberAnimation { property: "opacity"; from: 1; to: 0; duration: Fluent.anim.fast } }
    }

    onTextChanged: {
        if (_suppressPopup) {
            _suppressPopup = false
            return
        }
        updateSuggestions()
        if (activeFocus && filteredSuggestions.length > 0) suggestPopup.open()
        else suggestPopup.close()
    }

    onSuggestionsChanged: updateSuggestions()

    onActiveFocusChanged: {
        if (!activeFocus) {
            suggestPopup.close()
            return
        }
        updateSuggestions()
        if (filteredSuggestions.length > 0) suggestPopup.open()
    }
}
