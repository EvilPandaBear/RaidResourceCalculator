SLASH_RRC1 = "/rrc"
SLASH_RRC2 = "/raidresourcecalculator"
SlashCmdList["RRC"] = function(msg)
    createFrame()
end 
local mainFrame
function createFrame()
    mainFrame = CreateFrame("Frame",nil, UIParent)
    mainFrame:SetFrameStrata("BACKGROUND")
    mainFrame:SetWidth(128) -- Set these to whatever height/width is needed 
    mainFrame:SetHeight(64) -- for your Texture

    local t = mainFrame:CreateTexture(nil,"BACKGROUND")
    t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
    t:SetAllPoints(mainFrame)
    mainFrame.texture = t

    mainFrame:SetPoint("CENTER",0,0)
    mainFrame:Show()

end