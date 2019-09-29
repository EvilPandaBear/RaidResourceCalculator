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

---A helper function to print a table's contents.
---@param tbl table @The table to print.
---@param depth number @The depth of sub-tables to traverse through and print.
---@param n number @Do NOT manually set this. This controls formatting through recursion.


local function ScrollFrame_OnMouseWheel(self, delta)
	local newValue = self:GetVerticalScroll() - (delta * 20);
	
	if (newValue < 0) then
		newValue = 0;
	elseif (newValue > self:GetVerticalScrollRange()) then
		newValue = self:GetVerticalScrollRange();
	end
	
	self:SetVerticalScroll(newValue);
end

local function Tab_OnClick(self)
	PanelTemplates_SetTab(self:GetParent(), self:GetID())

	local scrollChild = mainFrame.ScrollFrame:GetScrollChild();
	if (scrollChild) then
		scrollChild:Hide();
	end
	
	mainFrame.ScrollFrame:SetScrollChild(self.content);

	self.content:Show()
end

local function SetTabs(frame, numTabs, ...)
	frame.numTabs = numTabs
	
	local contents = {}
	local frameName = frame:GetName()
	
	for i = 1, numTabs do	
		local tab = CreateFrame("Button", frameName.."Tab"..i, frame, "CharacterFrameTabButtonTemplate")
		tab:SetID(i)
		tab:SetText(select(i, ...))
		tab:SetScript("OnClick", Tab_OnClick)
		
		tab.content = CreateFrame("Frame", nil, mainFrame.ScrollFrame)
		tab.content:SetSize(320, 380)
		tab.content:Hide()

		table.insert(contents, tab.content)
		
		if (i == 1) then
			tab:SetPoint("TOPLEFT", mainFrame, "BOTTOMLEFT", 5, 0)
		else
			tab:SetPoint("TOPLEFT", _G[frameName.."Tab"..(i - 1)], "TOPRIGHT", -14, 0)
		end	
	end
	
	Tab_OnClick(_G[frameName.."Tab1"])

	return unpack(contents)
end

function MainMenuHandler:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
	local btn = CreateFrame("Button", nil, relativeFrame, "GameMenuButtonTemplate");
	btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset);
	btn:SetSize(160, 60);
	btn:SetText(text);
	btn:SetNormalFontObject("GameFontNormalLarge");
	btn:SetHighlightFontObject("GameFontHighlightLarge");
	return btn;
end

