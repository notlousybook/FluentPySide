pragma Singleton
import QtQuick

QtObject {
    // Automatically switches between light and dark theme based on system preference
    readonly property bool isDark: Application.styleHints.colorScheme === Qt.Dark

    // ===== SURFACE / BACKGROUND COLORS =====
    readonly property color background: isDark ? "#202020" : "#f3f3f3"
    readonly property color backgroundSecondary: isDark ? "#1c1c1c" : "#e5e5e5"
    readonly property color backgroundTertiary: isDark ? "#282828" : "#f9f9f9"
    readonly property color cardBackground: isDark ? "#2d2d2d" : "#ffffff"
    readonly property color cardBackgroundSecondary: isDark ? "#383838" : "#f6f6f6"
    readonly property color popupBackground: isDark ? "#2d2d2d" : "#ffffff"
    readonly property color layerBackground: isDark ? "#2c2c2c" : "#e8e8e8"
    readonly property color layerAltBackground: isDark ? "#383838" : "#f6f6f6"

    // ===== TEXT / FOREGROUND COLORS =====
    readonly property color textPrimary: isDark ? "#ffffff" : "#1a1a1a"
    readonly property color textSecondary: isDark ? "#9d9d9d" : "#616161"
    readonly property color textTertiary: isDark ? "#7a7a7a" : "#8a8a8a"
    readonly property color textDisabled: isDark ? "#5d5d5d" : "#a0a0a0"
    readonly property color textOnAccent: isDark ? "#003d7a" : "#ffffff"
    readonly property color textOnAccentDisabled: isDark ? "#5d5d5d" : "#a0a0a0"

    // ===== ACCENT COLORS =====
    readonly property color accent: isDark ? "#60cdff" : "#005fb8"
    readonly property color accentHover: isDark ? "#7dd6ff" : "#004c95"
    readonly property color accentPressed: isDark ? "#005a9e" : "#003d7a"
    readonly property color accentSelected: isDark ? "#003d7a" : "#c7e0f4"
    readonly property color accentDisabled: isDark ? "#3d7a9e" : "#a0a0a0"
    readonly property color accentFocusOuter: isDark ? "#60cdff" : "#005fb8"

    // ===== CONTROL COLORS =====
    readonly property color controlBackground: isDark ? "#3d3d3d" : "#ffffff"
    readonly property color controlBackgroundHover: isDark ? "#484848" : "#f0f0f0"
    readonly property color controlBackgroundPressed: isDark ? "#3d3d3d" : "#e5e5e5"
    readonly property color controlBackgroundDisabled: isDark ? "#282828" : "#f9f9f9"
    readonly property color controlStrongBackground: isDark ? "#60cdff" : "#005fb8"
    readonly property color controlStrongBackgroundDisabled: isDark ? "#3d7a9e" : "#a0a0a0"
    readonly property color controlStrongForeground: isDark ? "#003d7a" : "#ffffff"
    readonly property color controlStrongForegroundDisabled: isDark ? "#5d5d5d" : "#a0a0a0"
    readonly property color controlAltBackground: isDark ? "#383838" : "#f6f6f6"
    readonly property color controlAltBackgroundHover: isDark ? "#444444" : "#ededed"
    readonly property color controlAltBackgroundPressed: isDark ? "#3d3d3d" : "#e5e5e5"
    readonly property color controlAltBackgroundTransparent: isDark ? "transparent" : "transparent"
    readonly property color controlAltBackgroundTransparentHover: isDark ? "#ffffff0a" : "#00000005"
    readonly property color controlAltBackgroundTransparentPressed: isDark ? "#ffffff14" : "#0000000f"

    // ===== INPUT / TEXT FIELD COLORS =====
    readonly property color inputBackground: isDark ? "#2d2d2d" : "#ffffff"
    readonly property color inputBackgroundHover: isDark ? "#383838" : "#f0f0f0"
    readonly property color inputBackgroundDisabled: isDark ? "#282828" : "#f9f9f9"
    readonly property color inputBorder: isDark ? "#5d5d5d" : "#9d9d9d"
    readonly property color inputBorderHover: isDark ? "#7a7a7a" : "#7a7a7a"
    readonly property color inputBorderFocus: isDark ? "#60cdff" : "#005fb8"
    readonly property color inputBorderDisabled: isDark ? "#3d3d3d" : "#d1d1d1"
    readonly property color inputPlaceholderForeground: isDark ? "#7a7a7a" : "#8a8a8a"
    readonly property color inputForeground: isDark ? "#ffffff" : "#1a1a1a"
    readonly property color inputForegroundDisabled: isDark ? "#5d5d5d" : "#a0a0a0"

    // ===== BORDER COLORS =====
    readonly property color border: isDark ? "#3d3d3d" : "#d1d1d1"
    readonly property color borderStrong: isDark ? "#5d5d5d" : "#9d9d9d"
    readonly property color borderDisabled: isDark ? "#2d2d2d" : "#e5e5e5"

    // ===== DIVIDER / SEPARATOR =====
    readonly property color divider: isDark ? "#3d3d3d" : "#d1d1d1"
    readonly property color dividerStrong: isDark ? "#5d5d5d" : "#9d9d9d"

    // ===== NOTIFICATION / STATUS COLORS =====
    readonly property color success: isDark ? "#6ccb5f" : "#0f7b0f"
    readonly property color caution: isDark ? "#fcb900" : "#9d5d00"
    readonly property color warning: isDark ? "#ffb900" : "#ff8c00"
    readonly property color critical: isDark ? "#ff99a4" : "#c42b1c"
    readonly property color informational: isDark ? "#60cdff" : "#005fb8"

    // ===== SHADOW =====
    readonly property color shadow: isDark ? "#00000040" : "#00000018"
    readonly property color shadowAmbient: isDark ? "#00000066" : "#00000026"

    // ===== TYPOGRAPHY =====
    readonly property string fontFamily: "Segoe UI Variable"
    readonly property real fontCaptionSize: 12
    readonly property real fontBodySize: 14
    readonly property real fontBodyStrongSize: 14
    readonly property real fontBodyLargeSize: 16
    readonly property real fontSubtitleSize: 20
    readonly property real fontTitleSize: 28
    readonly property real fontTitleLargeSize: 40
    readonly property real fontDisplaySize: 68

    // ===== SPACING (in dp) =====
    readonly property real spacingXXS: 2
    readonly property real spacingXS: 4
    readonly property real spacingS: 8
    readonly property real spacingM: 12
    readonly property real spacingL: 16
    readonly property real spacingXL: 20
    readonly property real spacingXXL: 24

    // ===== RADIUS (in dp) =====
    readonly property real radiusSmall: 4
    readonly property real radiusMedium: 8
    readonly property real radiusLarge: 12
    readonly property real radiusXLarge: 16
    readonly property real radiusCircle: 9999
}
