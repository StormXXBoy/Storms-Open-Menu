function Text(subM, text)
	subM:add_action(text, function() end)
end

--Menus--
local Menu = menu.add_submenu("-Storm's Open Menu-")
	Text(Menu, "=============================")
	Text(Menu, "              --Storm's Open Menu--")
	Text(Menu, "=============================")
local GunMenu = Menu:add_submenu("-Weapon Menu-")
local VehicleMenu = Menu:add_submenu("-Vehicle Menu-")
	local PlateMenu = VehicleMenu:add_submenu("-Number Plate Menu-")
local SelfMenu = Menu:add_submenu("-Self Menu-")
	local MethodMenu = SelfMenu:add_submenu("-Method Menu-")
		local CasinoMenu = MethodMenu:add_submenu("-Casino Method-")
		local NightclubMenu = MethodMenu:add_submenu("-Nightclub Method-")
local TrollMenu = Menu:add_submenu("-Troll Menu-")
	Text(Menu, "=============================")
local ExtraInfoMenu = Menu:add_submenu("-Extra Info-")
	Text(Menu, "=============================")
	local DevToolsMenu = ExtraInfoMenu:add_submenu("-Developer Tools-")

--Locals--
Player = localplayer
SisEnabled = false
localTPpos = vector3(0, 0, 0)

--Hotkeys--
menu.register_hotkey(120, function() menu.kill_all_npcs() end)
menu.register_hotkey(121, function() setLocalPos() end)
menu.register_hotkey(122, function() tpLocalPos() end)
menu.register_hotkey(123, function() HunstuckCar() end)
menu.register_hotkey(97, function() Player:set_run_speed(10) end)
menu.register_hotkey(99, function() menu.heal_all() end)

--Events--
menu.register_callback('OnPlayerChanged', function() Player = localplayer end)

--Event/Hotkey Functions--
function setLocalPos()
	localTPpos = Player:get_position()
end

function tpLocalPos()
	local inCar = Player:is_in_vehicle()
	Player:set_position(localTPpos)
	if inCar == false then
		Player:set_position(localTPpos)
	else
		local car = Player:get_current_vehicle()
		car:set_position(localTPpos)
	end
end

function HunstuckCar()
	local inCar = Player:is_in_vehicle()
	if inCar == true then
		local car = Player:get_current_vehicle()
		carP = car:get_position()
		carR = car:get_rotation()
		carP.z = carP.z + 1
		carR.y = 0
		carR.z = 0
		car:set_position(carP)
		car:set_rotation(carR)
	end
end

--Player Actions--
menu.add_player_action("===================", function() end)
menu.add_player_action("-Kill Player-", function() killPlayer(player.get_player_ped(menu.get_selected_player_index())) end)
menu.add_player_action("-Wanted Player-", function() (player.get_player_ped(menu.get_selected_player_index())):set_wanted_level(5) end)
menu.add_player_action("-High Player Wallet-", function() (player.get_player_ped(menu.get_selected_player_index())):set_wallet(999999) end)
menu.add_player_action("-Drop Money Player-", function() pMoneyDrop(player.get_player_ped(menu.get_selected_player_index())) end)
menu.add_player_action("-Human Drop-", function() pHumanDrop(player.get_player_ped(menu.get_selected_player_index())) end)
menu.add_player_action("-Kill Car-", function() pKillCar(player.get_player_ped(menu.get_selected_player_index())) end)
menu.add_player_action("-Skydive Player-", function() pSkydive(player.get_player_ped(menu.get_selected_player_index())) end)
menu.add_player_action("===================", function() end)

--Player Functions--
function killPlayer(selectPlayer)
	selectPlayer:set_health(0)
end

function pMoneyDrop(selectPlayer)
	local position = selectPlayer:get_position()
	position.z = position.z + 30

	for p in replayinterface.get_peds() do
		if p == nil or p == selectPlayer then
			goto conDrop
		end
		if p:get_pedtype() < 4 then
			goto conDrop
		end
		if p:is_in_vehicle() then
			goto conDrop
		end
		p:set_position(position)
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_health(0)
			p:set_wallet(1330)
			break
		end
		::conDrop::
	end
end

function pHumanDrop(selectPlayer)
	local position = selectPlayer:get_position()
	position.z = position.z + 10

	for p in replayinterface.get_peds() do
		if p == nil or p == Player then
			goto endDrop
		end
		if p:get_pedtype() < 4 then
			goto endDrop
		end
		if p:is_in_vehicle() then
			goto endDrop
		end
		p:set_position(position)
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_freeze_momentum(false)
			p:set_godmode(true)
			break
		end
		::endDrop::
	end
end

function pKillCar(selectPlayer)
	local car = selectPlayer:get_current_vehicle()
	car:set_health(-500)
end

function pSkydive(selectPlayer)
	for i=1, 50 do
	local position = selectPlayer:get_position()
	position.z = position.z + 10
	selectPlayer:set_position(position)
	end
