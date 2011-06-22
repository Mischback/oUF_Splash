--[[ CORE
	Contains the core-functions
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings
local lib = ns.lib

-- Let's get it on!
local core = {}
-- *********************************************************************************

core.CreateUnitFrame = function(self, key)

	cfg = SplashSettings[key]

	self:SetSize(cfg.width, cfg.height)

	-- Creating the Health-bar
	local hp = CreateFrame('StatusBar', nil, self)
	hp:SetFrameLevel(11)
	hp:SetAllPoints(self)
	hp:SetStatusBarTexture(settings.tex.hp)
	hp:SetStatusBarColor(unpack(SplashSettings.general.barColor))

	hp.bg = hp:CreateTexture(nil, 'BACKGROUND')
	hp.bg:SetAllPoints(hp)
	hp.bg:SetTexture(settings.tex.hp_bg)
	hp.bg:SetVertexColor(unpack(SplashSettings.general.barBGColor))

	hp.border = CreateFrame('Frame', nil, hp)
	hp.border:SetFrameLevel(10)
	hp.border:SetPoint('TOPLEFT', hp, 'TOPLEFT', -1, 1)
	hp.border:SetPoint('BOTTOMRIGHT', hp, 'BOTTOMRIGHT', 1, -1)
	hp.border.tex = hp.border:CreateTexture(nil, 'BACKGROUND')
	hp.border.tex:SetAllPoints(hp.border)
	hp.border.tex:SetTexture(0, 0, 0, 1)

	self.Health = hp

end

-- *********************************************************************************
ns.core = core