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
    stack_max = 99,
})

-- Fence Site Block (for tower tops)
minetest.register_node("berlin_wall:fence_site", {
    description = "Fence Site",
    tiles = {"fence-site.png"},
    is_ground_content = false,
    groups = {cracky = 3, fence = 1},
    sounds = stone_sounds,
    use_texture_alpha = "clip",
    stack_max = 99,
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
        
        -- Normalize yaw to 0-360 range
        if yaw < 0 then
            yaw = yaw + 360
        end
        
        -- Restrict to 2 horizontal directions only (N/S or E/W)
        -- If player faces roughly N/S (yaw < 45 or > 315, or between 135-225), place N/S (facedir 0 or 2)
        -- If player faces roughly E/W (yaw between 45-135 or 225-315), place E/W (facedir 1 or 3)
        local facedir
        if (yaw >= 315 or yaw < 45) or (yaw >= 135 and yaw < 225) then
            -- North/South direction
            if yaw >= 315 or yaw < 45 then
                facedir = 0  -- North
            else
                facedir = 2  -- South
            end
        else
            -- East/West direction
            if yaw >= 45 and yaw < 135 then
                facedir = 1  -- East
            else
                facedir = 3  -- West
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
    on_rotate = function(pos, node, user, mode)
        local current_param2 = node.param2
        local dir = user:get_look_dir()
        local yaw = math.deg(math.atan2(dir.x, -dir.z))
        
        -- Normalize yaw to 0-360 range
        if yaw < 0 then
            yaw = yaw + 360
        end
        
        -- Determine which of the 2 allowed orientations to use based on player facing
        local new_facedir
        if (yaw >= 315 or yaw < 45) or (yaw >= 135 and yaw < 225) then
            -- Player facing N/S - use N/S orientation
            -- Keep the closest N/S orientation (0 or 2)
            if current_param2 == 0 or current_param2 == 2 then
                new_facedir = current_param2  -- Already N/S, keep it
            elseif yaw >= 315 or yaw < 45 then
                new_facedir = 0  -- Switch to North
            else
                new_facedir = 2  -- Switch to South
            end
        else
            -- Player facing E/W - use E/W orientation
            -- Keep the closest E/W orientation (1 or 3)
            if current_param2 == 1 or current_param2 == 3 then
                new_facedir = current_param2  -- Already E/W, keep it
            elseif yaw >= 45 and yaw < 135 then
                new_facedir = 1  -- Switch to East
            else
                new_facedir = 3  -- Switch to West
            end
        end
        
        node.param2 = new_facedir
        minetest.set_node(pos, node)
        return true
    end,
})

-- Standard Wall Block (normal stone block on all sides)
minetest.register_node("berlin_wall:wall_block", {
    description = "Berlin Wall Block",
    tiles = {"wall-block-front-and-back.png"},
    is_ground_content = false,
    groups = {cracky = 3},
    sounds = stone_sounds,
    stack_max = 99,
})
