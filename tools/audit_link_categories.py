#!/usr/bin/env python3
import re
from pathlib import Path
import argparse
from typing import Dict, List, Optional, Tuple

ROOT = Path(__file__).resolve().parents[1]
MD_FILES = list(ROOT.rglob("*.md"))

LINK_PATTERN = re.compile(r"\[([^\]]+)\]\(([^)]+)\)")
HEADING_PATTERN = re.compile(r"^(#{1,6})\s*(.+?)\s*$")
CODE_FENCE = re.compile(r"^```")

CATEGORY_KEYWORDS: Dict[str, List[str]] = {
    "agents": ["agent", "crew", "autogen", "mcp"],
    "nlp": ["nlp", "language", "text", "bert", "huggingface", "spacy", "nltk"],
    "computer-vision": ["vision", "yolo", "cnn", "opencv"],
    "llms": ["llm", "llms", "gpt", "llama", "mistral", "rag", "prompt"],
    "generative-ai": ["generative", "diffusion", "vae", "gan", "stable-diffusion", "midjourney", "dalle"],
    "mlops": ["mlops", "deployment", "serving", "monitoring", "kubeflow", "mlflow", "seldon", "drift"],
    "data": ["data", "eda", "pandas", "dataset", "feature"],
    "notebooks": ["notebook", "kaggle", "colab", "jupyter"],
    "tools": ["tool", "framework", "library", "sdk"],
    "infrastructure": ["gpu", "cloud", "infra", "kubernetes", "aws", "gcp", "azure"],
}

# Map folders to default category context to reduce false positives
FOLDER_CATEGORY_HINTS: List[Tuple[str, str]] = [
    ("domains/ai-agents/", "agents"),
    ("natural-language-processing/", "nlp"),
    ("domains/nlp/", "nlp"),
    ("domains/computer-vision/", "computer-vision"),
    ("domains/large-language-models/", "llms"),
    ("domains/generative-ai/", "generative-ai"),
    ("domains/mlops-deployment/", "mlops"),
    ("domains/time-series/", "data"),
    ("data/", "data"),
    ("notebooks/", "notebooks"),
    ("tools/", "tools"),
    ("infrastructure/", "infrastructure"),
]

IGNORES_FILE = ROOT / "tools" / "category_audit_ignores.txt"

def load_ignores() -> List[Tuple[re.Pattern, re.Pattern, re.Pattern]]:
    patterns: List[Tuple[re.Pattern, re.Pattern, re.Pattern]] = []
    if not IGNORES_FILE.exists():
        return patterns
    for line in IGNORES_FILE.read_text(encoding="utf-8", errors="ignore").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        # format: path_regex | text_regex | target_regex
        parts = [p.strip() for p in line.split("|")]
        if len(parts) != 3:
            continue
        try:
            patterns.append((re.compile(parts[0]), re.compile(parts[1]), re.compile(parts[2])))
        except Exception:
            continue
    return patterns

SUPPRESSIONS = load_ignores()

def is_suppressed(rel_path: str, text: str, target: str) -> bool:
    for p_pat, t_pat, trg_pat in SUPPRESSIONS:
        if p_pat.search(rel_path) and t_pat.search(text) and trg_pat.search(target):
            return True
    return False


def detect_keywords(text: str) -> List[str]:
    """Detect category keywords using whole-word token matching to reduce false positives."""
    text_l = text.lower()
    tokens = set(re.findall(r"[a-z0-9]+", text_l))
    hits: List[str] = []
    for cat, kws in CATEGORY_KEYWORDS.items():
        if any(kw in tokens for kw in kws):
            hits.append(cat)
    return hits


def current_context_from_path(path: Path) -> Optional[str]:
    rel = str(path.relative_to(ROOT)).replace("\\", "/")
    for prefix, cat in FOLDER_CATEGORY_HINTS:
        if rel.startswith(prefix):
            return cat
    return None


