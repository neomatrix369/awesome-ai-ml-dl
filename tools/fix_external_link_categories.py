#!/usr/bin/env python3
import re
from pathlib import Path
from typing import Dict, List, Optional, Tuple


ROOT = Path(__file__).resolve().parents[1]
MD_FILES = list(ROOT.rglob("*.md"))

LINK_PATTERN = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
HEADING_PATTERN = re.compile(r"^(?P<hashes>#{1,6})\s*(?P<title>.+?)\s*$")
CODE_FENCE = re.compile(r"^```")


CATEGORY_KEYWORDS: Dict[str, List[str]] = {
    "agents": ["agent", "crew", "autogen", "mcp", "langgraph", "semantic kernel", "babyagi"],
    "nlp": ["nlp", "language", "text", "bert", "huggingface", "spacy", "nltk", "token", "transformer"],
    "computer-vision": ["vision", "yolo", "cnn", "opencv", "image", "segmentation", "detection"],
    "llms": ["llm", "llms", "gpt", "llama", "mistral", "rag", "prompt", "instruct", "chat"],
    "generative-ai": ["generative", "diffusion", "vae", "gan", "stable-diffusion", "midjourney", "dalle"],
    "mlops": ["mlops", "deployment", "serving", "monitoring", "kubeflow", "mlflow", "seldon", "drift", "feature store", "feature-store"],
    "data": ["data", "eda", "pandas", "dataset", "feature", "feature engineering", "sql"],
    "notebooks": ["notebook", "kaggle", "colab", "jupyter"],
    "tools": ["tool", "framework", "library", "sdk", "api"],
    "infrastructure": ["gpu", "cloud", "infra", "kubernetes", "aws", "gcp", "azure", "docker"],
}


# Priority when multiple categories detected
CATEGORY_PRIORITY: List[str] = [
    "agents",
    "llms",
    "generative-ai",
    "nlp",
    "computer-vision",
    "mlops",
    "data",
    "infrastructure",
    "tools",
    "notebooks",
]


HUMAN_SECTION_TITLES: Dict[str, str] = {
    "agents": "AI Agents",
    "nlp": "NLP",
    "computer-vision": "Computer Vision",
    "llms": "Large Language Models (LLMs)",
    "generative-ai": "Generative AI",
    "mlops": "MLOps & Deployment",
    "data": "Data",
    "notebooks": "Notebooks",
    "tools": "Tools & Frameworks",
    "infrastructure": "Infrastructure & Cloud",
}


GENERIC_SECTIONS = {
    "examples", "presentations", "table of contents", "related", "start here",
    "quick links", "core topics", "specialized areas", "reference materials",
    "at a glance", "deep dive", "what’s new", "legacy content (full index)",
    "python", "java & jvm", "other languages", "explore by domain", "awesome ai-ml-dl",
    "ethics & governance", "data & analytics", "learning resources", "cloud & devops",
    "tools & infrastructure", "mathematical foundations",
    "automation & mlops", "miscellaneous", "guides & tutorials", "courses & competitions",
}


def detect_keywords(text: str) -> List[str]:
    text_l = (text or "").lower()
    tokens = set(re.findall(r"[a-z0-9\-]+", text_l))
    hits: List[str] = []
    for cat, kws in CATEGORY_KEYWORDS.items():
        if any(kw for kw in kws if any(kw == t or kw in t for t in tokens)):
            hits.append(cat)
    return hits


def choose_category(hits: List[str]) -> Optional[str]:
    if not hits:
        return None
    for cat in CATEGORY_PRIORITY:
        if cat in hits:
            return cat
    return hits[0]


