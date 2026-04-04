<p align="center">
  <img src="assets/banner.png" alt="FluentPySide Banner">
</p>

FluentPySide
===========

[![PyPI Version](https://img.shields.io/pypi/v/fluentpyside.svg)](https://pypi.org/project/fluentpyside/)

fluentpyside packages the FluentWinUI3 Qt Quick Controls style so any Qt / PySide6 application can add the FluentWinUI3 theme easily.
The goal is to make it simple to enable the Fluent theme without bundling the full PySide6 runtime into your application. For minimal, bloat-free builds prefer installing PySide6-Essentials on the target system rather than packaging compiled plugin binaries inside this package.

> **⚠️ IMPORTANT — Read this before using**
>
> This library is a **QML visual theme only**. It styles Qt Quick Controls 2 components (Button, TextField, CheckBox, etc.) to look like Windows 11's Fluent Design. It does **NOT** provide:
>
> - A Python widget library (it does NOT touch `QtWidgets` — no `QPushButton`, `QLabel`, etc.)
> - Custom QML components — you use the **standard** Qt Quick Controls 2 API, this library just changes how they look
>
> For colors and design tokens, use the `Fluent` singleton (available after calling `fluentpyside.apply()`):
> ```qml
> Rectangle {
>     color: Fluent.cardBackground
>     radius: Fluent.radiusMedium
>     Label {
>         text: "Hello"
>         color: Fluent.textPrimary
>         font.pixelSize: Fluent.fontBodySize
>         font.family: Fluent.fontFamily
>     }
> }
> ```

Quick Start
-----------

```sh
pip install PySide6-Essentials   # recommended — provides the runtime plugins
pip install fluentpyside
```

```py
import fluentpyside
fluentpyside.apply()
```

That's it. `apply()` registers the FluentWinUI3 QML import path and sets the QtQuickControls2 style to `FluentWinUI3`. After that, any standard Qt Quick Controls 2 component in your QML will be rendered with the Fluent theme automatically.

### How it works

You write **standard QML** using the normal Qt Quick Controls 2 imports. The `fluentpyside.apply()` call sets the style, so every component automatically gets the Fluent look — you don't import anything special, you don't reference any theme object, you just write normal QML.

```py
# main.py
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import fluentpyside

app = QGuiApplication([])
engine = QQmlApplicationEngine()

# ONE line — this is all you need
fluentpyside.apply()

engine.load("main.qml")
app.exec()
```

```qml
// main.qml
// NOTE: Only standard Qt imports — NO Fluent-specific import needed
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "FluentWinUI3 Demo"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Label {
            text: "FluentWinUI3 Theme"
            font.pixelSize: 20
            font.bold: true
        }

        TextField {
            placeholderText: "Type something..."
            Layout.fillWidth: true
        }

        Button {
            text: "Click me"
            onClicked: console.log("Button clicked!")
        }

        CheckBox {
            text: "Enable feature"
        }

        Switch {
            text: "Dark mode toggle"
        }

        ProgressBar {
            value: 0.6
            Layout.fillWidth: true
        }

        ComboBox {
            model: ["Option 1", "Option 2", "Option 3"]
            Layout.fillWidth: true
        }

        Item { Layout.fillHeight: true }
    }
}
```

Available styled components
---------------------------

These **standard Qt Quick Controls 2** components get Fluent styling automatically when `fluentpyside.apply()` is called:

| Component | Notes |
|---|---|
| `ApplicationWindow` | Main window container |
| `Button` | Standard push button |
| `RoundButton` | Circular/pill-shaped button |
| `DelayButton` | Button that activates after holding |
| `ToolButton` | Toolbar button |
| `TextField` | Single-line text input |
| `TextArea` | Multi-line text input |
| `SearchField` | Text input with search icon (Qt 6.10+) |
| `SpinBox` | Numeric input with up/down arrows |
| `ComboBox` | Dropdown selector |
| `CheckBox` | Checkbox with label |
| `CheckDelegate` | Checkbox in a list item |
| `RadioButton` | Radio button with label |
| `RadioDelegate` | Radio button in a list item |
| `Switch` | Toggle switch |
| `SwitchDelegate` | Toggle switch in a list item |
| `Slider` | Horizontal slider |
| `RangeSlider` | Two-handle slider |
| `ProgressBar` | Linear progress indicator |
| `BusyIndicator` | Spinning loading indicator |
| `PageIndicator` | Dot-style page indicator |
| `GroupBox` | Labeled container frame |
| `Frame` | Container frame |
| `ScrollView` | Scrollable area (falls back to system) |
| `TabBar` / `TabButton` | Tab navigation |
| `ToolBar` | Toolbar container |
| `ToolSeparator` | Separator for toolbars |
| `MenuBar` / `MenuBarItem` | Top menu bar |
| `Menu` / `MenuItem` / `MenuSeparator` | Dropdown menus |
| `Dialog` / `DialogButtonBox` | Modal dialogs |
| `Popup` | Generic popup container |
| `ToolTip` | Hover tooltip |
| `ItemDelegate` | Clickable list item |
| `SwipeDelegate` | Swipeable list item |
| `Calendar` | Date picker with month navigation |
| `Dial` | Rotary/knob control (custom Fluent design) |
| `Drawer` | Sliding side panel (left/right/bottom, modal) |
| `Label` | Text label with Fluent typography |
| `Pane` | Background container with Fluent styling |
| `ScrollView` | Scrollable area with Fluent scrollbars |
| `SplitView` | Resizable split layout with styled divider |
| `StackView` | Navigation stack with slide transitions |
| `SwipeView` | Swipeable page container |
| `Tumbler` | Wheel/drum picker (3D effect) |
| `TreeView` | Expandable tree view with chevron indicators |

That's **52 styled components** covering the full Qt Quick Controls 2 API. All components automatically switch between light and dark mode.

### Gallery Demo

A comprehensive gallery showcasing every control is included. Run it with:

```sh
cd examples
python run_gallery.py
```


Fluent Design Tokens
---------------------

After calling `fluentpyside.apply()`, a `Fluent` singleton is available in your QML with WinUI 3 design tokens. All colors automatically switch between light and dark mode based on the system preference (`Fluent.isDark`).

### Example usage

```qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true; width: 600; height: 400

    Rectangle {
        anchors.fill: parent
        color: Fluent.background

        ColumnLayout {
            anchors.centerIn: parent

            Label {
                text: "Welcome"
                color: Fluent.textPrimary
                font.pixelSize: Fluent.fontTitleSize
                font.family: Fluent.fontFamily
            }

            Button {
                text: "Accent Button"
                Layout.alignment: Qt.AlignHCenter
            }

            Rectangle {
                width: 200; height: 4
                radius: Fluent.radiusSmall
                color: Fluent.accent
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
```

### Available properties

**Surface Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.background` | `#f3f3f3` | `#202020` |
| `Fluent.backgroundSecondary` | `#e5e5e5` | `#1c1c1c` |
| `Fluent.backgroundTertiary` | `#f9f9f9` | `#282828` |
| `Fluent.cardBackground` | `#ffffff` | `#2d2d2d` |
| `Fluent.cardBackgroundSecondary` | `#f6f6f6` | `#383838` |
| `Fluent.popupBackground` | `#ffffff` | `#2d2d2d` |
| `Fluent.layerBackground` | `#e8e8e8` | `#2c2c2c` |
| `Fluent.layerAltBackground` | `#f6f6f6` | `#383838` |

**Text Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.textPrimary` | `#1a1a1a` | `#ffffff` |
| `Fluent.textSecondary` | `#616161` | `#9d9d9d` |
| `Fluent.textTertiary` | `#8a8a8a` | `#7a7a7a` |
| `Fluent.textDisabled` | `#a0a0a0` | `#5d5d5d` |
| `Fluent.textOnAccent` | `#ffffff` | `#003d7a` |

**Accent Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.accent` | `#005fb8` | `#60cdff` |
| `Fluent.accentHover` | `#004c95` | `#7dd6ff` |
| `Fluent.accentPressed` | `#003d7a` | `#005a9e` |
| `Fluent.accentSelected` | `#c7e0f4` | `#003d7a` |
| `Fluent.accentDisabled` | `#a0a0a0` | `#3d7a9e` |
| `Fluent.accentFocusOuter` | `#005fb8` | `#60cdff` |

**Control Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.controlBackground` | `#ffffff` | `#3d3d3d` |
| `Fluent.controlBackgroundHover` | `#f0f0f0` | `#484848` |
| `Fluent.controlBackgroundPressed` | `#e5e5e5` | `#3d3d3d` |
| `Fluent.controlBackgroundDisabled` | `#f9f9f9` | `#282828` |
| `Fluent.controlStrongBackground` | `#005fb8` | `#60cdff` |
| `Fluent.controlStrongForeground` | `#ffffff` | `#003d7a` |
| `Fluent.controlAltBackground` | `#f6f6f6` | `#383838` |
| `Fluent.controlAltBackgroundTransparentHover` | `#00000005` | `#ffffff0a` |
| `Fluent.controlAltBackgroundTransparentPressed` | `#0000000f` | `#ffffff14` |

**Input / Text Field Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.inputBackground` | `#ffffff` | `#2d2d2d` |
| `Fluent.inputBackgroundHover` | `#f0f0f0` | `#383838` |
| `Fluent.inputBorder` | `#9d9d9d` | `#5d5d5d` |
| `Fluent.inputBorderHover` | `#7a7a7a` | `#7a7a7a` |
| `Fluent.inputBorderFocus` | `#005fb8` | `#60cdff` |
| `Fluent.inputPlaceholderForeground` | `#8a8a8a` | `#7a7a7a` |
| `Fluent.inputForeground` | `#1a1a1a` | `#ffffff` |

**Border / Divider**

| Property | Light | Dark |
|---|---|---|
| `Fluent.border` | `#d1d1d1` | `#3d3d3d` |
| `Fluent.borderStrong` | `#9d9d9d` | `#5d5d5d` |
| `Fluent.borderDisabled` | `#e5e5e5` | `#2d2d2d` |
| `Fluent.divider` | `#d1d1d1` | `#3d3d3d` |
| `Fluent.dividerStrong` | `#9d9d9d` | `#5d5d5d` |

**Status Colors**

| Property | Light | Dark |
|---|---|---|
| `Fluent.success` | `#0f7b0f` | `#6ccb5f` |
| `Fluent.caution` | `#9d5d00` | `#fcb900` |
| `Fluent.warning` | `#ff8c00` | `#ffb900` |
| `Fluent.critical` | `#c42b1c` | `#ff99a4` |
| `Fluent.informational` | `#005fb8` | `#60cdff` |

**Typography**

| Property | Value |
|---|---|
| `Fluent.fontFamily` | `"Segoe UI Variable"` |
| `Fluent.fontCaptionSize` | `12` |
| `Fluent.fontBodySize` | `14` |
| `Fluent.fontBodyStrongSize` | `14` |
| `Fluent.fontBodyLargeSize` | `16` |
| `Fluent.fontSubtitleSize` | `20` |
| `Fluent.fontTitleSize` | `28` |
| `Fluent.fontTitleLargeSize` | `40` |
| `Fluent.fontDisplaySize` | `68` |

**Spacing**

| Property | Value |
|---|---|
| `Fluent.spacingXXS` | `2` |
| `Fluent.spacingXS` | `4` |
| `Fluent.spacingS` | `8` |
| `Fluent.spacingM` | `12` |
| `Fluent.spacingL` | `16` |
| `Fluent.spacingXL` | `20` |
| `Fluent.spacingXXL` | `24` |

**Radius**

| Property | Value |
|---|---|
| `Fluent.radiusSmall` | `4` |
| `Fluent.radiusMedium` | `8` |
| `Fluent.radiusLarge` | `12` |
| `Fluent.radiusXLarge` | `16` |
| `Fluent.radiusCircle` | `9999` |

Requirements
------------

- Python 3.8+
- PySide6-Essentials (recommended) or PySide6 — provides the Qt runtime plugins needed at runtime. This package only ships the QML styling files (no compiled plugin binaries), keeping the wheel small and cross-platform.

Public API reference
--------------------

### `fluentpyside.apply() -> str`

One-liner to enable the FluentWinUI3 theme. Call this **before** loading any QML. Returns the path used for the style.

```py
import fluentpyside
fluentpyside.apply()  # call BEFORE engine.load()
```

### `fluentpyside.set_style(engine=None, path=None) -> str`

Lower-level API if you need fine-grained control. Sets the QML import path and Qt Quick Controls 2 style.

```py
engine = QQmlApplicationEngine()
style_path = fluentpyside.set_style(engine=engine)
engine.load("main.qml")
```

### `fluentpyside.install_assets(target_dir)`

Copy the FluentWinUI3 QML tree into a target project directory. Useful for vendoring the theme files.

```sh
python -m fluentpyside --install /path/to/your/project
```

### `fluentpyside.find_installed_style() -> Optional[Path]`

Search for the FluentWinUI3 style in the installed PySide6 package. Returns `None` if not found.

### `fluentpyside.default_style_path() -> Path`

Return the package-local style path (inside the fluentpyside wheel).

Common mistakes
---------------

### ❌ "ReferenceError: Fluent is not defined"

Make sure you call `fluentpyside.apply()` **before** loading your QML. The `Fluent` singleton is only available after the style is applied:

```py
engine = QQmlApplicationEngine()
fluentpyside.apply()  # ✅ Fluent singleton is now available
engine.load("main.qml")
```

### ❌ Using Qt Widgets instead of Qt Quick

This library styles **Qt Quick Controls 2 (QML) only**. It does nothing for classic Qt Widgets:

```py
# ❌ These are Qt Widgets — NOT styled by fluentpyside
from PySide6.QtWidgets import QPushButton, QLabel, QMainWindow

# ✅ Use QML with PySide6 — this IS styled
from PySide6.QtQml import QQmlApplicationEngine
```

### ❌ Calling `apply()` after loading QML

`fluentpyside.apply()` must be called **before** `engine.load()`:

```py
engine = QQmlApplicationEngine()
fluentpyside.apply()  # ✅ BEFORE
engine.load("main.qml")

# NOT:
# engine.load("main.qml")  # ❌ too late
# fluentpyside.apply()
```

### ❌ Forgetting PySide6-Essentials

This package only ships QML files. You need PySide6 installed for the runtime:

```sh
pip install PySide6-Essentials  # or PySide6 (full)
pip install fluentpyside
```

Updating the theme in a project
-------------------------------

If you want to copy the FluentWinUI3 QML tree into a target project manually:

```sh
python tools/update_theme.py /path/to/your/project
```

This copies `FluentWinUI3/` into `/path/to/your/project/QtQuick/Controls/FluentWinUI3/` so you can add the project root as a QML import path.

License
-------

- Wrapper: MIT License (file LICENSE)
- Upstream QML assets: copied from the locally installed PySide6 / PySide6-Essentials package. Follow Qt/PySide licensing when redistributing.