def audit_file(md_path: Path, include_sections: Optional[List[str]] = None) -> List[Tuple[int, str, str, str, List[str]]]:
    """Return list of (line, link_text, target, section, suggested_categories)."""
    results: List[Tuple[int, str, str, str, List[str]]] = []
    section = ""
    in_code = False
    path_ctx = current_context_from_path(md_path)

    GENERIC_SECTIONS = {
        # common templates
        "examples", "presentations", "table of contents", "related", "start here",
        "quick links", "core topics", "specialized areas", "reference materials",
        "at a glance", "deep dive", "what’s new", "legacy content (full index)",
        # portal headings
        "python", "java & jvm", "other languages",
        "ethics & governance", "data & analytics", "learning resources",
        "tools & infrastructure", "mathematical foundations",
        "automation & mlops", "miscellaneous", "guides & tutorials", "courses & competitions",
        # topical groups
        "development environments", "data analysis tools", "machine learning frameworks",
        "cloud platforms", "specialized hardware", "automation tools", "deployment & mlops",
        # common section labels in example/docs pages
        "resources", "additional resources", "scripts provided:", "source location",
        "linux / macos (docker environment)", "linux / macos (local environment)",
        # footers/meta
        "contributing", "sponsoring", "disclaimer"
    }
    try:
        with md_path.open("r", encoding="utf-8", errors="ignore") as f:
            for lineno, line in enumerate(f, start=1):
                if CODE_FENCE.match(line):
                    in_code = not in_code
                    continue
                if in_code:
                    continue
                m = HEADING_PATTERN.match(line)
                if m:
                    section = m.group(2)
                    continue
                for lm in LINK_PATTERN.finditer(line):
                    text = lm.group(1)
                    target = lm.group(2)
                    # skip images and external
                    if text.strip().startswith("!"):
                        continue
                    if re.match(r"^[a-z]+://", target):
                        continue
                    # derive likely categories based on text and target
                    hits = set(detect_keywords(text) + detect_keywords(target))
                    # ignore if empty or matches path context or generic sections
                    if section and section.strip().lower() in GENERIC_SECTIONS:
                        continue
                    if include_sections:
                        sec_norm = (section or "").strip().lower()
                        if sec_norm not in [s.strip().lower() for s in include_sections]:
                            continue
                    sec_hits = set(detect_keywords(section))
                    if not hits:
                        continue
                    if path_ctx and path_ctx in hits:
                        continue
                    if hits & sec_hits:
                        continue
                    rel_path = str(md_path.relative_to(ROOT)).replace("\\", "/")
                    if is_suppressed(rel_path, text.strip(), target.strip()):
                        continue
                    results.append((lineno, text.strip(), target.strip(), section.strip(), sorted(hits)))
    except Exception:
        pass
    return results


def main() -> None:
    parser = argparse.ArgumentParser(description="Audit link categorization")
    parser.add_argument("--include-path", help="Regex to include file paths", default=None)
    parser.add_argument("--include-sections", help="Comma-separated section names to include", default=None)
    parser.add_argument("--output", help="Output report path", default=str(ROOT / "tools" / "category_audit.md"))
    args = parser.parse_args()

    include_path_re = re.compile(args.include_path) if args.include_path else None
    include_sections = [s.strip() for s in args.include_sections.split(",")] if args.include_sections else None
    report_lines: List[str] = []
    report_lines.append("# Link Categorization Audit\n")
    # Status header persisted across regenerations
    # (dynamic findings count is added below after computing total)
    report_lines.append("\nStatus: In progress\n")
    report_lines.append("\nThis report flags links whose keywords suggest different categories than the current section/folder context.\n")
    total = 0
    for md in sorted(MD_FILES):
        if include_path_re and not include_path_re.search(str(md)):
            continue
        findings = audit_file(md, include_sections=include_sections)
        if not findings:
            continue
        total += len(findings)
        rel = md.relative_to(ROOT)
        report_lines.append(f"\n## {rel}\n")
        for lineno, text, target, section, hits in findings:
            hits_str = ", ".join(hits)
            report_lines.append(f"- L{lineno}: [{text}]({target}) — section: '{section or '-'}' — suggested: {hits_str}")
    # Insert a brief progress section with dynamic findings count
    progress_section = [
        "\n### Progress\n",
        f"- Current findings: {total}\n",
    ]
    # Insert after the title and status (i.e., at index 3)
    report_lines[3:3] = progress_section

    report_lines.append(f"\n\nTotal flagged links: {total}\n")

    out = Path(args.output)
    out.write_text("\n".join(report_lines), encoding="utf-8")
    print(f"Wrote report with {total} findings to {out}")


if __name__ == "__main__":
    main()
