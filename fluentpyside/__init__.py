"""fluentpyside public API

Fluent Design UI for PySide6, featuring a complete component library
ported and adapted from Rin-UI (https://github.com/RinLit-233-shiroko/Rin-UI).
"""

from __future__ import annotations

from ._installer import install_assets, find_installed_style, default_style_path
from ._loader import set_style
from ._launcher import FluentWindow
from ._theme import ThemeManager
from ._config import Theme, BackdropEffect, FluentConfig, ConfigManager
from ._translator import FluentTranslator


def apply() -> str:
    """Convenience one-liner to enable the FluentWinUI3 theme.

    - Finds the FluentWinUI3 QML import tree
    - Adds the QML import path and attempts to set QQuickStyle to "FluentWinUI3"

    Returns the path used for the FluentWinUI3 style (string).
    """
    p = default_style_path()
    if not p.exists():
        found = find_installed_style()
        if found:
            p = found

    try:
        set_style(path=p)
    except Exception:
        pass

    return str(p)


__all__ = [
    "install_assets",
    "find_installed_style",
    "set_style",
    "default_style_path",
    "apply",
    "FluentWindow",
    "ThemeManager",
    "Theme",
    "BackdropEffect",
    "FluentConfig",
    "ConfigManager",
    "FluentTranslator",
]