function MainMenuHandler:CreateMainMenu()
    
	-- Generate Main window based on BasicFrameTemplate from Blizzard
    mainFrame = CreateFrame("Frame", "RaidResourceCalculator", UIParent, "BasicFrameTemplate")
	mainFrame:SetFrameStrata("BACKGROUND")
    mainFrame:SetSize(350, 400) -- Set these to whatever width/height is needed for your Texture
    mainFrame:SetPoint("CENTER", UIParent, "CENTER")
    
    ---- Resetting Blizzard Background
    mainFrame.bg = mainFrame:CreateTexture(nil, "BACKGROUND")
    mainFrame.bg:SetAllPoints(true)
    mainFrame.bg:SetColorTexture(0,0,0, 0.8)

	---- Setting Title to Main Window
	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 0, 0)
	mainFrame.title:SetText("Raid Resource Calculator")
	mainFrame.title:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 19, "OUTLINE")
	
	-- -- Set new Frame to enter Greetings Text
    -- mainFrame.defaultFrame = CreateFrame("Frame", nil, mainFrame)
    -- mainFrame.defaultFrame:SetSize(mainFrame:GetWidth()* 0.98 , mainFrame:GetHeight()* 0.90) -- Set these to whatever height/width is needed for your Texture
	-- mainFrame.defaultFrame:SetPoint("CENTER", mainFrame.defaultFrame:GetParent(), "CENTER", 0 ,-10)
	-- mainFrame.defaultFrame.bg = mainFrame.defaultFrame:CreateTexture(nil, "ARTWORK")
	-- mainFrame.defaultFrame.bg:SetAllPoints(true)
	-- mainFrame.defaultFrame.bg:SetColorTexture(math.random(), math.random(), math.random(), 0.6)

	-- only using scrollframe, because I could not enable the tab windows without it
	mainFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, mainFrame, "UIPanelScrollFrameTemplate");
	mainFrame.ScrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 4, -25);
	mainFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -3, 4);
	mainFrame.ScrollFrame:SetClipsChildren(true);
	mainFrame.ScrollFrame:SetScript("OnMouseWheel", ScrollFrame_OnMouseWheel);
	
	-- if you don't want to show the scrollbar just commend the 3 lines below.
	mainFrame.ScrollFrame.ScrollBar:ClearAllPoints();
    mainFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", mainFrame.ScrollFrame, "TOPRIGHT", -12, -18);
	mainFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", mainFrame.ScrollFrame, "BOTTOMRIGHT", -7, 18);

    -- ########## TAB AREA ##########
    local content1, content2 = SetTabs(mainFrame, 2, "MAIN" ,"INFO")
    -- ##############################
	-- ########## TAB 1 ##########
	content1.loadBtn = self:CreateButton("CENTER", content1, "TOP", -70, "Snapping\nRaid Players");

	-- Reset Button:	
	content1.resetBtn = self:CreateButton("TOP", content1.loadBtn, "BOTTOM", -10, "Reset");

	-- Load Button:	
	content1.saveBtn = self:CreateButton("TOP", content1.resetBtn, "BOTTOM", -10, "Save");
	-- ###########################
	
	-- ########## TAB 2 ##########
	-- ########## GREETINGS TEXT ##########
    
    -- Set new Frame to enter Greetings Text
    content2.greetingsFrame = CreateFrame("Frame", nil, content2)
    content2.greetingsFrame:SetSize(content2:GetWidth() , content2:GetHeight()* 0.20) -- Set these to whatever height/width is needed for your Texture
    content2.greetingsFrame:SetPoint("CENTER", content2.greetingsFrame:GetParent(), "TOP", 0 ,0)
    
    ---- Set Background to Frame text <- useful for debugging
    content2.greetingsFrame.bg = content2.greetingsFrame:CreateTexture(nil, "BACKGROUND")
    content2.greetingsFrame.bg:SetAllPoints(true)
    -- content2.greetingsFrame.bg:SetColorTexture(110,104,104, 0.1)

    ------ Set Greetings text title area
    content2.greetingsFrame.titleArea = CreateFrame("Frame", nil, content2.greetingsFrame)
    content2.greetingsFrame.titleArea:SetSize(content2.greetingsFrame:GetWidth(), 80)
    content2.greetingsFrame.titleArea:SetPoint("CENTER", content2.greetingsFrame.titleArea:GetParent(), "CENTER", 0, -5)
    
    content2.greetingsFrame.titleArea.bg = content2.greetingsFrame.titleArea:CreateTexture(nil, "BACKGROUND")
	content2.greetingsFrame.titleArea.bg:SetAllPoints(true)

    -------- Setting Title to Greetings text title area
	content2.greetingsFrame.titleArea.title = content2.greetingsFrame.titleArea:CreateFontString(nil, "ARTWORK")
	content2.greetingsFrame.titleArea.title:SetPoint("CENTER", content2.greetingsFrame.titleArea, "CENTER", 0, -15)
	content2.greetingsFrame.titleArea.title:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 11, "OUTLINE")
    content2.greetingsFrame.titleArea.title:SetText("Hello Fellas...\n Thank you for using our Raid Resource Calculator!\nIf you face any error, feel free to contact us.")
    
    -- ####################################

    -- ########## PATCH NOTE AREA ##########

    -- Set Patchnote text title area
    content2.patchNoteArea = CreateFrame("Frame", nil, content2)
    content2.patchNoteArea:SetSize(content2:GetWidth() * 0.98 , content2:GetHeight()* 0.85) -- Set these to whatever height/width is needed for your Texture
    content2.patchNoteArea:SetPoint("BOTTOM", content2.patchNoteArea:GetParent(), "BOTTOM", 0, 10)

    ------ Setting text frame element in Patch Notes header
    content2.patchNoteArea.header = CreateFrame("Frame", nil, content2.patchNoteArea)
    content2.patchNoteArea.header:SetSize(content2.patchNoteArea:GetWidth(), 25)
    content2.patchNoteArea.header:SetPoint("TOPLEFT", content2.patchNoteArea, 0, 0)
    
    -------- Setting text element in Patch Notes header
    content2.patchNoteArea.header.text = content2.patchNoteArea.header:CreateFontString(nil, "ARTWORK")
    content2.patchNoteArea.header.text:SetPoint("TOPLEFT", content2.patchNoteArea.header, "LEFT", 10, 0)
    content2.patchNoteArea.header.text:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 14, "OUTLINE")
    content2.patchNoteArea.header.text:SetText("Patchnotes")

    ------ Setting text frame element in Patch Notes one
    content2.patchNoteArea.one = CreateFrame("Frame", nil, content2.patchNoteArea)
    content2.patchNoteArea.one:SetSize(content2.patchNoteArea:GetWidth(), 25)
    content2.patchNoteArea.one:SetPoint("BOTTOM", content2.patchNoteArea.header, 0, -content2.patchNoteArea.header:GetHeight())

    -------- Setting text element in Patch Notes one
	content2.patchNoteArea.one.text = content2.patchNoteArea.one:CreateFontString(nil, "ARTWORK")
	content2.patchNoteArea.one.text:SetPoint("TOPLEFT", content2.patchNoteArea.one, "LEFT", 0, 0)
	content2.patchNoteArea.one.text:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 10, "OUTLINE")
    content2.patchNoteArea.one.text:SetText("### - 20190928 | Added Main Window and Slash Control")

    ------ Setting text frame element in Patch Notes two
    content2.patchNoteArea.two = CreateFrame("Frame", nil, content2.patchNoteArea)
    content2.patchNoteArea.two:SetSize(content2.patchNoteArea:GetWidth(), 25)
    content2.patchNoteArea.two:SetPoint("BOTTOM", content2.patchNoteArea.one, 0, -content2.patchNoteArea.one:GetHeight())

    -------- Setting text element in Patch Notes two
	content2.patchNoteArea.two.text = content2.patchNoteArea.two:CreateFontString(nil, "ARTWORK")
	content2.patchNoteArea.two.text:SetPoint("LEFT", content2.patchNoteArea.two, "LEFT", 0, 0)
	content2.patchNoteArea.two.text:SetFont("Interface\\AddOns\\RaidResourceCalculator\\Fonts\\GothamNarrowUltra.ttf", 10, "OUTLINE")
    content2.patchNoteArea.two.text:SetText("### - 20190728 | Initial Build")

    -- #####################################
	
    -- ###########################
    

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
