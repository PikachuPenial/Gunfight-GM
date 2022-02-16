local roundNumber
local roundTime
local roundMap


local playerOne
local playerTwo

local spawnOne
local spawnTwo

function EndBuyTime(plyTable)

    print("Ending Buy Time!")

    for _, ply in ipairs( plyTable ) do

        ply:UnLock()

    end

end

function StartBuyTime(plyTable)

    print("Starting Buy Time!")

    for _, ply in ipairs( plyTable ) do

        ply:Lock()

    end

    timer.Simple( 20, function() EndBuyTime(plyTable) end )

end

function SpawnPlayers(map)

    local spawns = ents.FindByName( "gf_match_spawns_"..map )
    local players = player.GetHumans()

    if #players == 1 then

        playerOne = players[1]
        
        spawnOne = spawns[1]

        playerOne:SetPos(spawnOne:GetPos())
        playerOne:SetEyeAngles(spawnOne:GetAngles())

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

    roundMap = args[1]

    SpawnPlayers(roundMap)

end
concommand.Add("gf_start_match", StartMatch)

function EndMatch()

end

function NewRound()

end