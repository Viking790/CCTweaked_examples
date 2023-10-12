--[[ questionBot 1.0.0
    By Andrew for the ModdedMC Network ATM9 server
    This program is designed to answer common questions in chat on the ModdedMC Network ATM9 server.
    This program is designed to be run on a computer with a chat box peripheral.
    BUILT FOR PERSONAL USE! DO NOT SHARE!
    Later versions will have more questions, depending on what I see in chat and approval from staff to use links.
]]--
-- VARIABLES:
-- event, player, message
-- power, storage, flawless (tables of questions)
-- powerResponse, storageResponse, flawlessResponse (tables of responses)
-- powerJSON, storageJSON, flawlessJSON (JSON strings of responses)


-- find the chat box peripheral

local cb = peripheral.find("chatBox")

print("Starting...")
print("Chatbox found: " .. tostring(cb))
print("Question Bot 1.0.0 by Andrew is now running")

-- questions

-- use LUA patterns to match the questions, as they are not always the same (e.g. "what is the best power gen" vs "what is the best power generation")

local power    = "best power.*"

local power2   = "power gen.*"

local power3   = "what gen.*"

local power4   = "which gen.*"

local storage  = "best storage.*"

local storage2 = "what storage.*"

local storage3 = "which storage.*"

local flawless = "certus quartz.*"

local banned   = "banned items.*"

-- function to convert & to § for color codes

function magic(text)
    r, _ = string.gsub(text, "&", "\167") -- uses unicode to convert to § since the Computer won't let you insert it directly
    return r
end

-- responses

local powerRepsonse = {
    text = "Powah mod thermo generators are best for passive power, reactors from Mekanism or Extreme Reactors for later game power",
    color = "gold"
}

local storageResponse = {
    text = "AE2 is the best for overall storage. Use Functional Storage, Occultism or lategame Mekanism for storage of lots of item types.",
    color = "green"
}

local flawlessResponse = {
    text = "Certus quartz generates much the same as amethyst does, except above ground. Flawless budding certus quartz (and worse tiers) can be found in AE2 meteors, and brought home with Blood Magic teleposers. Flawless quartz degrades and becomes worthless if broken, even with silk touch",
    color = "red"
}

local bannedResponse = {
    {
    text = "The banned items list can be found in #atm9-chat's pinned messages. ",
    color = "red",
    underline = true
    }, 
    {
    text = "The link to the Discord can be found by going to spawn and stepping on the pressure plate.",
    color = "blue"
    }
}

-- JSON string conversion
local powerJSON    = textutils.serialiseJSON(powerRepsonse)

local storageJSON  = textutils.serialiseJSON(storageResponse)

local flawlessJSON = textutils.serialiseJSON(flawlessResponse)

local bannedJSON   = textutils.serialiseJSON(bannedResponse)

-- main loop, waits for chat events and checks if the message is in the tables above

while true do

    -- wait for chat event, pulls player and message for use
    local event, player, message = os.pullEvent("chat")

    if string.match(message, power) 
    or string.match(message, power2) 
    or string.match(message, power3) 
    or string.match(message, power4) then
        -- sends the response to the player
        cb.sendFormattedMessageToPlayer(
            powerJSON,
            player,
            magic("&3Question &6Bot"), "  ")
            print("Sent power response to " .. player)
    end -- end if

    if string.match(message, storage) or string.match(message, storage2) or string.match(message, storage3) then
        cb.sendFormattedMessageToPlayer(storageJSON, player, magic("&3Question &6Bot"), "  ")
        print("Sent storage response to " .. player)
    end -- end if

    if string.match(message, flawless) then
        cb.sendFormattedMessageToPlayer(flawlessJSON, player, magic("&3Question &6Bot"), "  ")
        print("Sent flawless response to " .. player)
    end -- end if

    if string.match(message, banned) then
        cb.sendFormattedMessageToPlayer(bannedJSON, player, magic("&3Question &6Bot"), "  ")
        print("Sent banned response to " .. player)
    end -- end if

end -- end main loop
