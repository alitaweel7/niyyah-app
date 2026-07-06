#!/usr/bin/env python3
"""
Generate Islamic decorative PNG assets for Niyyah.

Creates ornate Ottoman/Mughal-inspired manuscript decorations using Pillow.
All assets are drawn at 2x resolution and scaled down with LANCZOS for crisp rendering.
"""

import math
import os
import random

from PIL import Image, ImageDraw, ImageFilter

# ── Output directory ──────────────────────────────────────────────────────────
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
OUTPUT_DIR = os.path.join(PROJECT_DIR, "assets", "images")
os.makedirs(OUTPUT_DIR, exist_ok=True)

# ── Color palette ─────────────────────────────────────────────────────────────
GOLD = (203, 191, 163)          # #CBBFA3
GOLD_LIGHT = (217, 207, 186)    # #D9CFBA
OLIVE = (107, 125, 92)          # #6B7D5C
OLIVE_DARK = (79, 93, 69)       # #4F5D45
ROSE = (155, 107, 107)          # #9B6B6B
ROSE_DARK = (125, 79, 79)       # #7D4F4F
CREAM = (245, 240, 230)         # #F5F0E6
CREAM_DARK = (235, 228, 215)    # #EBE4D7


# ── Drawing helpers ───────────────────────────────────────────────────────────

def rgba(color, alpha):
    """Convert RGB tuple + alpha (0-255) to RGBA."""
    return (*color, alpha)


