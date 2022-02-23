local GameMenu

-- Setting up the background/base of the queue menu.

function gameMenu()
    if (GameMenu == nil) then
    GameMenu = vgui.Create("DFrame")
        GameMenu:SetSize(600,500)
        GameMenu:Center()
        GameMenu:SetTitle("Gunfight Menu")
        GameMenu:SetDraggable(true)
        GameMenu:ShowCloseButton(false)
        GameMenu:SetDeleteOnClose(false)
        GameMenu.Paint = function()
            surface.SetDrawColor(40, 40, 40, 200)
            surface.DrawRect(0, 0, GameMenu:GetWide(), GameMenu:GetTall())

            surface.SetDrawColor(60, 60, 60, 200)
            surface.DrawRect(0, 24, GameMenu:GetWide(), GameMenu:GetTall())
        end

        gameMenuAddButtons(GameMenu)
        gui.EnableScreenClicker(true)
    else
        if (GameMenu:IsVisible()) then
            GameMenu:SetVisible(false)
            gui.EnableScreenClicker(false)
        else
            GameMenu:SetVisible(true)
            gui.EnableScreenClicker(true)
        end
    end
end
concommand.Add("gf_gamemenu", gameMenu)

-- Creating buttons to put a player into a queue.

function gameMenuAddButtons(GameMenu)
    local queueButton = vgui.Create("DButton")
    queueButton:SetParent(GameMenu)
    queueButton:SetText("Enter Queue")
    queueButton:SetSize(125, 75)
    queueButton:Center()
    queueButton:SetConsoleCommand("gf_start_match")
    queueButton.Paint = function()

        -- Changing color of the button.
        surface.SetDrawColor(150, 150, 150, 255)
        surface.DrawRect(0, 0, queueButton:GetWide(), queueButton:GetTall())
        
        -- Changing color of the buttons borders.
        surface.SetDrawColor(100, 100, 100, 225)
        surface.DrawRect(0, 74, queueButton:GetWide(), 1)
        surface.DrawRect(124, 0, 1, queueButton:GetTall())
    end
end