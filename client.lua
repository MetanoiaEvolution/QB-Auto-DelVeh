local QBCore = exports['qb-core']:GetCoreObject() -- Initialize QBCore
local vehiclesToBeDeleted = {}

-- Function to check if a vehicle is eligible for deletion
function checkVehicle(vehicle)
    local driver = GetPedInVehicleSeat(vehicle, -1) -- Get the driver of the vehicle
    local locked = GetVehicleDoorLockStatus(vehicle) -- Door lock status (1 = unlocked, 2 = locked)
    local isNPC = not IsPedAPlayer(driver) -- Check if the driver is an NPC

    -- Vehicles eligible for deletion:
    -- 1. NPC vehicles (whether locked or unlocked)
    -- 2. Player vehicles that are unlocked and unoccupied
    -- 3. NPC-driven vehicles with no passengers
    if (isNPC or not driver) and (locked ~= 2 or isNPC) and GetVehicleNumberOfPassengers(vehicle) == 0 then
        return true
    else
        return false
    end
end

-- Function to notify players using QBCore notification system
function notifyAllPlayers(message)
    QBCore.Functions.Notify(message, "error") -- Send notification as an error message
end

-- Function to clean up vehicles that are eligible for deletion
function cleanupVehicles()
    vehiclesToBeDeleted = {} -- Reset the list of vehicles to be deleted

    local vehicles = GetGamePool('CVehicle') -- Get all vehicles in the game
    for _, vehicle in ipairs(vehicles) do
        if checkVehicle(vehicle) then
            table.insert(vehiclesToBeDeleted, vehicle) -- Add eligible vehicles to the list
        end
    end

    -- Countdown notifications
    Citizen.SetTimeout(0, function() notifyAllPlayers("⚠️ Vehicle cleanup in 60 seconds!") end)
    Citizen.SetTimeout(30000, function() notifyAllPlayers("⚠️ Vehicle cleanup in 30 seconds!") end)
    Citizen.SetTimeout(50000, function() notifyAllPlayers("⚠️ Vehicle cleanup in 10 seconds!") end)

    -- After 60 seconds, delete the vehicles
    Citizen.SetTimeout(60000, function()
        for _, vehicle in ipairs(vehiclesToBeDeleted) do
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle) -- Delete the vehicle
            end
        end
        notifyAllPlayers(Config.CleanupMessage) -- Notify after cleanup
    end)
end

-- Function for manual cleanup with a specified radius
function manualCleanup(radius)
    vehiclesToBeDeleted = {} -- Reset the list of vehicles to be deleted

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local vehicles = GetGamePool('CVehicle') -- Get all vehicles in the game

    for _, vehicle in ipairs(vehicles) do
        local vehicleCoords = GetEntityCoords(vehicle)
        if #(playerCoords - vehicleCoords) <= radius and checkVehicle(vehicle) then
            table.insert(vehiclesToBeDeleted, vehicle) -- Add eligible vehicles to the list
        end
    end

    -- Manual countdown 10 seconds
    notifyAllPlayers("⚠️ Unlocked vehicles will be removed in 10 seconds!")
    Citizen.SetTimeout(5000, function() notifyAllPlayers("⚠️ Cleanup in 5 seconds!") end)
    Citizen.SetTimeout(9000, function() notifyAllPlayers("⚠️ Cleanup in 1 second!") end)

    -- After 10 seconds, delete the vehicles
    Citizen.SetTimeout(10000, function()
        for _, vehicle in ipairs(vehiclesToBeDeleted) do
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle) -- Delete the vehicle
            end
        end
        notifyAllPlayers(Config.CleanupMessage) -- Notify after cleanup
    end)
end

-- Main thread to run cleanup based on intervals
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CleanupInterval * 60000) -- Wait according to the interval (in minutes)
        cleanupVehicles() -- Run the cleanup
    end
end)

-- Add a command for immediate cleanup
RegisterCommand("scrapnow", function(_, args)
    local radius = Config.CleanupRadius
    if args[1] then
        radius = tonumber(args[1]) -- If the first argument is provided, use it as the radius
    end
    manualCleanup(radius) -- Run manual cleanup with the specified radius
end, false)
