﻿local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)

--GLOBALS: ElvDB, ElvPrivateDB
local SLE_Test = false

local ProfileNames = NONE
local CharacterNames = NONE

local mediaFonts = {
	'zone',
	'subzone',
	'pvp',
	'mail',
	'gossip',
	'objective',
	'objectiveHeader',
	'questFontSuperHuge',
}

--Convers all the things!
function SLE:DatabaseConversions()
	if ElvDB.SLE_DB_Ver == SLE.DBversion and not SLE_Test then return end --Only execute all this shit when current database is actually outdated.
	--Profile options conversion
	for profile, data in pairs(ElvDB.profiles) do
		-- if profile ~= "Minimalistic" then
		-- print(profile)
		-- end
		local profileChanged = false
		if data and data.sle then
			if data.sle.databars and data.sle.databars.exp then
				E:CopyTable(E.db.sle.databars.experience, data.sle.databars.exp)
				data.sle.databars.exp = nil
				profileChanged = true
			end
			if data.sle.databars and data.sle.databars.rep then
				E:CopyTable(E.db.sle.databars.reputation, data.sle.databars.rep)
				data.sle.databars.rep = nil
				profileChanged = true
			end
			if data.sle.databars and data.sle.databars.reputation and data.sle.databars.reputation.chatfilter and (data.sle.databars.reputation.chatfilter.style and type(data.sle.databars.reputation.chatfilter.style) ~= 'table') then
				local oldValue = E.db.sle.databars.reputation.chatfilter.style
				E.db.sle.databars.reputation.chatfilter.style = {}
				E:CopyTable(E.db.sle.databars.reputation.chatfilter.style, P.sle.databars.reputation.chatfilter.style)
				E.db.sle.databars.reputation.chatfilter.style.increase = oldValue
				profileChanged = true
			end
			if data.sle.Armory then data.sle.Armory = nil
				profileChanged = true
			end
			if data.sle.armory then
				if data.sle.armory.character then
					if data.sle.armory.character.ilvl then
						if data.sle.armory.character.ilvl.fontStyle == 'NONE' then
							data.sle.armory.character.ilvl.fontStyle = ''
							profileChanged = true
						end
					end
					if data.sle.armory.character.enchant then
						if data.sle.armory.character.enchant.fontStyle == 'NONE' then
							data.sle.armory.character.enchant.fontStyle = ''
							profileChanged = true
						end
					end
				end
				if data.sle.armory.inspect then
					if data.sle.armory.inspect.ilvl then
						if data.sle.armory.inspect.ilvl.fontStyle == 'NONE' then
							data.sle.armory.inspect.ilvl.fontStyle = ''
							profileChanged = true
						end
					end
					if data.sle.armory.inspect.enchant then
						if data.sle.armory.inspect.enchant.fontStyle == 'NONE' then
							data.sle.armory.inspect.enchant.fontStyle = ''
							profileChanged = true
						end
					end
				end
				if data.sle.armory.stats then
					if data.sle.armory.stats.enable then
						E.private.sle.armory.stats.enable = data.sle.armory.stats.enable
						data.sle.armory.stats.enable = nil
						profileChanged = true
					end
					if data.sle.armory.stats.itemLevel then
						if data.sle.armory.stats.itemLevel.size then
							E.db.sle.armory.stats.itemLevel.fontSize = data.sle.armory.stats.itemLevel.size
							data.sle.armory.stats.itemLevel.size = nil
							profileChanged = true
						end
						if data.sle.armory.stats.itemLevel.outline then
							E.db.sle.armory.stats.itemLevel.fontOutline = data.sle.armory.stats.itemLevel.outline
							data.sle.armory.stats.itemLevel.outline = nil
							profileChanged = true
						end
					end
					if data.sle.armory.stats.catFonts then
						if data.sle.armory.stats.catFonts.font then
							E.db.sle.armory.stats.statHeaders.font = data.sle.armory.stats.catFonts.font
							data.sle.armory.stats.catFonts.font = nil
							profileChanged = true
						end
						if data.sle.armory.stats.catFonts.size then
							E.db.sle.armory.stats.statHeaders.fontSize = data.sle.armory.stats.catFonts.size
							data.sle.armory.stats.catFonts.size = nil
							profileChanged = true
						end
						if data.sle.armory.stats.catFonts.outline then
							E.db.sle.armory.stats.statHeaders.fontOutline = data.sle.armory.stats.catFonts.outline
							data.sle.armory.stats.catFonts.outline = nil
							profileChanged = true
						end
					end
					if data.sle.armory.stats.statFonts then
						if data.sle.armory.stats.statFonts.font then
							E.db.sle.armory.stats.statLabels.font = data.sle.armory.stats.statFonts.font
							data.sle.armory.stats.statFonts.font = nil
							profileChanged = true
						end
						if data.sle.armory.stats.statFonts.size then
							E.db.sle.armory.stats.statLabels.fontSize = data.sle.armory.stats.statFonts.size
							data.sle.armory.stats.statFonts.size = nil
							profileChanged = true
						end
						if data.sle.armory.stats.statFonts.outline then
							E.db.sle.armory.stats.statLabels.fontOutline = data.sle.armory.stats.statFonts.outline
							data.sle.armory.stats.statFonts.outline = nil
							profileChanged = true
						end
					end
				end
			end
			if data.sle.minimap then
				if data.sle.minimap.locPanel then
					if data.sle.minimap.locPanel.fontOutline == 'NONE' then
						data.sle.minimap.locPanel.fontOutline = ''
						profileChanged = true
					end
					if data.sle.minimap.portals then
						if type(data.sle.minimap.locPanel.portals.hsPrio) == 'table' then
							data.sle.minimap.locPanel.portals.hsPrio = P.sle.minimap.locPanel.portals.hsPrio
							profileChanged = true
						end
					elseif data.sle.minimap.locPanel.portals and data.sle.minimap.locPanel.portals.hsPrio then
						local CurrentDefault = P.sle.minimap.locPanel.portals.hsPrio
						local CurrentSettings = data.sle.minimap.locPanel.portals.hsPrio
						for hs in CurrentDefault:gmatch('%d+') do
							if not CurrentSettings:match(hs) then
								CurrentSettings = CurrentSettings .. ',' .. hs
								profileChanged = true
							end
						end
					end
				end
				if data.sle.minimap.coords then
					if data.sle.minimap.coords.fontOutline and data.sle.minimap.coords.fontOutline == 'NONE' then
						data.sle.minimap.coords.fontOutline = ''
						profileChanged = true
					end
				end
				if data.sle.minimap.instance then
					if data.sle.minimap.instance.fontOutline and data.sle.minimap.instance.fontOutline == 'NONE' then
						data.sle.minimap.instance.fontOutline = ''
						profileChanged = true
					end
				end

			end
			if data.sle.media then
				if data.sle.media.fonts then
					for i = 1, #mediaFonts do
						if data.sle.media.fonts[mediaFonts[i]] then
							if data.sle.media.fonts[mediaFonts[i]].outline then
								E.db.sle.media.fonts[mediaFonts[i]].fontOutline = data.sle.media.fonts[mediaFonts[i]].outline
								data.sle.media.fonts[mediaFonts[i]].outline = nil
								profileChanged = true
							end
							if data.sle.media.fonts[mediaFonts[i]].size then
								E.db.sle.media.fonts[mediaFonts[i]].fontSize = data.sle.media.fonts[mediaFonts[i]].size
								data.sle.media.fonts[mediaFonts[i]].size = nil
								profileChanged = true
							end
						end
					end
				end
			end
			if data.sle.nameplates then
				if data.sle.nameplates.threat then
					if type(data.sle.nameplates.threat) == "table" then
						if data.sle.nameplates.threat.fontOutline and data.sle.nameplates.threat.fontOutline == 'NONE' then
							data.sle.nameplates.threat.fontOutline = ''
							profileChanged = true
						end
					else
						data.sle.nameplates.threat = nil
						profileChanged = true
					end
				end
				if data.sle.nameplates.targetcount then
					if type(data.sle.nameplates.targetcount) == "table" then
						if data.sle.nameplates.targetcount.fontOutline and data.sle.nameplates.targetcount.fontOutline == 'NONE' then
							data.sle.nameplates.targetcount.fontOutline = ''
							profileChanged = true
						end
					else
						data.sle.nameplates.targetcount = nil
						profileChanged = true
					end
				end

			end
			if data.sle.screensaver then
				data.sle.screensaver = nil
				profileChanged = true
			end
			if data.sle.skins then
				if data.sle.skins.merchant then
					if data.sle.skins.merchant.list then
						if data.sle.skins.merchant.list.nameOutline and data.sle.skins.merchant.list.nameOutline == 'NONE' then
							data.sle.skins.merchant.list.nameOutline = ''
							profileChanged = true
						end
						if data.sle.skins.merchant.list.subOutline and data.sle.skins.merchant.list.subOutline == 'NONE' then
							data.sle.skins.merchant.list.subOutline = ''
							profileChanged = true
						end
					end
				end
			end
			if profileChanged then
				if ProfileNames == NONE then
					ProfileNames = profile
				else
					ProfileNames = ProfileNames..', '..profile
				end
			end
		end
	end
	--Private options convert
	for private, data in pairs(ElvPrivateDB.profiles) do
		local privateChanged = false
		if data then
			if data.sle then
				if data.sle.module then
					if data.sle.module.blizzmove then
						if data.sle.module.blizzmove and type(data.sle.module.blizzmove) == 'boolean' then data.sle.module.blizzmove = V.sle.module.blizzmove; privateChanged = true; end --Ancient setting conversions
						if not data.sle.module.blizzmove.points then data.sle.module.blizzmove.points = {} end
						if not data.sle.pvpreadydialogreset then
							data.sle.module.blizzmove.points['PVPReadyDialog'] = nil
							data.sle.pvpreadydialogreset = true
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['CalendarViewEventFrame'] then
							data.sle.module.blizzmove.points['CalendarViewEventFrame'] = nil
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['CalendarViewHolidayFrame'] then
							data.sle.module.blizzmove.points['CalendarViewHolidayFrame'] = nil
							privateChanged = true
						end
						--Remove these from saved variables so the script will not attempt to mess with them, cause they are not ment to be moved permanently
						if data.sle.module.blizzmove.points['BonusRollFrame'] then
							data.sle.module.blizzmove.points['BonusRollFrame'] = nil
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['BonusRollLootWonFrame'] then
							data.sle.module.blizzmove.points['BonusRollLootWonFrame'] = nil
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['BonusRollMoneyWonFrame'] then
							data.sle.module.blizzmove.points['BonusRollMoneyWonFrame'] = nil
							privateChanged = true
						end
						--DF changes
						for i = 1, 4 do
							if data.sle.module.blizzmove.points['StaticPopup'..i] then
								data.sle.module.blizzmove.points['StaticPopup'..i] = nil
								privateChanged = true
							end
						end
						if data.sle.module.blizzmove.points['AudioOptionsFrame'] then
							data.sle.module.blizzmove.points['AudioOptionsFrame'] = nil
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['InterfaceOptionsFrame'] then
							data.sle.module.blizzmove.points['InterfaceOptionsFrame'] = nil
							privateChanged = true
						end
						if data.sle.module.blizzmove.points['VideoOptionsFrame'] then
							data.sle.module.blizzmove.points['VideoOptionsFrame'] = nil
							privateChanged = true
						end
					end
					if data.sle.module.screensaver and type(data.sle.module.screensaver) == 'boolean' then
						data.sle.module.screensaver = nil
						privateChanged = true
					end
				end
				if data.sle.equip then
					if data.sle.equip.onlyTalent then data.sle.equip.onlyTalent = nil end
				end
				if data.sle.professions then
					if data.sle.professions.fishing then
						if data.sle.professions.fishing.CastButton and data.sle.professions.fishing.CastButton == "None" then
							data.sle.professions.fishing.CastButton = "Shift"
							privateChanged = true
						end
					end
				end
				if privateChanged then
					if CharacterNames == NONE then
						CharacterNames = private
					else
						CharacterNames = CharacterNames..', '..private
					end
				end
			end
		end
	end
	--Global settions converted
	local globals = ElvDB.global
	if globals then
		if globals.sle then
			if globals.sle.pvpreadydialogreset then globals.sle.pvpreadydialogreset = nil end
		end
	end

	if not SLE_Test then ElvDB.SLE_DB_Ver = SLE.DBversion end
	E:StaticPopup_Show('SLE_CONVERSION_COMPLETE', ProfileNames, CharacterNames)
end