def draw_ellipse_rotated(draw, cx, cy, rx, ry, angle_deg, fill=None, outline=None, width=1):
    """Draw a rotated ellipse by creating a temp image and pasting."""
    # Create a small image for the ellipse
    size = int(max(rx, ry) * 2.5) + 4
    tmp = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    tmp_draw = ImageDraw.Draw(tmp)
    center = size // 2
    tmp_draw.ellipse(
        [center - rx, center - ry, center + rx, center + ry],
        fill=fill, outline=outline, width=width
    )
    tmp = tmp.rotate(-angle_deg, resample=Image.BICUBIC, expand=False)
    return tmp, (int(cx - size // 2), int(cy - size // 2))


def draw_rose(draw, img, cx, cy, size, rose_color=ROSE, rose_dark=ROSE_DARK, leaf_color=OLIVE):
    """Draw a stylized multi-petal rose at given position."""
    s = size
    # Outer petals (5 large)
    for i in range(5):
        angle = i * 72 - 90
        rad = math.radians(angle)
        px = cx + s * 0.3 * math.cos(rad)
        py = cy + s * 0.3 * math.sin(rad)
        tmp, pos = draw_ellipse_rotated(
            draw, px, py, int(s * 0.38), int(s * 0.22), angle + 20,
            fill=rgba(rose_color, 180)
        )
        img.alpha_composite(tmp, pos)

    # Inner petals (5 smaller, rotated)
    for i in range(5):
        angle = i * 72 - 54
        rad = math.radians(angle)
        px = cx + s * 0.15 * math.cos(rad)
        py = cy + s * 0.15 * math.sin(rad)
        tmp, pos = draw_ellipse_rotated(
            draw, px, py, int(s * 0.25), int(s * 0.15), angle + 10,
            fill=rgba(rose_dark, 200)
        )
        img.alpha_composite(tmp, pos)

    # Center dot
    r = int(s * 0.08)
    draw.ellipse([cx - r, cy - r, cx + r, cy + r], fill=rgba(GOLD, 220))


def draw_leaf(draw, img, cx, cy, size, angle_deg, color=OLIVE):
    """Draw a small leaf shape (elongated ellipse with pointed tip)."""
    s = size
    tmp, pos = draw_ellipse_rotated(
        draw, cx, cy, int(s * 0.45), int(s * 0.18), angle_deg,
        fill=rgba(color, 170)
    )
    img.alpha_composite(tmp, pos)


def draw_vine_segment(draw, x1, y1, x2, y2, color=GOLD, alpha=180, width=2):
    """Draw a vine line between two points."""
    draw.line([(x1, y1), (x2, y2)], fill=rgba(color, alpha), width=width)


def draw_dot(draw, x, y, r, color=GOLD, alpha=160):
    """Draw a small accent dot."""
    draw.ellipse([x - r, y - r, x + r, y + r], fill=rgba(color, alpha))


def draw_curved_vine(draw, points, color=GOLD, alpha=180, width=2):
    """Draw a smooth curve through a list of points using line segments."""
    for i in range(len(points) - 1):
        draw.line([points[i], points[i + 1]], fill=rgba(color, alpha), width=width)


def bezier_points(p0, p1, p2, steps=20):
    """Generate quadratic bezier curve points."""
    pts = []
    for t_i in range(steps + 1):
        t = t_i / steps
        x = (1 - t) ** 2 * p0[0] + 2 * (1 - t) * t * p1[0] + t ** 2 * p2[0]
        y = (1 - t) ** 2 * p0[1] + 2 * (1 - t) * t * p1[1] + t ** 2 * p2[1]
        pts.append((int(x), int(y)))
    return pts


# ── Asset 1: border_corner.png (400x400, transparent) ────────────────────────

def generate_border_corner():
    """Ornate L-shaped corner decoration with rose, vines, and leaves."""
    W, H = 800, 800  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    margin = 40
    thickness = 6
    inner_offset = 20

    # Outer L-bracket lines
    # Vertical arm (left side, top to bottom)
    draw.line([(margin, margin), (margin, H - margin)], fill=rgba(GOLD, 200), width=thickness)
    # Horizontal arm (top side, left to right)
    draw.line([(margin, margin), (W - margin, margin)], fill=rgba(GOLD, 200), width=thickness)

    # Inner L-bracket lines
    m2 = margin + inner_offset
    draw.line([(m2, m2), (m2, H - margin - 60)], fill=rgba(GOLD, 140), width=3)
    draw.line([(m2, m2), (W - margin - 60, m2)], fill=rgba(GOLD, 140), width=3)

    # Decorative end caps (small circles at line ends)
    for pos in [(margin, H - margin), (W - margin, margin)]:
        draw_dot(draw, pos[0], pos[1], 8, GOLD, 200)
    for pos in [(m2, H - margin - 60), (W - margin - 60, m2)]:
        draw_dot(draw, pos[0], pos[1], 5, GOLD, 140)

    # Corner rose at intersection
    draw_rose(draw, img, margin + 10, margin + 10, 80, ROSE, ROSE_DARK, OLIVE)

    # Vine along vertical arm
    vine_x = margin + inner_offset // 2 + 5
    for i in range(5):
        y_pos = 160 + i * 110
        # Vine curve
        pts = bezier_points(
            (vine_x, y_pos - 30),
            (vine_x + 30 * (1 if i % 2 == 0 else -1), y_pos),
            (vine_x, y_pos + 30),
            steps=15
        )
        draw_curved_vine(draw, pts, GOLD, 150, 2)
        # Leaf
        leaf_side = 1 if i % 2 == 0 else -1
        draw_leaf(draw, img, vine_x + 25 * leaf_side, y_pos, 30, 45 * leaf_side, OLIVE)
        # Dot accent
        draw_dot(draw, vine_x - 10 * leaf_side, y_pos + 15, 3, GOLD, 130)

    # Vine along horizontal arm
    vine_y = margin + inner_offset // 2 + 5
    for i in range(5):
        x_pos = 160 + i * 110
        pts = bezier_points(
            (x_pos - 30, vine_y),
            (x_pos, vine_y + 30 * (1 if i % 2 == 0 else -1)),
            (x_pos + 30, vine_y),
            steps=15
        )
        draw_curved_vine(draw, pts, GOLD, 150, 2)
        leaf_side = 1 if i % 2 == 0 else -1
        draw_leaf(draw, img, x_pos, vine_y + 25 * leaf_side, 30, 90 + 45 * leaf_side, OLIVE)
        draw_dot(draw, x_pos + 15, vine_y - 10 * leaf_side, 3, GOLD, 130)

    # Small buds at vine ends
    for i in range(3):
        y = 140 + i * 200
        draw_dot(draw, vine_x + 8, y, 4, ROSE, 140)
        x = 140 + i * 200
        draw_dot(draw, x, vine_y + 8, 4, ROSE, 140)

    # Additional scrollwork near corner
    scroll_pts = bezier_points((100, 100), (130, 70), (160, 100), steps=12)
    draw_curved_vine(draw, scroll_pts, GOLD, 120, 2)
    scroll_pts2 = bezier_points((100, 100), (70, 130), (100, 160), steps=12)
    draw_curved_vine(draw, scroll_pts2, GOLD, 120, 2)

    # Scale down to 400x400
    img = img.resize((400, 400), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "border_corner.png"), "PNG", optimize=True)
    print("  -> border_corner.png")


# ── Asset 2: border_side_top.png (800x120, transparent) ──────────────────────

def generate_border_side_top():
    """Horizontal border with repeating floral motifs and central medallion."""
    W, H = 1600, 240  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    cy = H // 2

    # Thin outer lines top and bottom
    draw.line([(40, 30), (W - 40, 30)], fill=rgba(GOLD, 160), width=2)
    draw.line([(40, H - 30), (W - 40, H - 30)], fill=rgba(GOLD, 160), width=2)

    # Inner lines
    draw.line([(60, 50), (W - 60, 50)], fill=rgba(GOLD, 100), width=1)
    draw.line([(60, H - 50), (W - 60, H - 50)], fill=rgba(GOLD, 100), width=1)

    # Central vine
    vine_pts = []
    for x in range(60, W - 60, 4):
        wave = math.sin(x * 0.02) * 20
        vine_pts.append((x, cy + int(wave)))
    draw_curved_vine(draw, vine_pts, GOLD, 130, 2)

    # Small floral motifs along the vine
    for i in range(12):
        x = 100 + i * (W - 200) // 11
        wave = math.sin(x * 0.02) * 20
        y = cy + int(wave)
        if i == 5 or i == 6:
            continue  # Skip center area for medallion
        # Small flower
        for j in range(5):
            angle = j * 72 - 90
            rad = math.radians(angle)
            px = x + 12 * math.cos(rad)
            py = y + 12 * math.sin(rad)
            draw_dot(draw, int(px), int(py), 4, ROSE, 150)
        draw_dot(draw, x, y, 3, GOLD, 180)
        # Leaves
        draw_leaf(draw, img, x - 18, y, 18, -30, OLIVE)
        draw_leaf(draw, img, x + 18, y, 18, 30, OLIVE)

    # Central medallion
    mcx = W // 2
    # Outer circle
    r = 50
    draw.ellipse([mcx - r, cy - r, mcx + r, cy + r], outline=rgba(GOLD, 200), width=3)
    r2 = 40
    draw.ellipse([mcx - r2, cy - r2, mcx + r2, cy + r2], outline=rgba(GOLD, 140), width=2)
    # Central rose
    draw_rose(draw, img, mcx, cy, 55, ROSE, ROSE_DARK, OLIVE)

    # Dot accents along outer lines
    for i in range(20):
        x = 80 + i * (W - 160) // 19
        draw_dot(draw, x, 30, 2, GOLD, 100)
        draw_dot(draw, x, H - 30, 2, GOLD, 100)

    img = img.resize((800, 120), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "border_side_top.png"), "PNG", optimize=True)
    print("  -> border_side_top.png")


