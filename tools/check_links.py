#!/usr/bin/env python3
import os
import re
import sys
from typing import List, Tuple

LINK_PATTERN = re.compile(r'(!)?\[[^\]]+\]\(([^)]+)\)')

IGNORE_SCHEMES = (
    'http://', 'https://', 'mailto:', 'tel:', 'ftp://', 'data:', 'news:', 'irc:', 'ssh:'
)


def is_local_target(target: str) -> bool:
    if target.startswith(IGNORE_SCHEMES):
        return False
    if target.startswith('#'):
        return False
    return True


def resolve_path(md_file: str, target: str) -> Tuple[str, str]:
    # Strip anchor if present
    path_only, *_ = target.split('#', 1)
    # Normalize and join with markdown file's directory
    abs_path = os.path.normpath(os.path.join(os.path.dirname(md_file), path_only))
    return abs_path, path_only


def exists_as_file_or_dir_with_readme(abs_path: str) -> bool:
    if os.path.exists(abs_path):
        return True
    # If linking to a directory implicitly, allow README.md inside it
    if os.path.isdir(abs_path):
        readme = os.path.join(abs_path, 'README.md')
        return os.path.isfile(readme)
    # If link path did not end with '/', also try path/README.md
    readme2 = os.path.join(abs_path, 'README.md')
    return os.path.isfile(readme2)


def check_file(md_file: str) -> List[Tuple[int, str]]:
    broken: List[Tuple[int, str]] = []
    try:
        with open(md_file, 'r', encoding='utf-8') as f:
            for lineno, line in enumerate(f, start=1):
                for m in LINK_PATTERN.finditer(line):
                    is_image = m.group(1) == '!'
                    target = m.group(2).strip()
                    if is_image:
                        continue
                    if not is_local_target(target):
                        continue
                    abs_path, _ = resolve_path(md_file, target)
                    if not exists_as_file_or_dir_with_readme(abs_path):
                        broken.append((lineno, target))
    except Exception as e:
        broken.append((0, f'ERROR reading file: {e}'))
    return broken


def gather_md_files(inputs: List[str]) -> List[str]:
    files: List[str] = []
    if inputs:
        for p in inputs:
            if os.path.isdir(p):
                for root, _, filenames in os.walk(p):
                    for name in filenames:
                        if name.lower().endswith('.md'):
                            files.append(os.path.join(root, name))
            else:
                if p.lower().endswith('.md'):
                    files.append(p)
        return files
    # No inputs provided: scan repo from CWD
    for root, _, filenames in os.walk(os.getcwd()):
        # Respect typical VCS/virtual env dirs
        if any(seg in {'.git', '.venv', 'node_modules', '.mypy_cache', '.pytest_cache'} for seg in root.split(os.sep)):
            continue
        for name in filenames:
            if name.lower().endswith('.md'):
                files.append(os.path.join(root, name))
    return files


def main(argv: List[str]) -> int:
    files = gather_md_files(argv[1:])
    any_broken = False
    for md in files:
        broken = check_file(md)
        if broken:
            any_broken = True
            rel = os.path.relpath(md, os.getcwd())
            print(f"Broken links in {rel}:")
            for lineno, target in broken:
                if lineno == 0:
                    print(f"  - {target}")
                else:
                    print(f"  - L{lineno}: {target}")
    return 1 if any_broken else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv))
