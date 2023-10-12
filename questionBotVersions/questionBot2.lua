--[[ Question Bot v1.0.5 By Andrew Hansen/Viking
    Built for personal use on the ModdedMC Network/Education use everywhere else. 
        Use, and possible punishment for abuse, are up to the discretions of individual servers, and there's no guarantee this bot is allowed at all on your particular server.
    Designed to answer a variety of modpack/server related questions users ask in chat.
    Runs on an Advanced Computer with an Advanced Monitor and Chatbox attached.
    
    This version adds more questions, updates pattern matching requirements, and changes code formatting style
]]--

-- Declaration of VARIABLES:

local version = "1.0.5"

local cb = peripheral.wrap("chatBox") -- Find the Chatbox and connect it to the computer

-- Fake loading messages
print("Starting... ") 
sleep(1)
print("Initializing... ")
sleep(1)
print("Question Bot version is " .. version .. "!") -- Real version message
print("Use at your own discretion. Abusing the bot to mute evade/spam/etc. will probably get you banned")

--[[
    INFO:
    Question section
    LUA pattern matching, some abstraction, divine intervention. Used multiple "LUA pattern tester" sites to check the patterns.
    Some of them work the way the documentation says, some confuse me to no end but work, others only God understands. Sorry. - October 11th 2023
]]--

local powerArr = {"best power.*", "power gen.*", "what gen.*", "which gen.*"}

local storageArr = {"best storage.*", "what storage.*", "which storage.*"}

local flawlessArr = {"where is certus quartz.*", "flawless certus quartz."}

local banned = "banned items.*"

-- responses

local powerRes =    {
    text = "Get to 3 thermo generators from Powah as soon as possible. They are the best early power gen in the pack. Then, go for either Mekanism or Extreme Reactors",
    color = ""
}
local storageRes =  {
    text = "Use AE2! Can automate almost everything with it as well. If you need to store a lot of one item type, use Functional Storage or Occultism. Lots of unstackable items (ie apoth gear/enchanted) should be processed immediately, or stored in an Armory Cabinet",
    color = ""
}
local flawlessRes = {
    text = "",
    color = ""
}
local bannedRes =   {
    text = "",
    color = ""
}

-- JSONification

local powerJSON    = textutils.serializeJSON(powerRes)
local storageJSON  = textutils.serializeJSON(storageRes)
local flawlessJSON = textutils.serializeJSON(flawlessRes)
local bannedJSON   = textutils.serializeJSON(bannedRes)

-- Function declarations

function colorMagic(text)
    r, _ = string.gsub(text, "&", "\167")
    return r
end