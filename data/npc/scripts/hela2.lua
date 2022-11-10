local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)       
    selfTurn(NORTH)     
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

npcHandler:setMessage(MESSAGE_GREET, 'So you don\'t remember much of your past life, heh? Well, let me guide you then. \nIn this tower you are going to learn more about the {Archer} vocation.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'We will meet again.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'I will see you soon, |PLAYERNAME|.')

keywordHandler:addKeyword({'archer'},   StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'They are known for keeping their distance when fighting, using different ranged weapons. \tArchers can eventually be promoted by Odin and become {Hunters}.'})
keywordHandler:addKeyword({'hunter'},   StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Hunters are highly skilled Archers, and the only vocation capable of casting {holy} spells.'})
keywordHandler:addKeyword({'holy'},     StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'A sacred element used by Hunters. It deals heavy damage against unholy creatures, like Demons.'})

npcHandler:addModule(FocusModule:new())