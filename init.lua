-- Berlin Wall Mod for Luanti/Minetest
-- Adds blocks representing parts of the Berlin Wall (Grenzmauer 75)

local modname = "berlin_wall"

-- Define stone sounds safely (compatible with all versions)
local stone_sounds = {
    footstep = {name = "default_node_footstep", gain = 0.5},
    dig = {name = "default_node_dig", gain = 0.6},
    dug = {name = "default_node_dug", gain = 0.8},
    place = {name = "default_node_place", gain = 1.0},
}

-- Search Light Block (emits light with light density 10)
minetest.register_node("berlin_wall:search_light", {
    description = "Search Light",
    tiles = {"search-light.png"},
    is_ground_content = false,
    light_source = 10,
    groups = {cracky = 3, not_in_creative_inventory = 0},
    sounds = stone_sounds,
})

-- Fence Site Block (for tower tops)
minetest.register_node("berlin_wall:fence_site", {
    description = "Fence Site",
    tiles = {"fence-site.png"},
    is_ground_content = false,
    groups = {cracky = 3, fence = 1},
    sounds = stone_sounds,
    use_texture_alpha = "clip",
})

-- Grenzmauer 75 Top Block (semi-circular concrete pipe top)
-- This block has different textures for sides vs front/back to represent the round top
minetest.register_node("berlin_wall:grenzmauer_top", {
    description = "Grenzmauer 75 Top (Round Pipe)",
    tiles = {
        "round-wall-top-sites.png",  -- top
        "round-wall-top-sites.png",  -- bottom
        "wall-block-side-with-round-flat.png",  -- side
        "wall-block-side-with-round-flat.png",  -- side
        "wall-block-front-and-back-with-round-flat.png",  -- front
        "wall-block-front-and-back-with-round-flat.png",  -- back
    },
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = stone_sounds,
    use_texture_alpha = "clip",
})

-- Standard Wall Block (normal stone block on all sides)
minetest.register_node("berlin_wall:wall_block", {
    description = "Berlin Wall Block",
    tiles = {"wall-block-front-and-back.png"},
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = stone_sounds,
})
