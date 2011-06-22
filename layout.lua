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

Splash:RegisterEvent('ADDON_LOADED')
Splash:SetScript('OnEvent', function(self, event, addon)
	if ( addon ~= ADDON_NAME ) then return end

	SplashSettings = settings.init
end)