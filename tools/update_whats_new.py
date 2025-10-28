#!/usr/bin/env python3
import subprocess
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
README = ROOT / "README.md"
SECTION_START = "## What’s new"
BEGIN_MARK = "<!-- whatsnew:start -->"
END_MARK = "<!-- whatsnew:end -->"
MAX_COMMITS = 10


def run(cmd: list[str]) -> str:
    return subprocess.check_output(cmd, cwd=ROOT).decode("utf-8", errors="ignore").strip()


def get_recent_commits(n: int) -> list[tuple[str, str]]:
    fmt = "%h|%s"
    out = run(["git", "log", f"-n{n}", "--pretty=format:%h|%s"])
    items = []
    for line in out.splitlines():
        if not line.strip():
            continue
        sha, subject = line.split("|", 1)
        # Skip noisy auto-merge or version bumps if desired
        if subject.lower().startswith("merge "):
            continue
        items.append((sha, subject.strip()))
    return items


def build_section(commits: list[tuple[str, str]]) -> str:
    lines = [SECTION_START, "", BEGIN_MARK]
    for sha, subject in commits:
        lines.append(f"- {subject} (`{sha}`)")
    lines.append(END_MARK)
    lines.append("")
    return "\n".join(lines)


def insert_or_replace_section(readme_text: str, section_text: str) -> str:
    if BEGIN_MARK in readme_text and END_MARK in readme_text:
        pattern = re.compile(re.escape(BEGIN_MARK) + r"[\s\S]*?" + re.escape(END_MARK))
        return pattern.sub("\n".join(section_text.splitlines()[2:-1]), readme_text)
    # Insert after banner or after Start here if banner missing
    insert_after = "![banner]"
    idx = readme_text.find(insert_after)
    if idx == -1:
        idx = readme_text.find("## Start here")
    if idx == -1:
        # Prepend if no good anchor found
        return section_text + "\n" + readme_text
    # Find line end
    next_newline = readme_text.find("\n", idx)
    return readme_text[: next_newline + 1] + "\n" + section_text + "\n" + readme_text[next_newline + 1 :]


def main() -> None:
    commits = get_recent_commits(MAX_COMMITS)
    section = build_section(commits)
    text = README.read_text(encoding="utf-8")
    updated = insert_or_replace_section(text, section)
    if updated != text:
        README.write_text(updated, encoding="utf-8")
        print("README updated with What’s new section.")
    else:
        print("README already up-to-date.")


if __name__ == "__main__":
    main()
