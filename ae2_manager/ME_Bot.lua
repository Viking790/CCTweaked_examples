local monitor = peripheral.wrap("right")
local me = peripheral.wrap("left")

local items = me.listItems()

while true do
    -- store items in a local variable, then update items
    local temp = items
    items = me.listItems()
    -- if items have changed, update the monitor
    if temp ~= items then
        monitor.clear()
        monitor.setCursorPos(1, 1)
        -- sort items by amount
        table.sort(items, function(a, b) return a.amount > b.amount end)
        -- print items
        for k, v in pairs(items) do
            -- move cursor to next line every 3 items. This is a bad way to do it. TODO: get the monitor size, put items in a table, then print them in a loop with the correct spacing and line breaks
            if (k - 1) % 3 == 0 then -- For example : k = 4. 4 - 1 = 3, 3 % 3 = 0, so it will move the cursor to the next line
                monitor.setCursorPos(1, (k / 3) + 1)
            end
            -- NOTE: The CODE formatting is on purpose. Makes it easier to edit the string.sub() functions in a proper text editor
            if v.amount > 1000000000 then
                -- poorly done number formatting. TODO: make it look better. move to a function? idk
                monitor.write(math.floor(v.amount / 1000000000) .. "B: " .. string.sub(v.displayName,1, 15) .. "|" .. "\n")
                -- string.sub() is used to limit the length of the item name. This is specifically for the monitor I'm using, a 8 wide by 6 tall advanced monitor (advanced needed for colors)
            elseif v.amount > 1000000 then
                monitor.write(math.floor(v.amount / 1000000) .. "M: " ..    string.sub(v.displayName,1, 15) .. "|" .. "\n")
            elseif v.amount > 1000 then
                monitor.write(math.floor(v.amount / 1000) .. "K: " ..       string.sub(v.displayName,1, 15) .. "|" .. "\n")
            else
                monitor.write(v.amount .. ": " ..                           string.sub(v.displayName,1, 15) .. "|" .. "\n")
            end
        end
        sleep(3) -- hopefully not lag the server. if it does, sleep for longer.
    end
end
