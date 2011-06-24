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

--[[

]]
local function createPlayer(self)
	core.CreateUnitFrame(self, 'player')

	self.Health.PostUpdate = core.UpdateHealth_player
end

--[[

]]
local function createTarget(self)
	core.CreateUnitFrameCastbar(self, 'target')

	self.Castbar.Text:SetPoint('RIGHT', -15, 0)
	self.Castbar.Time = lib.CreateFontObject(self.Castbar, 16, settings.fonts.clear)
	self.Castbar.Time:SetPoint('RIGHT', -3, 0)
	self.Castbar.Time:SetTextColor(1, 1, 1)
	self.Castbar.Time:SetJustifyH('RIGHT')
end

-- *********************************************************************************
Splash:RegisterEvent('ADDON_LOADED')
Splash:SetScript('OnEvent', function(self, event, addon)
	if ( addon ~= ADDON_NAME ) then return end

	SplashSettings = settings.init

	oUF:RegisterStyle('oUF_Splash_player', createPlayer)
	oUF:RegisterStyle('oUF_Splash_target', createTarget)

	oUF:SetActiveStyle('oUF_Splash_player')
	oUF:Spawn('player', 'oUF_Splash_player'):SetPoint('RIGHT', UIParent, 'CENTER', -100, -200)

	oUF:SetActiveStyle('oUF_Splash_target')
	oUF:Spawn('target', 'oUF_Splash_target'):SetPoint('LEFT', UIParent, 'CENTER', 100, -200)
end)