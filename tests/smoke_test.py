"""Non-blocking smoke test for the fluentpyside package.

This script mimics end-user usage without entering the QApplication event loop.
It installs assets (if missing), applies the style, loads a small QML string and
exits with code 0 on success.
"""

import sys
from pathlib import Path

import sys
from pathlib import Path

# Ensure local package is preferred during testing (insert repo root before site-packages)
repo_root = Path(__file__).parent.parent.resolve()
sys.path.insert(0, str(repo_root))

import fluentpyside
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine


def main() -> int:
    print("fluentpyside package path:", Path(fluentpyside.__file__).parent)

    try:
        fluentpyside.install_assets()
        print("install_assets: OK")
    except FileNotFoundError as e:
        # It's OK if assets already exist in package or installed location; report and continue
        print("install_assets: warning -", e)
    except Exception as e:
        print("install_assets: failed -", e)
        return 2

    try:
        # create an application instance because some QML modules require it
        app = QApplication([])
    except Exception as e:
        print("QApplication creation failed:", e)
        return 3

    engine = QQmlApplicationEngine()
    # Ask set_style to add the import path to this engine as well
    try:
        style_path = fluentpyside.set_style(engine=engine)
        print("set_style: used", style_path)
    except Exception as e:
        print("set_style: failed -", e)
        return 4

    # Ensure the package root is an import path so "import QtQuick.Controls.FluentWinUI3"
    # resolves to the copied qmldir under fluentpyside/QtQuick/Controls/FluentWinUI3
    pkg_root = Path(__file__).parent.parent / "fluentpyside"
    if pkg_root.exists():
        engine.addImportPath(str(pkg_root))
    print("engine.importPathList =", engine.importPathList())
    import os

    print("env QML2_IMPORT_PATH =", os.environ.get("QML2_IMPORT_PATH"))

    qml = """
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.FluentWinUI3

ApplicationWindow {
    visible: false
    width: 400
    height: 200
    title: qsTr("FluentWinUI3 Smoke Test")

    Column {
        anchors.centerIn: parent
        spacing: 10

        Button { text: "Hello" }
        CheckBox { text: "Check me" }
    }
}
"""

    # Use QQmlComponent to get detailed component errors when loading from string
    from PySide6.QtQml import QQmlComponent
    from PySide6.QtCore import QUrl

    comp = QQmlComponent(engine)
    comp.setData(qml.encode("utf-8"), QUrl())
    errs = comp.errors()
    if errs:
        print("Component reported errors:")
        for e in errs:
            try:
                print(" -", e.toString())
            except Exception:
                print(" -", e)

    obj = comp.create()
    if obj is not None:
        print("QML component created successfully")
        return 0
    else:
        print("QML component creation failed; see errors above")
        return 5


if __name__ == "__main__":
    raise SystemExit(main())
