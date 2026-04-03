FluentPySide
===========

[![PyPI Version](https://img.shields.io/pypi/v/fluentpyside.svg)](https://pypi.org/project/fluentpyside/)
[![Downloads](https://img.shields.io/pypi/dm/fluentpyside.svg)](https://pypi.org/project/fluentpyside/)

fluentpyside packages the FluentWinUI3 Qt Quick Controls style so any Qt / PySide6 application can add the FluentWinUI3 theme easily.
The goal is to make it simple to enable the Fluent theme without bundling the full PySide6 runtime into your application. For minimal, bloat-free builds prefer installing PySide6-Essentials on the target system rather than packaging compiled plugin binaries inside this package.

Quick Start — three ways
------------------------

1) Install the wrapper package and use the helper (recommended)

Prerequisites:
- Python 3.8+
- PySide6 (and optionally PySide6-Essentials for upstream plugin binaries)

Install and run:

```sh
pip install PySide6
pip install -e .   # from this repository root (development install)
python examples/demo.py
```

Minimal example (use fluentpyside.set_style):

```py
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
import fluentpyside

app = QApplication([])
engine = QQmlApplicationEngine()

# Ensure package-local QML assets exist (copies from installed PySide6 when missing)
fluentpyside.install_assets()

# Add import path and try to set the QtQuickControls2 style plugin
fluentpyside.set_style(engine=engine)

# Load QML that imports FluentWinUI3
engine.load('examples/gallery.qml')
app.exec()
```

2) Drag-and-drop the style into a project (no packaging)

- Copy `fluentpyside/QtQuick` into your project root so there is `./QtQuick/Controls/FluentWinUI3/qmldir`.
- In Python, add your project root as a QML import path before loading QML:

```py
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine

app = QApplication([])
engine = QQmlApplicationEngine()
engine.addImportPath('path/to/project/root')
engine.load('main.qml')
app.exec()
```

3) Run the included gallery demo

```sh
pip install PySide6
pip install -e .
python examples/demo.py
```

Files included
--------------
- fluentpyside/: Python wrapper and packaged QML assets
- examples/demo.py: demo app that loads examples/gallery.qml
- examples/gallery.qml: QML demo UI (gallery of controls)
- tests/smoke_test.py: non-interactive smoke test

Publishing & GitHub
-------------------

- I will not publish/delete on your behalf without explicit credentials and confirmation.
- To publish to PyPI locally:

  python -m build
  python -m twine upload dist/*

- To create or replace a GitHub repo locally with `gh`:

  gh repo create <owner>/FluentPySide --public --source=. --push

  (If you want me to run these steps from this environment, provide the tokens and explicit confirmation.)

Notes and troubleshooting
-------------------------
- Call `fluentpyside.set_style(engine=engine)` or `engine.addImportPath(...)` before loading QML that imports QtQuick.Controls.FluentWinUI3.
- This wrapper ships the QML import tree so applications can import `QtQuick.Controls.FluentWinUI3` without manually copying files. It may also include upstream compiled plugin binaries if copied from your local install — bundling those binaries makes the wheel platform-specific and increases size. For small, bloat-free builds prefer installing `PySide6-Essentials` (or the platform's PySide6 runtime) on the target system instead of redistributing compiled plugin binaries inside this package.

License
-------
- Wrapper: MIT License (file LICENSE)
- Upstream QML assets: copied from the locally installed PySide6 / PySide6-Essentials package. Follow Qt/PySide licensing when redistributing.
