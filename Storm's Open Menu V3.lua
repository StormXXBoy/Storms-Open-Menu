--[[

 .d8888b.  888                                   d8b          
d88P  Y88b 888                                   88P          
Y88b.      888                                   8P           
 "Y888b.   888888  .d88b.  888d888 88888b.d88b.  "   .d8888b  
    "Y88b. 888    d88""88b 888P"   888 "888 "88b     88K      
      "888 888    888  888 888     888  888  888     "Y8888b. 
Y88b  d88P Y88b.  Y88..88P 888     888  888  888          X88 
 "Y8888P"   "Y888  "Y88P"  888     888  888  888      88888P' 
                                                              
                                                              
                                                              
 .d88888b.                                                    
d88P" "Y88b                                                   
888     888                                                   
888     888 88888b.   .d88b.  88888b.                         
888     888 888 "88b d8P  Y8b 888 "88b                        
888     888 888  888 88888888 888  888                        
Y88b. .d88P 888 d88P Y8b.     888  888                        
 "Y88888P"  88888P"   "Y8888  888  888                        
            888                                               
            888                                               
            888                                               
888b     d888                                                 
8888b   d8888                                                 
88888b.d88888                                                 
888Y88888P888  .d88b.  88888b.  888  888                      
888 Y888P 888 d8P  Y8b 888 "88b 888  888                      
888  Y8P  888 88888888 888  888 888  888                      
888   "   888 Y8b.     888  888 Y88b 888                      
888       888  "Y8888  888  888  "Y88888

	Thank you for using Storm's Open Menu!
		Made by StormXXBoy

--]]


--Try to only use abc and ABC charaters or it may not work!--
--Change the MacroText variable for the text macro!--
MacroText = "Hello world"


--Pre-Functions--
function Text(subM, text)
	subM:add_action(text, function() end)
end

function mpx()
	return "MP".. stats.get_int("MPPLY_LAST_MP_CHAR").. "_"
end

function car()
	return localplayer:get_current_vehicle()
end

function gun()
	return localplayer:get_current_weapon()
end

--Rainbow Car--
rainbowColors = {}
numColors = 256
Rspeed = 1
Status = false
StatusL = false

function hsvToRgb(h, s, v)
  local r, g, b
  
  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)
  
  i = i % 6
  
  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end
  
  return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

function GenRainbow()
	rainbowColors = {}
	for i = 1, numColors do
		local hue = i / numColors
		local r, g, b = hsvToRgb(hue, 1, 1)
		table.insert(rainbowColors, {r, g, b})
	end
end

function Rcar()
	while true do
		for i, color in ipairs(rainbowColors) do
			if Status == true then
				car():set_custom_primary_colour(color[1], color[2], color[3])
				car():set_custom_secondary_colour(color[1], color[2], color[3])
				sleep(Rspeed)
			end
		end
	end
end

GenRainbow()


--Menus--
local Menu = menu.add_submenu("-Storm's Open Menu-")
	Text(Menu, "=============================")
	Text(Menu, "              --Storm's Open Menu--")
	Text(Menu, "=============================")
local SelfMenu = Menu:add_submenu("-Self Menu-")
local GunMenu = Menu:add_submenu("-Weapon Menu-")
local VehicleMenu = Menu:add_submenu("-Vehicle Menu-")
	local PlateMenu = VehicleMenu:add_submenu("-Number Plate Menu-")
local TrollMenu = Menu:add_submenu("-Troll Menu-")
	Text(Menu, "=============================")
local PlayersMenu = Menu:add_submenu("-Players Menu-", function() RefreshPM() end)
local MacroMenu = Menu:add_submenu("-Macro Menu-")
local ReportsMenu = Menu:add_submenu("-Reports Menu-")
	Text(Menu, "=============================")
local NerdMenu = Menu:add_submenu("-Nerd Tools-")
local ExtraInfoMenu = Menu:add_submenu("-Extra Info-")
	Text(Menu, "=============================")


--Locals--
SisEnabled = false
localTPpos = vector3(0, 0, 0)
SemiGod = false
SemiGodL = false
ACGod = false
MA = 1
LA = 1
TBM = 1
TBL = 1
RS = 1

