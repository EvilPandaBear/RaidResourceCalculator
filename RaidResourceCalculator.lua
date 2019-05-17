local AddonName, RaidResourceCalculator = ...
local mainFrameVisible
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
function RaidResourceCalculator:ToggleDevMode()
    ReloadUI()
end

-- ShowInterface is the entry point to the AddOns Interface
-- TODO: add real interface
function RaidResourceCalculator:ShowInterface()
	if not mainFrameVisible then
		createFrame()
	else
		mainFrame:Hide()
		mainFrameVisible = false
	end
end

function createFrame()
    mainFrame = CreateFrame("Frame",nil,UIParent)
	mainFrame:SetFrameStrata("BACKGROUND")
	mainFrame:SetWidth(128) -- Set these to whatever height/width is needed 
	mainFrame:SetHeight(64) -- for your Texture

	local t = mainFrame:CreateTexture(nil,"BACKGROUND")
	t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Factions.blp")
	t:SetAllPoints(mainFrame)
	mainFrame.texture = t

	mainFrame:SetPoint("CENTER",0,0)
	mainFrame:Show()
	mainFrameVisible = true
end