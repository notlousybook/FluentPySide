"""Non-interactive smoke test: import fluentpyside, call apply(), verify path exists."""

import sys
import unittest
from pathlib import Path

# Ensure we import from the local repo, not a stale site-packages install
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))


class TestSmoke(unittest.TestCase):
    def test_import(self):
        import fluentpyside

        self.assertTrue(hasattr(fluentpyside, "apply"))
        self.assertTrue(hasattr(fluentpyside, "set_style"))

    def test_apply_returns_existing_path(self):
        import fluentpyside

        p = fluentpyside.apply()
        self.assertIsInstance(p, str)
        self.assertTrue(
            Path(p).exists(), f"Path returned by apply() does not exist: {p}"
        )


if __name__ == "__main__":
    unittest.main()