def find_or_create_section(lines: List[str], title: str, default_level: int = 2) -> Tuple[int, int]:
    """Find an existing section (start, end index exclusive). If not found, create at end and return new indices."""
    # First, find heading lines matching title (case-insensitive)
    indices: List[int] = []
    for i, line in enumerate(lines):
        m = HEADING_PATTERN.match(line)
        if m and m.group("title").strip().lower() == title.strip().lower():
            indices.append(i)
    if indices:
        start = indices[0]
        # find end: next heading of same or higher level
        level = len(HEADING_PATTERN.match(lines[start]).group("hashes"))
        end = len(lines)
        for j in range(start + 1, len(lines)):
            m2 = HEADING_PATTERN.match(lines[j])
            if m2 and len(m2.group("hashes")) <= level:
                end = j
                break
        return start, end

    # Create section at end
    new_heading = "#" * max(1, min(6, default_level)) + " " + title + "\n"
    if lines and not lines[-1].endswith("\n"):
        lines[-1] = lines[-1] + "\n"
    insert_at = len(lines)
    lines.append("\n")
    lines.append(new_heading)
    lines.append("\n")
    return insert_at + 1, insert_at + 3  # approximate range; caller will append content before end


def most_common_section_level(lines: List[str]) -> int:
    levels: List[int] = []
    for line in lines:
        m = HEADING_PATTERN.match(line)
        if m:
            levels.append(len(m.group("hashes")))
    if not levels:
        return 2
    # Pick median-ish small level but not 1
    levels = sorted(levels)
    for lvl in levels:
        if lvl > 1:
            return lvl
    return 2


def process_file(md_path: Path) -> int:
    """Reorganize external link list items into category sections. Returns number of moved items."""
    text = md_path.read_text(encoding="utf-8", errors="ignore")
    lines = text.splitlines(keepends=True)
    default_level = most_common_section_level(lines)

    in_code = False
    current_section_title = ""
    moves_by_category: Dict[str, List[Tuple[int, str]]] = {}
    lines_to_remove: List[int] = []

    for idx, line in enumerate(lines):
        if CODE_FENCE.match(line):
            in_code = not in_code
            continue
        if in_code:
            continue
        m = HEADING_PATTERN.match(line)
        if m:
            current_section_title = m.group("title").strip()
            continue

        # Only consider list-style items that contain a single link
        if re.match(r"^\s*([\-*]|\d+\.)\s+", line) and LINK_PATTERN.search(line):
            # avoid lines with multiple links to reduce risk
            if len(LINK_PATTERN.findall(line)) != 1:
                continue
            link_text, link_target = LINK_PATTERN.findall(line)[0]
            if not re.match(r"^[a-z]+://", link_target.strip()):
                continue
            hits = set(detect_keywords(link_text) + detect_keywords(link_target))
            if not hits:
                continue
            sec_norm = (current_section_title or "").lower().strip()
            if sec_norm and any(gs in sec_norm for gs in GENERIC_SECTIONS):
                continue
            sec_hits = set(detect_keywords(current_section_title))
            if hits & sec_hits:
                continue

            target_category = choose_category(sorted(hits))
            if not target_category:
                continue
            human_title = HUMAN_SECTION_TITLES.get(target_category, target_category.title())

            # Schedule move
            moves_by_category.setdefault(human_title, []).append((idx, line))
            lines_to_remove.append(idx)

    if not moves_by_category:
        return 0

    # Remove lines in reverse order to keep indices valid
    for idx in sorted(set(lines_to_remove), reverse=True):
        del lines[idx]

    # Append moved items under their sections
    for human_title, items in moves_by_category.items():
        start, end = find_or_create_section(lines, human_title, default_level=default_level)
        # Insert items just before end (which is either next section or EOF marker approx)
        insert_at = end
        # Ensure a blank line before items
        if insert_at > 0 and lines[insert_at - 1].strip():
            lines.insert(insert_at, "\n")
            insert_at += 1
        for _, original_line in items:
            lines.insert(insert_at, original_line if original_line.endswith("\n") else original_line + "\n")
            insert_at += 1

    md_path.write_text("".join(lines), encoding="utf-8")
    return sum(len(v) for v in moves_by_category.values())


def main() -> None:
    total_moved = 0
    affected_files = 0
    for md in sorted(MD_FILES):
        moved = process_file(md)
        if moved:
            affected_files += 1
            total_moved += moved
            print(f"Reorganized {moved} link(s) in {md.relative_to(ROOT)}")
    print(f"Done. Affected files: {affected_files}, total links moved: {total_moved}")


if __name__ == "__main__":
    main()