# ── Asset 3: divider_floral.png (600x80, transparent) ────────────────────────

def generate_divider_floral():
    """Horizontal divider with central rose and extending vines."""
    W, H = 1200, 160  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    cx, cy = W // 2, H // 2

    # Central rose
    draw_rose(draw, img, cx, cy, 60, ROSE, ROSE_DARK, OLIVE)

    # Extending vines left
    for side in [-1, 1]:
        pts = []
        for i in range(60):
            x = cx + side * (50 + i * 7)
            wave = math.sin(i * 0.3) * 12
            pts.append((x, cy + int(wave)))
        draw_curved_vine(draw, pts, GOLD, 150, 2)

        # Small buds and leaves along vine
        for i in range(5):
            x = cx + side * (100 + i * 80)
            wave = math.sin((50 + i * 80 // 7) * 0.3) * 12
            y = cy + int(wave)
            # Small bud
            draw_dot(draw, x, y, 5, ROSE, 130)
            # Leaf
            draw_leaf(draw, img, x + side * 15, y - 8, 18, 30 * side, OLIVE)
            # Gold dot
            draw_dot(draw, x - side * 8, y + 10, 2, GOLD, 140)

    # Thin lines extending to edges
    draw.line([(40, cy), (cx - 60, cy)], fill=rgba(GOLD, 80), width=1)
    draw.line([(cx + 60, cy), (W - 40, cy)], fill=rgba(GOLD, 80), width=1)

    img = img.resize((600, 80), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "divider_floral.png"), "PNG", optimize=True)
    print("  -> divider_floral.png")


# ── Asset 4: header_illumination.png (800x200, transparent) ──────────────────

def generate_header_illumination():
    """Illuminated header panel with pointed arch and arabesque fill."""
    W, H = 1600, 400  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    margin_x = 60
    margin_y = 60
    arch_height = 50

    # Outer rectangle
    rect = [margin_x, margin_y + arch_height, W - margin_x, H - margin_y]
    draw.rectangle(rect, outline=rgba(GOLD, 200), width=4)

    # Inner rectangle
    inner_margin = 16
    inner_rect = [rect[0] + inner_margin, rect[1] + inner_margin,
                  rect[2] - inner_margin, rect[3] - inner_margin]
    draw.rectangle(inner_rect, outline=rgba(GOLD, 130), width=2)

    # Pointed arch/finial at top center
    arch_cx = W // 2
    arch_base_y = margin_y + arch_height
    arch_top_y = margin_y - 10
    arch_width = 120

    # Draw arch shape
    arch_pts = [
        (arch_cx - arch_width, arch_base_y),
        (arch_cx - arch_width // 2, arch_top_y + 20),
        (arch_cx, arch_top_y),
        (arch_cx + arch_width // 2, arch_top_y + 20),
        (arch_cx + arch_width, arch_base_y),
    ]
    # Draw as smooth bezier
    left_pts = bezier_points(arch_pts[0], arch_pts[1], arch_pts[2], 20)
    right_pts = bezier_points(arch_pts[2], arch_pts[3], arch_pts[4], 20)
    all_arch = left_pts + right_pts[1:]
    draw_curved_vine(draw, all_arch, GOLD, 200, 4)

    # Fill arch with background color semi-transparent
    # Small decorative element at arch top
    draw_dot(draw, arch_cx, arch_top_y - 5, 6, GOLD, 200)
    draw_dot(draw, arch_cx, arch_top_y - 5, 3, ROSE, 180)

    # Arabesque fill pattern inside the frame (dense small motifs)
    fill_left = inner_rect[0] + 10
    fill_top = inner_rect[1] + 10
    fill_right = inner_rect[2] - 10
    fill_bottom = inner_rect[3] - 10

    # Semi-transparent fill for text overlay area
    overlay = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    overlay_draw = ImageDraw.Draw(overlay)
    overlay_draw.rectangle(
        [fill_left, fill_top, fill_right, fill_bottom],
        fill=rgba(CREAM, 40)
    )
    img.alpha_composite(overlay)

    # Small repeating arabesque motifs
    spacing = 40
    for y in range(fill_top, fill_bottom, spacing):
        for x in range(fill_left, fill_right, spacing):
            # Tiny 4-petal flower
            for angle in [0, 90, 180, 270]:
                rad = math.radians(angle)
                px = x + 6 * math.cos(rad)
                py = y + 6 * math.sin(rad)
                draw_dot(draw, int(px), int(py), 2, GOLD, 60)
            draw_dot(draw, x, y, 1, OLIVE, 50)

    # Corner ornaments
    for corner_x, corner_y in [(rect[0], rect[1]), (rect[2], rect[1]),
                                 (rect[0], rect[3]), (rect[2], rect[3])]:
        draw_dot(draw, corner_x, corner_y, 8, GOLD, 180)
        draw_dot(draw, corner_x, corner_y, 4, ROSE, 150)

    # Side ornaments (small roses on left and right edges)
    mid_y = (rect[1] + rect[3]) // 2
    for sx in [rect[0], rect[2]]:
        draw_rose(draw, img, sx, mid_y, 30, ROSE, ROSE_DARK, OLIVE)

    img = img.resize((800, 200), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "header_illumination.png"), "PNG", optimize=True)
    print("  -> header_illumination.png")


# ── Asset 5: rose_accent.png (120x120, transparent) ──────────────────────────

def generate_rose_accent():
    """Single stylized Islamic rose/tulip with stem and leaves."""
    W, H = 240, 240  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    cx, cy = W // 2, W // 2 - 20

    # Main rose
    draw_rose(draw, img, cx, cy, 70, ROSE, ROSE_DARK, OLIVE)

    # Stem
    draw.line([(cx, cy + 35), (cx, H - 20)], fill=rgba(OLIVE, 180), width=3)

    # Leaves on stem
    draw_leaf(draw, img, cx - 22, cy + 60, 28, -40, OLIVE)
    draw_leaf(draw, img, cx + 22, cy + 70, 28, 40, OLIVE)

    # Small leaf at base
    draw_leaf(draw, img, cx - 12, H - 30, 16, -60, OLIVE_DARK)
    draw_leaf(draw, img, cx + 12, H - 30, 16, 60, OLIVE_DARK)

    img = img.resize((120, 120), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "rose_accent.png"), "PNG", optimize=True)
    print("  -> rose_accent.png")


# ── Asset 6: vine_border_vertical.png (80x800, transparent) ──────────────────

def generate_vine_border_vertical():
    """Vertical vine border with alternating flowers and leaves."""
    W, H = 160, 1600  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    cx = W // 2

    # Main vine (sinusoidal)
    vine_pts = []
    for y in range(20, H - 20, 3):
        wave = math.sin(y * 0.015) * 20
        vine_pts.append((cx + int(wave), y))
    draw_curved_vine(draw, vine_pts, GOLD, 150, 2)

    # Flowers and leaves at intervals
    for i in range(8):
        y = 80 + i * (H - 160) // 7
        wave = math.sin(y * 0.015) * 20
        x = cx + int(wave)

        if i % 2 == 0:
            # Small rose
            draw_rose(draw, img, x, y, 25, ROSE, ROSE_DARK, OLIVE)
        else:
            # Small bud cluster
            draw_dot(draw, x, y, 5, ROSE, 150)
            draw_dot(draw, x - 6, y - 6, 3, ROSE_DARK, 130)
            draw_dot(draw, x + 6, y - 6, 3, ROSE_DARK, 130)

        # Leaves
        side = 1 if i % 2 == 0 else -1
        draw_leaf(draw, img, x + side * 25, y + 10, 22, 50 * side, OLIVE)
        draw_leaf(draw, img, x - side * 20, y - 10, 18, -40 * side, OLIVE_DARK)

        # Dot accents
        draw_dot(draw, x + side * 10, y + 25, 2, GOLD, 120)

    img = img.resize((80, 800), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "vine_border_vertical.png"), "PNG", optimize=True)
    print("  -> vine_border_vertical.png")


