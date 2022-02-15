AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

    --Player stats.

function GM:PlayerSpawn(ply)
    ply:SetGravity(1.40)
    ply:SetMaxHealth(100)
    ply:SetRunSpeed(275)
    ply:SetWalkSpeed(175)
    ply:SetJumpPower(230)

    local playerModels = {"models/kyo/ghost_azrael_pm.mdl", "models/balkandude.mdl", "models/usef.mdl", "models/tfusion/playermodels/mw3/mp_delta_elite_a.mdl", "models/kuma96/codmw/characters/allegiancedef/allegiancedef_pm.mdl"}
    local chosenPlayerModel = playerModels[math.random(#playerModels)]

    ply:SetModel(playerModels[math.random(#playerModels)])
    print(chosenPlayerModel)

    ply:SetupHands()
    
    return true
  end