RegisterCommand('livery', function(source, args)
    local livery = tonumber(args[1])
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    local count = GetVehicleLiveryCount(veh)
    local inveh = IsPedInAnyVehicle(ped, false)

    if inveh then
        if livery <= count and livery ~= 0 then
            SetVehicleLivery(veh, livery)
            TriggerEvent('ox_lib:notify', {
                title = 'Vehicle Livery',
                description = 'Livery set to '..livery,
                type = 'success',
                duration = 5000
            })
        else
            TriggerEvent('ox_lib:notify', {
                title = 'Error',
                description = 'Invalid Livery',
                type = 'error',
                duration = 5000
            })
        end
    else
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'You are not in a vehicle',
            type = 'error',
            duration = 5000
        })
    end
end)

CreateThread(function()
    while true do
        Wait(4000)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local count = GetVehicleLiveryCount(veh)
        local inveh = IsPedInAnyVehicle(ped, false)

        local text = ""

        if inveh and count ~= -1 then
            text = string.format("This vehicle has %d liveries", count)
        elseif inveh and count == -1 then
            text = "This vehicle has not got liveries"
        else
            text = "You are not in a vehicle"
        end

        TriggerEvent('chat:addSuggestion', '/livery', 'Change Vehicle Livery', {
            { name="livery", help=text },
        })
    end
end)
