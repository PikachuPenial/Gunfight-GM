local roundNumber
local roundTime
local roundMap


local playerOne
local playerTwo

local spawnOne
local spawnTwo

local knownTimerType

util.AddNetworkString( "TimerLength" )
util.AddNetworkString( "ActiveTimerType" )

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

    for _, ply in ipairs( plyTable ) do

        ply:Lock()

    end

    local buyTime = 20

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

function StartMatch(ply, cmd, args)

    -- Ugly way of disabling all timers if you make a new match mid-game. For testing (:

    local timerNames = {"BuyTimer", "RoundTimer"}
    for k, v in pairs(timerNames) do if timer.Exists(v) == true then timer.Remove(v) end end

    roundMap = args[1]

    SpawnPlayers(roundMap)

end
concommand.Add("gf_start_match", StartMatch)

function EndMatch()

    -- Ugly way of disabling all timers if you make a new match mid-game. For testing (:
    local timerNames = {"BuyTimer", "RoundTimer"}
    for k, v in pairs(timerNames) do if timer.Exists(v) == true then timer.Remove(v) end end

    spawns = ents.FindByClass( "info_player_start" )

    for k, ply in ipairs( player.GetHumans() ) do

        ply:SetPos(spawns[k]:GetPos())
        ply:UnLock()

    end

end
concommand.Add("gf_end_match", EndMatch)

function NewRound()

end