KeyCodes = {
	DOWN = {
	    a = 65,
		b = 66,
		c = 67,
		d = 68,
		e = 69,
		f = 70,
		g = 71,
		h = 72,
		i = 73,
		j = 74,
		k = 75,
		l = 76,
		m = 77,
		n = 78,
		o = 79,
		p = 80,
		q = 81,
		r = 82,
		s = 83,
		t = 84,
		u = 85,
		v = 86,
		w = 87,
		x = 88,
		y = 89,
		z = 90
	},
	UP = {
		A = 65,
		B = 66,
		C = 67,
		D = 68,
		E = 69,
		F = 70,
		G = 71,
		H = 72,
		I = 73,
		J = 74,
		K = 75,
		L = 76,
		M = 77,
		N = 78,
		O = 79,
		P = 80,
		Q = 81,
		R = 82,
		S = 83,
		T = 84,
		U = 85,
		V = 86,
		W = 87,
		X = 88,
		Y = 89,
		Z = 90
	},
	DOT = 46,
	EXL = 33,
	COMMA = 110,
	SPACE = 32,
	CAPS = 20,
	CHAT = 84,
	SEND = 13
}

--Event/Hotkeys--
menu.register_hotkey(120, function() menu.clear_wanted_level() end)
menu.register_hotkey(121, function() setLocalPos() end)
menu.register_hotkey(122, function() tpLocalPos() end)
menu.register_hotkey(123, function() HunstuckCar() end)
menu.register_hotkey(97, function() localplayer:set_run_speed(10) end)
menu.register_hotkey(99, function() menu.heal_all() end)

--Event/Hotkey Functions--
function setLocalPos()
	localTPpos = localplayer:get_position()
end

function tpLocalPos()
	local inCar = localplayer:is_in_vehicle()
	localplayer:set_position(localTPpos)
	if inCar == false then
		localplayer:set_position(localTPpos)
	else
		local car = localplayer:get_current_vehicle()
		car:set_position(localTPpos)
	end
end

function HunstuckCar()
	local inCar = localplayer:is_in_vehicle()
	if inCar == true then
		local car = localplayer:get_current_vehicle()
		carP = car:get_position()
		carR = car:get_rotation()
		carP.z = carP.z + 1
		carR.y = 0
		carR.z = 0
		car:set_position(carP)
		car:set_rotation(carR)
	end
end


--Loops--
function SemiGodF()
	while true do
		if localplayer:get_health() ~= localplayer:get_max_health() then
			if SemiGod == true then
				menu.heal_all()
			end
		end
		sleep(0.2)
	end
end

--Self Actions--
Text(SelfMenu, "-------------------------------------")
SelfMenu:add_toggle("-Semi Godmode-", function() return SemiGod end, function(God) SemiGod = not SemiGod if SemiGodL == false then SemiGodF() else SemiGodL = true end end)
SelfMenu:add_action("-Remove Cops-", function() menu.clear_wanted_level() end)
SelfMenu:add_action("-6 Stars-", function() localplayer:set_wanted_level(6) end)
SelfMenu:add_action("-Drop Money- ⚠", function() MoneyDrop() end)
SelfMenu:add_action("-Safer Drop Money-", function() sMoneyDrop() end)
SelfMenu:add_action("-Teleport Forward-", function() menu.teleport_forward() end)
Text(SelfMenu, "-------------------------------------")

--Self Functions--
function MoneyDrop()
	local position = localplayer:get_position()
	position.z = position.z + 30

	for p in replayinterface.get_peds() do
		if p == nil or p == localplayer then
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
	local position = localplayer:get_position()
	position.z = position.z + 30

	for p in replayinterface.get_peds() do
		if p == nil or p == localplayer then
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


--Weapon Actions--
Text(GunMenu, "-------------------------------------")
GunMenu:add_action("-Force Gun-", function() force_gun() end)
GunMenu:add_action("-Boom Gun-", function() boom_gun() end)
GunMenu:add_action("-Nuke Gun-", function() nuke_gun() end)
GunMenu:add_action("-Instant Kill Gun-", function() gun():set_bullet_damage(99900000.00) end)
GunMenu:add_action("-Rapid Fire-", function() gun():set_time_between_shots(0.01) end)
GunMenu:add_action("-Long Range-", function() gun():set_range(99999) end)
Text(GunMenu, "-------------------------------------")

--Weapon Functions--
function force_gun()
	local gun = localplayer:get_current_weapon()
	gun:set_heli_force(99900000.00)
    gun:set_ped_force(99900000.00)
    gun:set_vehicle_force(99900000.00)
end

function boom_gun()
	local gun = localplayer:get_current_weapon()
	gun:set_explosion_type(1)
	gun:set_damage_type(5)
end

function nuke_gun()
	local gun = localplayer:get_current_weapon()
	gun:set_explosion_type(82)
	gun:set_damage_type(5)
end


