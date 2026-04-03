"""fluentpyside public API

One-liner to enable the FluentWinUI3 theme in PySide6 apps.
"""

from __future__ import annotations

from pathlib import Path
from typing import Optional

from ._installer import install_assets, find_installed_style, default_style_path
from ._loader import set_style


def apply() -> str:
    """Convenience one-liner to enable the FluentWinUI3 theme.

    - Finds the FluentWinUI3 QML import tree (prefers package-local copy,
      falls back to an installed PySide6 location)
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
]