# ── Asset 7: gold_speckle_overlay.png (400x400, transparent, tileable) ───────

def generate_gold_speckle():
    """Tileable texture of scattered gold dots at varying sizes and opacities."""
    W, H = 800, 800  # 2x
    img = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    random.seed(42)  # Reproducible

    for _ in range(200):
        x = random.randint(0, W - 1)
        y = random.randint(0, H - 1)
        r = random.choice([1, 1, 1, 2, 2, 3])
        alpha = random.randint(20, 80)
        color = random.choice([GOLD, GOLD_LIGHT, GOLD])
        draw_dot(draw, x, y, r, color, alpha)

    # For tileability, mirror some dots near edges
    edge_margin = 30
    for _ in range(30):
        x = random.randint(0, edge_margin)
        y = random.randint(0, H - 1)
        r = random.choice([1, 1, 2])
        alpha = random.randint(20, 60)
        draw_dot(draw, x, y, r, GOLD, alpha)
        draw_dot(draw, W - edge_margin + x, y, r, GOLD, alpha)

    for _ in range(30):
        x = random.randint(0, W - 1)
        y = random.randint(0, edge_margin)
        r = random.choice([1, 1, 2])
        alpha = random.randint(20, 60)
        draw_dot(draw, x, y, r, GOLD, alpha)
        draw_dot(draw, x, H - edge_margin + y, r, GOLD, alpha)

    img = img.resize((400, 400), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "gold_speckle_overlay.png"), "PNG", optimize=True)
    print("  -> gold_speckle_overlay.png")


