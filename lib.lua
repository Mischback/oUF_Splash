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

--[[ Shortening the values displayed on the Health- and Power-Bars
	STRING Shorten(INT value)
]]
lib.Shorten = function(value)
	if value >= 1e7 then
		return ('%.1fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e6 then
		return ('%.2fm'):format(value / 1e6):gsub('%.?0+([km])$', '%1')
	elseif value >= 1e5 then
		return ('%.0fk'):format(value / 1e3)
	elseif value >= 1e3 then
		return ('%.1fk'):format(value / 1e3):gsub('%.?0+([km])$', '%1')
	else
		return value
	end
end

-- *********************************************************************************
ns.lib = lib