local roundsCompleted = 0

local roundsWonPlayerOne = 0
local roundsWonPlayerTwo = 0

local playerOne
local playerTwo

local spawnOne
local spawnTwo

local knownTimerType

local doRandomWeapons

local buyTime = 5

local randomWeaponTable = {}
randomWeaponTable[1] = "mg_deagle"
randomWeaponTable[2] = "mg_mike4"
randomWeaponTable[3] = "mg_ump45"
randomWeaponTable[4] = "mg_oscar12"
randomWeaponTable[5] = "mg_falima"

util.AddNetworkString( "TimerLength" )
util.AddNetworkString( "ActiveTimerType" )

util.AddNetworkString( "UpdateScore" )

function GetRandomWeapon()

    return randomWeaponTable[ math.random(#randomWeaponTable) ]

end

function UpdateTimer(timer, type)

    net.Start("TimerLength")
    net.WriteUInt(timer, 10)
    net.Broadcast()

    if(type != knownTimerType) then

        net.Start("ActiveTimerType")
        net.WriteUInt(type, 3)
        net.Broadcast()

    end

end

function NextRound(winner, loser)

    local plyTable = {winner, loser}
    table.Shuffle(plyTable)

    if winner == playerOne then

        roundsWonPlayerOne = roundsWonPlayerOne + 1

        net.Start("UpdateScore")
        net.WriteString(roundsWonPlayerOne .. "-" .. roundsWonPlayerTwo)
        net.Send(playerOne)

    else

        roundsWonPlayerTwo = roundsWonPlayerTwo + 1

        net.Start("UpdateScore")
        net.WriteString(roundsWonPlayerTwo .. "-" .. roundsWonPlayerOne)
        net.Send(playerTwo)

    end

    timer.Create("NextRoundTimer", 5, 1, function ()
    
        StartBuyTime(plyTable)

    end)

end

hook.Add("PlayerDeath", "Next_Round", function(victim, _, attacker)

    if attacker == victim then return end

    NextRound(attacker, victim)

end)

function StartRound(plyTable)

    print("StartingRound!")

    for _, ply in ipairs( plyTable ) do

        ply:UnLock()

    end

    local roundTime = 90

    local timeLeft = roundTime

    UpdateTimer(timeLeft, 2)

    timer.Create("RoundTimer", 1, 0, function()
    
        if timeLeft < 1 then

            timer.Remove("RoundTimer")

        else

            timeLeft = timeLeft - 1

            UpdateTimer(timeLeft, 2)

        end
    
    end)

end

function StartBuyTime(plyTable)

    print("Starting Buy Time!")

    local randomWep = GetRandomWeapon()

    for _, ply in ipairs( plyTable ) do

        ply:StripWeapons()
        ply:StripAmmo()

        ply:Lock()
        ply:Give(randomWep)

        wep = weapons.Get(randomWep)

        ply:GiveAmmo(120, ply:GetWeapon(randomWep):GetPrimaryAmmoType(), true)

    end

    local timeLeft = buyTime

    UpdateTimer(timeLeft, 1)

    timer.Create("BuyTimer", 1, 0, function()
    
        if timeLeft < 1 then

            print("starting round")

            StartRound(plyTable)

            timer.Remove("BuyTimer")

        else

            print("TimeLeft = " .. tostring(timeLeft))

            UpdateTimer(timeLeft, 1)

            timeLeft = timeLeft - 1

        end
    
    end)

end

function SpawnPlayers(map)

    local spawns = ents.FindByName( "gf_match_spawns_"..map )
    local players = player.GetHumans()

    if #players == 1 then

        playerOne = players[1]
        
        spawnOne = spawns[1]

        playerOne:SetPos(spawnOne:GetPos())
        playerOne:SetEyeAngles(spawnOne:GetAngles())

        playerOne:PrintMessage( HUD_PRINTTALK, "Only one player is in this game, match will proceed in debug mode for testing purposes. Shit probably won't work correctly, so get a friend." )

    else

        playerOne = players[1]
        playerTwo = players[2]
        
        spawnOne = spawns[1]
        spawnTwo = spawns[2]

        playerOne:SetPos(spawnOne:GetPos())
        playerOne:SetEyeAngles(spawnOne:GetAngles())

        playerTwo:SetPos(spawnTwo:GetPos())
        playerTwo:SetEyeAngles(spawnTwo:GetAngles())

    end
    
    StartBuyTime(players)

end

function DetermineRandomArena()

    local spawns = ents.FindByClass( "info_target" )

    local arenaNameTable = {}
    local arenas = {}

    for k, v in pairs(spawns) do

        if string.StartWith(v:GetName(), "arena_") == true then

            local spawnNameDirty = v:GetName()
            print(spawnNameDirty)

            cleanSpawnName = string.Replace(spawnNameDirty, "arena_", "")

            table.insert(arenaNameTable, cleanSpawnName)

        end 

    end

    for k, v in pairs(arenaNameTable) do

        if arenas == nil then
            table.insert(arenas, v)
        end

    end

    return arenaNameTable[ math.random( #arenaNameTable ) ]

end

function StartMatch(ply, cmd, args)

    -- Ugly way of disabling all timers if you make a new match mid-game. For testing (:

    local timerNames = {"BuyTimer", "RoundTimer"}
    for k, v in pairs(timerNames) do if timer.Exists(v) == true then timer.Remove(v) end end

    local roundMap

    if args[1] == nil then roundMap = DetermineRandomArena() else roundMap = args[1] end

    if args[2] == true then

        doRandomWeapons = true

    end

    print("Round map is: "..roundMap)

    SpawnPlayers(roundMap)

end
concommand.Add("gf_start_match", StartMatch)

function EndMatch()

    -- Ugly way of disabling all timers if you make a new match mid-game. For testing (:
    local timerNames = {"BuyTimer", "RoundTimer"}
    for k, v in pairs(timerNames) do if timer.Exists(v) == true then timer.Remove(v) end end

    spawns = ents.FindByClass( "info_player_start" )

    for k, ply in ipairs( player.GetHumans() ) do

        ply:StripWeapons()
        ply:StripAmmo()

        ply:SetPos(spawns[k]:GetPos())
        ply:UnLock()

    end

end
concommand.Add("gf_end_match", EndMatch)

function NewRound()

end