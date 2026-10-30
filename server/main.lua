local oxInventory = exports.ox_inventory

local function registerContainerItem()
    oxInventory:setContainerProperties(Config.BoxItem, {
        slots = Config.BoxContainer.slots,
        maxWeight = Config.BoxContainer.maxWeight,
        whitelist = {
            coconut_water = true,
            pori = true,
            banana = true,
        },
    })
end

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() or resourceName == 'ox_inventory' then
        registerContainerItem()
    end
end)

local function sendNotify(source, description, notifyType)
    TriggerClientEvent('poojai:client:notify', source, description, notifyType)
end

local function isNearPickup(source)
    local ped = GetPlayerPed(source)
    if ped <= 0 then
        return false
    end

    local coords = GetEntityCoords(ped)
    return #(coords - Config.BoxLocation) <= Config.PickupDistance
end

RegisterNetEvent('poojai:server:claimBox', function()
    local source = source

    if not isNearPickup(source) then
        sendNotify(source, 'You are too far away from the food box.', 'error')
        return
    end

    if Config.OneBoxPerCharacter and oxInventory:GetItemCount(source, Config.BoxItem) > 0 then
        sendNotify(source, 'You already have a food box.', 'error')
        return
    end

    if not oxInventory:CanCarryItem(source, Config.BoxItem, 1) then
        sendNotify(source, 'You do not have enough inventory space.', 'error')
        return
    end

    local success, response = oxInventory:AddItem(source, Config.BoxItem, 1)
    if not success then
        sendNotify(source, 'The food box could not be added to your inventory.', 'error')
        print(('[%s] Failed to add %s to player %s: %s'):format(GetCurrentResourceName(), Config.BoxItem, source, response or 'unknown'))
        return
    end

    local boxSlot = response and response.slot or oxInventory:GetSlotIdWithItem(source, Config.BoxItem)
    local container = boxSlot and oxInventory:GetContainerFromSlot(source, boxSlot)

    if not container then
        oxInventory:RemoveItem(source, Config.BoxItem, 1, nil, boxSlot)
        sendNotify(source, 'The food box could not be prepared. Please try again.', 'error')
        return
    end

    local containerId = container.id or container
    for _, content in ipairs(Config.BoxContents) do
        local contentAdded = oxInventory:AddItem(containerId, content.item, content.count)
        if not contentAdded then
            oxInventory:RemoveItem(source, Config.BoxItem, 1, nil, boxSlot)
            sendNotify(source, 'The food box could not be prepared. Please try again.', 'error')
            print(('[%s] Failed to add %s to container %s'):format(GetCurrentResourceName(), content.item, tostring(containerId)))
            return
        end
    end

    sendNotify(source, 'Food box added to your inventory.', 'success')
end)
