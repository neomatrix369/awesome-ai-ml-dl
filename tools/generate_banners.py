#!/usr/bin/env python3
from PIL import Image, ImageDraw, ImageFont
from pathlib import Path

OUTPUT_DIR = Path(__file__).resolve().parents[1] / "assets" / "banners"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

SIZE = (1200, 280)  # slimmer for better page aesthetics
TEXT = (255, 255, 255)

# Per-banner style config: gradient colors and optional subtitle
BANNERS = {
    "portal-hero.png": {
        "title": "Awesome AI-ML-DL",
        "gradient": ((92, 70, 156), (29, 122, 214)),  # violet → blue
        "pattern_alpha": 22,
    },
    "reference-hero.png": {
        "title": "Reference",
        "gradient": ((2, 62, 138), (0, 119, 182)),  # deep blue → cyan-blue
        "pattern_alpha": 18,
    },
    "infrastructure-hero.png": {
        "title": "Infrastructure",
        "gradient": ((3, 102, 102), (0, 168, 150)),  # teal range
        "pattern_alpha": 18,
    },
    "domains-hero.png": {
        "title": "Domains",
        "gradient": ((0, 153, 255), (255, 79, 129)),  # blue → pink
        "pattern_alpha": 16,
    },
    "ai-agents-hero.png": {
        "title": "AI Agents",
        "gradient": ((94, 0, 255), (0, 204, 255)),  # violet → cyan
        "pattern_alpha": 22,
    },
    "nlp-hero.png": {
        "title": "Natural Language Processing",
        "gradient": ((255, 94, 58), (255, 149, 0)),  # orange range
        "pattern_alpha": 20,
    },
    "computer-vision-hero.png": {
        "title": "Computer Vision",
        "gradient": ((0, 180, 216), (0, 119, 182)),  # cyan → blue
        "pattern_alpha": 20,
    },
    "large-language-models-hero.png": {
        "title": "Large Language Models",
        "gradient": ((74, 0, 224), (29, 122, 214)),  # indigo → blue
        "pattern_alpha": 18,
    },
    "generative-ai-hero.png": {
        "title": "Generative AI",
        "gradient": ((255, 0, 128), (255, 102, 196)),  # magenta range
        "pattern_alpha": 22,
    },
    "mlops-deployment-hero.png": {
        "title": "MLOps & Deployment",
        "gradient": ((0, 148, 94), (34, 197, 94)),  # green range
        "pattern_alpha": 18,
    },
    "time-series-hero.png": {
        "title": "Time Series",
        "gradient": ((255, 140, 0), (255, 99, 71)),  # orange → tomato
        "pattern_alpha": 20,
    },
    "data-hero.png": {
        "title": "Data",
        "gradient": ((0, 119, 182), (0, 180, 216)),  # blue → cyan
        "pattern_alpha": 16,
    },
    "tools-hero.png": {
        "title": "Tools",
        "gradient": ((68, 68, 68), (136, 136, 136)),  # neutral gray gradient
        "pattern_alpha": 16,
    },
    "notebooks-hero.png": {
        "title": "Notebooks",
        "gradient": ((255, 204, 0), (255, 159, 28)),  # warm yellow range
        "pattern_alpha": 22,
    },
    "guides-hero.png": {
        "title": "Guides",
        "gradient": ((156, 39, 176), (233, 30, 99)),  # purple → pink
        "pattern_alpha": 20,
    },
    "courses-hero.png": {
        "title": "Courses",
        "gradient": ((33, 150, 243), (3, 169, 244)),  # blue range
        "pattern_alpha": 18,
    },
    "things-to-know-hero.png": {
        "title": "Things to Know",
        "gradient": ((76, 175, 80), (129, 199, 132)),  # green range
        "pattern_alpha": 20,
    },
    "study-notes-hero.png": {
        "title": "Study Notes",
        "gradient": ((255, 152, 0), (255, 193, 7)),  # amber range
        "pattern_alpha": 18,
    },
}


def load_font(size: int) -> ImageFont.FreeTypeFont:
    # Try common fonts; fallback to default if unavailable
    for name in [
        "Inter-Bold.ttf",
        "Inter-SemiBold.ttf",
        "DejaVuSans-Bold.ttf",
        "Arial Bold.ttf",
        "Arial.ttf",
        "Helvetica.ttc",
    ]:
        try:
            return ImageFont.truetype(name, size)
        except Exception:
            continue
    return ImageFont.load_default()

def lerp(a: int, b: int, t: float) -> int:
    return int(a + (b - a) * t)

def draw_linear_gradient(img: Image.Image, start_color, end_color, horizontal: bool = False) -> None:
    draw = ImageDraw.Draw(img)
    w, h = img.size
    steps = w if horizontal else h
    for i in range(steps):
        t = i / max(steps - 1, 1)
        r = lerp(start_color[0], end_color[0], t)
        g = lerp(start_color[1], end_color[1], t)
        b = lerp(start_color[2], end_color[2], t)
        if horizontal:
            draw.line([(i, 0), (i, h)], fill=(r, g, b))
        else:
            draw.line([(0, i), (w, i)], fill=(r, g, b))

def draw_subtle_pattern(img: Image.Image, alpha: int = 18) -> None:
    # Diagonal lines overlay with low alpha for texture
    overlay = Image.new("RGBA", img.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(overlay)
    w, h = img.size
    spacing = 24
    color = (255, 255, 255, alpha)
    for x in range(-h, w, spacing):
        d.line([(x, 0), (x + h, h)], fill=color, width=1)
    img.alpha_composite(overlay)


def draw_banner(filename: str, title: str, style: dict) -> None:
    # Create RGBA for compositing effects
    img = Image.new("RGBA", SIZE, (0, 0, 0, 0))
    # Background gradient
    start_color, end_color = (20, 24, 28), (20, 24, 28)
    # Will be overridden per-banner
    # Build base gradient layer
    base = Image.new("RGBA", SIZE, (0, 0, 0, 255))
    draw_linear_gradient(base, start_color, end_color, horizontal=False)

    # Overlay per-banner gradient
    g = Image.new("RGBA", SIZE, (0, 0, 0, 0))
    draw_linear_gradient(g, style["gradient"][0], style["gradient"][1], horizontal=False)

    # Combine base + gradient
    img = Image.alpha_composite(base, g)

    # Subtle diagonal pattern
    draw_subtle_pattern(img, alpha=style.get("pattern_alpha", 18))

    draw = ImageDraw.Draw(img)

    # Rounded border frame
    pad = 10
    radius = 20
    rect = [pad, pad, SIZE[0] - pad, SIZE[1] - pad]
    draw.rounded_rectangle(rect, radius=radius, outline=(255, 255, 255, 40), width=2)

    # Title text with stroke for readability
    base_font_size = 50 if len(title) <= 20 else 42 if len(title) <= 28 else 36
    font = load_font(base_font_size)
    bbox = draw.textbbox((0, 0), title, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]
    x = (SIZE[0] - text_w) // 2
    y = (SIZE[1] - text_h) // 2

    draw.text(
        (x, y),
        title,
        font=font,
        fill=TEXT,
        stroke_width=2,
        stroke_fill=(0, 0, 0, 120),
    )

    # Save as PNG
    img.convert("RGB").save(OUTPUT_DIR / filename, format="PNG", optimize=True)


def main() -> None:
    count = 0
    for filename, style in BANNERS.items():
        draw_banner(filename, style["title"], style)
        count += 1
    print(f"Generated {count} banners in {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