--Vehicle Actions--
Text(VehicleMenu, "-------------------------------------")
VehicleMenu:add_toggle("-Auto Car Godmode-", function() return ACGod end, function(v) ACGodT() end)
VehicleMenu:add_action("-Car Godmode-", function() carGodmode(car()) end)
VehicleMenu:add_action("-Gravity Toggle-", function() gravity(car()) end)
VehicleMenu:add_action("-Unstuck Car-", function() unstuckCar(car()) end)
VehicleMenu:add_action("-Fast Car- ⚠", function() fastCarSpeed(car()) end)
VehicleMenu:add_action("-Infinte Car Speed Limit-", function() car():set_max_speed(-1) end)
VehicleMenu:add_toggle("-Rainbow Car- ⚠", function() return Status end, function() Status = not Status if StatusL == false then StatusL = true Rcar() end end)
Text(VehicleMenu, "-------------------------------------")

Text(PlateMenu, "-------------------------------------")
PlateMenu:add_action("-Number Plate StormX-", function() localplayer:get_current_vehicle():set_number_plate_text(".StormX") end)
PlateMenu:add_action("-Number Plate GTA 5-", function() localplayer:get_current_vehicle():set_number_plate_text(" GTA5") end)
PlateMenu:add_action("-Number Plate SEXY-", function() localplayer:get_current_vehicle():set_number_plate_text(" SEXY") end)
PlateMenu:add_action("-Number Plate XXXXXXXX-", function() localplayer:get_current_vehicle():set_number_plate_text("XXXXXXXX") end)
Text(PlateMenu, "-------------------------------------")

--Vehicle Functions--
function ACGodT()
	ACGod = not ACGod
	if ACGod == true then
		ACGc = menu.register_callback("OnVehicleChanged", function(OldCar, NewCar) NewCar:set_godmode(true) end)
	else
		menu.remove_callback(ACGc)
	end
end

function carGodmode(car)
	car:set_godmode(true)
	car:set_can_be_visibly_damaged(false)
end

function gravity(car)
	local Cgravity = car:get_gravity()
	if Cgravity > 0 then 
	car:set_gravity(0)
	else
	car:set_gravity(9)
	end
end

function unstuckCar(car)
	local inCar = localplayer:is_in_vehicle()
	if inCar == true then
		carP = car:get_position()
		carR = car:get_rotation()
		carP.z = carP.z + 1
		carR.y = 0
		carR.z = 0
		car:set_position(carP)
		car:set_rotation(carR)
	end
end

function fastCarSpeed(car)
	car:set_max_speed(-1)
	car:set_gravity(25)
	car:set_acceleration(1)
end


--Troll Actions--
Text(TrollMenu, "-------------------------------------")
TrollMenu:add_action("-Human Drop-", function() HumanDrop() end)
TrollMenu:add_action("-Skydive-", function() Skydive() end)
Text(TrollMenu, "-------------------------------------")
TrollMenu:add_action("-When Cars Fly-", function() yeetCars() end)
TrollMenu:add_action("-Car Drop-", function() CarDrop() end)
TrollMenu:add_action("-Launch Car-", function() LaunchCar() end)
TrollMenu:add_action("-Kill Car-", function() KillCar() end)
TrollMenu:add_action("-Fragile Car-", function() SoftCar() end)
Text(TrollMenu, "-------------------------------------")
TrollMenu:add_action("-Snow Toggle-", function() toggleSnow() end)
TrollMenu:add_toggle("-Become Tiny-", function() bePlayer() end, function(value) localplayer:set_config_flag(223, value) end)
Text(TrollMenu, "-------------------------------------")

--Troll Functions--
function HumanDrop()
	local position = localplayer:get_position()
	position.z = position.z + 10

	for p in replayinterface.get_peds() do
		if p == nil or p == localplayer then
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

function Skydive()
	for i=1, 50 do
		if localplayer:is_in_vehicle() == false then
			local position = localplayer:get_position()
			position.z = position.z + 10
			localplayer:set_position(position)
		else
			local position = car():get_position()
			position.z = position.z + 10
			car():set_position(position)
		end
	end
end

function yeetCars()
	repeat for car in replayinterface.get_vehicles() do
	car:set_gravity(-10)
	localplayer:set_position(car:get_position())
	return
	end
	until nil
end

function CarDrop()
	local position = localplayer:get_position()
	position.z = position.z + 5

	for c in replayinterface.get_vehicles() do
		print(c)
		print(replayinterface.get_vehicles())
		print(replayinterface)
		c:set_position(position)
		return
	end
