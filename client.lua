ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('sellcar', function(source, args)
    price = tonumber(args[1])

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        modelHash = GetEntityModel(vehicle)
        modelName = GetDisplayNameFromVehicleModel(modelHash)
        numberplate = GetVehicleNumberPlateText(vehicle) -- Corrected variable name

        TriggerServerEvent('bil_salg:salg_veh', modelHash, modelName, price, numberplate)
    else
        lib.notify({description = 'Du er ikke i et køretøj', type = 'error'})
    end
end)

RegisterCommand('buycar', function(source, args)
    numberplate = args[1]
    TriggerServerEvent('bil_salg:koeb_veh', numberplate)
end)

RegisterCommand('carlist', function()
    TriggerEvent('bil_salg:salg_veh_menu')
end)

RegisterNetEvent('bil_salg:salg_veh_menu')
AddEventHandler('bil_salg:salg_veh_menu', function(model, modelName, price, numberplate)
    ESX.TriggerServerCallback('bil:sell:get_biler', function(vehicles)
        local options = {}

        for _, vehicle in pairs(vehicles) do
            table.insert(options, {
                title = vehicle.label,
                description = 'Køb ' .. vehicle.label .. ' for ' .. vehicle.price .. ' DKK',
                metadata = {
                    Pris = vehicle.price,
                    Nummerplade = vehicle.numberplate,
                },
                onSelect = function(selected)
                end
            })
        end

        lib.registerContext({
            id = 'open_sell_menu',
            title = 'Liste over',
            options = options
        })

        lib.showContext('open_sell_menu')
    end)
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/sellcar', 'Sælg dit køretøj', {
      {name="pris", help="Prisen på køretøjet"},
    })
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/buycar', 'Køb køretøj', {
      {name="nummerplade", help="Nummerpladen på køretøjet du vil købe"},
    })
end)