# ── Asset 8: parchment_texture.png (400x400, tileable) ───────────────────────

def generate_parchment_texture():
    """Tileable warm parchment background with subtle noise."""
    W, H = 800, 800  # 2x
    img = Image.new("RGBA", (W, H), (*CREAM, 255))

    random.seed(123)  # Reproducible

    # Add subtle noise
    pixels = img.load()
    for y in range(H):
        for x in range(W):
            noise = random.randint(-8, 8)
            r = min(255, max(0, CREAM[0] + noise))
            g = min(255, max(0, CREAM[1] + noise + random.randint(-3, 3)))
            b = min(255, max(0, CREAM[2] + noise + random.randint(-2, 2)))
            pixels[x, y] = (r, g, b, 255)

    # Slight warm gradient overlay (very subtle)
    overlay = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    overlay_pixels = overlay.load()
    for y in range(H):
        for x in range(W):
            # Very subtle radial darkening near edges for depth
            dx = abs(x - W // 2) / (W // 2)
            dy = abs(y - H // 2) / (H // 2)
            dist = min(1.0, (dx * dx + dy * dy) ** 0.5)
            darken = int(dist * 6)
            overlay_pixels[x, y] = (0, 0, 0, darken)

    img.alpha_composite(overlay)

    # Light gaussian blur for smoothness
    img = img.filter(ImageFilter.GaussianBlur(radius=0.8))

    img = img.resize((400, 400), Image.LANCZOS)
    img.save(os.path.join(OUTPUT_DIR, "parchment_texture.png"), "PNG", optimize=True)
    print("  -> parchment_texture.png")


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    print(f"Generating Islamic decorative assets into {OUTPUT_DIR}")
    print()
    generate_border_corner()
    generate_border_side_top()
    generate_divider_floral()
    generate_header_illumination()
    generate_rose_accent()
    generate_vine_border_vertical()
    generate_gold_speckle()
    generate_parchment_texture()
    print()

    # Check file sizes
    total = 0
    for f in sorted(os.listdir(OUTPUT_DIR)):
        if f.endswith(".png") and f not in ("app_icon.png", "app_icon_foreground.png"):
            path = os.path.join(OUTPUT_DIR, f)
            size = os.path.getsize(path)
            total += size
            status = "OK" if size < 200 * 1024 else "WARNING: > 200KB"
            print(f"  {f}: {size // 1024}KB  [{status}]")

    print(f"\nTotal generated: {total // 1024}KB")
    print("Done!")


if __name__ == "__main__":
    main()
