local AddonName, RaidResourceCalculator = ...

-- Possible console calls to open the addon
SLASH_RAIDRESOURCECALCULATOR1 = '/rrc'
SLASH_RAIDRESOURCECALCULATOR2 = '/rrcalculator'
SLASH_RAIDRESOURCECALCULATOR2 = '/raidresourcecalc'

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
    message('Hello World')
end
