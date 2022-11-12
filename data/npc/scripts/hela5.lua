local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)       
    selfTurn(EAST)     
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

function oracle(cid, message, keywords, parameters, node)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local cityNode = node:getParent():getParent()
	local vocNode = node:getParent()

	local destination = cityNode:getParameters().destination
	local town = cityNode:getParameters().town
	local vocation = vocNode:getParameters().vocation

	if(destination ~= nil and vocation ~= nil and town ~= nil) then
		if(getPlayerLevel(cid) > parameters.level) then
			npcHandler:say('You are already too experienced!', cid)
			npcHandler:resetNpc()
		else
			if(getPlayerVocation(cid) > 0) then
				npcHandler:say('Sorry, You already have a vocation!')
				npcHandler:resetNpc()
			else
				doPlayerSetVocation(cid, vocation)
				doPlayerSetTown(cid, town)
				doPlayerAddExperience(cid, 100)
				if vocation == 1 then
                	setPlayerStorageValue(cid, 6002, 1)
				elseif vocation == 3 then
					setPlayerStorageValue(cid, 6001, 1)
				else
					setPlayerStorageValue(cid, 6003, 1)
				end
				if getCreatureSpeed(cid) > getCreatureBaseSpeed(cid) then doChangeSpeed(cid, -500) end
				doPlayerSendOutfitWindow(cid)
				npcHandler:resetNpc()

				local tmp = getCreaturePosition(cid)
				doTeleportThing(cid, destination)
				doSendMagicEffect(tmp, CONST_ME_POFF)
				doSendMagicEffect(destination, CONST_ME_TELEPORT)
			end
		end
	end

	return true
end

npcHandler:setMessage(MESSAGE_GREET, 'We meet for the last time, |PLAYERNAME|. \tWell, at least for a {while}.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'You can\'t escape this place, |PLAYERNAME|. I am your only salvation.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'So be it.')

keywordHandler:addKeyword({'while'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Every time you die in battle you will be sent back here, to Helheim. But for now, let\'s focus on your {destiny}'})

local yesNode = KeywordNode:new({'yes'}, oracle, {level = 1})
local noNode = KeywordNode:new({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, moveup = 1, text = 'Then what vocation do you want to become?'})

local node1 = keywordHandler:addKeyword({'destiny'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'In order to continue your journey, you must go back to {midgard}.'})

local node2 = node1:addChildKeyword({'midgard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, town = 3, destination = {x=100, y=100, z=7}, text = 'The realm that humans and mortals dwell.\t What vocation do you wish to become once you get there? {Archer}, {Mage}, or {Barbarian}?'})
local node3 = node2:addChildKeyword({'mage'}, StdModule.say, {npcHandler = npcHandler, vocation = 1, onlyFocus = true, text = 'So, you wish to be a powerful magician? Are you sure about that? This decision is irreversible!'})
    node3:addChildKeywordNode(yesNode)
    node3:addChildKeywordNode(noNode)
    node3 = node2:addChildKeyword({'archer'}, StdModule.say, {npcHandler = npcHandler, vocation = 3, onlyFocus = true, text = 'A ranged marksman. Are you sure? This decision is irreversible!'})
    node3:addChildKeywordNode(yesNode)
    node3:addChildKeywordNode(noNode)
    node3 = node2:addChildKeyword({'barbarian'}, StdModule.say, {npcHandler = npcHandler, vocation = 4, onlyFocus = true, text = 'A mighty warrior. Is that your final decision? This decision is irreversible!'})
    node3:addChildKeywordNode(yesNode)
    node3:addChildKeywordNode(noNode)

keywordHandler:addKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Then come back when you are ready.'})


npcHandler:addModule(FocusModule:new())