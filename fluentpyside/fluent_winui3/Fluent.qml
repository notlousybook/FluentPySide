pragma Singleton
import QtQuick

QtObject {
    id: fluent

    property bool isDark: {
        if (typeof _themeMode !== "undefined" && _themeMode === "dark") return true
        if (typeof _themeMode !== "undefined" && _themeMode === "light") return false
        return Application.styleHints.colorScheme === Qt.Dark
    }

    property bool backdropEnabled: false
    property color primaryColor: (typeof _accentColor !== "undefined" && _accentColor) ? _accentColor : "#605ed2"

    function _accentForDark(c) {
        return Qt.color(c).lighter(1.6).darker(1.2)
    }

    function _updateAccentColors() {
        var base = isDark ? _accentForDark(primaryColor) : primaryColor
        accent = base
        accentHover = Qt.color(base).lighter(1.15)
        accentPressed = Qt.color(base).darker(1.2)
        accentSelected = isDark ? Qt.color(base).darker(2.0) : Qt.color(base).lighter(3.5)
        accentDisabled = isDark ? Qt.color(base).darker(2.5) : "#a0a0a0"
    }

    onPrimaryColorChanged: _updateAccentColors()
    onIsDarkChanged: {
        _updateAccentColors()
        if (backdropEnabled && _themeManager) {
            _themeManager.reapplyBackdrop()
        }
    }

    readonly property color effectiveAccent: accent

    // ===== SURFACE / BACKGROUND =====
    readonly property color background: isDark ? "#202020" : "#f3f3f3"
    readonly property color backgroundSecondary: isDark ? "#1c1c1c" : "#e5e5e5"
    readonly property color backgroundTertiary: isDark ? "#282828" : "#f9f9f9"
    readonly property color backgroundAcrylic: isDark ? "#2c2c2c" : "#f9f9f9"
    readonly property color backgroundSmoke: isDark ? "#4d000000" : "#4d000000"
    readonly property color cardBackground: isDark ? "#0dffffff" : "#b3ffffff"
    readonly property color cardBackgroundSecondary: isDark ? "#08ffffff" : "#80f6f6f6"
    readonly property color cardBackgroundTertiary: isDark ? "#12ffffff" : "#ffffffff"
    readonly property color cardBorder: isDark ? "#1a000000" : "#0f000000"
    readonly property color popupBackground: isDark ? "#2d2d2d" : "#ffffff"
    readonly property color layerBackground: isDark ? "#4d3a3a3a" : "#80ffffff"
    readonly property color layerAltBackground: isDark ? "#383838" : "#f6f6f6"

    // ===== TEXT / FOREGROUND =====
    readonly property color textPrimary: isDark ? "#ffffff" : "#1a1a1a"
    readonly property color textSecondary: isDark ? "#9affffff" : "#9a000000"
    readonly property color textTertiary: isDark ? "#8affffff" : "#72000000"
    readonly property color textDisabled: isDark ? "#5d5d5d" : "#a0a0a0"
    readonly property color textOnAccent: isDark ? "#000000" : "#ffffff"
    readonly property color textOnAccentDisabled: isDark ? "#5d5d5d" : "#a0a0a0"
    readonly property color textAccent: accent
    readonly property color textSelected: isDark ? "#000000" : "#ffffff"

    // ===== ACCENT =====
    property color accent: primaryColor
    property color accentHover: primaryColor
    property color accentPressed: primaryColor
    property color accentSelected: primaryColor
    property color accentDisabled: "#a0a0a0"
    readonly property color accentFocusOuter: isDark ? "#ffffff" : "#000000e5"

    // ===== CONTROL =====
    readonly property color controlFill: isDark ? "#0fffffff" : "#b3ffffff"
    readonly property color controlFillSecondary: isDark ? "#15ffffff" : "#80f9f9f9"
    readonly property color controlFillTertiary: isDark ? "#0affffff" : "#4df9f9f9"
    readonly property color controlFillQuaternary: isDark ? "#12ffffff" : "#c2f3f3f3"
    readonly property color controlStrongFill: isDark ? "#8bffffff" : "#72000000"
    readonly property color controlAltFillSecondary: isDark ? "#1a000000" : "#06000000"
    readonly property color controlAltFillTertiary: isDark ? "#0affffff" : "#0f000000"
    readonly property color controlAltFillQuaternary: isDark ? "#12ffffff" : "#18000000"
    readonly property color controlInputActive: isDark ? "#b31e1e1e" : "#ffffffff"
    readonly property color controlSolid: isDark ? "#454545" : "#ffffff"
    readonly property color controlBorder: isDark ? "#17ffffff" : "#0f000000"
    readonly property color controlBottomBorder: isDark ? "#08000000" : "#29000000"
    readonly property color controlAccentBottomBorder: isDark ? "#24000000" : "#66000000"
    readonly property color controlBorderStrong: isDark ? "#9affffff" : "#9a000000"
    readonly property color controlBorderAccent: isDark ? "#14ffffff" : "#4d000000"
    readonly property color textControlBorder: isDark ? "#8affffff" : "#73000000"
    readonly property color textControlBorderFocused: accent
    readonly property color flyoutBorder: isDark ? "#33000000" : "#0f000000"

    // ===== DIVIDER / SEPARATOR =====
    readonly property color divider: isDark ? "#15ffffff" : "#14000000"
    readonly property color dividerStrong: isDark ? "#5d5d5d" : "#9d9d9d"
    readonly property color dividerBorder: isDark ? "#15ffffff" : "#15000000"

    // ===== WINDOW =====
    readonly property color windowBorder: isDark ? "#12575757" : "#18575757"
    readonly property color captionClose: "#c42b1c"
    readonly property color captionCloseText: "#ffffff"

    // ===== SUBTLE =====
    readonly property color subtle: isDark ? "transparent" : "#00ffffff"
    readonly property color subtleSecondary: isDark ? "#0fffffff" : "#06000000"
    readonly property color subtleTertiary: isDark ? "#0affffff" : "#04000000"

    // ===== FOCUS =====
    readonly property color focusBorderOuter: isDark ? "#ffffff" : "#e5000000"
    readonly property color focusBorderInner: isDark ? "#b3000000" : "#ffffff"

    // ===== NOTIFICATION / STATUS =====
    readonly property color success: isDark ? "#6ccb5f" : "#0f7b0f"
    readonly property color caution: isDark ? "#fcb900" : "#9d5d00"
    readonly property color warning: isDark ? "#ffb900" : "#ff8c00"
    readonly property color critical: isDark ? "#ff99a4" : "#c42b1c"
    readonly property color informational: accent

    readonly property color systemAttentionBackground: isDark ? "#2e2e2e" : "#fbfbfb"
    readonly property color systemSuccessBackground: isDark ? "#393d1b" : "#dff6dd"
    readonly property color systemCautionBackground: isDark ? "#433519" : "#fff4ce"
    readonly property color systemCriticalBackground: isDark ? "#442726" : "#fde7e9"
    readonly property color systemNeutralBackground: isDark ? "#333333" : "#f9f9f9"

    // ===== SHADOW =====
    readonly property color shadow: isDark ? "#5e000000" : "#30000000"
    readonly property color shadowAmbient: isDark ? "#a6000000" : "#42000000"

    // ===== APPEARANCE =====
    readonly property QtObject appearance: QtObject {
        readonly property int buttonRadius: 5
        readonly property int borderWidth: 1
        readonly property real borderFactor: isDark ? 1.2 : 0.9
        readonly property real borderOnAccentFactor: 1.08
        readonly property int smallRadius: 3
        readonly property int dialogTitleBarHeight: 32
        readonly property int windowTitleBarHeight: 48
        readonly property int windowRadius: 7
        readonly property int windowButtonWidth: 46
        readonly property int scrollBarMinWidth: 2
        readonly property int scrollBarWidth: 6
        readonly property int scrollBarPadding: 3
        readonly property int sliderHandleSize: 20
    }

    // ===== ANIMATION =====
    readonly property QtObject anim: QtObject {
        readonly property int speed: 250
        readonly property int fast: 120
        readonly property int middle: 450
        readonly property int expander: 375
        readonly property int appearance: 175
        readonly property int progressBar: 1550
    }

    // ===== TYPOGRAPHY =====
    readonly property QtObject typography: QtObject {
        readonly property string fontFamily: "Segoe UI Variable"
        readonly property string fontIconFamily: (typeof iconFontFamilyResizable !== "undefined" && iconFontFamilyResizable) ? iconFontFamilyResizable : ((typeof iconFontFamily !== "undefined" && iconFontFamily) ? iconFontFamily : "FluentSystemIcons-Resizable")
        readonly property int display: 68
        readonly property int titleLarge: 40
        readonly property int title: 28
        readonly property int subtitle: 20
        readonly property int bodyLarge: 18
        readonly property int body: 14
        readonly property int bodyStrong: 14
        readonly property int caption: 12
    }

    // ===== SPACING =====
    readonly property QtObject spacing: QtObject {
        readonly property real xxs: 2
        readonly property real xs: 4
        readonly property real s: 8
        readonly property real m: 12
        readonly property real l: 16
        readonly property real xl: 20
        readonly property real xxl: 24
    }

    // ===== RADIUS =====
    readonly property QtObject radius: QtObject {
        readonly property real small: 4
        readonly property real medium: 8
        readonly property real large: 12
        readonly property real xlarge: 16
        readonly property real circle: 9999
    }

    // ===== UTILITY =====
    readonly property int windowDragArea: 8

    Component.onCompleted: _updateAccentColors()
}
