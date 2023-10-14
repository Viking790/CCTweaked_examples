--[[
    Wood Factory Bot
    Version: 1.0.0
    Uses a Advanced Peripherals End Automata to create a row of birch trees, bone meal them to growth, break them, collect the drops, then move them
    over to a chest for processing
    Teleportation is used to move the turtle around the farm.
    NOTE: This is kind of broken. It works, but it doesn't refill itself properly, and just throws out items on the floor instead of tping them to the storage.
]] --

-- Clear the shell and print a startup message
shell.run("clear")
print("Starting...")
print("")
print("Wood Factory Bot")
print("Version: 1.0.0")
print("")
print("By: Viking790")
sleep(1)
shell.run("clear")
print("Started!")
print("")
print("Please make sure there is plenty of room for me!")
print("")
print("As well as a storage chest to my left, right, and below me")

-- Find the End Automata 
local automata = peripheral.wrap("right")

-- starting teleport location
automata.savePoint("start")

-- Prompt the user to input required items, then number of trees to plant
print("Please input the required items for the bot to use: ")
print("Inventory slot 1: Dirt equal to the number of trees to plant")
print("Inventory slot 2: 64x Tree Fertilizer")
print("Inventory slot 3: Birch saplings equal to the number of trees to plant")
print("Inventory slot 4: 1x Birch Log")
print("Inventory slot 5: 64x Charcoal")

print("Please input the number of trees to plant: ")
numTrees = io.read()

-- initial planting of trees
if numTrees ~= nil then
    turtle.select(5)
    turtle.refuel()
    turtle.up()
    for i = 1, numTrees do
        automata.savePoint("tree" .. i)
        turtle.forward()
        turtle.select(1)
        turtle.placeDown()
        turtle.select(3)
        turtle.up()
        turtle.placeDown()
        for i = 1, 3 do
            turtle.forward()
        end
        turtle.down()
    end

    -- wait a lil
    sleep(2)

    -- main loop

    while turtle.getFuelLevel() > 0 do

        -- fertilizer the trees

        for i = 1, numTrees do
            automata.warpToPoint("tree" .. i)
            turtle.select(2)
            turtle.place()
            sleep(1)

            -- break the trees
            automata.warpToPoint("tree" .. i)
            turtle.select(4)
            if turtle.compare() then
                turtle.dig()
            end
            turtle.forward()
            while turtle.compareUp() do
                turtle.digUp()
                turtle.up()
            end

            -- replant the trees
            automata.warpToPoint("tree" .. i)
            turtle.select(3)
            turtle.place()

            -- move the items to the chest
            if turtle.getItemCount(4) == 64 then
                automata.warpToPoint("start")
                turtle.turnLeft()
                turtle.turnLeft()
                turtle.select(4)
                turtle.drop(63)
                for i = 6, 16 do
                    turtle.select(i)
                    turtle.drop()
                end
                turtle.turnLeft()
                turtle.turnLeft()
            end

            -- the refilling of empty slots

            if turtle.getItemCount(2) == 0 then
                turtle.select(2)
                automata.warpToPoint("start")
                turtle.turnLeft()
                turtle.suck(64)
                turtle.turnRight()
            end

            if turtle.getItemCount(3) == 0 then
                turtle.select(3)
                automata.warpToPoint("start")
                turtle.turnRight()
                turtle.suck(64)
                turtle.turnLeft()
            end

            if turtle.getFuelLevel() < 100 then
                turtle.select(5)
                automata.warpToPoint("start")
                turtle.suckDown(64)
                turtle.refuel()
            end
        end
    end

else
    print("Please input a number")
end
