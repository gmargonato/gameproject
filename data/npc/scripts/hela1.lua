local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)       
    selfTurn(SOUTH)     
    npcHandler:onCreatureAppear(cid)            
end

function onCreatureDisappear(cid)        
    npcHandler:onCreatureDisappear(cid)            
end

function onCreatureSay(cid, type, msg)        
    npcHandler:onCreatureSay(cid, type, msg)        
end

function onThink()        
    npcHandler:onThink()        
end

npcHandler:setMessage(MESSAGE_GREET, 'I see you managed your way out of the void, |PLAYERNAME|. You are now in Helheim. \nIf you don\'t remember much of your past life, just keep crossing the bridge. Otherwise, you can ask me to {skip} it.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'We will meet again.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'You can\'t run away from your destiny, |PLAYERNAME|.')

local travelNode = keywordHandler:addKeyword({'skip'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Are you sure you want to skip the tutorial?'})
    travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 1, cost = 0, destination = {x=119, y=18, z=5}, text = 'So be it.', reset = true})
    travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Then your journey awaits for you ahead.'})

npcHandler:addModule(FocusModule:new())