-- Copy these entries into ox_inventory/data/items.lua.
-- The resource registers the box as a container at runtime, but ox_inventory
-- still needs every item to exist in its item list before it can be added.

['poojai_box'] = {
    label = 'Pooja Food Box',
    weight = 250,
    stack = false,
    close = false,
    consume = 0,
    description = 'A food box containing coconut water, pori and a banana.',
},

['coconut_water'] = {
    label = 'Coconut Water',
    weight = 250,
    stack = true,
    close = true,
    consume = 1,
    description = 'Fresh coconut water.',
    client = {
        status = {
            hunger = 100000,
            thirst = 100000,
        },
        anim = {
            dict = 'mp_player_intdrink',
            clip = 'loop_bottle',
        },
        prop = {
            model = `prop_ld_flow_bottle`,
            bone = 60309,
            pos = vec3(0.03, 0.03, 0.02),
            rot = vec3(0.0, 0.0, -1.5),
        },
        usetime = 2500,
    },
},

['pori'] = {
    label = 'Pori',
    weight = 100,
    stack = true,
    close = true,
    consume = 1,
    description = 'Crispy puffed rice.',
    client = {
        status = {
            hunger = 100000,
            thirst = 100000,
        },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger_fp',
        },
        prop = {
            model = `prop_cs_burger_01`,
            bone = 60309,
            pos = vec3(0.0, 0.0, -0.02),
            rot = vec3(30.0, 0.0, 0.0),
        },
        usetime = 2500,
    },
},

['banana'] = {
    label = 'Banana',
    weight = 120,
    stack = true,
    close = true,
    consume = 1,
    description = 'A ripe banana.',
    client = {
        status = {
            hunger = 100000,
            thirst = 100000,
        },
        anim = {
            dict = 'mp_player_inteat@burger',
            clip = 'mp_player_int_eat_burger_fp',
        },
        usetime = 2500,
    },
},
