local AddonName, RaidResourceCalculator = ...

--------------------------------------
-- Custom Slash Command
--------------------------------------
RaidResourceCalculator.commands = {
	["toggle"] = RaidResourceCalculator.MainMenuHandler.Toggle, -- this is a function (no knowledge of MainMenuHandler object)
	["dev"] = RaidResourceCalculator.MainMenuHandler.ToggleDevMode,
	["help"] = function()
		print(" ");
		RaidResourceCalculator:Print("List of slash commands:")
		RaidResourceCalculator:Print("|cff00cc66/rrc toggle|r - shows MainMenuHandler menu");
		RaidResourceCalculator:Print("|cff00cc66/rrc dev|r - reloads the UI");
		RaidResourceCalculator:Print("|cff00cc66/rrc help|r - shows help info");
		print(" ");
	end
};

local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/at" with no additional args.
		RaidResourceCalculator.commands.toggle();
		return;		
	end	
	
	local args = {};
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg);
		end
	end
	
	local path = RaidResourceCalculator.commands; -- required for updating found table.
	
	for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower();			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))); 
					return;
				end
			else
				-- does not exist!
				RaidResourceCalculator.commands.help();
				return;
			end
		end
	end
end

function RaidResourceCalculator:Print(...)
    local hex = select(4, self.MainMenuHandler:GetThemeColor());
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Raid Resource Calculator:");	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...));
end

-- WARNING: self automatically becomes events frame!
function RaidResourceCalculator:init(event, name)
	if (name ~= "RaidResourceCalculator") then return end 

	-- check if saved variables are set, if not create empty
	if (type(RaidResourceCalculatorDB) == "table") then
		RaidResourceCalculatorDB = {}; -- This is the first time this addon is loaded; initialize the count to 0.
	   end

	-- allows using left and right buttons to move through chat 'edit' box
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false);
	end
	
	----------------------------------
	-- Register Slash Commands!
	----------------------------------

	SLASH_FRAMESTK1 = "/fs"; -- new slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools");
		FrameStackTooltip_Toggle();
	end

	SLASH_RaidResourceCalculator1 = "/rrc";
	SlashCmdList.RaidResourceCalculator = HandleSlashCommands;
	
    RaidResourceCalculator:Print("Welcome back", UnitName("player").."!");
end

local events = CreateFrame("Frame");
events:RegisterEvent("ADDON_LOADED");
events:SetScript("OnEvent", RaidResourceCalculator.init);