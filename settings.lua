--[[ SETTINGS
	Contains the addons settings
]]

local ADDON_NAME, ns = ...

local settings = {}
-- *********************************************************************************

settings.fonts = {
	['grunge'] = [[Interface\AddOns\oUF_Splash\media\Coalition.ttf]],
	['clear'] = [[Interface\AddOns\oUF_Splash\media\accid__.ttf]],
}

settings.tex = {
	['hp'] = [[Interface\AddOns\oUF_Splash\media\hp_fg.tga]],
	['hp_bg'] = [[Interface\AddOns\oUF_Splash\media\hp_bg.tga]],
	['power'] = [[Interface\AddOns\oUF_Splash\media\power_fg.tga]],
	['solid'] = [[Interface\AddOns\oUF_Splash\media\solid.tga]],
	['gloss'] = [[Interface\AddOns\oUF_Splash\media\gloss.tga]],
	['gloss_aura'] = [[Interface\AddOns\oUF_Splash\media\gloss_aura.tga]],
	['overlay'] = [[Interface\AddOns\oUF_Splash\media\overlay.tga]],
}

settings.init = {
	['general'] = {
		['barColor'] = { 0.4, 0.4, 0.4 },
		['barBGColor'] = { 0.7, 0.7, 0.7, 1 },
		['powerBGModifier'] = 0.3,
	},
	['player'] = {
		['width'] = 180,
		['height'] = 32,
		['powerHeight'] = 5,
		['powerXOff'] = 10,
	}
}

-- *********************************************************************************
ns.settings = settings