#!/usr/bin/env python3
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MD_FILES = list(ROOT.rglob("*.md"))

HEADING_PATTERN = re.compile(r"^#\s*(.+?)\s*$", re.MULTILINE)
BACK_TO_TOP_LINK = re.compile(r"(\[[^\]]*Back to top[^\]]*\]\()#([^)]+)(\))", re.IGNORECASE)


def slugify_github(text: str) -> str:
    text = text.strip().lower()
    text = re.sub(r"[\t\n\r`~!@#$%^&*()_+=|\\{}\[\]:;\"'<>?,./]", "", text)
    text = re.sub(r"\s+", "-", text)
    return text


from typing import Optional

def get_h1_slug(text: str) -> Optional[str]:
    m = HEADING_PATTERN.search(text)
    if not m:
        return None
    title = m.group(1)
    return slugify_github(title)


def fix_file(md_path: Path) -> bool:
    original = md_path.read_text(encoding="utf-8")
    slug = get_h1_slug(original)
    if not slug:
        return False

    def repl(match: re.Match) -> str:
        before, _old_anchor, after = match.groups()
        return f"{before}#{slug}{after}"

    updated = BACK_TO_TOP_LINK.sub(repl, original)
    if updated != original:
        md_path.write_text(updated, encoding="utf-8")
        return True
    return False


def main() -> None:
    changed = 0
    for md in MD_FILES:
        try:
            if fix_file(md):
                changed += 1
        except Exception:
            continue
    print(f"Updated {changed} files with normalized Back-to-top anchors.")


if __name__ == "__main__":
    main()
