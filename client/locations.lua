local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('QBCore:Client:UpdateObject', function() QBCore = exports['qb-core']:GetCoreObject() end)

PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData) PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
			for _, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
			if havejob then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end)
RegisterNetEvent('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
		for _, v in pairs(Config.JobRoles) do if v == PlayerJob.name then havejob = true end end
		if havejob then onDuty = PlayerJob.onduty end end)
	Wait(500)
end)

local till = {}
local laptop = {}
local nos = {}
local parking = {}
local bench = {}
local Targets = {}

CreateThread(function()
	if Config.LocationRequired then
		for k in pairs(Config.Locations) do
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].job, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside)
				if isPointInside then
					if Config.RequiresJob then
						if PlayerJob.name == tostring(Config.Locations[k].job) then	injob = true
							if Config.Locations[k].autoClock.enter and not onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					else injob = true end
				else
					if Config.RequiresJob then
						if PlayerJob.name == tostring(Config.Locations[k].job) then injob = false
							if Config.Locations[k].autoClock.exit and onDuty then TriggerServerEvent("QBCore:ToggleDuty") end
						end
					else injob = false end
				end
			end)
		end
	end
	for k, v in pairs(Config.Locations) do
	--Blip Creation
		if v.blip then
			if Config.LocationBlips then
				local blip = AddBlipForCoord(v.blip)
				SetBlipAsShortRange(blip, true)
				SetBlipSprite(blip, 446)
				SetBlipColour(blip, v.blipcolor)
				SetBlipScale(blip, 0.7)
				SetBlipDisplay(blip, 6)
				BeginTextCommandSetBlipName('STRING')
				if v.bliplabel then AddTextComponentString(v.bliplabel)
				else AddTextComponentString("Mechanic Shop") end
				EndTextCommandSetBlipName(blip)
			end
		end

	--Make Crafting Locations
		if Config.Crafting then
			if v.crafting then
				for l, b in pairs(v.crafting) do
					Targets["MechCraft: "..k..l] =
					exports['qb-target']:AddBoxZone("MechCraft: "..k..l, b.coords.xyz, b.w, b.d, { name="MechCraft: "..k..l, heading = b.coords.w, debugPoly=Config.Debug, minZ=b.coords.z-1.0, maxZ=b.coords.z+1.0 },
						{ options = { { event = "qb-mechanic:client:Crafting:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["crafting"].menuheader, job = v.job }, },
							distance = 2.0 })
				end
			end
		end

	--Make Store Locations
		if Config.Stores then
			if v.store then
				for l, b in pairs(v.store) do
					Targets["MechStore: "..k..l] =
					exports['qb-target']:AddBoxZone("MechStore: "..k..l, b.coords.xyz, b.w, b.d, { name="MechStore: "..k..l, heading = b.coords.w, debugPoly=Config.Debug, minZ=b.coords.z-1.0, maxZ=b.coords.z+1.0 },
						{ options = { { event = "qb-mechanic:client:Store:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["stores"].browse, job = v.job }, },
							distance = 2.0 })
				end
			end
		end

	--Make Cash Register Locations
		if v.payments then
			local v = v.payments
			Targets["MechReceipt: "..k] =
			exports['qb-target']:AddBoxZone("MechReceipt: "..k, v.coords.xyz, (v.w or 0.47), (v.d or 0.34), { name="MechReceipt: "..k, heading = v.coords.w, debugPoly=Config.Debug, minZ=v.coords.z-0.1, maxZ=v.coords.z+0.4 },
				{ options = { { event = "jim-payments:client:Charge", icon = "fas fa-credit-card", label = Loc[Config.Lan]["payments"].charge, job = v.job, img = v.img }, },
					distance = 2.0
			})
			if v.prop then till[#till+1] = makeProp({prop = `prop_till_03`, coords = vec4(v.coords.x, v.coords.y, v.coords.z+1.03, v.coords.w+180.0)}, 1, false) end
		end

	--Make Mechanic Stash locations
		if ((Config.StashRepair and not Config.FreeRepair) or Config.StashCraft) or Config.ShowStash then
			if Config.RequiresJob then
				if v.stash then
					for l, b in pairs(v.stash) do
						Targets["MechSafe: "..k..l] =
						exports['qb-target']:AddBoxZone("MechSafe: "..k..l, b.coords.xyz, b.w, b.d, { name="MechSafe: "..k..l, heading = b.coords.w, debugPoly=Config.Debug, minZ=b.coords.z-1.0, maxZ=b.coords.z+1.0 },
							{ options = { { event = "qb-mechanic:client:Safe", icon = "fas fa-cogs", label = Loc[Config.Lan]["repair"].browse, job = v.job }, },
								distance = 2.0 })
					end
				end
			end
		end
	if v.clockin then
		for l, b in pairs(v.clockin) do
			if type(b) ~= "boolean" then
				local bossrole = {}
				for grade in pairs(QBCore.Shared.Jobs[v.job].grades) do
					if QBCore.Shared.Jobs[v.job].grades[grade].isboss == true then
						if bossrole[v.job] then
							if bossrole[v.job] > tonumber(grade) then bossrole[v.job] = tonumber(grade) end
						else bossrole[v.job] = tonumber(grade) end
					end
				end
				if b.prop then laptop[#laptop+1] = makeProp({prop = `prop_laptop_01a`, coords = vec4(b.coords.x, b.coords.y, b.coords.z+1.03, b.coords.w+180.0)}, 1, false) end

				Targets["MechClock: "..k..l] =
				exports['qb-target']:AddBoxZone("MechClock: "..k..l, b.coords.xyz, (b.w or 0.45), (b.d or 0.4), { name="MechClock: "..k..l, heading = b.coords.w, debugPoly=Config.Debug, minZ=b.coords.z-0.1, maxZ=b.coords.z+0.4 },
					{ options = {
						{ type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-clipboard", label = "Duty Toggle", job = v.job },
						{ event = "qb-management:client:OpenMenu", icon = "fas fa-list", label = "Open Bossmenu", job = bossrole, },
					},
					distance = 2.0 })
			end
		end
	end

	--Manual Repair Bench
		if v.manualRepair then
			for l, b in pairs(v.manualRepair) do
				if b.prop then bench[#bench+1] = makeProp({coords = vec4(b.coords.x, b.coords.y, b.coords.z-1.37, b.coords.w), prop = `gr_prop_gr_bench_03a`}, 1, 0) end
				Targets["RepairBench: "..k..l] =
				exports['qb-target']:AddBoxZone("RepairBench: "..k..l, b.coords.xyz, (b.w or 1.2), (b.w or 4.2), { name="RepairBench: "..k..l, heading = b.coords.w, debugPoly=Config.Debug, minZ = b.coords.z-1, maxZ = b.coords.z+1.4, },
					{ options = { { event = "qb-mechanic:client:Manual:Menu", icon = "fas fa-cogs", label = Loc[Config.Lan]["police"].userepair, society = v.job }, }, distance = 5.0 })
			end
		end

	--Garage Locations
		if v.garage then
			local out = v.garage.out

			if v.garage.prop then parking[#parking+1] = makeProp({prop = `prop_parkingpay`, coords = out}, 1, false) end
			Targets["MechGarage: "..k] =
			exports['qb-target']:AddBoxZone("MechGarage: "..k, vec3(out.x, out.y, out.z-1.03), 0.8, 0.5, { name="MechGarage: "..k, heading = out[4]+180.0, debugPoly=Config.Debug, minZ=(out.z-1.03)-0.1, maxZ=out.z-1.03+1.3 },
				{ options = { { event = "qb-mechanic:client:Garage:Menu", icon = "fas fa-clipboard", label = Loc[Config.Lan]["garage"].jobgarage, job = v.job, coords = v.garage.spawn, list = v.garage.list }, },
				distance = 2.0 })
		end

	--NosRefill Locations
		if v.nosrefill then
			for l, b in pairs(v.nosrefill) do
				nos[#nos+1] = makeProp({prop = `prop_byard_gastank02`, coords = vec4(b.coords.x, b.coords.y, b.coords.z, b.coords.w+180.0)}, 1, false)

				Targets["MechNos: "..k..l] =
				exports['qb-target']:AddBoxZone("MechNos: "..k..l, vec3(b.coords.x, b.coords.y, b.coords.z), 0.7, 0.7, { name="MechNos: "..k..l, heading = b.coords[4], debugPoly=Config.Debug, minZ=b.coords.z-1.05, maxZ=b.coords.z+0.25 },
					{ options = { { event = "qb-mechanic:client:NosRefill", item = "noscan", icon = "fas fa-gauge-high", label = "NOS ($"..Config.NosRefillCharge..")", coords = b.coords, tank = nos[#nos], society = v.job }, },
					distance = 2.0 })

			end
		end
	end
end)

----- CRAFTING STUFF -------
RegisterNetEvent('qb-mechanic:client:Crafting:Menu', function()
	local Menu = {}
	Menu[#Menu + 1] = { isMenuHeader = true, header = Loc[Config.Lan]["crafting"].menuheader, txt = "", }
	Menu[#Menu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "qb-mechanic:client:Menu:Close" } }
	Menu[#Menu + 1] = { header = Loc[Config.Lan]["crafting"].toolheader, txt = #Crafting.Tools..Loc[Config.Lan]["crafting"].numitems, params = { event = "qb-mechanic:Crafting", args = { craftable = Crafting.Tools, header = Loc[Config.Lan]["crafting"].toolheader, } } }
	Menu[#Menu + 1] = { header = Loc[Config.Lan]["crafting"].performheader, txt = #Crafting.Perform..Loc[Config.Lan]["crafting"].numitems, params = { event = "qb-mechanic:Crafting", args = { craftable = Crafting.Perform, header = Loc[Config.Lan]["crafting"].performheader, } } }
	Menu[#Menu + 1] = { header = Loc[Config.Lan]["crafting"].cosmetheader, txt = #Crafting.Cosmetic..Loc[Config.Lan]["crafting"].numitems, params = { event = "qb-mechanic:Crafting", args = { craftable = Crafting.Cosmetic, header = Loc[Config.Lan]["crafting"].cosmetheader, } } }
	exports['arshia-menu']:openMenu(Menu)
end)

RegisterNetEvent('qb-mechanic:Crafting', function(data)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { icon = "fas fa-circle-arrow-left", header = "", txt = string.gsub(Loc[Config.Lan]["common"].ret, "⬅️ ", ""), params = { event = "qb-mechanic:client:Crafting:Menu" } }
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if k ~= "amount" and k ~= "job" then
				if data.craftable[i]["job"] then hasjob = false
					for l, b in pairs(data.craftable[i]["job"]) do
						if l == PlayerJob.name and PlayerJob.grade.level >= b then hasjob = true end
					end
				end
				if not QBCore.Shared.Items[k] then print("^5Debug^7: ^2Item not found in server^7: '^6"..k.."^7'") else
					if data.craftable[i]["job"] and hasjob == false then else
						local text = ""
						setheader = "<img src=nui://"..Config.img..QBCore.Shared.Items[k].image.." width=30px onerror='this.onerror=null; this.remove();'> "..QBCore.Shared.Items[tostring(k)].label
						if data.craftable[i]["amount"] then setheader = setheader.." x"..data.craftable[i]["amount"] end
						local disable = false
						local checktable = {}
						for l, b in pairs(data.craftable[i][tostring(k)]) do
							if b == 1 then number = "" else number = " x"..b end
							text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
							settext = text
							if not Config.StashCraft then checktable[l] = HasItem(l, b) end
							Wait(0)
						end
						for _, v in pairs(checktable) do if v == false then disable = true break end end
						if not Config.StashCraft then if not disable then setheader = setheader.." ✔️" end end
						Menu[#Menu + 1] = { disabled = disable, icon = k, header = setheader, txt = settext, params = { event = "qb-mechanic:Crafting:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } } }
						settext, setheader = nil
					end
				end
			end
		end
	end
	exports['arshia-menu']:openMenu(Menu)
end)

RegisterNetEvent('qb-mechanic:Crafting:MakeItem', function(data)
	QBCore.Functions.TriggerCallback('qb-mechanic:Crafting:get', function(amount)
		if not amount then triggerNotify(nil, Loc[Config.Lan]["crafting"].ingredients, 'error') else TriggerEvent('qb-mechanic:Crafting:ItemProgress', data) end
	end, data.item, data.craft)
end)

RegisterNetEvent('qb-mechanic:Crafting:ItemProgress', function(data)
	QBCore.Functions.Progressbar('making_food', "Crafting "..QBCore.Shared.Items[data.item].label, 7000, false, true, { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
	{ animDict = "mini@repair", anim = "fixing_a_ped", flags = 8, },
	{}, {}, function()
		qblog("Crafted `"..data.item.."`")
		TriggerServerEvent('qb-mechanic:Crafting:GetItem', data.item, data.craft)
		emptyHands(PlayerPedId())
		TriggerEvent("qb-mechanic:Crafting", data)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		emptyHands(PlayerPedId())
	end, data.item)
end)

------ Nos Refill -------
local refilling = false
RegisterNetEvent('qb-mechanic:client:NosRefill', function(data)
	if refilling then return end
	local p = promise.new()	QBCore.Functions.TriggerCallback('qb-mechanic:checkCash', function(cb) p:resolve(cb) end)
	local cash = Citizen.Await(p)
	if cash >= Config.NosRefillCharge then
		refilling = true
		local coords = GetOffsetFromEntityInWorldCoords(data.tank, 0, 0.5, 0.02)
		local prop = makeProp({prop = `v_ind_cs_gascanister`, coords = vec4(coords.x, coords.y, coords.z+1.03, data.coords.w)}, 1, 1)

		if not IsPedHeadingTowardsPosition(PlayerPedId(), coords, 20.0) then
			TaskTurnPedToFaceCoord(PlayerPedId(), coords, 1500) Wait(1500)
		end
		if #(coords - GetEntityCoords(PlayerPedId())) > 1.3 then TaskGoStraightToCoord(PlayerPedId(), coords, 0.5, 400, 0.0, 0) Wait(400) end

		UseParticleFxAssetNextCall('core')
		local gas = StartParticleFxLoopedOnEntity('ent_sht_steam', prop, 0.02, 0.00, 0.42, 0.0, 0.0, 0.0, 0.1, 0, 0, 0)

		QBCore.Functions.Progressbar('making_food', "Refilling "..QBCore.Shared.Items["nos"].label, 7000, false, true, { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
		{ task = "CODE_HUMAN_MEDIC_TEND_TO_DEAD" },
		{}, {}, function()
			qblog("Purchased a NOS refill")
			TriggerServerEvent("qb-mechanic:chargeCash", Config.NosRefillCharge, data.society)
			toggleItem(false, "noscan", 1)
			toggleItem(true, "nos", 1)
			DeleteObject(prop)
			prop = nil
			StopParticleFxLooped(gas)
			gas = nil
			emptyHands(PlayerPedId())
			refilling = false
		end, function() -- Cancel
			DeleteObject(prop)
			StopParticleFxLooped(gas)
			gas = nil
			emptyHands(PlayerPedId())
			prop = nil
			refilling = false
		end, "nos")
	else
		triggerNotify(nil, "Not enough cash", "error") return
	end
end)

------ Store Stuff ------
-- Menu to pick the store
RegisterNetEvent('qb-mechanic:client:Store:Menu', function(data)
    exports['arshia-menu']:openMenu({
        { header = Loc[Config.Lan]["stores"].tools, txt = "", params = { event = "qb-mechanic:client:Store", args = { id = 1, job = data.job } } },
        { header = Loc[Config.Lan]["stores"].perform, txt = "", params = { event = "qb-mechanic:client:Store", args = { id = 2, job = data.job } } },
        { header = Loc[Config.Lan]["stores"].cosmetic, txt = "", params = { event = "qb-mechanic:client:Store", args = { id = 3, job = data.job } } },
    })
end)

-- Open the selected store
RegisterNetEvent('qb-mechanic:client:Store', function(data)
	local event = "inventory:server:OpenInventory" if Config.JimShops then event = "qb-shops:ShopOpen" end
	if data.id == 1 then TriggerServerEvent(event, "shop", data.job, Stores.ToolItems)
	elseif data.id == 2 then TriggerServerEvent(event, "shop", data.job, Stores.PerformItems)
	elseif data.id == 3 then TriggerServerEvent(event, "shop", data.job, Stores.StoreItems) end
end)

------ Repair Stash Stuff -----
RegisterNetEvent('qb-mechanic:client:Safe', function(data) TriggerEvent("inventory:client:SetCurrentStash", data.job.."Safe") TriggerServerEvent("inventory:server:OpenInventory", "stash", data.job.."Safe", { maxweight = 4000000, slots = 50, }) end)

-------- Garage Stuff ---------
local currentVeh = { out = false, current = nil }
local garageBlip = nil

RegisterNetEvent('qb-mechanic:client:Garage:Menu', function(data)
	loadAnimDict("amb@prop_human_atm@male@enter")
	TaskPlayAnim(PlayerPedId(), 'amb@prop_human_atm@male@enter', "enter", 1.0,-1.0, 1500, 1, 1, true, true, true)
	local vehicleMenu = { { icon = "fas fa-car-tunnel", header = Loc[Config.Lan]["garage"].jobgarage, isMenuHeader = true } }
	if Config.JimMenu then vehicleMenu[#vehicleMenu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = string.gsub(Loc[Config.Lan]["common"].close, "❌ ", ""), params = { event = "qb-mechanic:client:Menu:Close" } }
	else vehicleMenu[#vehicleMenu + 1] = { header = "", txt = Loc[Config.Lan]["common"].close, params = { event = "qb-mechanic:client:Menu:Close" } } end
	if currentVeh.out and DoesEntityExist(currentVeh.current) then
		local col1, col2 = GetVehicleColours(currentVeh.current)
		for k, v in pairs(Loc[Config.Lan].vehicleResprayOptionsClassic) do if col1 == v.id then col1 = v.name end end
		vehicleMenu[#vehicleMenu+1] = { icon = "fas fa-clipboard-list", header = Loc[Config.Lan]["garage"].vehout,
										txt = searchCar(currentVeh.current)..Loc[Config.Lan]["paint"].primary..": "..col1.."<br>"..Loc[Config.Lan]["check"].plate..trim(GetVehicleNumberPlateText(currentVeh.current)).."]" ,
										params = { event = "qb-mechanic:client:Garage:Blip", }, }
		vehicleMenu[#vehicleMenu+1] = { icon = "fas fa-car-burst", header = Loc[Config.Lan]["garage"].remveh, params = { event = "qb-mechanic:client:Garage:RemSpawn" } }
	else
		currentVeh = { out = false, current = nil }
		table.sort(data.list, function(a, b) return a:lower() < b:lower() end)
		for k, v in pairs(data.list) do
			local spawnName = v
			local v = string.lower(GetDisplayNameFromVehicleModel(GetHashKey(spawnName))) v = v:sub(1,1):upper()..v:sub(2).." "..GetMakeNameFromVehicleModel(GetHashKey(tostring(spawnName)))
			for _, b in pairs(QBCore.Shared.Vehicles) do
				if tonumber(b.hash) == GetHashKey(spawnName) then
					if Config.Debug then print("^5Debug^7: ^2Vehicle^7: ^6"..b.hash.." ^7(^6"..b.name.." "..b.brand.."^7)")
				end
				v = b.name.." "..b.brand
				end
			end
			vehicleMenu[#vehicleMenu+1] = { header = v, params = { event = "qb-mechanic:client:Garage:SpawnList", args = { spawnName = spawnName, coords = data.coords } } }
		end
	end
    exports['arshia-menu']:openMenu(vehicleMenu)
	unloadAnimDict("amb@prop_human_atm@male@enter")
end)

RegisterNetEvent("qb-mechanic:client:Garage:SpawnList", function(data)
	local oldveh = GetClosestVehicle(data.coords.x, data.coords.y, data.coords.z, 2.5, 0, 71)
	if oldveh ~= 0 then
		local name = GetDisplayNameFromVehicleModel(GetEntityModel(oldveh)):lower()
		for k, v in pairs(QBCore.Shared.Vehicles) do
			if tonumber(v.hash) == GetEntityModel(oldveh) then
			if Config.Debug then print("^5Debug^7: ^2Vehicle^7: '^6"..v.hash.."^7' (^6"..v.label.."^7)") end
			name = QBCore.Shared.Vehicles[k].name break
			end
		end
		triggerNotify(nil, name..Loc[Config.Lan]["garage"].cantspawn, "error")
	else
		QBCore.Functions.SpawnVehicle(data.spawnName, function(veh)
			currentVeh = { out = true, current = veh }
			SetVehicleModKit(veh, 0)
			NetworkRequestControlOfEntity(veh)
			SetEntityAsMissionEntity(veh, true, true)
			SetVehicleColours(veh, Loc[Config.Lan].vehicleResprayOptionsClassic[math.random(1, #Loc[Config.Lan].vehicleResprayOptionsClassic)].id, Loc[Config.Lan].vehicleResprayOptionsClassic[math.random(1, #Loc[Config.Lan].vehicleResprayOptionsClassic)].id)
			SetVehicleNumberPlateText(veh, string.sub(PlayerJob.label, 1, 5)..tostring(math.random(100, 999)))
			SetEntityHeading(veh, data.coords.w)
			TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
			exports['row-fuel']:SetFuel(veh, 100.0)
			TriggerEvent("vehiclekeys:client:SetOwner", trim(GetVehicleNumberPlateText(veh)))
			SetVehicleEngineOn(veh, true, true)
			Wait(250)
			if GetNumVehicleMods(veh, 48) > 0 or GetVehicleLiveryCount(veh) > -1 then TriggerEvent("qb-mechanic:client:Preview:Livery", {close=true}) end
			triggerNotify(nil, GetDisplayNameFromVehicleModel(data.spawnName).." ["..trim(GetVehicleNumberPlateText(currentVeh.current)).."]")
			qblog("`Garage - "..GetDisplayNameFromVehicleModel(data.spawnName).."` spawned [**"..trim(GetVehicleNumberPlateText(currentVeh.current)).."**]")
		end, data.coords, true)
	end
end)

RegisterNetEvent("qb-mechanic:client:Garage:RemSpawn", function(data)
	if Config.RemSpawn then
		SetVehicleEngineHealth(currentVeh.current, 200.0)
		SetVehicleBodyHealth(currentVeh.current, 200.0)
		for i = 0, 7 do SmashVehicleWindow(currentVeh.current, i) Wait(150) end PopOutVehicleWindscreen(currentVeh.current)
		for i = 0, 5 do	SetVehicleTyreBurst(currentVeh.current, i, true, 0) Wait(150) end
		for i = 0, 5 do SetVehicleDoorBroken(currentVeh.current, i, false) Wait(150) end
	end
	Wait(800)
	DeleteEntity(currentVeh.current) currentVeh = { out = false, current = nil }
end)

local markerOn = false
RegisterNetEvent("qb-mechanic:client:Garage:Blip", function(data)
	triggerNotify(nil, Loc[Config.Lan]["garage"].marker)
	if markerOn then markerOn = not markerOn end
	markerOn = true
	local carBlip = GetEntityCoords(currentVeh.current)
	if not DoesBlipExist(garageBlip) then
		garageBlip = AddBlipForCoord(carBlip.x, carBlip.y, carBlip.z)
		SetBlipColour(garageBlip, 8)
		SetBlipRoute(garageBlip, true)
		SetBlipSprite(garageBlip, 85)
		SetBlipRouteColour(garageBlip, 3)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(Loc[Config.Lan]["garage"].markername)
		EndTextCommandSetBlipName(garageBlip)
	end
	while markerOn do
		local time = 5000
		local carLoc = GetEntityCoords(currentVeh.current)
		local playerLoc = GetEntityCoords(PlayerPedId())
		if DoesEntityExist(currentVeh.current) then
			if #(carLoc - playerLoc) <= 30.0 then time = 100
			elseif #(carLoc - playerLoc) <= 1.5 then
				RemoveBlip(garageBlip)
				garageBlip = nil
				markerOn = not markerOn
			else time = 5000 end
		else
			RemoveBlip(garageBlip)
			garageBlip = nil
			markerOn = not markerOn
		end
		Wait(time)
	end
end)

Config.Locations = {
		{	job = "hayes",
		zones = {
			vector2(-1443.07, -448.45),
			vector2(-1385.32, -410.94),
			vector2(-1316.67, -504.32),  
			vector2(-1380.62, -546.02)
		},
		autoClock = { enter = false, exit = false, },
		stash = { { coords = vector3(-1418.65, -454.64, 35.91), w = 2.0, d = 3.19, heading = 295.0, }, },
		store = { { coords = vector3(-1410.18, -448.37, 35.91), w = 2.76, d = 2.0, heading = 20.0, }, },
		crafting = { { coords = vector3(-1415.65, -451.89, 35.91), w = 2.6, d = 2.56, heading = 255.0, recipes = {"Tools" , "Perform" , "Cosmetic" }}, },
		clockin = { { coords = vector3(-1428.15, -453.86, 35.91), prop = false, }, },
		garage = { spawn = vector4(0, 0, 0,0),
	 				out = vector4(0, 0, 0, 0),
					list = { "towtruck", "panto" } },
				payments = { coords = vector3(-1430.16, -453.58, 35.91), heading = 219, img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png width=150px></p>" },
					blip = vector3(-1418.68, -445.7, 35.91),
		bliplabel = "Hayes Mechanic",
		blipcolor = 57,
		discordlink = "",
		discordcolour = 16711680,
		discordimg = "https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png",
	},
-- 	{	job = "cardealer",
-- 	zones = {
-- 		vector2(-1280.58, -353.48),
-- 		vector2(-1263.41, -387.27),
-- 		vector2(-1210.93, -316.87),
-- 		vector2(-1188.63, -356.14)
-- 	},
-- 	autoClock = { enter = false, exit = false, },
-- 	stash = { { coords = vec4(836.97, -814.73, 26.33, 90.0), w = 0.6, d = 3.6, }, },
-- 	store = { { coords = vec4(837.02, -808.22, 15.33, 90.0), w = 1.0, d = 1.4, }, },
-- 	crafting = { { coords = vec4(837.03, -811.74, 26.33, 90.0), w = 1.4, d = 2.2, }, },
-- 	clockin = { { coords = vec4(834.63, -829.76, 26.13, 197.67), prop = true, }, },
-- 	manualRepair = { { coords = vector4(-24.89, -1059.28, 28.40, 70.0), prop = true, } },
-- 	garage = { spawn = vector4(0, 0, 0,0),
-- 	 			out = vector4(0, 0, 0, 0),
-- 				list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" },
-- 				prop = true },
-- 	payments = { coords = vec4(833.96, -826.79, 26.13, 0.35),
-- 		img = "<center><p><img src=https://i.imgur.com/74UVnCb.jpeg width=150px></p>",
-- 		prop = true },
-- 	blip = vector3(-35.18, -1052.48, 28.4),
-- 	bliplabel = "Repair Station",
-- 	blipcolor = 1,
-- 	discordlink = "",
-- 	discordcolour = 16711680,
-- 	discordimg = "https://i.imgur.com/74UVnCb.jpeg",
-- },
	{	job = "tuner",
		zones = {
			vector2(153.387, -3007.082),
			vector2(120.684, -3007.853),
			vector2(120.857, -3051.483),
			vector2(154.459, -3051.364),
		},
		autoClock = { enter = false, exit = false, },
		stash = { { coords = vector3(144.29, -3051.55, 7.04), w = 3.4, d = 1, heading = 90.0 }, },
		store = { { coords = vector3(128.64, -3014.68, 7.04), w = 1.6, d = 3.0, heading = 0.0, }, },
		crafting = { { coords = vector3(136.77, -3050.77, 7.04),  w = 0.6, d = 1.0, heading = 117.0, recipes = { "Tools" , "Perform" , "Cosmetic" }}, },
		clockin = { { coords = vec4(0, 0, 0,0), prop = true, }, },
		nosrefill = { { coords = vector4(121.39, -3021.65, 7.04, 270.35) } },
		garage = { spawn = vector4(0, 0, 0,0),
	 			out = vector4(0, 0, 0, 0),
					list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" } },
		payments = { coords = vector3(146.44, -3014.09, 6.94), heading = 195.0, img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" },
		blip = vector3(139.91, -3023.83, 7.04),
		bliplabel = "Tuner Mechanic",
		blipcolor = 0,
		discordlink = "",
		discordcolour = 2571775,
		discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
	},
	-- {	job = "mechanicbenny",
	-- 	zones = {
	-- 		vector2(-45.15, -1023.83),
	-- 		vector2(-61.3, -1066.96),
	-- 		vector2(-19.85, -1083.06),  
	-- 		vector2(-1.82, -1027.51)
	-- 	},
	-- 	autoClock = { enter = false, exit = false, },
	-- 	stash = { { coords = vector3(-41.09, -1056.03, 28.4), w = 1, d = 1, heading = 0, }, },
	-- 	store = { { coords = vector3(-37.25, -1036.42, 28.78), w = 4.76, d = 1.0, heading = 20.0, }, },
	-- 	crafting = { { coords = vector3(-33.68, -1037.4, 28.6),  w = 3.0, d = 3.0, heading = 5.0, recipes = { "Tools" , "Perform" , "Cosmetic" }}, },
	-- 	clockin = { { coords = vector3(-36.01, -1041.23, 28.6), prop = true, }, },
	-- 	garage = { spawn = vector4(0, 0, 0,0),
	--  			out = vector4(0, 0, 0, 0),
	-- 				list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" } },
	-- 	payments = { coords = vector3(-35.35, -1041.45, 28.6), heading = 275.0, img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png width=150px></p>" },
	-- 	-- blip = vector3(-37.46, -1050.02, 28.4),
	-- 	bliplabel = "Bennys",
	-- 	blipcolor = 3,
	-- 	discordlink = "",
	-- 	discordcolour = 2571775,
	-- 	discordimg = "https://static.wikia.nocookie.net/gtawiki/images/f/f2/GTAV-LSCustoms-Logo.png",
	-- },
		-- HAYES AUTOS --
	-- {	job = "hayes",
	-- 	zones = {
	-- 		vector2(490.57400512695, -1302.0946044922),
	-- 		vector2(490.27529907227, -1305.3948974609),
	-- 		vector2(509.71032714844, -1336.8293457031),
	-- 		vector2(483.09429931641, -1339.0887451172),
	-- 		vector2(479.38552856445, -1330.6906738281),
	-- 		vector2(469.89437866211, -1309.5773925781)
	-- 	},
	-- 	autoClock = { enter = false, exit = false, },
	-- 	stash = { { coords = vector3(-1409.17, -438.61, 35.91), w = 2, d = 2, heading = 30, }, },
	-- 	store = { { coords = vector3(554.95, -166.05, 54.3), w = 4.76, d = 1.0, heading = 20.0, }, },
	-- 	crafting = { { coords = vector3(-1414.47, -451.75, 35.9), w = 2, d = 1.0, heading = 300.0, recipes = { "Tools" , "Perform" , "Cosmetic" } }, },
	-- 	clockin = { { coords = vec4(836.85, -813.67, 26.33, 0.0), prop = true, }, },
	-- 	garage = { spawn = vector4(0, 0, 0,0),
	--  			out = vector4(0, 0, 0, 0),
	-- 				list = { "towtruck", "panto", "slamtruck", "cheburek", "utillitruck3" } },
	-- 	payments = { coords = vector3(471.76, -1311.61, 29.20), heading = 120.0, img = "<center><p><img src=https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png width=150px></p>" },
	-- 	blip = vector3(936.33, -972.24, 39.54),
	-- 	bliplabel = "Hayes Autos",
	-- 	blipcolor = 57,
	-- 	discordlink = "",
	-- 	discordcolour = 39135,
	-- 	discordimg = "https://static.wikia.nocookie.net/gtawiki/images/0/0c/HayesAutoBodyShop-GTAV-Logo.png",
	-- },
	}

AddEventHandler('onResourceStop', function(r) if r ~= GetCurrentResourceName() then return end
	for k in pairs(Targets) do exports["qb-target"]:RemoveZone(k) end
	for i = 1, #till do DeleteEntity(till[i]) end
	for i = 1, #bench do DeleteEntity(bench[i]) end
	for i = 1, #laptop do DeleteEntity(laptop[i]) end
	for i = 1, #nos do DeleteEntity(nos[i]) end
	for i = 1, #parking do DeleteEntity(parking[i]) end
	emptyHands(PlayerPedId())
end)