ESX = nil

local position = {
    {x = 238.3,   y = -404.3,  z = 47.92 },
}

local MenuOpen = false

local Menu = {
    checkbox = false,
}

DecorRegister("Female", 4)
pedHash = "s_f_y_airhostess_01"
zone = vector3(238.7, -402.86, 46.92)
Heading = 161.62
Ped = nil
HeadingSpawn = 161.62

Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    DecorSetInt(Ped, "Female", 5431)
    FreezeEntityPosition(Ped, 1)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

function NotifSound()
    PlaySoundFrontend( -1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    ESX.ShowAdvancedNotification("Office du Toursime", "Position GPS ~g~effectuée", "", "CHAR_MOLLY", 1)
end

function NotifSound2()
    PlaySoundFrontend( -1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 1)
    ESX.ShowAdvancedNotification("Office du Toursime", "Position GPS ~r~annulé", "", "CHAR_MOLLY", 1)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
    end

RMenu.Add('modeo', 'main', RageUI.CreateMenu("Office du Tourisme", "By Modeo"))
RMenu:Get('modeo', 'main'):SetRectangleBanner(255, 0, 0, 100)
RMenu:Get('modeo', 'main').Closed = function()
    MenuOpen = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if dist <= 1.0 then

               RageUI.Text({
                    message = "Appuyez sur [~r~E~w~] pour parler à ~r~L'Agent d'accueil Touristique",
                    time_display = 100,
                })

                if IsControlJustPressed(1,51) then
                    openTourisme()
                    end
                end
            end
        end
    end)
end)

function openTourisme()
    if not MenuOpen then

        MenuOpen = true
        RageUI.Visible(RMenu:Get('modeo', 'main'), true)
        
    Citizen.CreateThread(function()
        while MenuOpen do
            Citizen.Wait(1)
        RageUI.IsVisible(RMenu:Get('modeo', 'main'), true, true, true, function()

            RageUI.Checkbox("Demander ou se trouve les ~r~lieux importants",nil, checkbox,{Style = RageUI.CheckboxStyle.Tick},function(Hovered,Active,Selected,Checked)
                if Selected then
                    checkbox = Checked
                    if Checked then
                        Checked = true
                    else
                        Checked = false
                    end
                end
            end)

            if checkbox then
            RageUI.Separator("↓ ~r~Office du Tourisme~s~ ↓")

            RageUI.Button("Mécano", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(-215.84, -1319.09, 30.89)
            NotifSound()
                end
            end)

            RageUI.Button("Concessionnaire", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(-29.99, -1104.84, 26.41)
            NotifSound()
                end
            end)

            RageUI.Button("Parking Central", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(215.8, -810.07, 30.73)
            NotifSound()
                end
            end)

            RageUI.Button("Gouvernement", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(-545.49, -203.59, 38.21)
            NotifSound()
                end
            end)

            RageUI.Button("Commissariat", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(-1098.31, -830.7, 4.88)
            NotifSound()
                end
            end)

            RageUI.Button("Annuler", nil, {RightLabel = ""}, true,function(h,a,s)
            if s then
            SetNewWaypoint(238.3, -404.3, 46.92)
            NotifSound2()
                    end
                end)
            end
        end)
    end
        end, function()
        end, 1)

        Citizen.Wait(0)
    end
end