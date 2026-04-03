"""Full demo that loads the FluentWinUI3 gallery QML and applies the style."""

from pathlib import Path
import sys

# Prefer the repository copy of the package when running the demo locally.
repo_root = Path(__file__).parent.parent.resolve()
if str(repo_root) not in sys.path:
    sys.path.insert(0, str(repo_root))

import fluentpyside
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine


def main() -> int:
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Ensure the package has the assets (copies from local PySide6 if needed)
    try:
        fluentpyside.install_assets()
    except Exception:
        pass

    # Add the style and the engine import path
    fluentpyside.set_style(engine=engine)

    qml_file = Path(__file__).parent / "gallery.qml"
    engine.load(str(qml_file))
    if not engine.rootObjects():
        print("Failed to load demo QML. Make sure the QML import paths are correct.")
        return 1
    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())