end

--Weapon Actions--
Text(GunMenu, "-------------------------------------")
GunMenu:add_action("-Force Gun-", function() force_gun() end)
GunMenu:add_action("-Boom Gun-", function() boom_gun() end)
GunMenu:add_action("-Nuke Gun-", function() nuke_gun() end)
GunMenu:add_action("-Instant Kill Gun-", function() insta_gun() end)
GunMenu:add_action("-Rapid Fire-", function() fast_gun() end)
Text(GunMenu, "-------------------------------------")

--Weapon Functions--
function force_gun()
	local gun = Player:get_current_weapon()
	gun:set_heli_force(99900000.00)
    gun:set_ped_force(99900000.00)
    gun:set_vehicle_force(99900000.00)
end

function boom_gun()
	local gun = Player:get_current_weapon()
	gun:set_explosion_type(1)
	gun:set_damage_type(5)
end

function nuke_gun()
	local gun = Player:get_current_weapon()
	gun:set_explosion_type(37)
	gun:set_damage_type(5)
end

function insta_gun()
	local gun = Player:get_current_weapon()
	gun:set_bullet_damage(99900000.00)
end

function fast_gun()
	local gun = Player:get_current_weapon()
	gun:set_time_between_shots(0.01)
end

--Vehicle Actions--
Text(VehicleMenu, "-------------------------------------")
VehicleMenu:add_action("-Car Godmode-", function() carGodmode() end)
VehicleMenu:add_action("-Gravity Toggle-", function() gravity() end)
VehicleMenu:add_action("-Unstuck Car-", function() unstuckCar() end)
VehicleMenu:add_action("-Fast Car- ⚠", function() fastCarSpeed() end)
VehicleMenu:add_action("-Infinte Car Speed Limit-", function() infCarSpeed() end)
Text(VehicleMenu, "-------------------------------------")

Text(PlateMenu, "-------------------------------------")
PlateMenu:add_action("-Number Plate StormX-", function() Player:get_current_vehicle():set_number_plate_text(".StormX") end)
PlateMenu:add_action("-Number Plate GTA 5-", function() Player:get_current_vehicle():set_number_plate_text(" GTA5") end)
PlateMenu:add_action("-Number Plate SEXY-", function() Player:get_current_vehicle():set_number_plate_text(" SEXY") end)
PlateMenu:add_action("-Number Plate XXXXXXXX-", function() Player:get_current_vehicle():set_number_plate_text("XXXXXXXX") end)
Text(PlateMenu, "-------------------------------------")

--Vehicle Functions--
function carGodmode()
	local car = Player:get_current_vehicle()
	car:set_godmode(true)
	car:set_can_be_visibly_damaged(false)
end

function gravity()
	local car = Player:get_current_vehicle()
	local Cgravity = car:get_gravity()
	if Cgravity > 0 then 
	car:set_gravity(0)
	else
	car:set_gravity(9)
	end
end

function unstuckCar()
	local inCar = Player:is_in_vehicle()
	if inCar == true then
		local car = Player:get_current_vehicle()
		carP = car:get_position()
		carR = car:get_rotation()
		carP.z = carP.z + 1
		carR.y = 0
		carR.z = 0
		car:set_position(carP)
		car:set_rotation(carR)
	end
end

function fastCarSpeed()
	local car = Player:get_current_vehicle()
	car:set_max_speed(-1)
	car:set_gravity(25)
	car:set_acceleration(1)
end

function infCarSpeed()
	local car = Player:get_current_vehicle()
	car:set_max_speed(-1)
end

--Self Actions--
Text(SelfMenu, "-------------------------------------")
SelfMenu:add_action("-Teleport Forward-", function() menu.teleport_forward() end)
SelfMenu:add_action("-Remove Cops-", function() menu.clear_wanted_level() end)
SelfMenu:add_action("-Drop Money- ⚠", function() MoneyDrop() end)
SelfMenu:add_action("-Safer Drop Money-", function() sMoneyDrop() end)
Text(SelfMenu, "-------------------------------------")

Text(MethodMenu, "--This is just a concept!--")

CasinoMenu:add_action("-Rig Slot Machines-", function() menu.rig_slot_machines() end)
CasinoMenu:add_action("-End Cutscene-", function() menu.end_cutscene() end)
CasinoMenu:add_action("-Lose Slot Machines-", function() menu.lose_slot_machines() end)

NightclubMenu:add_action("-Fill Cargo & Shipments-", function() menu.fill_cargo() end)
NightclubMenu:add_action("-Fill Sporting Goods-", function() menu.lose_slot_machines() end)
NightclubMenu:add_action("-Trigger Production-", function() menu.trigger_nightclub_production() end)
NightclubMenu:add_action("-Teleport Nightclub-", function() menu.teleport_to_nightclub() end)


