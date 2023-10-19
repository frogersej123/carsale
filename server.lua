ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('bil_salg:salg_veh')
AddEventHandler('bil_salg:salg_veh', function(model, modelName, price, numberplate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO bil_vehicle_test (label, model, price, numberplate) VALUES (@label, @model, @price, @numberplate)', {
        ['@label'] = modelName,
        ['@model'] = model,
        ['@price'] = price,
        ['@numberplate'] = numberplate
    })
end)

RegisterNetEvent('bil_salg:koeb_veh')
AddEventHandler('bil_salg:koeb_veh', function(numberplate)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.execute('DELETE FROM bil_vehicle_test WHERE numberplate = @numberplate', {
        ['@numberplate'] = numberplate
    })
end)

ESX.RegisterServerCallback('bil:sell:get_biler', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM bil_vehicle_test', {}, function(vehicles)
        local vehicleData = {}

        for _, vehicle in pairs(vehicles) do
            table.insert(vehicleData, {
                label = vehicle.label,
                model = vehicle.model,
                price = vehicle.price,
                numberplate = vehicle.numberplate
            })
        end

        cb(vehicleData)
    end)
end)