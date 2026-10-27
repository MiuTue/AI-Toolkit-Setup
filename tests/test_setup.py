"""Verify skill installation without network or writes to the real user home."""
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'templates/.agents/skills/hallmark'


def manifest(directory):
    return {str(p.relative_to(directory)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in directory.rglob('*') if p.is_file()}


class SetupTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='toolkit-test-')
        self.addCleanup(self.tmp.cleanup)
        self.base = Path(self.tmp.name)
        self.project = self.base / 'project with spaces'
        self.project.mkdir()
        self.home = self.base / 'home'
        self.home.mkdir()

    def run_setup(self, *args, script=ROOT / 'setup.sh', expected=0):
        result = subprocess.run(['bash', str(script), *args], cwd=self.project,
                                env={**os.environ, 'HOME': str(self.home)},
                                capture_output=True, text=True)
        self.assertEqual(result.returncode, expected, result.stdout + result.stderr)
        return result.stdout

    def test_complete_copy_and_preserve_existing(self):
        self.run_setup('skill', 'hallmark', '--target', 'both')
        for dest in [self.project / '.agents/skills/hallmark',
                     self.home / '.claude/skills/hallmark']:
            self.assertEqual(manifest(SOURCE), manifest(dest))
            (dest / 'SKILL.md').write_text('customized')
        self.run_setup('skill', 'hallmark', '--target', 'both')
        self.assertEqual((self.project / '.agents/skills/hallmark/SKILL.md').read_text(), 'customized')

    def test_catalog_build_all_and_default_setup(self):
        self.assertIn('hallmark', self.run_setup('skill', '--list'))
        self.run_setup('skill', 'bundle:build')
        self.assertEqual(len(list((self.project / '.agents/skills').glob('*/SKILL.md'))), 8)
        self.run_setup('skill', 'all')
        self.assertEqual(len(list((self.project / '.agents/skills').glob('*/SKILL.md'))), 25)
        fresh = self.base / 'fresh'
        fresh.mkdir()
        self.project = fresh
        self.run_setup('setup')
        self.assertEqual(len(list((fresh / '.agents/skills').glob('*/SKILL.md'))), 31)
        self.assertEqual(manifest(SOURCE), manifest(fresh / '.agents/skills/hallmark'))

    def test_missing_cache_fails_without_false_success(self):
        incomplete = self.base / 'incomplete'
        incomplete.mkdir()
        script = incomplete / 'setup.sh'
        shutil.copy2(ROOT / 'setup.sh', script)
        output = self.run_setup('skill', 'hallmark', script=script, expected=1)
        self.assertIn('thiếu cache', output)
        self.assertNotIn('✅ Xong', output)
        self.assertFalse((self.project / '.agents/skills/hallmark/SKILL.md').exists())


if __name__ == '__main__':
    unittest.main()
