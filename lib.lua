--[[ LIBRARY
	Contains library-functions
]]

local ADDON_NAME, ns = ...

-- grab other files from the namespace
local settings = ns.settings

-- Let's get it on!
local lib = {}
-- *********************************************************************************

lib.CreateFontObject = function(parent, size, font)
	local fo = parent:CreateFontString(nil, 'OVERLAY')
	fo:SetFont(font, size)
	fo:SetJustifyH('CENTER')
	fo:SetShadowColor(0,0,0)
	fo:SetShadowOffset(1, 1)
	return fo
end

-- *********************************************************************************
ns.lib = lib