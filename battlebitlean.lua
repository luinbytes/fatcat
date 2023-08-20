--[[
    @title
        Battlebit Remastered Lean Spam
    @author
        lu.
    @description
        Battlebit Remastered Lean Spam, makes it harder to hit you.
]]--
local modules = require 'modules'
local battlebitlean = {  
    input = modules.input,  
    jiggle = true, -- Spams lean when shooting (Basically antiaim B)
    jiggle_need_keybind = true, -- Set this to false if you just want it to activate when you fire. When true, you only need to hit the keybind.
    jiggle_keybind = 5, -- https://cherrytree.at/misc/vk.htm
    lean_left = 56, -- 8
    lean_right = 57, -- 9
    timer = 0,
    flip = false,
}
function battlebitlean.on_worker()
    if not battlebitlean.jiggle_need_keybind then
        if battlebitlean.input:is_key_down(1) then
            battlebitlean.timer = battlebitlean.timer + 1
            if battlebitlean.flip == false and battlebitlean.timer <= 9 then
                battlebitlean.input:key(battlebitlean.lean_left, 100)
                battlebitlean.flip = true
            end
            if battlebitlean.timer >= 10 and battlebitlean.flip then
                battlebitlean.input:key(battlebitlean.lean_right, 100)
                battlebitlean.flip = false
            end
            if battlebitlean.timer >= 20 then
                battlebitlean.timer = 0
            end
        else
            battlebitlean.timer = 0
        end
    else
        if battlebitlean.input:is_key_down(battlebitlean.jiggle_keybind) then
            battlebitlean.timer = battlebitlean.timer + 1
            if battlebitlean.flip == false and battlebitlean.timer <= 9 then
                battlebitlean.input:key(battlebitlean.lean_left, 100)
                battlebitlean.flip = true
            end
            if battlebitlean.timer >= 10 and battlebitlean.flip then
                battlebitlean.input:key(battlebitlean.lean_right, 100)
                battlebitlean.flip = false
            end
            if battlebitlean.timer >= 20 then
                battlebitlean.timer = 0
            end
        else
            battlebitlean.timer = 0
        end
    end
end
return battlebitlean