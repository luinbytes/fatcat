--[[
    @title
        Battlebit Remastered RCS
    @author
        lu. & JoshCantCode
    @description
        Battlebit Remastered Recoil Mitigation.
]]--
local modules = require 'modules'
local battlebitrcs = {
    input = modules.input,
    weapons = {
        --WEAPON = { Vertical recoil, First shot punch, Firerate }
        ACR = { 1.40, 1.00, 700 },
        AUG = { 1.20, 1.00, 500 },
        AK15 = { 1.60, 1.00, 540 },
        AK5C = { 1.40, 1.50, 600 },
        AK74 = { 1.50, 1.00, 670 },
        AS_VAL = { 1.50, 1.00, 800 },
        FAL = { 1.50, 1.00, 650 },
        FAMAS = { 1.00, 1.00, 900 },
        G36C = { 1.40, 1.00, 750 },
        GROZA = { 1.20, 3.00, 650 },
        HK419 = { 1.40, 1.00, 660 },
        HONEYBADGER = { 1.50, 1.00, 800 },
        M249 = { 1.10, 1.00, 700 },
        M4A1 = { 1.50, 1.00, 700 },
        MP5 = { 0.90, 1.00, 800 },
        MP7 = { 1.00, 1.00, 950 },
        P90 = { 0.80, 1.00, 800 },
        PP19 = { 0.90, 1.00, 750 },
        PP2000 = { 1.20, 1.00, 900 },
        SCAR = { 1.60, 1.00, 500 },
        SCORPIONEVO = { 2.70, 1.00, 1200 },
        SG550 = { 0.90, 1.00, 700 },
        UMP45 = { 0.90, 1.00, 700 },
        KRISSVECTOR = { 0.97, 1.00, 1200 }
    },
    -- DO NOT CHANGE
    accumulated_recoil = 0,
    accumulated_delay = 0,
    random_x = 0,
    base_fov = 90,
    recoil_y = 0,
    -- Change these as needed
    current_weapon = "HONEYBADGER",
    smooth_steps = 1,
    fov = 90,
}
local function range(num, old_min, old_max, new_min, new_max)
    return ((num - old_min) / (old_max - old_min)) * (new_max - new_min) + new_min
end
function battlebitrcs.on_worker()
    -- [[ Recoil Mitigation ]] -- 
    if battlebitrcs.input:is_key_down(2) and battlebitrcs.input:is_key_down(1) then
        local weapon = battlebitrcs.weapons[battlebitrcs.current_weapon]
        battlebitrcs.recoil_y = ((weapon[1] * 23 * (battlebitrcs.fov / battlebitrcs.base_fov)) / battlebitrcs.smooth_steps) * range(battlebitrcs.smooth_steps, 1, 10, 1, 2)
        local fire_rate = (60000 / weapon[3]) / battlebitrcs.smooth_steps
        battlebitrcs.accumulated_recoil = battlebitrcs.accumulated_recoil + battlebitrcs.recoil_y
        local rounded_recoil = math.floor(battlebitrcs.accumulated_recoil)
        battlebitrcs.accumulated_recoil = battlebitrcs.accumulated_recoil - rounded_recoil
        battlebitrcs.accumulated_delay = battlebitrcs.accumulated_delay + fire_rate
        local rounded_delay = math.floor(battlebitrcs.accumulated_delay)
        battlebitrcs.accumulated_delay = battlebitrcs.accumulated_delay - rounded_delay
        if math.random(0, 10) >= 2 then
            battlebitrcs.random_x = math.random(-1, 1)
        else
            battlebitrcs.random_x = 0
        end
        fantasy.log("Moving mouse by - x: " .. battlebitrcs.random_x .. " | - y: " .. rounded_recoil)
        battlebitrcs.input:move(random_x, rounded_recoil)
        fantasy.sleep(rounded_delay)
    end
end
return battlebitrcs