end

function LaunchCar()
	local car = localplayer:get_current_vehicle()
	car:set_gravity(-100)
end

function KillCar()
	local car = localplayer:get_current_vehicle()
	car:set_health(-500)
end

function SoftCar()
	local car = localplayer:get_current_vehicle()
	car:set_engine_damage_multiplier(800000)
	car:set_deformation_damage_multiplier(800000)
	car:set_collision_damage_multiplier(800000)
end

function toggleSnow()
    SisEnabled = not SisEnabled
    globals.set_boolean(262145 + 4752, SisEnabled)
end

function bePlayer()
	if localplayer == nil then
		return nil
	end
	return localplayer:get_config_flag(223)
end


--Players Menu--
function RefreshPM()
	PlayersMenu:clear()
	Text(PlayersMenu, "----------------------------------------------")
	Text(PlayersMenu, "                 ---Players ".. player.get_number_of_players().. "/30---")
	Text(PlayersMenu, "----------------------------------------------")
	for i=0, 31 do
		local ply = player.get_player_ped(i)
		if ply then
			local plyName = player.get_player_name(i)
			plyHP = math.floor((ply:get_health() / ply:get_max_health()) * 100).. "❤ | "
			plyArmor = math.floor(ply:get_armour()).. "🛡 | "
			plyWanted = ply:get_wanted_level().. "☆"
			if ply:get_godmode() == true then
				plyGod = "God | "
			else
				plyGod = " "
			end
			if ply:is_in_vehicle() == true then
				plyCar = "🚗 | "
			else
				plyCar = "🚶 | "
			end
			Text(PlayersMenu, plyName.. "|".. plyGod.. plyCar.. plyHP.. plyArmor.. plyWanted)
		end
	end
	Text(PlayersMenu, "----------------------------------------------")
	PlayersMenu:add_action("-Manual Refresh-", function() RefreshPM() end)
	Text(PlayersMenu, "----------------------------------------------")
end

--Macro Menu--
function Update()
MacroMenu:clear()
Text(MacroMenu, "----------------------------------------------")
MacroMenu:add_action("-Start Macro-", function() StartM() end)
MacroMenu:add_int_range("Messages Amount", RS, 1, 100, function() return MA end, function(n) MA = n end)
MacroMenu:add_int_range("Lobby Amount", RS, 1, 100, function() return LA end, function(n) LA = n end)
MacroMenu:add_int_range("Time Between Messages", RS, 1, 100, function() return TBM end, function(n) TBM = n end)
MacroMenu:add_int_range("Time Between Lobby's", RS, 1, 100, function() return TBL end, function(n) TBL = n end)
MacroMenu:add_int_range("Range Step", RS, 1, 10, function() return RS end, function(n) RS = n Update() end)
MacroMenu:add_action("Current text : ".. MacroText, function() end)
Text(MacroMenu, "Change the MacroText variable in the script.")
Text(MacroMenu, "----------------------------------------------")
end

function StartM()
	for i = 1, LA do
		for i = 1, MA do
			Type()
			sleep(TBM)
		end
		NewSes()
		sleep(TBL)
	end
end

function Type()
	menu.send_key_press(KeyCodes.CHAT)
	sleep(0.25)
	for i = 1, #MacroText do
		local Char = Text:sub(i,i)
		print(string.byte(Char))
		if KeyCodes.DOWN[Char] ~= nil then
			menu.send_key_press(KeyCodes.DOWN[Char])
		elseif KeyCodes.UP[Char] ~= nil then
			menu.send_key_press(KeyCodes.CAPS)
			menu.send_key_press(KeyCodes.UP[Char])
			menu.send_key_press(KeyCodes.CAPS)
		elseif string.byte(Char) == KeyCodes.SPACE then
			menu.send_key_press(KeyCodes.SPACE)
		end
	end
	menu.send_key_press(KeyCodes.SEND)
end

function NewSes()
	globals.set_int(1575017, 0)
	globals.set_int(1574589, 1)
	sleep(0.2)
	globals.set_int(1574589, 0) 
end

Update()

