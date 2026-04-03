FluentPySide
===========

[![PyPI Version](https://img.shields.io/pypi/v/fluentpyside.svg)](https://pypi.org/project/fluentpyside/)
[![Downloads](https://img.shields.io/pypi/dm/fluentpyside.svg)](https://pypi.org/project/fluentpyside/)

fluentpyside packages the FluentWinUI3 Qt Quick Controls style so any Qt / PySide6 application can add the FluentWinUI3 theme easily.
The goal is to make it simple to enable the Fluent theme without bundling the full PySide6 runtime into your application. For minimal, bloat-free builds prefer installing PySide6-Essentials on the target system rather than packaging compiled plugin binaries inside this package.

Quick Start
-----------

```sh
pip install PySide6-Essentials   # recommended — provides the runtime plugins
pip install fluentpyside
```

```py
import fluentpyside
fluentpyside.apply()
```

That's it. `apply()` registers the FluentWinUI3 QML import path and attempts to set the QtQuickControls2 style to `FluentWinUI3`. After that, any QML file that imports `QtQuick.Controls.FluentWinUI3` will use the Fluent theme.

Full example
------------

```py
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
import fluentpyside

app = QApplication([])
engine = QQmlApplicationEngine()

# One-liner to register the import path and set the style
fluentpyside.apply()

# Now load any QML that uses QtQuick.Controls.FluentWinUI3
engine.load("main.qml")
app.exec()
```

Requirements
------------

- Python 3.8+
- PySide6-Essentials (recommended) or PySide6 — provides the Qt runtime plugins needed at runtime. This package only ships the QML styling files (no compiled plugin binaries), keeping the wheel small and cross-platform.

Updating the theme in a project
-------------------------------

If you want to copy the FluentWinUI3 QML tree into a target project manually:

```sh
python tools/update_theme.py /path/to/your/project
```

This copies `FluentWinUI3/` into `/path/to/your/project/QtQuick/Controls/FluentWinUI3/` so you can add the project root as a QML import path.

Notes and troubleshooting
-------------------------

- Always call `fluentpyside.apply()` before loading QML that imports `QtQuick.Controls.FluentWinUI3`.
- If the style doesn't apply, make sure PySide6-Essentials (or PySide6) is installed on the target system — it provides the compiled plugin binaries at runtime.
- For fine-grained control use `fluentpyside.set_style(engine=engine)` or `engine.addImportPath(...)` directly.

License
-------

- Wrapper: MIT License (file LICENSE)
- Upstream QML assets: copied from the locally installed PySide6 / PySide6-Essentials package. Follow Qt/PySide licensing when redistributing.
