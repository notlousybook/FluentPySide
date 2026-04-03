"""fluentpyside public API

Provides install_assets() and set_style() convenience helpers.
"""

from ._installer import install_assets, find_installed_style, default_style_path
from ._loader import set_style

__all__ = ["install_assets", "find_installed_style", "set_style", "default_style_path"]
