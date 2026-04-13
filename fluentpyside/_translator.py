# Based on RinUI by RinLit (https://github.com/RinLit-233-shiroko/Rin-UI)
from pathlib import Path

from PySide6.QtCore import QLocale, QTranslator

from .config import FLUENT_PATH


class FluentTranslator(QTranslator):
    """
    FluentPySide i18n translator.
    :param locale: QLocale, optional, default is system locale
    """

    def __init__(
        self, locale: QLocale = QLocale.system().name(), parent=None
    ):  # follow system
        super().__init__(parent)
        self.load(locale or QLocale())

    def load(self, locale: QLocale) -> bool:
        """
        Load translation file for the given locale.
        :param locale: QLocale, the locale to load (eg = QLocale(QLocale.Chinese, QLocale.China), QLocale("zh_CN"))
        :return: bool
        """
        print(f"🌏 Current locale: {locale.name()}")
        path = Path(FLUENT_PATH) / "FluentPySide" / "languages" / f"{locale.name()}.qm"
        if not path.exists():
            print(f'Language file "{path}" not found. Fallback to default (en_US)')
            path = Path(FLUENT_PATH) / "FluentPySide" / "languages" / "en_US.qm"
            QLocale().setDefault(QLocale("en_US"))

        QLocale().setDefault(locale)
        return super().load(str(path))
