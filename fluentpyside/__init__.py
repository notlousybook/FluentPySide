"""fluentpyside public API

Provides install_assets() and set_style() convenience helpers.
"""

from ._installer import install_assets, find_installed_style, default_style_path
from ._loader import set_style


def apply() -> str:
    """Convenience one-liner to make the package usable with no arguments.

    - Ensures the QML assets exist (copies from a local PySide6 when missing)
    - Adds the QML import path and attempts to set the QtQuickControls2 style

    Returns the path used for the FluentWinUI3 style (string).
    """
    # Best-effort: install assets into the package if not already present.
    try:
        p = install_assets()
    except FileNotFoundError:
        # If not available locally, set_style will try to use an installed style
        p = default_style_path()

    # Try to ensure imports are registered and QQuickStyle is applied.
    try:
        set_style(path=p)
    except Exception:
        # swallow errors; apply() is a convenience helper and should not raise
        # for normal missing-plugin situations — user can call set_style() manually
        # for more control.
        pass

    return str(p)


__all__ = [
    "install_assets",
    "find_installed_style",
    "set_style",
    "default_style_path",
    "apply",
]
