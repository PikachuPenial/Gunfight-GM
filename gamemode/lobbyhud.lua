local timeLeft = 0
local timerTypeInt = 0

net.Receive("TimerLength", function(len, ply)

    timeLeft = net.ReadUInt(10)

end)

-- Tracks what kind of timer is active. As of writing; 0 will hide the timer, 1 indicates buy time, and 2 indicated round time.
net.Receive("ActiveTimerType", function(len, ply)

    timerTypeInt = net.ReadUInt(3)

end)

function HUD()

    local client = LocalPlayer()
  
    if !client:Alive() then
        return
    end

    -- Remember kids, if you've been paying attention to my comments like good boys, you would know what this next part does.

    if timerTypeInt > 0 then

        if timerTypeInt == 1 then

            -- Buy Time Text

            draw.RoundedBox(0, (ScrW() / 2) - 70, 20, 140, 40, Color(60,60,60,175))
            draw.SimpleText("BUY TIME", "DermaLarge", ScrW() / 2, 40, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            -- Buy Time Left

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