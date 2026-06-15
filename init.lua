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
    paramtype2 = "facedir",
    on_place = function(itemstack, placer, pointed_thing)
        local node_under = minetest.get_node_or_nil(pointed_thing.under)
        if not node_under then
            return itemstack
        end
        
        -- Get the direction the player is facing
        local dir = placer:get_look_dir()
        local yaw = math.deg(math.atan2(dir.x, -dir.z))
        
        -- Only allow north/south orientation (round side faces north or south)
        -- This means the flat sides face east/west
        local facedir = 0
        if yaw >= -45 and yaw < 45 then
            facedir = 0  -- North
        elseif yaw >= 135 or yaw < -135 then
            facedir = 2  -- South
        else
            -- For east/west viewing angles, still place in north/south orientation
            -- The round top will be perpendicular to player view
            if yaw >= 45 and yaw < 135 then
                facedir = 0  -- Place as north when looking east
            else
                facedir = 2  -- Place as south when looking west
            end
        end
        
        local pos = pointed_thing.above
        local node = {name = "berlin_wall:grenzmauer_top", param2 = facedir}
        
        if minetest.setting_getbool("creative_mode") then
            minetest.set_node(pos, node)
        else
            minetest.set_node(pos, node)
            itemstack:take_item(1)
        end
        
        return itemstack
    end,
})

-- Standard Wall Block (normal stone block on all sides)
minetest.register_node("berlin_wall:wall_block", {
    description = "Berlin Wall Block",
    tiles = {"wall-block-front-and-back.png"},
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = stone_sounds,
})
