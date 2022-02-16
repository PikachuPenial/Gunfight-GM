AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("concommands.lua")
include("sv_match_system.lua")

    --This section is mostly setting up integers for stats/achivments, while also setting up the player(s) stats like movement and health.
    --Set up player movement, and playermodels.

function GM:PlayerSpawn(ply)
    ply:SetGravity(1.40)
    ply:SetMaxHealth(100)
    ply:SetRunSpeed(275)
    ply:SetWalkSpeed(175)
    ply:SetJumpPower(230)

    local playerModels = {"models/kyo/ghost_azrael_pm.mdl", "models/balkandude.mdl", "models/usef.mdl", "models/tfusion/playermodels/mw3/mp_delta_elite_a.mdl", "models/kuma96/codmw/characters/allegiancedef/allegiancedef_pm.mdl", "models/tfusion/playermodels/mw3/mp_sas_c.mdl"}
    local chosenPlayerModel = playerModels[math.random(#playerModels)]

    ply:SetModel(playerModels[math.random(#playerModels)])
    print(chosenPlayerModel)

    ply:SetupHands()
    
    return true
end

    --Disable Gravity Gun punt.

function GM:GravGunPunt(player, entity)
	return false
end

    --If the player(s) has a nil integer, set it to a actual integer/number to make LUA happy.

function GM:PlayerInitialSpawn(ply)
        if(ply:GetPData("playerKills") == nil) then
		ply:SetNWInt("playerKills", 0)
	else
		ply:SetNWInt("playerKills", tonumber(ply:GetPData("playerKills")))
	end
	
		if(ply:GetPData("playerDeaths") == nil) then
		ply:SetNWInt("playerDeaths", 0)
	else
		ply:SetNWInt("playerDeaths", tonumber(ply:GetPData("playerDeaths")))
	end
	
		if(ply:GetPData("playerKDR") == nil) then
		ply:SetNWInt("playerKDR", 1)
	else
		ply:SetNWInt("playerKDR", tonumber(ply:GetPData("playerKDR")))
	end
	
		if(ply:GetPData("playerDamageGiven") == nil) then
		ply:SetNWInt("playerDamageGiven", 0)
	else
		ply:SetNWInt("playerDamageGiven", tonumber(ply:GetPData("playerDamageGiven")))
	end
	
		if(ply:GetPData("playerDamageRecieved") == nil) then
		ply:SetNWInt("playerDamageRecieved", 0)
	else
		ply:SetNWInt("playerDamageRecieved", tonumber(ply:GetPData("playerDamageRecieved")))
	end
	
		if(ply:GetPData("playerDistance") == nil) then
		ply:SetNWInt("playerDistance", 0)
	else
		ply:SetNWInt("playerDistance", tonumber(ply:GetPData("playerDistance")))
	end
end

    --Save player(s) variables when they leave the server.

function GM:PlayerDisconnected(ply)
	ply:SetPData("playerKills", ply:GetNWInt("playerKills"))
	ply:SetPData("playerDeaths", ply:GetNWInt("playerDeaths"))
    ply:SetPData("playerKDR", ply:GetNWInt("playerKDR"))
	ply:SetPData("playerDamageGiven", ply:GetNWInt("playerDamageGiven"))
	ply:SetPData("playerDamageRecieved", ply:GetNWInt("playerDamageRecieved"))
	ply:SetPData("playerDistance", ply:GetNWInt("playerDistance"))
end

    --Save player(s) variables when the server shutsdown.

function GM:ShutDown()
	for k, v in pairs(player.GetAll()) do
		v:SetPData("playerKills", v:GetNWInt("playerKills"))
		v:SetPData("playerDeaths", v:GetNWInt("playerDeaths"))
		v:SetPData("playerKDR", v:GetNWInt("playerKDR"))
		v:SetPData("playerDamageGiven", v:GetNWInt("playerDamageGiven"))
		v:SetPData("playerDamageRecieved", v:GetNWInt("playerDamageRecieved"))
		v:SetPData("playerDistance", v:GetNWInt("playerDistance"))
	end
end

    --This section will add onto the integers that we previously set up when the player(s) join a server running "Gunfight" for the first time.
    --Updating integers when a player is killed.

    function GM:PlayerDeath(victim, inflictor, attacker)
        if(attacker == victim) then		

            victim:SetNWInt("playerKDR", victim:GetNWInt("playerKills") / victim:GetNWInt("playerDeaths"))
        else
        
            local killGained = (1)
        
            local deathGained = (1)
        
            attacker:SetNWInt("playerKills", attacker:GetNWInt("playerKills") + killGained)
        
            victim:SetNWInt("playerDeaths", victim:GetNWInt("playerDeaths") + deathGained)
        
            victim:SetNWInt("playerKDR", victim:GetNWInt("playerKills") / victim:GetNWInt("playerDeaths"))
        
            attacker:SetNWInt("playerKDR", attacker:GetNWInt("playerKills") / attacker:GetNWInt("playerDeaths"))
            
        end
    end



hook.Add("PlayerHurt", "playerDamage", function(victim, attacker, remainingHealth, dmgTaken)

    attacker:SetNWInt("playerDamageGiven", attacker:GetNWInt("playerDamageGiven") + math.Round(dmgTaken, 0))
        
    victim:SetNWInt("playerDamageRecieved", victim:GetNWInt("playerDamageRecieved") + math.Round(dmgTaken, 0))
    
end)

function GM:ShowSpare1(ply)
	ply:ConCommand("gf_player_menu")
end