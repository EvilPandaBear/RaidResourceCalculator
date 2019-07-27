local AddonName, RaidResourceCalculator = ...
local mainFrameVisible = false
local mainFrame
-- Possible console calls to open the addon
SLASH_RAIDRESOURCECALCULATOR1 = '/rrc'
SLASH_RAIDRESOURCECALCULATOR2 = '/rrcalculator'
SLASH_RAIDRESOURCECALCULATOR2 = '/raidresourcecalc'
SLASH_RAIDRESOURCECALCULATOR3 = '/raidresourcecalculator'

-- Parse console calls and arguments
function SlashCmdList.RAIDRESOURCECALCULATOR(cmd, editbox)
    local rqst, arg = strsplit(' ', cmd)
    if rqst == "dev" then
        RaidResourceCalculator:ToggleDevMode()
    else
        RaidResourceCalculator:ShowInterface()
    end
end

-- reload UI from AddOn Call
function RaidResourceCalculator:ToggleDevMode() ReloadUI() end

-- ShowInterface is the entry point to the AddOns Interface
-- TODO: add real interface
function RaidResourceCalculator:ShowInterface()
    if not mainFrameVisible then
        createMainFrame()
	else
        mainFrame:Hide()
        mainFrameVisible = false
	end
	print("Is Window shown?: ", mainFrameVisible)
end

function createMainFrame()

	-- Generate Main window based on BasicFrameTemplate from Blizzard
    mainFrame = CreateFrame("Frame", "RaidResourceCalculator", UIParent, "BasicFrameTemplate")
	mainFrame:SetFrameStrata("BACKGROUND")
    mainFrame:SetSize(350, 350) -- Set these to whatever height/width is needed for your Texture
	mainFrame:SetPoint("TOPRIGHT", UIParent, "CENTER")

	---- Setting Title to Main Window
	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	mainFrame.title:SetPoint("LEFT", mainFrame.TitleBg, "LEFT", 5, 1)
	mainFrame.title:SetText("Raid Resource Calculator")
	mainFrame.title:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 15, "OUTLINE")

	-- Add lines to move frame
	mainFrame:EnableMouse(true)
    mainFrame:SetMovable(true)
    mainFrame:SetClampedToScreen(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
    mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
	
	-- finishing frame creation
	mainFrame:Show()
    mainFrameVisible = true
end


--[[
	
	local t = mainFrame:CreateTexture("nil", "BACKGROUND")
    t:SetTexture(
        "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
    t:SetAllPoints(mainFrame)
    mainFrame.texture = t

]]