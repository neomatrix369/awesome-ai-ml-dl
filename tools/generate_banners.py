#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
from pathlib import Path

OUTPUT_DIR = Path(__file__).resolve().parents[1] / "assets" / "banners"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

SIZE = (1200, 360)
BACKGROUND = (20, 24, 28)  # dark slate
ACCENT = (0, 163, 255)      # cyan accent
TEXT = (255, 255, 255)

BANNERS = [
    ("portal-hero.png", "Awesome AI-ML-DL"),
    ("reference-hero.png", "Reference"),
    ("infrastructure-hero.png", "Infrastructure"),
    ("domains-hero.png", "Domains"),
    ("ai-agents-hero.png", "AI Agents"),
    ("nlp-hero.png", "Natural Language Processing"),
    ("computer-vision-hero.png", "Computer Vision"),
    ("large-language-models-hero.png", "Large Language Models"),
    ("generative-ai-hero.png", "Generative AI"),
    ("mlops-deployment-hero.png", "MLOps & Deployment"),
    ("time-series-hero.png", "Time Series"),
    ("data-hero.png", "Data"),
    ("tools-hero.png", "Tools"),
    ("notebooks-hero.png", "Notebooks"),
]


def load_font(size: int) -> ImageFont.FreeTypeFont:
    # Try common fonts; fallback to default if unavailable
    for name in ["Inter-SemiBold.ttf", "Inter-Bold.ttf", "Arial.ttf", "Helvetica.ttc"]:
        try:
            return ImageFont.truetype(name, size)
        except Exception:
            continue
    return ImageFont.load_default()


def draw_banner(filename: str, title: str) -> None:
    img = Image.new("RGB", SIZE, BACKGROUND)
    draw = ImageDraw.Draw(img)

    # Accent strip
    strip_h = 12
    draw.rectangle([(0, 0), (SIZE[0], strip_h)], fill=ACCENT)

    # Title text
    base_font_size = 56 if len(title) <= 20 else 48 if len(title) <= 28 else 42
    font = load_font(base_font_size)
    # Measure text using modern API
    bbox = draw.textbbox((0, 0), title, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    x = (SIZE[0] - text_w) // 2
    y = (SIZE[1] - text_h) // 2

    # Soft shadow
    shadow_offset = 2
    draw.text((x + shadow_offset, y + shadow_offset), title, font=font, fill=(0, 0, 0))
    draw.text((x, y), title, font=font, fill=TEXT)

    img.save(OUTPUT_DIR / filename, format="PNG", optimize=True)


def main() -> None:
    for filename, title in BANNERS:
        draw_banner(filename, title)
    print(f"Generated {len(BANNERS)} banners in {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
