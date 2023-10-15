--[[
    Simple Inventory Display using the Advanced Peripherals addon mod's Inventory Manager
    Version: 1.0.0
    Uses a Advanced Peripherals Inventory Manager to display your inventory on a monitor, as well as your armor.
    NOTE: This is a "base" program, meaning it has concepts that will be used in other programs in the repository.
    General TODO: Clean up code. More readable.
]] --
-- Clear the shell and print a startup message
shell.run("clear")
print("Starting...")
print("")
print("Simple Inventory Display")
print("Version: 1.0.0")
print("")
print("By: Viking790")
-- if you make any changes to this code, please add your name to the list above. IE: By: Viking790, Steve, Bob, etc.
-- the order is just chronological and pops up in the computer's terminal
sleep(5)
shell.run("clear")
print("Started!")
print("")
print("Please put a 3x3 Advanced Monitor on top of the computer")
print("")
print("Please put a Inventory Manager with a bound memory card under the computer")
sleep(2)
shell.run("clear")

-- VARIABLES:
-- Connect the peripherals

local mon = peripheral.find("monitor")
local im =  peripheral.find("inventoryManager")

-- Setup the inventory manager
local armor = im.getArmor()
local inv =   im.getItems()
-- VARIABLES: END

-- Setup the monitor
mon.setTextColor(colors.cyan)
mon.setBackgroundColor(colors.black)
mon.clear()

-- Armor display function
function armorDisplay(i)
    mon.setCursorPos(1, 1)
    mon.write("Armor:")
    mon.setCursorPos(1, 2)
    for k, v in pairs(armor[i]) do
        if k == "displayName" then
            mon.setCursorPos(1, 1 + i)
            mon.write(v)
        end
    end
end

-- Inventory display function
function invdisplay()
    mon.setCursorPos(1, 7)
    mon.write("Inventory:")
    mon.setCursorPos(1, 8)
    for i = 1, 27 do
        if inv[i] == nil then
            break
        end
        mon.write(i .. ": " .. inv[i].count .. " " .. inv[i].displayName)
        mon.setCursorPos(1, 8 + i)
    end
end

-- Main loop

while true do
    armor = im.getArmor()
    inv = im.getItems()
    mon.clear()
    -- TODO: This is "backwards" and should be fixed. 4 (Helmet) should render on line 2 (Right under Armor:), and on
    if armor[1] ~= nil then
        armorDisplay(1)
    end
    if armor[2] ~= nil then
        armorDisplay(2)
    end
    if armor[3] ~= nil then
        armorDisplay(3)
    end
    if armor[4] ~= nil then
        armorDisplay(4)
    end
    invdisplay()
    sleep(1)
end
