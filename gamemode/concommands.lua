function ResetIndividualProgress(ply, cmd, args)

    ply:SetNWInt("playerKills", 0)
    ply:SetNWInt("playerDeaths", 0)
    ply:SetNWInt("playerKDR", 1)
    ply:SetNWInt("playerDamageGiven", 0)
    ply:SetNWInt("playerDamageRecieved", 0)
    ply:SetNWInt("playerDistance", 0)

end
concommand.Add("gf_reset_progress", ResetIndividualProgress)