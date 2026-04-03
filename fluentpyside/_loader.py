"""Helpers to expose the FluentWinUI3 style to QML and attempt to set QQuickStyle.

This module does not assume assets are present — it will try to copy them from a local
PySide6 installation when needed.
"""

from __future__ import annotations

import os
from pathlib import Path
from typing import Optional

from PySide6.QtQml import QQmlEngine

try:
    from PySide6.QtQuickControls2 import QQuickStyle
except Exception:
    QQuickStyle = None

from ._installer import default_style_path, install_assets, find_installed_style


def set_style(
    path: Optional[str | Path] = None, engine: Optional[QQmlEngine] = None
) -> Path:
    """Ensure the FluentWinUI3 style is available and add it to QML import paths.

    - path: optional explicit path to a FluentWinUI3 folder. If omitted, use package-local copy
      and attempt to install assets from the local PySide6 package when missing.
    - engine: optional QQmlEngine or QQmlApplicationEngine instance to call addImportPath on.

    Returns the path to the style folder used.
    """
    if path:
        style_path = Path(path)
    else:
        style_path = default_style_path()

    if not style_path.exists():
        # try to copy from installed PySide6
        try:
            install_assets(style_path)
        except FileNotFoundError:
            # last-resort: try to find installed style and use it directly
            found = find_installed_style()
            if found:
                style_path = found
            else:
                raise

    # Add to environment QML2_IMPORT_PATH so QML imports can find it
    current = os.environ.get("QML2_IMPORT_PATH", "")
    style_str = str(style_path)
    # The QML import path should point at the folder that contains the "QtQuick"
    # import root. If the style_path is nested under QtQuick/Controls/FluentWinUI3,
    # add its parent.parent.parent (the folder that contains QtQuick).
    add_path = style_str
    parts = Path(style_str).parts
    if "QtQuick" in parts:
        # find index of QtQuick and add up to that parent
        idx = parts.index("QtQuick")
        add_path = str(Path(*parts[:idx])) if idx > 0 else Path(".").resolve()
        # If idx==0 then QtQuick is at the filesystem root; fallback to style_str
        if add_path == Path(".").resolve():
            add_path = style_str

    if add_path not in current.split(os.pathsep):
        os.environ["QML2_IMPORT_PATH"] = add_path + (
            os.pathsep + current if current else ""
        )

    # Add to engine if provided
    if engine is not None:
        try:
            # add the QtQuick parent import path to the engine
            engine.addImportPath(add_path)
        except Exception:
            # ignore engine failures
            pass

    # Try to set QQuickStyle by name — plugin must be available
    if QQuickStyle is not None:
        try:
            QQuickStyle.setStyle("FluentWinUI3")
        except Exception:
            # not a plugin or unavailable; ignore
            pass

    return style_path
