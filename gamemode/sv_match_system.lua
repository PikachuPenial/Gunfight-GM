local roundNumber
local roundTime
local roundMap


local playerOne
local playerTwo

local spawnOne
local spawnTwo

function SpawnPlayers()

    local spawns = ents.FindByName( "gf_match_spawns" )
    local players = player.GetHumans()
    
    playerOne = players[1]
    playerTwo = players[2]
    
    spawnOne = spawns[1]
    spawnTwo = spawns[2]

    playerOne:SetPos(spawnOne:GetPos())
	playerOne:SetAngles(spawnOne:GetAngles())

    playerTwo:SetPos(spawnTwo:GetPos())
	playerTwo:SetAngles(spawnTwo:GetAngles())

end

function StartMatch(ply, cmd, args)

    roundNumber = args[1]
    roundTime = args[2]
    roundMap = args[3]

    SpawnPlayers()

    print("starting round")

end
concommand.Add("gf_start_match", StartMatch)

function EndMatch()

end

function NewRound()

end