Crafting = {
	Tools = {
		{ ['mechanic_tools'] = { ['iron'] = 5, ['plastic'] = 5, ['steel'] = 5, ['aluminum'] = 2, } },
		{ ['toolbox'] = { ['iron'] = 4, ['plastic'] = 4, ['steel'] = 4, ['aluminum'] = 2, } },
		{ ['ducttape'] = { ['plastic'] = 15, } },
		{ ['paintcan'] = { ['aluminum'] = 5, ['plastic'] = 3, ['iron'] = 2, ['rubber'] = 1, } },
		{ ['tint_supplies'] = { ['glass'] = 1, ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },
		{ ['underglow_controller'] = { ['glass'] = 10, ['aluminum'] = 5, ['plastic'] = 5, ['iron'] = 10, ['rubber'] = 10, } },
		{ ['cleaningkit'] = { ['plastic'] = 1, ['glass'] = 1, ['rubber'] = 1, ['iron'] = 1, } },
		{ ['carbattery'] = { ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },
		{ ['axleparts'] = { ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },
		{ ['sparetire'] = { ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },
		{ ['newoil'] = { ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },
		{ ['sparkplugs'] = { ['aluminum'] = 1, ['plastic'] = 1, ['iron'] = 1, ['rubber'] = 1, } },

				-- Example : Delete me --
		-- Support for multiple items in recipes --
		-- Support for multiple resulting items --
		-- Support to limit items to certain job roles --
		-- { ["cleaningkit"] = { ["rubber"] = 5, ["engine2"] = 1, ["plastic"] = 2 },
		-- 		["amount"] = 2, ["job"] = { ["mechanic"] = 4, ["tuner"] = 4, } },
		-- 		-- Example : Delete me --

	},
	Perform = {
		{ ['turbo'] = { ['iron'] = 17, ['plastic'] = 17, ['steel'] = 17, ['aluminum'] = 17, ['rubber'] = 17, ['metalscrap'] = 17, } },
		{ ['car_armor'] = { ['plastic'] = 68, ['steel'] = 68, ['iron'] = 68, } },
		{ ['engine1'] = { ['iron'] = 12, ['plastic'] = 12, ['steel'] = 12, ['aluminum'] = 12, ['rubber'] = 12, ['metalscrap'] = 12, ['copper'] = 12, } },
		{ ['engine2'] = { ['iron'] = 14, ['plastic'] = 14, ['steel'] = 14, ['aluminum'] = 14, ['rubber'] = 14, ['metalscrap'] = 14, ['copper'] = 14, } },
		{ ['engine3'] = { ['iron'] = 18, ['plastic'] = 18, ['steel'] = 18, ['aluminum'] = 18, ['rubber'] = 18, ['metalscrap'] = 18, ['copper'] = 18, } },
		{ ['engine4'] = { ['iron'] = 23, ['plastic'] = 23, ['steel'] = 23, ['aluminum'] = 23, ['rubber'] = 23, ['metalscrap'] = 23, ['copper'] = 23, } },
	    -- { ["engine5"] = { ['iron'] = 70, ['plastic'] = 70, ['steel'] = 70, ['aluminum'] = 70, ['rubber'] = 70, ['metalscrap'] = 70, ['copper'] = 70,  }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		{ ['transmission1'] = { ['steel'] = 12, ['aluminum'] = 12, ['rubber'] = 12, ['metalscrap'] = 12, ['copper'] = 12, } },
		{ ['transmission2'] = { ['steel'] = 16, ['aluminum'] = 16, ['rubber'] = 16, ['metalscrap'] = 16, ['copper'] = 16, } },
		{ ['transmission3'] = { ['steel'] = 25, ['aluminum'] = 25, ['rubber'] = 11, ['metalscrap'] = 15, ['copper'] = 22, } },
		-- { ["transmission4"] = { ['steel'] = 48, ['aluminum'] = 48, ['rubber'] = 48, ['metalscrap'] = 48, ['copper'] = 48, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		{ ['brakes1'] = { ['steel'] = 9, ['iron'] = 9, ['plastic'] = 9, ['rubber'] = 9, ['metalscrap'] = 9, ['copper'] = 9, } },
		-- { ['brakes2'] = { ['steel'] = 16, ['iron'] = 16, ['plastic'] = 16, ['rubber'] = 16, ['metalscrap'] = 16, ['copper'] = 16, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		{ ['brakes3'] = { ['steel'] = 36, ['iron'] = 36, ['plastic'] = 36, ['rubber'] = 36, ['metalscrap'] = 36, ['copper'] = 36, } },
		{ ['suspension1'] = { ['steel'] = 13, ['iron'] = 13, ['plastic'] = 13, ['copper'] = 13, } },
		{ ['suspension2'] = { ['steel'] = 18, ['iron'] = 18, ['plastic'] = 18, ['copper'] = 18, } },
		{ ['suspension3'] = { ['steel'] = 26, ['iron'] = 26, ['plastic'] = 26, ['copper'] = 26, } },
		-- { ['suspension4'] = { ['steel'] = 50, ['iron'] = 50, ['plastic'] = 50, ['copper'] = 50, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		-- { ["suspension5"] = { ['steel'] = 67, ['iron'] = 67, ['plastic'] = 67, ['copper'] = 67, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		-- { ['bprooftires'] = { ['steel'] = 7, ['iron'] = 6, ['plastic'] = 5, ['copper'] = 5, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		-- { ['drifttires'] = { ['steel'] = 20, ['iron'] = 11, ['plastic'] = 16, ['copper'] = 11, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		{ ["nos"] = { ["noscan"] = 4, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		-- { ['noscan'] = { ['aluminum'] = 25, ['plastic'] = 25, ['iron'] = 25, ['rubber'] = 25, }, ["amount"] = 1, ["job"] = { ["tuner"] = 4, } },
		-- { ["nos"] = { ["noscan"] = 1, ["steel"] = 1, ["plastic"] = 2 },
		-- ["amount"] = 2, ["job"] = { ["tuner"] = 4, } },
		-- { ["noscan"] = { ["noscan"] = 1, ["steel"] = 1, ["plastic"] = 2 },
		-- ["amount"] = 2, ["job"] = { ["tuner"] = 4, } },
	},
	Cosmetic = {
		{ ['hood'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['roof'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['spoiler'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['bumper'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['skirts'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['exhaust'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['seat'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['livery'] = { ['glass'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, }, },
		{ ['tires'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, ['rubber'] = 1, } },
		{ ['horn'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['internals'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['externals'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['customplate'] = { ['steel'] = 10, } },
		{ ['headlights'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, ['glass'] = 1, } },
		{ ['rims'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['rollcage'] = { ['iron'] = 1, ['plastic'] = 1, ['steel'] = 1, ['aluminum'] = 1, } },
		{ ['noscolour'] = { ['iron'] = 5, ['plastic'] = 5, ['steel'] = 5, ['aluminum'] = 5, } },
	},
}

Stores = {
	ToolItems = {
		label = Loc[Config.Lan]["stores"].tools,
		items = {
			{ name = "mechanic_tools", price = 436, amount = 10, info = {}, type = "item", },
			{ name = "toolbox", price = 364, amount = 10, info = {}, type = "item", },
			{ name = "ducttape", price = 384, amount = 100, info = {}, type = "item", },
			{ name = "paintcan", price = 397, amount = 50, info = {}, type = "item", },
			{ name = "tint_supplies", price = 132, amount = 50, info = {}, type = "item", },
			{ name = "underglow_controller", price = 1000, amount = 50, info = {}, type = "item", },
			{ name = "cleaningkit", price = 118, amount = 100, info = {}, type = "item", },
			{ name = "sparetire", price = 50, amount = 100, info = {}, type = "item", },
			{ name = "axleparts", price = 50, amount = 100, info = {}, type = "item", },
			{ name = "carbattery", price = 50, amount = 100, info = {}, type = "item", },
			{ name = "sparkplugs", price = 50, amount = 100, info = {}, type = "item", },
			{ name = "newoil", price = 50, amount = 100, info = {}, type = "item", },
		},
	},
	PerformItems = {
		label = Loc[Config.Lan]["stores"].perform,
		items = {
			{ name = "turbo", price = 2351, amount = 50, info = {}, type = "item", },
			{ name = "engine1", price = 1853, amount = 50, info = {}, type = "item", },
			{ name = "engine2", price = 2136, amount = 50, info = {}, type = "item", },
			{ name = "engine3", price = 2687, amount = 50, info = {}, type = "item", },
			{ name = "engine4", price = 3478, amount = 50, info = {}, type = "item", },
			-- { name = "engine5", price = 8738, amount = 50, info = {}, type = "item", },
			{ name = "transmission1", price = 1453, amount = 50, info = {}, type = "item", },
			{ name = "transmission2", price = 1983, amount = 50, info = {}, type = "item", },
			{ name = "transmission3", price = 2874, amount = 50, info = {}, type = "item", },
			-- { name = "transmission4", price = 4738, amount = 50, info = {}, type = "item", },
			{ name = "brakes1", price = 1347, amount = 50, info = {}, type = "item", },
			{ name = "brakes2", price = 2123, amount = 50, info = {}, type = "item", },
			-- { name = "brakes3", price = 4326, amount = 50, info = {}, type = "item", },
			{ name = "car_armor", price = 4326, amount = 50, info = {}, type = "item", },
			{ name = "suspension1", price = 1253, amount = 50, info = {}, type = "item", },
			{ name = "suspension2", price = 1761, amount = 50, info = {}, type = "item", },
			{ name = "suspension3", price = 2345, amount = 50, info = {}, type = "item", },
			-- { name = "suspension4", price = 3937, amount = 50, info = {}, type = "item", },
			-- { name = "suspension5", price = 5361, amount = 50, info = {}, type = "item", },
			-- { name = "bprooftires", price = 500000000000, amount = 50, info = {}, type = "item", },
			-- { name = "drifttires", price = 3216, amount = 50, info = {}, type = "item", },
			-- { name = "nos", price = 7349, amount = 50, info = {}, type = "item", },
		},
	},
	StoreItems = {
		label = Loc[Config.Lan]["stores"].cosmetic,
		items = {
			{ name = "hood", price = 167, amount = 50, info = {}, type = "item", },
			{ name = "roof", price = 189, amount = 50, info = {}, type = "item", },
			{ name = "spoiler", price = 235, amount = 50, info = {}, type = "item", },
			{ name = "bumper", price = 218, amount = 50, info = {}, type = "item", },
			{ name = "skirts", price = 152, amount = 50, info = {}, type = "item", },
			{ name = "exhaust", price = 194, amount = 50, info = {}, type = "item", },
			{ name = "seat", price = 278, amount = 50, info = {}, type = "item", },
			{ name = "livery", price = 351, amount = 50, info = {}, type = "item", },
			{ name = "tires", price = 387, amount = 50, info = {}, type = "item", },
			{ name = "horn", price = 295, amount = 50, info = {}, type = "item", },
			{ name = "internals", price = 275, amount = 50, info = {}, type = "item", },
			{ name = "externals", price = 235, amount = 50, info = {}, type = "item", },
			{ name = "customplate", price = 451, amount = 50, info = {}, type = "item", },
			{ name = "headlights", price = 232, amount = 50, info = {}, type = "item", },
			{ name = "rims", price = 189, amount = 100, info = {}, type = "item", },
			{ name = "rollcage", price = 251, amount = 50, info = {}, type = "item", },
			{ name = "noscolour", price = 587, amount = 50, info = {}, type = "item", },
		},
	},
}

-- No Touch
	-- This is corrective code to help simplify the stores for people removing the slot info
	-- Jim shops doesn"t use it but other inventories do
	-- Most people don"t even edit the slots, these lines generate the slot info autoamtically
Stores.StoreItems.slots = #Stores.StoreItems.items
for k in pairs(Stores.StoreItems.items) do Stores.StoreItems.items[k].slot = k end
Stores.PerformItems.slots = #Stores.PerformItems.items
for k in pairs(Stores.PerformItems.items) do Stores.PerformItems.items[k].slot = k end
Stores.ToolItems.slots = #Stores.ToolItems.items
for k in pairs(Stores.ToolItems.items) do Stores.ToolItems.items[k].slot = k end