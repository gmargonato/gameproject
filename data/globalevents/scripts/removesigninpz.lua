local function cancelConditions(cid)
	doRemoveCondition(cid, CONDITION_INFIGHT)
	doRemoveCondition(cid, CONDITION_FIRE)
	doRemoveCondition(cid, CONDITION_ENERGY)
	doRemoveCondition(cid, CONDITION_DRUNK)
	doRemoveCondition(cid, CONDITION_PARALYZE)
	doRemoveCondition(cid, CONDITION_CURSED)
	doRemoveCondition(cid, CONDITION_HUNTING)
	doRemoveCondition(cid, CONDITION_BLEEDING)
	doRemoveCondition(cid, CONDITION_POISON)
    return false
end
function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
	    local pos, tile = getThingPos(cid), getTileThingByPos(getThingPos(cid))
		if getTilePzInfo(pos) == true then
		    cancelConditions(cid)
		end
	end
end