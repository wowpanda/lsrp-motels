Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local ESX = nil
local myMotel = false
local curMotel = nil
local curRoom = nil
local curRoomOwner = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
    createBlips()
end)


function createBlips()
    for k,v in pairs(Config.Zones) do
            local blip = AddBlipForCoord(tonumber(v.Pos.x), tonumber(v.Pos.y), tonumber(v.Pos.z))
			SetBlipSprite(blip, v.Pos.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.Pos.size)
			SetBlipColour(blip, v.Pos.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Name)
			EndTextCommandSetBlipName(blip)
    end
end

function getMyMotel()
ESX.TriggerServerCallback('lsrp-motels:checkOwnership', function(owned)
    myMotel = owned
end)
end

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'motelroom' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('lsrp-motels:cancelRental')
AddEventHandler('lsrp-motels:cancelRental', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    TriggerServerEvent("lsrp-motels:cancelRental", room)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "renting_motel",
        duration = 2000,
        label = "Cancelling Contract for room "..motelRoom,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
anim = "idle_a",
        },
        prop = {
            model = "prop_notepad_01"	
        }
}, function(status)
        if not status then
            myMotel = false
        end
end)
end)

function PlayerDressings()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = 'Player Clothing',
		align    = 'top-left',
		elements = {
            {label = _U('player_clothes'), value = 'player_dressing'},
	        {label = _U('remove_cloth'), value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('lsrp-motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = _U('player_clothes'),
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('lsrp-motels:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then
            menu.close()
			ESX.TriggerServerCallback('lsrp-motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = _U('remove_cloth'),
					align    = 'top-left',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('lsrp-motels:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
        menu.close()
	end)




end

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
    if instance.type == 'motelroom' then
        local property = instance.data.property
        local motel = instance.data.motel
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
	end
end)

AddEventHandler('instance:loaded', function()
    TriggerEvent('instance:registerType', 'motelroom', function(instance)
        NetworkSetVoiceChannel(instance.data.property)
		EnterProperty(instance.data.property, instance.data.owner, instance.data.motel, instance.data.room)
    end, function(instance)
        NetworkClearVoiceChannel()
		ExitProperty(instance.data.property, instance.data.motel, instance.data.room)
	end)
end)

function EnterProperty(name, owner, motel, room)
    curMotel      = motel
    curRoom       = room
    local playerPed     = PlayerPedId() 
    Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
        end
        for k,v in pairs(Config.Zones) do     
                if curMotel == k then
                    SetEntityCoords(playerPed, v.roomLoc.x, v.roomLoc.y, v.roomLoc.z)
                end
        end
		DoScreenFadeIn(800)
	end)
end

RegisterNetEvent('lsrp-motels:enterRoom')
AddEventHandler('lsrp-motels:enterRoom', function(room, motel)
    local roomID = nil
    local playerPed = PlayerPedId()
    local roomIdent = room
    local reqmotel = motel
    ESX.TriggerServerCallback('lsrp-motels:getMotelRoomID', function(roomno)
    roomID = roomno
    end, room)
    Citizen.Wait(500)
    if roomID ~= nil then
    local instanceid = 'motel'..roomID..''..roomIdent
        TriggerEvent('instance:create', 'motelroom', {property = instanceid, owner = ESX.GetPlayerData().identifier, motel = reqmotel, room = roomIdent})
    end
end)

RegisterNetEvent('lsrp-motels:exitRoom')
AddEventHandler('lsrp-motels:exitRoom', function(motel, room)
    local roomID = room
    local playerPed = PlayerPedId()
    Citizen.Wait(500)
    TriggerEvent('instance:leave')
end)

RegisterNetEvent('lsrp-motels:roomOptions')
AddEventHandler('lsrp-motels:roomOptions', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'lsrp-motels',
        {
            title    = motelName..' Room '..motelRoom,
            align    = 'top-right',
            elements = { 
                { label = 'Enter Room', value = 'enter' },
                { label = 'Cancel Rental', value = 'cancel' }
            }
        },
    function(data, menu)
        local value = data.current.value

        if value == 'enter' then
            menu.close()
            TriggerEvent("lsrp-motels:enterRoom", room, motel)

        elseif value == 'cancel' then
            menu.close()
            TriggerEvent("lsrp-motels:cancelRental", room)
        end

    end,
    function(data, menu)
        menu.close()
    end)
end)


RegisterNetEvent('lsrp-motels:roomMenu')
AddEventHandler('lsrp-motels:roomMenu', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    local owner = ESX.GetPlayerData().identifier
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    ESX.TriggerServerCallback('lsrp-motels:checkIsOwner', function(isOwner)
    if isOwner then
        options = {}

        if Config.SwitchCharacterSup then
        table.insert(options, {label = 'Change Character', value = 'changechar'})
        end
        table.insert(options, {label = 'Open Room Inventory', value = 'inventory'})
        table.insert(options, {label = 'Invite Citizen', value = 'inviteplayer'})
        

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'lsrp-motels',
        {
            title    = motelName..' Room '..motelRoom,
            align    = 'top-right',
            elements = options
        },
    function(data, menu)
        local value = data.current.value
        if value == 'changechar' then
            menu.close()
            TriggerEvent("mythic_progbar:client:progress", {
                name = "renting_motel",
                duration = 2000,
                label = "Leaving the City",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
                        disableMovement = true,
                        disableCarMovement = false,
                        disableMouse = false,
                        disableCombat = true,
                },
                
        }, function(status)
                if not status then
                    TriggerEvent('kashactersC:ReloadCharacters')
                    TriggerServerEvent("kashactersS:SaveSwitchedPlayer")
                end
        end)

        elseif value == 'inventory' then
            menu.close()

            owner = ESX.GetPlayerData().identifier
    ESX.TriggerServerCallback('lsrp-motels:checkIsOwner', function(isOwner)
        if isOwner then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "renting_motel",
                        duration = 1500,
                        label = "Accessing Room Inventory",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                                disableMovement = true,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                        },
                        
                }, function(status)
                        if not status then
                            OpenPropertyInventoryMenu('motels', owner)
                        end
                end)    
        else
            TriggerClientEvent('esx:showNotification', '~w~Accessible by Motel ~r~Owner~w~ only!')  
        end
    end, curRoom, owner)
        elseif value == 'inviteplayer' then
            local myInstance = nil
            local roomIdent = room
            local reqmotel = motel
            
            for k,v in pairs(Config.Zones) do
                for kk,vm in pairs(v.Rooms) do       
                    if room == vm.instancename then
                        playersInArea = ESX.Game.GetPlayersInArea(vm.entry, 5.0)
                    end
                end
            end
             
			local elements      = {}
            if playersInArea ~= nil then
                for i=1, #playersInArea, 1 do
                    if playersInArea[i] ~= PlayerId() then
                        table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
                    end
                end
            else
                table.insert(elements, {label = 'No Citizens Outside.'})
            end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite',
			{
				title    = motelName..' Room '..motelRoom .. ' - ' .. _U('invite') ..' Citizen',
				align    = 'top-right',
				elements = elements,
            }, function(data2, menu2)
                ESX.TriggerServerCallback('lsrp-motels:getMotelRoomID', function(roomno)
                    roomID = roomno
                    end, room)
                myInstance = 'motel'..roomID..''..roomIdent
				TriggerEvent('instance:invite', 'motelroom', GetPlayerServerId(data2.current.value), {property = myInstance, owner = ESX.GetPlayerData().identifier, motel = reqmotel, room = roomIdent})
				ESX.ShowNotification(_U('you_invited', GetPlayerName(data2.current.value)))
			end, function(data2, menu2)
				menu2.close()
			end)



        end

    end,
    function(data, menu)
        menu.close()
    end)
    else
        options = {}

        if Config.SwitchCharacterSup then
            table.insert(options, {label = 'Change Character', value = 'changechar'})
        end

        ESX.UI.Menu.Open(
            'default', GetCurrentResourceName(), 'lsrp-motels',
            {
                title    = motelName..' Room '..motelRoom,
                align    = 'top-right',
                elements = options
            },
        function(data, menu)
            local value = data.current.value
    
            if value == 'changechar' then
                menu.close()
                TriggerEvent('kashactersC:ReloadCharacters')
                TriggerServerEvent("kashactersS:SaveSwitchedPlayer")
            end
        end,
        function(data, menu)
            menu.close()
        end)
    end
