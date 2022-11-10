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

npcHandler:setMessage(MESSAGE_GREET, 'Greetings, |PLAYERNAME|! Your last chance to remind yourself of your previous life. Perhaps you were a {Barbarian}?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'We will meet again.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'I will see you soon, |PLAYERNAME|.')

keywordHandler:addKeyword({'barbarian'},    StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Barbarians are natural born fighters. \tUsing a variety of melee weapons, they don\'t have any mana to spent, and must sacrifice health in order to deal damage to their enemies.'})
keywordHandler:addKeyword({'promotion'},    StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'If barbarians live long enough, they might ask Odin for a promotion and become {Berserkers}.'})

npcHandler:addModule(FocusModule:new())