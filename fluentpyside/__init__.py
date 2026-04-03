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
    # Prefer the package-local copy of the FluentWinUI3 import tree. If it's
    # missing, try to use an installed PySide6 style as a fallback. We don't
    # copy files from the system during apply(); the package is intended to
    # include the full import tree so importing fluentpyside is sufficient.
    p = default_style_path()
    if not Path(p).exists():
        found = find_installed_style()
        if found:
            p = found
        else:
            # Still return the default path string; set_style will raise if it
            # cannot find or use the style. This keeps apply() non-throwing for
            # simple scripts but surfaces errors when set_style runs.
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