end, curRoom, owner)
end)

RegisterNetEvent('lsrp-motels:rentRoom')
AddEventHandler('lsrp-motels:rentRoom', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    TriggerServerEvent('lsrp-motels:rentRoom', room)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "renting_motel",
        duration = 2000,
        label = "Renting Room "..motelRoom,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
anim = "idle_a",
        },
        prop = {
            model = "prop_notepad_01"	
        }
}, function(status)
        if not status then

        end
end)

end)


function enteredExitMarker()
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
    local canSleep  = true
        for k,v in pairs(Config.Zones) do
            for km,vm in pairs(v.Rooms) do
                distance = GetDistanceBetweenCoords(coords, v.roomExit.x, v.roomExit.y, v.roomExit.z, true)
                if (distance < 1.0) then
                    if curRoom ~= nil then
                        DrawMarker(20, v.roomExit.x, v.roomExit.y, v.roomExit.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.RoomMarker.x, Config.RoomMarker.y, Config.RoomMarker.z, 255, 0, 0, 100, false, true, 2, false, false, false, false)	
                        DrawText3D(v.roomExit.x, v.roomExit.y, v.roomExit.z + 0.35, 'Press [~g~E~s~] to exit')
                        if IsControlJustReleased(0, Keys['E']) then
                            ESX.UI.Menu.CloseAll()
                        TriggerEvent('lsrp-motels:exitRoom', curMotel, curRoom)
                        end
                    end  
                end
            end
        end
