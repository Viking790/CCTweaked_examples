--[[
    Viking's 'Advanced' Lumber Turtle Bot for ComputerCraft
    Version: 1.0.0
    Description: This program is designed to be used with a regular turtle which you supply with a stack of dirt, a stack of birch saplings, a stack of coal, and a log that matches the sapling type. It will then proceed to chop down trees and replant them
    until it runs out of coal. It will then return to its starting position and drop off the wood and saplings in a designated chest, and refuel.
]] --

-- Clear the shell and prompt the user to input necessary items, and then select a number of saplings.
shell.run("clear")
print("Starting...")
print("Please make sure I have enough space to work (15 by 15 blocks, and am facing the direction I should be working in. I will return to this position when I am done working.")
print("Put at least 9 dirt in my first inventory slot, at least 9 saplings in my second, 64 coal in my third, and 1 log in my 4th inventory slot!")
sleep(10)
Numsaplings = 9
local dirt, saplings, coal, log = 1, 2, 3, 4

-- Position the turtle
turtle.up()
turtle.forward()

-- Initial planting

for i = 1, (Numsaplings / 3) do
    for g = 1, 3 do
        turtle.select(dirt)
        turtle.placeDown()
        turtle.select(saplings)
        turtle.up()
        turtle.placeDown()
        turtle.select(coal)
        turtle.refuel()
        for f = 1, 3 do
            turtle.forward()
        end
        turtle.down()
    end
    turtle.turnRight()
    for f = 1, 3 do
        turtle.forward()
    end
    turtle.turnLeft()
    for f = 1, 9 do
        turtle.back()
    end
end

-- Move to chopping starting spot

turtle.back()
turtle.turnLeft()
for f = 1, 8 do
    turtle.forward()
end
turtle.turnRight()
turtle.forward()

-- Main loop for chopping down trees

while true do 
    sleep(30)
    for g = 1, 3 do
        for i = 1, 3 do 
            turtle.turnLeft()
            turtle.select(log)
            if turtle.compare() then
                turtle.dig()
                turtle.forward()
                -- detect wood above
                while turtle.detectUp() do
                    turtle.digUp()
                    turtle.up()
                end
                -- go down
                while not turtle.detectDown() do
                    turtle.down()
                end
                -- replace sapling
                turtle.select(saplings)
                turtle.back()
                turtle.place()
                turtle.turnRight()
                for f = 1, 3 do
                    turtle.forward()
                end
            end
        end
        turtle.turnRight()
        for f = 1, 3 do
            turtle.forward()
        end
        turtle.turnLeft()
        for f = 1, 9 do
            turtle.back()
        end
    end
    turtle.turnRight()
    turtle.forward()
end