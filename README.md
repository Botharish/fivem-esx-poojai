# Pooja Food Box

An ESX Legacy resource using `ox_target` and `ox_inventory`.

Players target the box at the configured location and select **Give me food box**. The box is added as a unique inventory container. Using it opens the container, which contains coconut water, pori and a banana. Each item restores 10% hunger and 10% thirst.

## Installation

1. Copy this folder into the server's resources directory.
2. Open `ox_inventory/data/items.lua` and copy the entries from `ox_inventory_items.lua` into the returned item table.
3. Add these lines to `server.cfg` after the dependencies:

   ```cfg
   ensure es_extended
   ensure esx_status
   ensure ox_lib
   ensure ox_target
   ensure ox_inventory
   ensure poojai
   ```

4. Set `inventory:framework` to `esx` in the ox_inventory configuration if it is not already set.
5. Change `Config.BoxLocation` in `config.lua` if needed.

The box is limited to one per character by default. Set `Config.OneBoxPerCharacter = false` if players should be able to claim more than one.

## Notes

- The server checks the player's distance from the pickup location.
- The box only accepts the three configured food/drink items.
- The item status values assume ESX's normal 0-1000000 hunger/thirst scale.
