"""Find and copy FluentWinUI3 assets from local PySide6 installation."""

from __future__ import annotations

import shutil
from pathlib import Path
from typing import Optional


def find_installed_style() -> Optional[Path]:
    """Try to find the FluentWinUI3 folder inside the installed PySide6 package.

    Returns the source path if found, otherwise None.
    """
    try:
        import PySide6
    except Exception:
        return None

    pyside_pkg = Path(PySide6.__file__).parent
    # Common location inside PySide6: qml/QtQuick/Controls/FluentWinUI3
    candidate = pyside_pkg / "qml" / "QtQuick" / "Controls" / "FluentWinUI3"
    if candidate.exists():
        return candidate

    # Fallback: search the PySide6 package qml tree
    qml_root = pyside_pkg / "qml"
    if qml_root.exists():
        for p in qml_root.rglob("FluentWinUI3"):
            # ensure it's the controls style folder
            if p.is_dir() and "Controls" in p.parts:
                return p

    return None


def default_style_path() -> Path:
    """Path inside this package where assets will be copied to."""
    # Place the style under the QtQuick/Controls/FluentWinUI3 path so QML imports
    # like `import QtQuick.Controls.FluentWinUI3` work when the package folder
    # is added to QML import paths.
    return Path(__file__).parent / "QtQuick" / "Controls" / "FluentWinUI3"


def install_assets(dest: Optional[Path | str] = None) -> Path:
    """Copy the FluentWinUI3 tree from the local PySide6 install into dest.

    If dest is None the package-local `fluent_winui3/` folder is used. Returns the destination path.
    Raises FileNotFoundError if the source cannot be located.
    """
    src = find_installed_style()
    if src is None:
        raise FileNotFoundError(
            "Could not locate FluentWinUI3 in the installed PySide6 package."
        )

    dest_path = Path(dest) if dest else default_style_path()
    if dest_path.exists():
        # remove and replace to ensure a clean copy
        shutil.rmtree(dest_path)
    # copytree needs the target parent to exist if src contains the root folder name
    dest_parent = dest_path.parent
    dest_parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(src, dest_path)
    # Also try to copy impl/ if present (private plugin impl folder)
    impl_src = src / "impl"
    if impl_src.exists():
        try:
            shutil.copytree(impl_src, dest_path / "impl")
        except Exception:
            # ignore; we still copied the main QML files
            pass

    # Copy qmldir from the style folder itself if present (this declares the module)
    src_qmldir = src / "qmldir"
    if src_qmldir.exists():
        try:
            shutil.copy(src_qmldir, dest_path / "qmldir")
        except Exception:
            pass

    # Write a small attribution file
    try:
        with open(
            Path(__file__).parent.parent / "THIRD_PARTY_LICENSES.md",
            "a",
            encoding="utf-8",
        ) as f:
            f.write(f"\nCopied FluentWinUI3 from: {src}\n")
    except Exception:
        pass

    return dest_path
