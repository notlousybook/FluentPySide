"""Mica material support using pywinstyles."""

from __future__ import annotations

import sys
from typing import TYPE_CHECKING, Optional

if TYPE_CHECKING:
    from PySide6.QtWidgets import QWidget

_mica_available = False

try:
    import pywinstyles

    _mica_available = True
except ImportError:
    pywinstyles = None


def apply_mica(window: "QWidget", dark: bool = False) -> bool:
    """Apply Mica backdrop effect to a window.

    Args:
        window: The QWidget (QMainWindow or QWindow) to apply Mica to.
        dark: Whether to use dark theme.

    Returns:
        True if Mica was successfully applied, False otherwise.
    """
    if not _mica_available:
        print(
            "pywinstyles not installed. Install with: pip install pywinstyles",
            file=sys.stderr,
        )
        return False

    try:
        pywinstyles.apply_style(window, "mica")
        if dark:
            pywinstyles.apply_style(window, "dark")
        return True
    except Exception as e:
        print(f"Failed to apply Mica: {e}", file=sys.stderr)
        return False


def apply_acrylic(window: "QWidget", dark: bool = False) -> bool:
    """Apply Acrylic backdrop effect to a window.

    Args:
        window: The QWidget to apply Acrylic to.
        dark: Whether to use dark theme.

    Returns:
        True if Acrylic was successfully applied, False otherwise.
    """
    if not _mica_available:
        return False

    try:
        pywinstyles.apply_style(window, "acrylic")
        if dark:
            pywinstyles.apply_style(window, "dark")
        return True
    except Exception:
        return False


def change_header_color(window: "QWidget", color: str) -> bool:
    """Change the title bar/header color.

    Args:
        window: The QWidget to modify.
        color: Hex color string (e.g., "#005fb8").

    Returns:
        True if successful, False otherwise.
    """
    if not _mica_available:
        return False

    try:
        pywinstyles.change_header_color(window, color)
        return True
    except Exception:
        return False


def change_title_color(window: "QWidget", color: str) -> bool:
    """Change the title bar text color.

    Args:
        window: The QWidget to modify.
        color: Color string (e.g., "white" or "#ffffff").

    Returns:
        True if successful, False otherwise.
    """
    if not _mica_available:
        return False

    try:
        pywinstyles.change_title_color(window, color)
        return True
    except Exception:
        return False


def get_accent_color() -> Optional[str]:
    """Get the current Windows accent color.

    Returns:
        Hex color string (e.g., "#005fb8") or None if unavailable.
    """
    if not _mica_available:
        return None

    try:
        return pywinstyles.get_accent_color()
    except Exception:
        return None


__all__ = [
    "apply_mica",
    "apply_acrylic",
    "change_header_color",
    "change_title_color",
    "get_accent_color",
]
