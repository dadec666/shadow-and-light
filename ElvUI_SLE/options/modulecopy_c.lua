local SLE, T, E, L, V, P, G = unpack(ElvUI_SLE)
local MC

local function CreateArmory()
	local config = MC:CreateModuleConfigGroup(L["Armory Mode"], "armory", "sle")
	config.get = function(info) return E.global.profileCopy.sle.armory[ info[#info] ] end
	config.set = function(info, value) E.global.profileCopy.sle.armory[ info[#info] ] = value end
	config.args["character"] = {
		order = 2,
		type = "toggle",
		name = L["Character Armory"],
	}
	config.args["inspect"] = {
		order = 3,
		type = "toggle",
		name = L["Inspect Armory"],
	}
	config.args["stats"] = {
		order = 4,
		type = "toggle",
		name = STAT_CATEGORY_ATTRIBUTES,
	}

	return config
end

local function CreateBackgrounds()
	local config = MC:CreateModuleConfigGroup(L["Backgrounds"], "backgrounds", "sle")
	for i = 1, 4 do
		config.args["bg"..i] = {
			order = 1+i,
			type = "toggle",
			name = L["SLE_BG_"..i],
			get = function(info) return E.global.profileCopy.sle.backgrounds[ info[#info] ] end,
			set = function(info, value) E.global.profileCopy.sle.backgrounds[ info[#info] ] = value end
		}
	end

	return config
end

local function CreateChat()
	local config = MC:CreateModuleConfigGroup(L["Chat"], "chat", "sle")
	config.args.justify = {
		order = 2,
		type = "toggle",
		name = L["Chat Frame Justify"],
		get = function(info) return E.global.profileCopy.sle.chat[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.chat[ info[#info] ] = value end
	}
	config.args.tab = {
		order = 3,
		type = "toggle",
		name = L["Tabs"],
		get = function(info) return E.global.profileCopy.sle.chat[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.chat[ info[#info] ] = value end
	}
	config.args.invite = {
		order = 3,
		type = "toggle",
		name = INVITE,
		get = function(info) return E.global.profileCopy.sle.chat[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.chat[ info[#info] ] = value end
	}

	return config
end

local function CreateDatatbarsConfig()
	local config = MC:CreateModuleConfigGroup(L["DataBars"], "databars", "sle")

	config.args.experience = {
		order = 2,
		type = "toggle",
		name = XPBAR_LABEL,
		get = function(info) return E.global.profileCopy.sle.databars[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.databars[ info[#info] ] = value end
	}
	config.args.reputation = {
		order = 3,
		type = "toggle",
		name = REPUTATION,
		get = function(info) return E.global.profileCopy.sle.databars[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.databars[ info[#info] ] = value end
	}
	config.args.honor = {
		order = 4,
		type = "toggle",
		name = HONOR,
		get = function(info) return E.global.profileCopy.sle.databars[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.databars[ info[#info] ] = value end
	}
	config.args.azerite = {
		order = 5,
		type = "toggle",
		name = L["Azerite Bar"],
		get = function(info) return E.global.profileCopy.sle.databars[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.databars[ info[#info] ] = value end
	}

	return config
end

local function CreateSLEDatatextsConfig()
	local config = MC:CreateModuleConfigGroup(L["S&L Datatexts"], "dt", "sle")
	config.args.friends = {
		order = 2,
		type = "toggle",
		name = L["S&L Friends"],
		get = function(info) return E.global.profileCopy.sle.dt[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.dt[ info[#info] ] = value end
	}

	config.args.guild = {
		order = 3,
		type = "toggle",
		name = L["S&L Guild"],
		get = function(info) return E.global.profileCopy.sle.dt[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.dt[ info[#info] ] = value end
	}
	config.args.mail = {
		order = 4,
		type = "toggle",
		name = L["S&L Mail"],
		get = function(info) return E.global.profileCopy.sle.dt[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.dt[ info[#info] ] = value end
	}
	config.args.currency = {
		order = 6,
		type = "toggle",
		name = "S&L Currency",
		get = function(info) return E.global.profileCopy.sle.dt[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.dt[ info[#info] ] = value end
	}
	config.args.regen = {
		order = 7,
		type = "toggle",
		name = MANA_REGEN,
		get = function(info) return E.global.profileCopy.sle.dt[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.dt[ info[#info] ] = value end
	}

	return config
end

local function CreateLegacyConfig()
	local config = MC:CreateModuleConfigGroup(SLE.Russian and ITEM_QUALITY7_DESC or LFG_LIST_LEGACY, "legacy", "sle")
	config.args.garrison = {
		order = 3,
		type = "toggle",
		name = GARRISON_LOCATION_TOOLTIP,
		get = function(info) return E.global.profileCopy.sle.legacy[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.legacy[ info[#info] ] = value end
	}
	config.args.orderhall = {
		order = 4,
		type = "toggle",
		name = L["Class Hall"],
		get = function(info) return E.global.profileCopy.sle.legacy[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.legacy[ info[#info] ] = value end
	}
	config.args.warwampaign = {
		order = 5,
		type = "toggle",
		name = WAR_CAMPAIGN,
		get = function(info) return E.global.profileCopy.sle.legacy[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.legacy[ info[#info] ] = value end
	}

	return config
end

local function CreateLootConfig()
	local config = MC:CreateModuleConfigGroup(L["Loot"], "loot", "sle")
	config.args.autoroll = {
		order = 2,
		type = "toggle",
		name = L["Loot Auto Roll"],
		get = function(info) return E.global.profileCopy.sle.loot[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.loot[ info[#info] ] = value end
	}
	config.args.announcer = {
		order = 3,
		type = "toggle",
		name = L["Loot Announcer"],
		get = function(info) return E.global.profileCopy.sle.loot[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.loot[ info[#info] ] = value end
	}
	config.args.history = {
		order = 4,
		type = "toggle",
		name = L["Loot Roll History"],
		get = function(info) return E.global.profileCopy.sle.loot[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.loot[ info[#info] ] = value end
	}
	config.args.looticons = {
		order = 5,
		type = "toggle",
		name = L["Loot Icons"],
		get = function(info) return E.global.profileCopy.sle.loot[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.loot[ info[#info] ] = value end
	}

	return config
end

local function CreateMinimapConfig()
	local config = MC:CreateModuleConfigGroup(MINIMAP_LABEL, "minimap", "sle")
	config.args.coords = {
		order = 2,
		type = "toggle",
		name = L["Coordinates"],
		get = function(info) return E.global.profileCopy.sle.minimap[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.minimap[ info[#info] ] = value end
	}
	config.args.instance = {
		order = 4,
		type = "toggle",
		name = L["Instance indication"],
		get = function(info) return E.global.profileCopy.sle.minimap[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.minimap[ info[#info] ] = value end
	}
	config.args.locPanel = {
		order = 5,
		type = "toggle",
		name = L["Location Panel"],
		get = function(info) return E.global.profileCopy.sle.minimap[ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.minimap[ info[#info] ] = value end
	}

	return config
end

local function CreateUnitframesConfig()
	local config = MC:CreateModuleConfigGroup(L["UnitFrames"], "unitframes", "sle")
	config.args.unit = {
		order = 2,
		type = "group",
		guiInline = true,
		name = L["UnitFrames"],
		get = function(info) return E.global.profileCopy.sle.unitframes[info[#info - 1]][ info[#info] ] end,
		set = function(info, value) E.global.profileCopy.sle.unitframes[info[#info - 1]][ info[#info] ] = value end,
		args = {
			["player"] = {
				order = 1,
				type = "toggle",
				name = L["Player Frame"],
			},
			["target"] = {
				order = 2,
				type = "toggle",
				name = L["Target Frame"],
			},
			["targettarget"] = {
				order = 3,
				type = "toggle",
				name = L["TargetTarget Frame"],
			},
			["targettargettarget"] = {
				order = 4,
				type = "toggle",
				name = L["TargetTargetTarget Frame"],
			},
			["focus"] = {
				order = 5,
				type = "toggle",
				name = L["Focus Frame"],
			},
			["focustarget"] = {
				order = 6,
				type = "toggle",
				name = L["FocusTarget Frame"],
			},
			["pet"] = {
				order = 7,
				type = "toggle",
				name = L["Pet Frame"],
			},
			["pettarget"] = {
				order = 8,
				type = "toggle",
				name = L["PetTarget Frame"],
			},
			["boss"] = {
				order = 9,
				type = "toggle",
				name = L["Boss Frames"],
			},
			["arena"] = {
				order = 10,
				type = "toggle",
				name = L["Arena Frames"],
			},
			["party"] = {
				order = 11,
				type = "toggle",
				name = L["Party Frames"],
			},
			["raid1"] = {
				order = 12,
				type = "toggle",
				name = L["Raid 1 Frames"],
			},
			["raid2"] = {
				order = 12,
				type = "toggle",
				name = L["Raid 2 Frames"],
			},
			["raid3"] = {
				order = 13,
				type = "toggle",
				name = L["Raid 3 Frames"],
			},
		},
	}

	return config
end

local function configTable()
	if not E.Options.args.modulecontrol then return end
	local ACH = E.Libs.ACH
	MC = E.ModuleCopy

	E.Options.args.modulecontrol.args.modulecopy.args.sle = {
		order = 30,
		type = 'group',
		name = SLE.Title,
		childGroups = "tab",
		-- disabled = E.Options.args.profiles.args.profile.args.copyfrom.disabled,
		args = {
			header = ACH:Header(L["|cff9482c9Shadow & Light|r options"], 0),
			actionbar = MC:CreateModuleConfigGroup(L["ActionBars"], "actionbars", "sle"),
			armory = CreateArmory(),
			backgrounds = CreateBackgrounds(),
			blizzard = MC:CreateModuleConfigGroup("Blizzard", "blizzard", "sle"),
			chat = CreateChat(),
			databars = CreateDatatbarsConfig(),
			dt = CreateSLEDatatextsConfig(),
			legacy = CreateLegacyConfig(),
			lfr = MC:CreateModuleConfigGroup(RAID_FINDER, "lfr", "sle"),
			loot = CreateLootConfig(),
			media = MC:CreateModuleConfigGroup(L["Media"], "media", "sle"),
			minimap = CreateMinimapConfig(),
			nameplates = MC:CreateModuleConfigGroup(L["NamePlates"], "nameplates", "sle"),
			quests = MC:CreateModuleConfigGroup(QUESTS_LABEL, "quests", "sle"),
			pvp = MC:CreateModuleConfigGroup(PVP, "pvp", "sle"),
			raidmanager = MC:CreateModuleConfigGroup(RAID_CONTROL, "raidmanager", "sle"),
			raidmarkers = MC:CreateModuleConfigGroup(L["Raid Markers"], "raidmarkers", "sle"),
			afk = MC:CreateModuleConfigGroup(L["AFK Mode"], "afk", "sle"),
			shadows = MC:CreateModuleConfigGroup(L["Enhanced Shadows"], "shadows", "sle"),
			skins = MC:CreateModuleConfigGroup(L["Skins"], "skins", "sle"),
			tooltip = MC:CreateModuleConfigGroup(L["Tooltip"], "tooltip", "sle"),
			uibuttons = MC:CreateModuleConfigGroup(L["UI Buttons"], "uibuttons", "sle"),
			unitframes = CreateUnitframesConfig(),
		},
	}
end

tinsert(SLE.Configs, configTable)
