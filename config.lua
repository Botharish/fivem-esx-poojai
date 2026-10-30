Config = {}

-- Change this location to the place where players should collect the box.
Config.BoxLocation = vec3(215.76, -810.12, 30.73)
Config.PickupDistance = 3.0
Config.TargetRadius = 1.5
Config.TargetDistance = 2.5

Config.BoxItem = 'poojai_box'
Config.OneBoxPerCharacter = true

Config.BoxContents = {
    { item = 'coconut_water', count = 1 },
    { item = 'pori', count = 1 },
    { item = 'banana', count = 1 },
}

Config.BoxContainer = {
    slots = 6,
    maxWeight = 3000,
}

Config.BoxProp = {
    model = 'prop_box_wood05a',
    heading = 0.0,
}