end


function enteredMarker()
   
    local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
    local canSleep  = true
    if not myMotel then
        for k,v in pairs(Config.Zones) do
            distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if (distance < v.Boundries) then
                for km,vm in pairs(v.Rooms) do
                    distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                    if (distance < 1.0) then
                        DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, 'Press [~g~E~s~] to rent Room ~b~'..vm.number)
                        if IsControlJustReleased(0, Keys['E']) then
                            TriggerEvent('lsrp-motels:rentRoom', vm.instancename)
                        end
                    end
                end
            end
        end    
    else 
        for k,v in pairs(Config.Zones) do
            for km,vm in pairs(v.Rooms) do
                distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
                if (distance < v.Boundries) then
                    if vm.instancename == myMotel then
                        distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                        if (distance < 1.0) then
                            DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, 'Press [~g~E~s~] for options.')
                            if IsControlJustReleased(0, Keys['E']) then
                                TriggerEvent("lsrp-motels:roomOptions", vm.instancename, k)
                            end
                        end
                    end
                end
            end
        end
    end
end



function ExitProperty(name, motel, room)
	local property  = name
    local playerPed = PlayerPedId()
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end
        for k,v in pairs(Config.Zones) do
            for km,vm in pairs(v.Rooms) do
                if room == vm.instancename then
                SetEntityCoords(playerPed, vm.entry.x, vm.entry.y, vm.entry.z)
                end
            end
        end
		DoScreenFadeIn(800)
	end)
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)
        while true do
            Citizen.Wait(0)
            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)
            for k,v in pairs(Config.Zones) do
                distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
                if (distance < v.Boundries) then
                    getMyMotel()
                    Citizen.Wait(3000)
                end
            end
        end
end)


function OpenPropertyInventoryMenu(property, owner)
	ESX.TriggerServerCallback(
		"lsrp-motels:getPropertyInventory",
		function(inventory)
			TriggerEvent("esx_inventoryhud:openMotelsInventory", inventory)
		end, owner)
end

