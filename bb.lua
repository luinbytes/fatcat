--[[
    @title
        BattleBit Super Secret Project!!!

    @author
        lu.

    @description
        Keep it hush please!
--]]

local modules = require 'modules'
local bb = {
    offsets = {
        PlayerNetwork = 0x40EB750,
        LocalPlayer = 0x38,
        LocalState = 0x30,
    },

    pointers = {
        player_network = 0,
        local_player = 0,
        local_state = 0,
    },

    input = modules.input
}

local process, pid = modules.process, 0
function bb.on_loaded()
    fantasy.set_worker(1)
    fantasy.log("1")
    process = fantasy.engine.process( )
    pid = process:set("notepad.exe")
    fantasy.log("2")
    if pid == 0 then
        fantasy.log("3")
        fantasy.log("BattleBit is not running!")
    else
        fantasy.log("BattleBit is running! PID: " .. pid)
    end
    fantasy.log("4")

    bb.pointers.player_network = process:read(MEM_ADDRESS, bb.offsets.PlayerNetwork)
    bb.pointers.local_player = process:read(MEM_ADDRESS, bb.pointers.player_network:add(bb.offsets.LocalPlayer))
    bb.pointers.local_state = process:read(MEM_ADDRESS, bb.pointers.local_player:add(bb.offsets.LocalState))

    fantasy.log("PID: " .. pid)
    fantasy.log("-------------------------------------------")
    fantasy.log("Player Network: " .. tostring(bb.pointers.player_network))
    fantasy.log("Local Player: " .. tostring(bb.pointers.local_player))
    fantasy.log("Local State: " .. tostring(bb.pointers.local_state))
    fantasy.log("-------------------------------------------")
end

return bb