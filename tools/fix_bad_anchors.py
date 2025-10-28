#!/usr/bin/env python3
import re
from pathlib import Path
from typing import List

ROOT = Path(__file__).resolve().parents[1]
HEADING_PATTERN = re.compile(r"^(#{1,6})\s*(.+?)\s*$", re.MULTILINE)
LINK_PATTERN = re.compile(r"\[[^\]]+\]\((#[^)]+)\)")


def slugify_github(text: str) -> str:
    t = text.strip().lower()
    t = re.sub(r"[\t\n\r`~!@#$%^&*()_+=|\\{}\[\]:;\"'<>?,./]", "", t)
    t = re.sub(r"\s+", "-", t)
    return t


def collect_anchors(md_text: str) -> List[str]:
    anchors: List[str] = []
    for m in HEADING_PATTERN.finditer(md_text):
        anchors.append(slugify_github(m.group(2)))
    return anchors


def flat(s: str) -> str:
    return s.replace("-", "")


from typing import Optional

def best_candidate(target: str, anchors: List[str]) -> Optional[str]:
    # normalize target by dropping leading '#', punctuation, extra dashes
    raw = target[1:]
    cand = slugify_github(raw)
    if cand in anchors:
        return cand
    # hyphen-insensitive match
    flat_c = flat(cand)
    for a in anchors:
        if flat(a) == flat_c:
            return a
    # drop any leading dashes accidentally included
    cand2 = cand.lstrip("-")
    if cand2 in anchors:
        return cand2
    return None


def fix_file(md_path: Path) -> bool:
    text = md_path.read_text(encoding="utf-8", errors="ignore")
    anchors = collect_anchors(text)
    changed = False

    def repl(m: re.Match) -> str:
        nonlocal changed
        full = m.group(1)  # like #tools,-libraries,-frameworks
        cand = best_candidate(full, anchors)
        if cand:
            changed = True
            return f"#{cand}"
        return full

    new_text = LINK_PATTERN.sub(repl, text)
    if changed and new_text != text:
        md_path.write_text(new_text, encoding="utf-8")
        return True
    return False


def main() -> None:
    updated = 0
    for md in ROOT.rglob("*.md"):
        try:
            if fix_file(md):
                updated += 1
        except Exception:
            continue
    print(f"Updated {updated} files with normalized in-document anchors.")


if __name__ == "__main__":
    main()
