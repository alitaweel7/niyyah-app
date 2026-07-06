#!/usr/bin/env python3
"""
Generate app icons for Aya Unlock.

Creates:
  - assets/images/app_icon.png (1024x1024, full icon with background)
  - assets/images/app_icon_foreground.png (512x512, transparent background)

Design: Stylized open book (Quran) with a subtle crescent,
        using geometric shapes on a deep charcoal background.
"""

import math
from PIL import Image, ImageDraw

# Brand colors
BG_COLOR = (0x1A, 0x1A, 0x2E, 255)       # #1A1A2E - deep charcoal
TEAL = (0x0D, 0x73, 0x77, 255)            # #0D7377 - teal accent
TEAL_LIGHT = (0x10, 0x9B, 0xA0, 255)      # lighter teal for highlights
TEAL_DARK = (0x0A, 0x55, 0x58, 255)       # darker teal for depth
GOLD = (0xC4, 0x9B, 0x5A, 255)            # warm gold accent
TRANSPARENT = (0, 0, 0, 0)


def draw_book_icon(draw, cx, cy, scale, with_bg=True):
    """Draw a stylized open book (Quran) icon."""

    # Book dimensions
    bw = int(180 * scale)   # half-width of each page
    bh = int(220 * scale)   # book height
    spine_w = int(8 * scale) # spine width

    # --- Left page ---
    left_page = [
        (cx - spine_w - bw, cy - bh // 2 + int(15 * scale)),  # top-left
        (cx - spine_w, cy - bh // 2),                           # top-right (spine, higher)
        (cx - spine_w, cy + bh // 2),                           # bottom-right (spine)
        (cx - spine_w - bw, cy + bh // 2 - int(15 * scale)),   # bottom-left
    ]
    draw.polygon(left_page, fill=TEAL)

    # --- Right page ---
    right_page = [
        (cx + spine_w + bw, cy - bh // 2 + int(15 * scale)),  # top-right
        (cx + spine_w, cy - bh // 2),                           # top-left (spine, higher)
        (cx + spine_w, cy + bh // 2),                           # bottom-left (spine)
        (cx + spine_w + bw, cy + bh // 2 - int(15 * scale)),   # bottom-right
    ]
    draw.polygon(right_page, fill=TEAL)

    # --- Spine / center fold ---
    spine = [
        (cx - spine_w, cy - bh // 2),
        (cx, cy - bh // 2 + int(12 * scale)),  # slight dip for open book feel
        (cx + spine_w, cy - bh // 2),
        (cx + spine_w, cy + bh // 2),
        (cx, cy + bh // 2 - int(12 * scale)),
        (cx - spine_w, cy + bh // 2),
    ]
    draw.polygon(spine, fill=TEAL_DARK)

    # --- Text lines on left page ---
    line_color = BG_COLOR if with_bg else (0x1A, 0x1A, 0x2E, 200)
    line_h = int(4 * scale)
    line_margin_x = int(25 * scale)
    line_start_y = cy - bh // 2 + int(55 * scale)
    line_spacing = int(28 * scale)

    for i in range(5):
        y = line_start_y + i * line_spacing
        # Left page lines (varying lengths for natural look)
        lx1 = cx - spine_w - bw + line_margin_x
        line_len = bw - 2 * line_margin_x - int((i % 3) * 18 * scale)
        lx2 = lx1 + line_len
        # Adjust y for page tilt
        tilt_offset = int(15 * scale * (1 - (y - (cy - bh//2)) / bh))
        draw.rounded_rectangle(
            [lx1, y + tilt_offset, lx2, y + tilt_offset + line_h],
            radius=int(2 * scale),
            fill=line_color
        )

        # Right page lines (mirrored)
        rx2 = cx + spine_w + bw - line_margin_x
        rx1 = rx2 - line_len
        draw.rounded_rectangle(
            [rx1, y + tilt_offset, rx2, y + tilt_offset + line_h],
            radius=int(2 * scale),
            fill=line_color
        )

    # --- Crescent moon above the book ---
    crescent_cy = cy - bh // 2 - int(60 * scale)
    crescent_r = int(35 * scale)
    offset = int(14 * scale)

    # Draw outer circle
    draw.ellipse(
        [cx - crescent_r, crescent_cy - crescent_r,
         cx + crescent_r, crescent_cy + crescent_r],
        fill=GOLD
    )
    # Cut out inner circle to make crescent
    cut_color = BG_COLOR if with_bg else TRANSPARENT
    draw.ellipse(
        [cx - crescent_r + offset, crescent_cy - crescent_r - int(4 * scale),
         cx + crescent_r + offset, crescent_cy + crescent_r - int(4 * scale)],
        fill=cut_color
    )

    # --- Small star next to crescent ---
    star_cx = cx + int(28 * scale)
    star_cy = crescent_cy - int(18 * scale)
    star_r = int(7 * scale)
    draw_star(draw, star_cx, star_cy, star_r, GOLD)

    # --- Subtle light rays from the book ---
    draw_light_rays(draw, cx, cy - bh // 2 + int(20 * scale), scale, TEAL_LIGHT)


def draw_star(draw, cx, cy, r, color):
    """Draw a simple 4-pointed star."""
    points = []
    for i in range(8):
        angle = math.pi / 4 * i - math.pi / 2
        radius = r if i % 2 == 0 else r * 0.4
        px = cx + radius * math.cos(angle)
        py = cy + radius * math.sin(angle)
        points.append((px, py))
    draw.polygon(points, fill=color)


def draw_light_rays(draw, cx, cy, scale, color):
    """Draw subtle upward light rays from the open book."""
    ray_color = (*color[:3], 60)  # very transparent

    num_rays = 5
    ray_spread = int(120 * scale)
    ray_length = int(80 * scale)
    ray_width = int(3 * scale)

    for i in range(num_rays):
        angle = math.pi + math.pi * (i / (num_rays - 1)) * 0.6 + math.pi * 0.2
        x_end = cx + ray_length * math.cos(angle)
        y_end = cy + ray_length * math.sin(angle)
        draw.line(
            [(cx, cy), (x_end, y_end)],
            fill=ray_color,
            width=ray_width
        )


def draw_rounded_rect_bg(draw, x1, y1, x2, y2, radius, color):
    """Draw a rounded rectangle background."""
    draw.rounded_rectangle([x1, y1, x2, y2], radius=radius, fill=color)


def generate_full_icon(path, size=1024):
    """Generate the full app icon with background."""
    img = Image.new('RGBA', (size, size), BG_COLOR)
    draw = ImageDraw.Draw(img, 'RGBA')

    # Rounded corners for iOS-style icon (the system will mask it, but looks nice in assets)
    # Draw rounded rect background
    corner_r = int(size * 0.22)
    draw.rounded_rectangle(
        [0, 0, size - 1, size - 1],
        radius=corner_r,
        fill=BG_COLOR
    )

    # Draw the book icon centered
    cx = size // 2
    cy = size // 2 + int(size * 0.04)  # slightly lower to account for crescent above
    scale = size / 1024.0

    draw_book_icon(draw, cx, cy, scale, with_bg=True)

    img.save(path, 'PNG')
    print(f"Created {path} ({size}x{size})")


def generate_foreground_icon(path, size=512):
    """Generate the foreground icon with transparent background for adaptive icons."""
    img = Image.new('RGBA', (size, size), TRANSPARENT)
    draw = ImageDraw.Draw(img, 'RGBA')

    # Android adaptive icons have a safe zone of 66% of the icon
    # So we scale down the content to fit within that zone
    cx = size // 2
    cy = size // 2 + int(size * 0.04)
    scale = (size / 1024.0) * 0.75  # scale down for safe zone

    draw_book_icon(draw, cx, cy, scale, with_bg=False)

    img.save(path, 'PNG')
    print(f"Created {path} ({size}x{size})")


if __name__ == '__main__':
    import os

    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    images_dir = os.path.join(base_dir, 'assets', 'images')
    os.makedirs(images_dir, exist_ok=True)

    icon_path = os.path.join(images_dir, 'app_icon.png')
    fg_path = os.path.join(images_dir, 'app_icon_foreground.png')

    generate_full_icon(icon_path, 1024)
    generate_foreground_icon(fg_path, 512)

    print("\nDone! Icons generated successfully.")
