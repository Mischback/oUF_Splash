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

--[[ Creates an abstract unit-frame with healthbar & -value, powerbar, Threat-overlay and menu.
	VOID createUnitFrame(FRAME self, STRING key)
	STRING key is the access to the SavedVariables-array, where settings like the size are stored.
]]
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

	-- Creating the Power-bar
	local pb = CreateFrame('StatusBar', nil, self)
	pb:SetFrameLevel(61)
	pb:SetHeight(cfg.powerHeight)
	pb:SetPoint('LEFT', self, 'BOTTOMLEFT', cfg.powerXOff, 0)
	pb:SetPoint('RIGHT', self, 'BOTTOMRIGHT', -cfg.powerXOff, 0)
	pb:SetStatusBarTexture(settings.tex.power)

	pb.bg = pb:CreateTexture(nil, 'BACKGROUND')
	pb.bg:SetAllPoints(pb)
	pb.bg:SetTexture(settings.tex.solid)
	pb.bg:SetAlpha(SplashSettings.general.powerBGModifier)

	pb.border = CreateFrame('Frame', nil, pb)
	pb.border:SetFrameLevel(60)
	pb.border:SetPoint('TOPLEFT', pb, 'TOPLEFT', -1, 1)
	pb.border:SetPoint('BOTTOMRIGHT', pb, 'BOTTOMRIGHT', 1, -1)
	pb.border.tex = pb.border:CreateTexture(nil, 'BACKGROUND')
	pb.border.tex:SetAllPoints(pb.border)
	pb.border.tex:SetTexture(0, 0, 0, 1)

	pb.colorDisconnected = true
	pb.colorClass = true
	pb.colorReaction = true

	self.Power = pb

	-- Text-holder
	self.Text = CreateFrame('Frame', nil, self)
	self.Text:SetFrameLevel(31)

	self.Health.value = lib.CreateFontObject(self.Text, 14, settings.fonts.grunge)
	self.Health.value:SetJustifyH('RIGHT')
	self.Health.value:SetPoint('BOTTOMRIGHT', self.Health, 'BOTTOMRIGHT', -2, 6)

	self.Gloss = CreateFrame('Frame', nil, self)
	self.Gloss:SetFrameLevel(50)
	self.Gloss:SetAllPoints(self)
	self.Gloss.left = self.Gloss:CreateTexture(nil, 'OVERLAY')
	self.Gloss.left:SetSize(13, cfg.height)
	self.Gloss.left:SetTexture(settings.tex.gloss)
	self.Gloss.left:SetTexCoord(0, 0.25, 0, 1)
	self.Gloss.left:SetPoint('TOPLEFT')
	self.Gloss.right = self.Gloss:CreateTexture(nil, 'OVERLAY')
	self.Gloss.right:SetSize(13, cfg.height)
	self.Gloss.right:SetTexture(settings.tex.gloss)
	self.Gloss.right:SetTexCoord(0.75, 1, 0, 1)
	self.Gloss.right:SetPoint('TOPRIGHT')
	self.Gloss.mid = self.Gloss:CreateTexture(nil, 'OVERLAY')
	self.Gloss.mid:SetHeight(cfg.height)
	self.Gloss.mid:SetTexture(settings.tex.gloss)
	self.Gloss.mid:SetTexCoord(0.25, 0.75, 0, 1)
	self.Gloss.mid:SetPoint('TOPLEFT', self.Gloss.left, 'TOPRIGHT')
	self.Gloss.mid:SetPoint('TOPRIGHT', self.Gloss.right, 'TOPLEFT')

end

--[[ Adds a name to the unitframe
	VOID createUnitFrameName(FRAME self, STRING key)
	STRING key is the access to the SavedVariables-array, where settings like the size are stored.
]]
core.CreateUnitFrameName = function(self, key)

	core.CreateUnitFrame(self, key)

	-- creating the name
	self.Name = lib.CreateFontObject(self.Power, 12, settings.fonts.grunge)
	self.Name:SetPoint('LEFT', self.Health, 'TOPLEFT', 4, -2)
	self.Name:SetPoint('RIGHT', self.Health, 'TOPRIGHT', -2, -2)

	self.Health.PostUpdate = core.UpdateHealth_percent
	self.UNIT_NAME_UPDATE = core.UpdateName

end

--[[ Adds a castbar to the frame (castbar will show upon the health-bar).
	VOID createUnitFrameCastbar(FRAME self, STRING key)
	STRING key is the access to the SavedVariables-array, where settings like the size are stored.
]]
core.CreateUnitFrameCastbar = function(self, key)

	core.CreateUnitFrameName(self, key)

	-- the Castbar
	local cb = CreateFrame('StatusBar', nil, self)
	cb:SetFrameLevel(41)
	cb:SetStatusBarTexture(settings.tex.hp_bg, 'ARTWORK')
	cb:SetStatusBarColor(0.86, 0.5, 0, 1)
	cb:SetAllPoints(self.Health)

	cb.bg = cb:CreateTexture(nil, 'BACKGROUND')
	cb.bg:SetAllPoints(cb)
	cb.bg:SetTexture(settings.tex.hp)
	cb.bg:SetVertexColor(0.1, 0.1, 0.1)

	cb.Text = lib.CreateFontObject(cb, 16, settings.fonts.clear)
	cb.Text:SetPoint('LEFT', 3, 0)
	cb.Text:SetPoint('RIGHT', -3, 0)
	cb.Text:SetTextColor(1, 1, 1)

	self.Castbar = cb
end

-- *********************************************************************************
-- ***** ENGINES *******************************************************************
-- *********************************************************************************

--[[ Player's Health-value 
	VOID UpdateHealth_player(FRAME health, STRING unit, INT min, INT max)
	Plain HP, just the current value!
]]
core.UpdateHealth_player = function(health, unit, min, max)
	health.value:SetText(lib.Shorten(min))
end

--[[ Percent Health-value
	VOID UpdateHealth_percent(FRAME health, STRING unit, INT min, INT max)
	HP as %, triggers the update of the unit's name.
]]
core.UpdateHealth_percent = function(health, unit, min, max)
	health.value:SetFormattedText('%d', (min/max)*100)
	health:GetParent():UNIT_NAME_UPDATE(event, unit)
end

-- *********************************************************************************

--[[ Just the name...
	VOID UpdateName(FRAME self, STRING event, STRING unit)
]]
core.UpdateName = function(self, event, unit)
	local name = UnitName(unit)
	self.Name:SetText(name)
end

-- *********************************************************************************
ns.core = core