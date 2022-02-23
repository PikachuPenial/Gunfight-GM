local roundsCompleted = 0

local roundsWonPlayerOne = 0
local roundsWonPlayerTwo = 0

local playerOne
local playerTwo

local spawnOne
local spawnTwo

local knownTimerType

local doRandomWeapons

local buyTime = 12

local randomWeaponTable = {}

    -- These are all of the current weapons, pretty big list, me likey!

randomWeaponTable[1] = "mg_asm10"
randomWeaponTable[2] = "mg_357"
randomWeaponTable[3] = "mg_deagle"
randomWeaponTable[4] = "mg_charlie725"
randomWeaponTable[5] = "mg_ak12"
randomWeaponTable[6] = "mg_akilo47"
randomWeaponTable[7] = "mg_anovember94"
randomWeaponTable[8] = "mg_valpha"
randomWeaponTable[9] = "mg_galima"
randomWeaponTable[10] = "mg_falima"
randomWeaponTable[11] = "mg_scharlie"
randomWeaponTable[12] = "mg_falpha"
randomWeaponTable[13] = "mg_g36c"
randomWeaponTable[14] = "mg_sierra552"
randomWeaponTable[15] = "mg_ump45"
randomWeaponTable[16] = "mg_hk416"
randomWeaponTable[17] = "mg_aalpha12"
randomWeaponTable[18] = "mg_rfb"
randomWeaponTable[19] = "mg_kilo433"
randomWeaponTable[20] = "mg_mcharlie"
randomWeaponTable[21] = "mg_p320"
randomWeaponTable[22] = "mg_m1911"
randomWeaponTable[23] = "mg_mike4"
randomWeaponTable[24] = "mg_makarov"
randomWeaponTable[25] = "mg_dblmg"
randomWeaponTable[26] = "mg_romeo870"
randomWeaponTable[27] = "mg_asierra12"
randomWeaponTable[28] = "mg_oscar12"
randomWeaponTable[29] = "mg_dpapa12"
randomWeaponTable[30] = "mg_tango21"
randomWeaponTable[31] = "mg_m9"
randomWeaponTable[32] = "mg_uspmatch"
randomWeaponTable[33] = "mg_mike26"
randomWeaponTable[34] = "mg_glock"
randomWeaponTable[35] = "mg_g3a3"

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

        ply:GiveAmmo(90, ply:GetWeapon(randomWep):GetPrimaryAmmoType(), true)

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