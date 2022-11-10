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

npcHandler:setMessage(MESSAGE_GREET, 'Hello, |PLAYERNAME|. Here you will learn more about the {Mage} vocation.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'We will meet again.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'I will see you soon, |PLAYERNAME|.')

keywordHandler:addKeyword({'mage'},     StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Mages are powerful spell casters and have mastered the usage of nature\'s elements. Hence, they are heavily dependent on {mana} to cast their magic and use {wands}. \tEventually, Mages can ask Odin for a promotion to become {Wizards}.'})
keywordHandler:addKeyword({'wizard'},   StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Wizards are beings capable of harvesting the full power of all elements.'})
keywordHandler:addKeyword({'mana'},     StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'It is the source of your power. You can not be hungry in order to regenerate passively mana points - so always carry food with you.'})
keywordHandler:addKeyword({'wands'},    StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The main weapon for mages.'})

npcHandler:addModule(FocusModule:new())