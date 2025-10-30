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


# Reuse a similar taxonomy as the internal link auditor, expanded a bit for external links
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


FOLDER_CATEGORY_HINTS: List[Tuple[str, str]] = [
    ("domains/ai-agents/", "agents"),
    ("natural-language-processing/", "nlp"),
    ("domains/nlp/", "nlp"),
    ("domains/computer-vision/", "computer-vision"),
    ("domains/large-language-models/", "llms"),
    ("domains/generative-ai/", "generative-ai"),
    ("domains/mlops-deployment/", "mlops"),
    ("domains/time-series/", "data"),
    ("examples/data/", "data"),
    ("examples/cloud-devops-infra/", "infrastructure"),
    ("examples/better-nlp/", "nlp"),
    ("data/", "data"),
    ("notebooks/", "notebooks"),
    ("tools/", "tools"),
    ("infrastructure/", "infrastructure"),
]


def detect_keywords(text: str) -> List[str]:
    text_l = (text or "").lower()
    tokens = set(re.findall(r"[a-z0-9\-]+", text_l))
    hits: List[str] = []
    for cat, kws in CATEGORY_KEYWORDS.items():
        if any(kw for kw in kws if any(kw == t or kw in t for t in tokens)):
            hits.append(cat)
    return hits


def current_context_from_path(path: Path) -> Optional[str]:
    rel = str(path.relative_to(ROOT)).replace("\\", "/")
    for prefix, cat in FOLDER_CATEGORY_HINTS:
        if rel.startswith(prefix):
            return cat
    return None


def audit_file(md_path: Path, include_sections: Optional[List[str]] = None) -> List[Tuple[int, str, str, str, List[str]]]:
    """Return list of (line, link_text, target, section, suggested_categories) for external links whose suggested
    category doesn't match file path context nor section keywords."""
    results: List[Tuple[int, str, str, str, List[str]]] = []
    section = ""
    in_code = False
    path_ctx = current_context_from_path(md_path)

    GENERIC_SECTIONS = {
        # high-level or navigational sections where mixed links are expected
        "examples", "presentations", "table of contents", "related", "start here",
        "quick links", "core topics", "specialized areas", "reference materials",
        "at a glance", "deep dive", "what’s new", "legacy content (full index)",
        # portal headings
        "python", "java & jvm", "other languages", "explore by domain", "awesome ai-ml-dl",
        "ethics & governance", "data & analytics", "learning resources", "cloud & devops",
        "tools & infrastructure", "mathematical foundations",
        "automation & mlops", "miscellaneous", "guides & tutorials", "courses & competitions",
    }

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
                text = lm.group(1).strip()
                target = lm.group(2).strip()
                if text.startswith("!"):
                    continue
                # Only consider external links here
                if not re.match(r"^[a-z]+://", target):
                    continue

                hits = set(detect_keywords(text) + detect_keywords(target))
                if not hits:
                    continue

                sec_norm = (section or "").strip().lower()
                if sec_norm and any(gs in sec_norm for gs in GENERIC_SECTIONS):
                    # allow mixed here
                    continue

                sec_hits = set(detect_keywords(section))

                # If file path context or section already matches, it's OK
                if path_ctx and path_ctx in hits:
                    continue
                if hits & sec_hits:
                    continue

                results.append((lineno, text, target, section.strip(), sorted(hits)))
    return results


def main() -> None:
    parser = argparse.ArgumentParser(description="Audit EXTERNAL link categorization across markdown files")
    parser.add_argument("--include-path", help="Regex to include file paths", default=None)
    parser.add_argument("--include-sections", help="Comma-separated section names to include", default=None)
    parser.add_argument("--output", help="Output report path", default=str(ROOT / "tools" / "external_category_audit.md"))
    args = parser.parse_args()

    include_path_re = re.compile(args.include_path) if args.include_path else None
    include_sections = [s.strip() for s in args.include_sections.split(",")] if args.include_sections else None

    report_lines: List[str] = []
    report_lines.append("# External Link Categorization Audit\n")
    report_lines.append("\nStatus: In progress\n")
    report_lines.append("\nThis report flags external links whose keywords suggest different categories than the current section/folder context.\n")

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

    progress_section = [
        "\n### Progress\n",
        f"- Current findings: {total}\n",
    ]
    report_lines[3:3] = progress_section

    report_lines.append(f"\n\nTotal flagged links: {total}\n")

    out = Path(args.output)
    out.write_text("\n".join(report_lines), encoding="utf-8")
    print(f"Wrote external audit report with {total} findings to {out}")


if __name__ == "__main__":
    main()
