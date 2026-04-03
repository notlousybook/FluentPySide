"""Copy the packaged FluentWinUI3 theme into a target project.

Usage:
    python tools/update_theme.py /path/to/project

If no path is provided the current working directory is used.
"""

from __future__ import annotations

import shutil
from pathlib import Path
import sys


def main():
    target = Path(sys.argv[1]) if len(sys.argv) > 1 else Path.cwd()
    if not target.exists():
        print("Target does not exist:", target)
        raise SystemExit(1)

    src = Path(__file__).parent.parent / "FluentWinUI3"
    if not src.exists():
        print("FluentWinUI3 source folder not found in package root.")
        raise SystemExit(1)

    # Destination: project root + QtQuick/Controls/FluentWinUI3
    dest = Path(target) / "QtQuick" / "Controls" / "FluentWinUI3"
    if dest.exists():
        shutil.rmtree(dest)
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(src, dest)
    print(f"Copied FluentWinUI3 to: {dest}")


if __name__ == "__main__":
    main()
