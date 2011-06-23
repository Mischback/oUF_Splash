--[[ LAYOUT
	Contains the layout
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib
local core = ns.core

-- Let's get it on!
local Splash = CreateFrame('Frame')
SplashSettings = nil
-- *********************************************************************************

local function createPlayer(self)
	core.CreateUnitFrame(self, 'player')

	self.Health.PostUpdate = core.UpdateHealth_player
end

-- *********************************************************************************
Splash:RegisterEvent('ADDON_LOADED')
Splash:SetScript('OnEvent', function(self, event, addon)
	if ( addon ~= ADDON_NAME ) then return end

	SplashSettings = settings.init

	oUF:RegisterStyle('oUF_Splash_player', createPlayer)

	oUF:Spawn('player', 'oUF_Splash_player'):SetPoint('RIGHT', UIParent, 'CENTER', -100, -200)
end)