--Self Functions--
function MoneyDrop()
	local position = Player:get_position()
	position.z = position.z + 30

	for p in replayinterface.get_peds() do
		if p == nil or p == Player then
			goto conDrop
		end
		if p:get_pedtype() < 4 then
			goto conDrop
		end
		if p:is_in_vehicle() then
			goto conDrop
		end
		p:set_position(position)
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_health(0)
			p:set_wallet(1330)
			break
		end
		::conDrop::
	end
end

function sMoneyDrop()
	local position = Player:get_position()
	position.z = position.z + 30

	for p in replayinterface.get_peds() do
		if p == nil or p == Player then
			goto conDrop
		end
		if p:get_pedtype() < 4 then
			goto conDrop
		end
		if p:is_in_vehicle() then
			goto conDrop
		end
		p:set_position(position)
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_health(0)
			break
		end
		::conDrop::
	end
end

--Troll Actions--
Text(TrollMenu, "-------------------------------------")
TrollMenu:add_action("-When Cars Fly-", function() yeetCars() end)
TrollMenu:add_action("-Human Drop-", function() HumanDrop() end)
TrollMenu:add_action("-Car Drop-", function() CarDrop() end)
TrollMenu:add_action("-Kill Car-", function() KillCar() end)
TrollMenu:add_action("-Fragile Car-", function() SoftCar() end)
TrollMenu:add_action("-Skydive-", function() Skydive() end)
TrollMenu:add_action("-Snow Toggle-", function() toggleSnow() end)
TrollMenu:add_toggle("-Become Tiny-", function() bePlayer() end, function(value) Player:set_config_flag(223, value) end)
Text(TrollMenu, "-------------------------------------")

--Troll Functions--
function yeetCars()
	repeat for car in replayinterface.get_vehicles() do
	car:set_gravity(-10)
	Player:set_position(car:get_position())
	return
	end
	until nil
end

function HumanDrop()
	local position = Player:get_position()
	position.z = position.z + 10

	for p in replayinterface.get_peds() do
		if p == nil or p == Player then
			goto endDrop
		end
		if p:get_pedtype() < 4 then
			goto endDrop
		end
		if p:is_in_vehicle() then
			goto endDrop
		end
		p:set_position(position)
		if p:get_health() > 99 then
			p:set_position(position)
			p:set_freeze_momentum(true)
			p:set_freeze_momentum(false)
			p:set_godmode(true)
			break
		end
		::endDrop::
	end
end

function CarDrop()
	local position = Player:get_position()
	position.z = position.z + 5

	for c in replayinterface.get_vehicles() do
		print(c)
		print(replayinterface.get_vehicles())
		print(replayinterface)
		c:set_position(position)
		return
	end
end

function KillCar()
	local car = Player:get_current_vehicle()
	car:set_health(-500)
end

function SoftCar()
	local car = Player:get_current_vehicle()
	car:set_engine_damage_multiplier(800000)
	car:set_deformation_damage_multiplier(800000)
	car:set_collision_damage_multiplier(800000)
end

function Skydive()
	for i=1, 50 do
	local position = Player:get_position()
	position.z = position.z + 10
	Player:set_position(position)
	end
end

function toggleSnow()
    SisEnabled = not SisEnabled
    globals.set_boolean(262145 + 4752, SisEnabled)
end

function bePlayer()
	if Player == nil then
		return nil
	end
	return Player:get_config_flag(223)
end

--Extra Info Actions/Text--
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--F9 = Kill all NPC's--")
Text(ExtraInfoMenu, "--F10 = Set local teleport position--")
Text(ExtraInfoMenu, "--F11 = Teleport to local position--")
Text(ExtraInfoMenu, "--F12 = Unstuck Car--")
ExtraInfoMenu:add_action("--Numpad 1 = Speed Boost--", function() SpeedBoostCTRL() end)
Text(ExtraInfoMenu, "--Numpad 3 = Heal All--")
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--⚠ = Risky--")
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--Version 1.0--")
Text(ExtraInfoMenu, "--Open Source!--")
Text(ExtraInfoMenu, "--stormxxboy.com--")
Text(ExtraInfoMenu, "--Made by StormXXBoy--")
Text(ExtraInfoMenu, "-------------------------------------")

DevToolsMenu:add_action("-Print Speed-", function() speedPrint() end)

--Extra Info Functions--
function speedPrint()
	local inCar = Player:is_in_vehicle()
	if inCar == false then
		local Pvel = Player:get_velocity()
		local Pspeed = Pvel.x * Pvel.y * Pvel.z / 3
		print(Pspeed)
	else
		local car = Player:get_current_vehicle()
		local Cvel = car:get_velocity()
		local Cspeed = Cvel.x * Cvel.y * Cvel.z / 3
		print(Cspeed)
	end
end

function SpeedBoostCTRL()
	menu.register_hotkey(162, function() Player:set_run_speed(10) end)
end