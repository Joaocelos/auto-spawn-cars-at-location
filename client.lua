-- Load config file
local configFile = LoadResourceFile(GetCurrentResourceName(), "config.json")
local config = json.decode(configFile)

-- Spawn cars at configured locations
Citizen.CreateThread(function()
    for _, location in ipairs(config.locations) do
        local car = GetHashKey(location.model)
        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end
        local vehicle = CreateVehicle(car, location.x, location.y, location.z, location.heading, true, false)
        SetVehicleNumberPlateText(vehicle, location.plate)
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleOnGroundProperly(vehicle)
        FreezeEntityPosition(vehicle, true)
    end
end)
