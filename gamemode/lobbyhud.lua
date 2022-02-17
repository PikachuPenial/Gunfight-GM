function HUD()
    local client = LocalPlayer()
  
    if !client:Alive() then
        return
      end

  --This HUD will appear when a player is in the lobby, and is not in a match.

      draw.SimpleText("You are currently NOT in a queue!", "DermaLarge", ScrW() / 2, ScrH() - 900, Color(255,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
      draw.SimpleText("Gunfight BETA", "CloseCaption_Bold", ScrW() - 80, ScrH() - 1065, Color(55,255,55,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  end
  hook.Add("HUDPaint", "LobbyHud", HUD)
  
  function HideHud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
        if name == v then
            return false
        end
    end
  end
  hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)