--Reports Menu--
local ExploitReports = stats.get_int("MPPLY_EXPLOITS")
local GriefReports = stats.get_int("MPPLY_GRIEFING")
local AnnoyingReports = stats.get_int("MPPLY_VC_ANNOYINGME") + stats.get_int("MPPLY_TC_ANNOYINGME")
local HateReports = stats.get_int("MPPLY_VC_HATE") + stats.get_int("MPPLY_TC_HATE")
local OffensiveReports = stats.get_int("MPPLY_OFFENSIVE_LANGUAGE") + stats.get_int("MPPLY_OFFENSIVE_TAGPLATE") + stats.get_int("MPPLY_OFFENSIVE_UGC")
local BadCrewReports = stats.get_int("MPPLY_BAD_CREW_NAME") + stats.get_int("MPPLY_BAD_CREW_MOTTO") + stats.get_int("MPPLY_BAD_CREW_STATUS") + stats.get_int("MPPLY_BAD_CREW_EMBLEM")
local MissionReports = stats.get_int("MPPLY_PLAYERMADE_TITLE") + stats.get_int("MPPLY_PLAYERMADE_DESC")
local MinorReports = stats.get_int("MINORITY_REPORT")
local GoodReports = stats.get_int("MPPLY_HELPFUL") + stats.get_int("MPPLY_FRIENDLY")

Text(ReportsMenu, "-------------------------------------")
Text(ReportsMenu, "I       Use Report Protection!       I")
Text(ReportsMenu, "-------------------------------------")
Text(ReportsMenu, "Exploiting Reports = ".. ExploitReports)
Text(ReportsMenu, "Griefing Reports = ".. GriefReports)
Text(ReportsMenu, "Annoying Reports = ".. AnnoyingReports)
Text(ReportsMenu, "Hate Reports = ".. HateReports)
Text(ReportsMenu, "Offensive Reports = ".. OffensiveReports)
Text(ReportsMenu, "Crew Reports = ".. BadCrewReports)
Text(ReportsMenu, "Job Reports = ".. MissionReports)
Text(ReportsMenu, "Minor Reports = ".. MinorReports)
Text(ReportsMenu, "-------------------------------------")
Text(ReportsMenu, "Commends = ".. GoodReports)
Text(ReportsMenu, "-------------------------------------")


--Nerd Actions--

Text(NerdMenu, "-------------------------------------")
NerdMenu:add_action("-Print Speed-", function() speedPrint() end)
Text(NerdMenu, "-------------------------------------")
NerdMenu:add_action("-Save Gun-", function() getGun(gun()) end)
NerdMenu:add_int_range("-Explosion Type-", 1, -1, 84, function() return EXP end, function(n) EXP = n gun():set_explosion_type(EXP) end)
NerdMenu:add_int_range("-Damage Type-", 1, 1, 5, function() return DAM end, function(n) DAM = n gun():set_damage_type(DAM) end)
local GunM = NerdMenu:add_submenu("-Guns-")
Text(NerdMenu, "-------------------------------------")

--Nerd Functions--
function speedPrint()
	local inCar = localplayer:is_in_vehicle()
	if inCar == false then
		local Pvel = localplayer:get_velocity()
		local Pspeed = Pvel.x * Pvel.y * Pvel.z / 3
		print(Pspeed)
	else
		local car = localplayer:get_current_vehicle()
		local Cvel = car:get_velocity()
		local Cspeed = Cvel.x * Cvel.y * Cvel.z / 3
		print(Cspeed)
	end
end

function getGun(gun)
	print("Damage ".. gun:get_damage_type())
	print("Explosion ".. gun:get_explosion_type())
	print("Fire ".. gun:get_fire_type())
	GunM:add_action("Damage ".. gun:get_damage_type().. " Explosion ".. gun:get_explosion_type().. " Fire ".. gun:get_fire_type(), function() gun:set_damage_type(gun:get_damage_type()) gun:set_explosion_type(gun:get_explosion_type()) end)
end


--Extra Info Actions/Text--
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--F9 = Removes your wanted level--")
Text(ExtraInfoMenu, "--F10 = Set local teleport position--")
Text(ExtraInfoMenu, "--F11 = Teleport to local position--")
Text(ExtraInfoMenu, "--F12 = Unstuck Car--")
ExtraInfoMenu:add_action("--Numpad 1 = Speed Boost--", function() SpeedBoostCTRL() end)
Text(ExtraInfoMenu, "--Numpad 3 = Heal All--")
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--⚠ = Risky--")
Text(ExtraInfoMenu, "-------------------------------------")
Text(ExtraInfoMenu, "--Version 3.0--")
Text(ExtraInfoMenu, "--Open Source!--")
Text(ExtraInfoMenu, "--stormxxboy.com--")
Text(ExtraInfoMenu, "--Made by StormXXBoy--")
Text(ExtraInfoMenu, "-------------------------------------")

function SpeedBoostCTRL()
	menu.register_hotkey(162, function() localplayer:set_run_speed(10) end)
end