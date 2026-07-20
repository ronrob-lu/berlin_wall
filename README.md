# Berlin Wall Mod for Luanti/Minetest

> [!IMPORTANT]
> ⚠️ **Development Note:** This mod is now part of the larger **[Enclave Mod](https://github.com/ronrob-lu/enclave)** project and is no longer developed as a standalone mod.
> 
> **Original Author:** [ronrob-lu](https://github.com/ronrob-lu) (2026)

> **Art Project Note:** This mod is intended primarily as an architectural reconstruction project to recreate historical architecture in Luanti/Minetest. It focuses on the historical accuracy of the Grenzmauer 75 design rather than combat gameplay mechanics.

![Berlin Wall Screenshot](screenshot-berlin-wall.png)

This mod adds blocks representing parts of the Berlin Wall, specifically the iconic **Grenzmauer 75** (Border Wall 75) generation.

---

## Features & Blocks Included

| Block / Item | Description | Light Level | Command to Give |
| :--- | :--- | :--- | :--- |
| **Search Light**<br>`berlin_wall:search_light` | A powerful wall-mounted or freestanding light source to illuminate your border posts. | 10 | `/giveme berlin_wall:search_light` |
| **Fence Site**<br>`berlin_wall:fence_site` | A mesh fence block designed for placement on tower tops or perimeter barriers. | None | `/giveme berlin_wall:fence_site` |
| **Grenzmauer 75 Top**<br>`berlin_wall:grenzmauer_top` | The wall cap fitted with a smooth, semi-circular concrete pipe to prevent climbers from gaining a foothold. Automatically aligns based on player rotation. | None | `/giveme berlin_wall:grenzmauer_top` |
| **Berlin Wall Block**<br>`berlin_wall:wall_block` | The standard solid wall block showing concrete/stone textures on all sides. | None | `/giveme berlin_wall:wall_block` |

---

## Mechanics & Placement

### Auto-Aligning Wall Caps (`grenzmauer_top`)
The top pipe elements are directional to ensure you can build clean, continuous wall sweeps. When you place a `grenzmauer_top` block:
- It automatically detects your orientation and aligns either **North/South** or **East/West**.
- You can adjust the direction using the **Screwdriver** tool or by looking in the desired direction when placing it.

---

## Installation

1. Download or copy this folder into your Luanti/Minetest `mods` directory (rename the folder to `berlin_wall`).
2. Enable the mod in your world's configuration or menu.
3. Launch your world and build!

---

## Requirements

- **Luanti** (formerly Minetest) 5.0.0 or newer.

---

## License & Credits

- **Code**: MIT License (Copyright (c) 2026 ronrob-lu) - see [LICENSE.md](LICENSE.md)
- **Graphics/Textures**: CC0 1.0 Universal (Public Domain) - see [LICENSE.md](LICENSE.md)
- **Design & Assets**: Created by [ronrob-lu](https://github.com/ronrob-lu).
