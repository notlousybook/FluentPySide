from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent.parent))
import fluentpyside
from PySide6.QtQml import QQmlEngine

e = QQmlEngine()
style_path = fluentpyside.set_style(engine=e)
print("style_path =", style_path)
print("engine import paths:")
for p in e.importPathList():
    print(" -", p)

import os

print("QML2_IMPORT_PATH =", os.environ.get("QML2_IMPORT_PATH"))

# Check that qmldir exists at expected location
qmldir = Path(style_path) / "qmldir"
print("qmldir at style_path exists:", qmldir.exists(), qmldir)
qmldir2 = (
    Path(style_path).parents[2] / "QtQuick" / "Controls" / "FluentWinUI3" / "qmldir"
)
print("qmldir2 check:", qmldir2.exists(), qmldir2)
