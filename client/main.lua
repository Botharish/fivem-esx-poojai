local boxProp
local targetZone

local function notify(description, notifyType)
    lib.notify({
        description = description,
        type = notifyType or 'inform',
    })
end

RegisterNetEvent('poojai:client:notify', function(description, notifyType)
    notify(description, notifyType)
end)

local function loadModel(model)
    local modelHash = joaat(model)

    if not IsModelInCdimage(modelHash) or not IsModelValid(modelHash) then
        return nil
    end

    RequestModel(modelHash)

    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(modelHash) and GetGameTimer() < timeout do
        Wait(50)
    end

    if not HasModelLoaded(modelHash) then
        return nil
    end

    return modelHash
end

local function createBoxProp()
    local modelHash = loadModel(Config.BoxProp.model)
    if not modelHash then
        print(('[%s] Could not load prop model %s'):format(GetCurrentResourceName(), Config.BoxProp.model))
        return
    end

    boxProp = CreateObject(modelHash, Config.BoxLocation.x, Config.BoxLocation.y, Config.BoxLocation.z, false, false, false)
    SetEntityHeading(boxProp, Config.BoxProp.heading)
    PlaceObjectOnGroundProperly(boxProp)
    FreezeEntityPosition(boxProp, true)
    SetEntityAsMissionEntity(boxProp, true, true)
    SetModelAsNoLongerNeeded(modelHash)
end

CreateThread(function()
    createBoxProp()

    targetZone = exports.ox_target:addSphereZone({
        coords = Config.BoxLocation,
        radius = Config.TargetRadius,
        debug = false,
        options = {
            {
                name = 'poojai_food_box_pickup',
                icon = 'fa-solid fa-box-open',
                label = 'Give me food box',
                distance = Config.TargetDistance,
                onSelect = function()
                    TriggerServerEvent('poojai:server:claimBox')
                end,
            },
        },
    })
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    if targetZone then
        exports.ox_target:removeZone(targetZone)
    end

    if boxProp and DoesEntityExist(boxProp) then
        DeleteEntity(boxProp)
    end
end)