function OpenPropertyInventoryMenuBed(property, owner)
	ESX.TriggerServerCallback(
		"lsrp-motels:getPropertyInventoryBed",
		function(inventory)
			TriggerEvent("esx_inventoryhud:openMotelsInventoryBed", inventory)
		end, owner)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        enteredMarker()
        enteredExitMarker()
        local playerPed = PlayerPedId()
        local coords    = GetEntityCoords(playerPed)

            for k,v in pairs(Config.Zones) do
                distance = GetDistanceBetweenCoords(coords, v.BedStash.x, v.BedStash.y, v.BedStash.z, true)
                if distance < 1.0 then
                    DrawText3D(v.BedStash.x, v.BedStash.y, v.BedStash.z + 0.1, 'Press [~g~E~s~] to access stash.')
                        if IsControlJustReleased(0, Keys['E']) then
                            OpenStash()
                        end
                end
            end
        if curRoom ~= nil and curMotel ~= nil then
            for k,v in pairs(Config.Zones) do
                distance = GetDistanceBetweenCoords(coords, v.Menu.x, v.Menu.y, v.Menu.z, true)
                if distance < 1.0 then
                    
                    DrawMarker(20, v.Menu.x, v.Menu.y, v.Menu.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.RoomMarker.x - 0.2, Config.RoomMarker.y -0.2, Config.RoomMarker.z - 0.3, 0, 0, 255, 100, false, true, 2, false, false, false, false)	
                    DrawText3D(v.Menu.x, v.Menu.y, v.Menu.z + 0.35, 'Press [~g~E~s~] to access menu.')
                        if IsControlJustReleased(0, Keys['E']) then
                            TriggerEvent('lsrp-motels:roomMenu', curRoom, curMotel)
                        end
                end
            end
        end
        for k,v in pairs(Config.Zones) do
            distance = GetDistanceBetweenCoords(coords, v.Inventory.x, v.Inventory.y, v.Inventory.z, true)
            if distance < 1.0 then
                DrawMarker(20, v.Inventory.x, v.Inventory.y, v.Inventory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.RoomMarker.x - 0.2, Config.RoomMarker.y -0.2, Config.RoomMarker.z - 0.3, 0, 0, 255, 100, false, true, 2, false, false, false, false)	
                DrawText3D(v.Inventory.x, v.Inventory.y, v.Inventory.z + 0.35, 'Press [~g~E~s~] to change outfit.')
                    if IsControlJustReleased(0, Keys['E']) then
                        PlayerDressings()
                    end
            end
        end

        if myMotel then 
            for k,v in pairs(Config.Zones) do
                for km,vm in pairs(v.Rooms) do
                    if vm.instancename == myMotel then
                        distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                        if (distance < v.Boundries) then
                        DrawMarker(20, vm.entry.x, vm.entry.y, vm.entry.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.RoomMarker.x, Config.RoomMarker.y, Config.RoomMarker.z, Config.RoomMarker.Owned.r, Config.RoomMarker.Owned.g, Config.RoomMarker.Owned.b, 100, false, true, 2, false, false, false, false)	
                        end
                    end
                end
            end
        end
    end
end)

function OpenStash()

    owner = ESX.GetPlayerData().identifier
    ESX.TriggerServerCallback('lsrp-motels:checkIsOwner', function(isOwner)
        if isOwner then
                    TriggerEvent("mythic_progbar:client:progress", {
                        name = "renting_motel",
                        duration = 1500,
                        label = "Accessing Stash",
                        useWhileDead = false,
                        canCancel = true,
                        controlDisables = {
                                disableMovement = true,
                                disableCarMovement = false,
                                disableMouse = false,
                                disableCombat = true,
                        },
                        
                }, function(status)
                        if not status then
                            OpenPropertyInventoryMenuBed('motelsbed', owner)
                        end
                end)    
        else
            TriggerClientEvent('esx:showNotification', '~w~Accessible by Motel ~r~Owner~w~ only!')  
        end
    end, curRoom, owner)
end

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.45
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end