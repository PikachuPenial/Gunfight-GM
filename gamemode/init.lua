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

    ply:SetupHands()
    
    return true
  end