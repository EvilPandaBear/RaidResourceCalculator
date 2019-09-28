local AddonName, RaidResourceCalculator = ...
RaidResourceCalculator.MainMenuHandler = {}

local MainMenuHandler = RaidResourceCalculator.MainMenuHandler
local mainFrameVisible = false
local mainFrame

--------------------------------------
-- Defaults (usually a database!)
--------------------------------------
local defaults = {
	theme = {
		r = 0, 
		g = 0.8, -- 204/255
		b = 1,
		hex = "00ccff"
	}
}

--------------------------------------
-- mainWindowHandler Functions
--------------------------------------
function MainMenuHandler:Toggle()
	local menu = mainFrame or MainMenuHandler:CreateMainMenu();
	menu:SetShown(not menu:IsShown());
end

function MainMenuHandler:GetThemeColor()
	local c = defaults.theme;
	return c.r, c.g, c.b, c.hex;
end
--------------------------------------
-- reload UI from AddOn Call
--------------------------------------
function MainMenuHandler:ToggleDevMode() ReloadUI() end

--------------------------------------
-- ShowInterface is the entry point to the AddOns Interface
-- TODO: add real interface
--------------------------------------
function MainMenuHandler:ShowInterface()
    if not mainFrameVisible then
        CreateMainMenu()
	else
        mainFrame:Hide()
        mainFrameVisible = false
	end
	print("Is Window shown?: ", mainFrameVisible)
end


function MainMenuHandler:CreateMainMenu()
    
	-- Generate Main window based on BasicFrameTemplate from Blizzard
    mainFrame = CreateFrame("Frame", "RaidResourceCalculator", UIParent, "BasicFrameTemplate")
	mainFrame:SetFrameStrata("BACKGROUND")
    mainFrame:SetSize(1000, 600) -- Set these to whatever width/height is needed for your Texture
    mainFrame:SetPoint("CENTER", UIParent, "CENTER")
    
    ---- Resetting Blizzard Background
    mainFrame.bg = mainFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.bg:SetAllPoints(true)
    mainFrame.bg:SetColorTexture(0,0,0, 0.8)

	---- Setting Title to Main Window
	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 5, 1)
	mainFrame.title:SetText("Raid Resource Calculator")
    mainFrame.title:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 15, "OUTLINE")
    
    -- Set new Frame to enter Greetings Text
    mainFrame.greetingsFrame = CreateFrame("Frame", nil, mainFrame, "InsetFrameTemplate4")
    mainFrame.greetingsFrame:SetSize(mainFrame:GetWidth() * 0.95 , mainFrame:GetHeight()* 0.85) -- Set these to whatever height/width is needed for your Texture
    mainFrame.greetingsFrame:SetPoint("CENTER", mainFrame, "CENTER")
    
    ---- Set Background to greetings text
    mainFrame.greetingsFrame.bg = mainFrame.greetingsFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.greetingsFrame.bg:SetAllPoints(true)
    mainFrame.greetingsFrame.bg:SetColorTexture(110,104,104, 0.4)

    ------ Set Greetings text title area
    mainFrame.greetingsFrame.titleArea = CreateFrame("Frame", nil, mainFrame.greetingsFrame)
    mainFrame.greetingsFrame.titleArea:SetSize(mainFrame.greetingsFrame:GetWidth(), 0)
    mainFrame.greetingsFrame.titleArea:SetPoint("CENTER", mainFrame.greetingsFrame, "TOP")
    
    mainFrame.greetingsFrame.titleArea.bg = mainFrame.greetingsFrame.titleArea:CreateTexture(nil, "BORDER")
    mainFrame.greetingsFrame.titleArea.bg:SetAllPoints(true)
    mainFrame.greetingsFrame.titleArea.bg:SetColorTexture(0,1,0.5)

    -------- Setting Title to Greetings text title area
	mainFrame.greetingsFrame.titleArea.title = mainFrame.greetingsFrame.titleArea:CreateFontString(nil, "HIGHLIGHT")
	mainFrame.greetingsFrame.titleArea.title:SetPoint("CENTER", mainFrame.greetingsFrame.titleArea, "CENTER", 0, 0)
	mainFrame.greetingsFrame.titleArea.title:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 15, "OUTLINE")
	mainFrame.greetingsFrame.titleArea.title:SetText("Hello Fellas... Thank you for using our Raid Resource Calculator!")

	-- Add lines to move frame
	mainFrame:EnableMouse(true)
    mainFrame:SetMovable(true)
    mainFrame:SetClampedToScreen(true)
    mainFrame:RegisterForDrag("LeftButton")
    mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
    mainFrame:SetScript("OnDragStop", mainFrame.StopMovingOrSizing)
	
	-- finishing frame creation
	mainFrame:Hide()
    return mainFrame;
end
