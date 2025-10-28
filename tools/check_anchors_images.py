#!/usr/bin/env python3
import os
import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple

ROOT = Path(__file__).resolve().parents[1]

MD_GLOB = "**/*.md"
IMG_PATTERN = re.compile(r"!\[[^\]]*\]\(([^)]+)\)")
LINK_PATTERN = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
HEADING_PATTERN = re.compile(r"^(#{1,6})\s*(.+?)\s*$")

IGNORE_SCHEMES = (
    "http://", "https://", "mailto:", "tel:", "ftp://", "data:", "news:", "irc:", "ssh:"
)


def slugify_github(text: str) -> str:
    # GitHub anchor slug rules (approximate): lowercase, strip, remove punctuation, spaces -> hyphens
    text = text.strip().lower()
    # remove punctuation except hyphen and space
    text = re.sub(r"[\t\n\r`~!@#$%^&*()_+=|\\{}\[\]:;\"'<>?,./]", "", text)
    text = re.sub(r"\s+", "-", text)
    return text


def collect_anchors(md_path: Path) -> List[str]:
    anchors: List[str] = []
    try:
        with md_path.open("r", encoding="utf-8") as f:
            for line in f:
                m = HEADING_PATTERN.match(line)
                if m:
                    heading = m.group(2)
                    anchors.append(slugify_github(heading))
    except Exception:
        pass
    return anchors


def is_local_target(target: str) -> bool:
    if target.startswith(IGNORE_SCHEMES):
        return False
    if target.startswith("#"):
        return True
    if re.match(r"^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$", target):
        return False
    return True


def check_file(md_file: Path) -> Tuple[List[Tuple[int, str]], List[Tuple[int, str]]]:
    missing_images: List[Tuple[int, str]] = []
    bad_anchors: List[Tuple[int, str]] = []

    anchors_here = collect_anchors(md_file)

    try:
        with md_file.open("r", encoding="utf-8") as f:
            in_code = False
            for lineno, line in enumerate(f, start=1):
                if line.strip().startswith("```"):
                    in_code = not in_code
                if in_code:
                    continue

                # Images: ensure path exists (relative to file)
                for m in IMG_PATTERN.finditer(line):
                    target = m.group(1).strip()
                    if not is_local_target(target):
                        continue
                    if target.startswith("#"):
                        continue
                    abs_path = (md_file.parent / target).resolve()
                    if not abs_path.exists():
                        missing_images.append((lineno, target))

                # Anchors in same file: [text](#anchor)
                for m in LINK_PATTERN.finditer(line):
                    target = m.group(1).strip()
                    if not is_local_target(target):
                        continue
                    if target.startswith("#"):
                        anchor = target[1:]
                        if anchor and anchor not in anchors_here:
                            bad_anchors.append((lineno, target))
    except Exception as e:
        bad_anchors.append((0, f"ERROR reading file: {e}"))

    return missing_images, bad_anchors


def main(paths: List[str]) -> int:
    md_files: List[Path] = []
    if paths:
        for p in paths:
            pth = Path(p)
            if pth.is_dir():
                md_files.extend(pth.rglob("*.md"))
            elif pth.suffix.lower() == ".md":
                md_files.append(pth)
    else:
        md_files = list(ROOT.rglob("*.md"))

    total_missing = 0
    total_anchor_issues = 0

    for md in md_files:
        missing, anchors = check_file(md)
        if missing or anchors:
            rel = md.relative_to(ROOT)
            print(f"\n== {rel} ==")
            for ln, t in missing:
                print(f"  [IMG MISSING] L{ln}: {t}")
            for ln, t in anchors:
                print(f"  [ANCHOR MISSING] L{ln}: {t}")
            total_missing += len(missing)
            total_anchor_issues += len(anchors)

    print("\nSummary:")
    print(f"  Missing images: {total_missing}")
    print(f"  Missing anchors: {total_anchor_issues}")

    return 1 if (total_missing or total_anchor_issues) else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
