function onUse(cid, item, fromPosition, itemEx, toPosition)
	if((isInArray(JUNGLE_GRASS, itemEx.itemid)) or (getPlayerAccess(cid) >= 3)) then
		doTransformItem(itemEx.uid, itemEx.itemid - 1)
		doDecayItem(itemEx.uid)
		return true
	end

	if((isInArray(SPIDER_WEB, itemEx.itemid)) or (getPlayerAccess(cid) >= 3)) then
		doTransformItem(itemEx.uid, (itemEx.itemid + 6))
		doDecayItem(itemEx.uid)
		return true
	end

	if((isInArray(WILD_GROWTH, itemEx.itemid)) or (getPlayerAccess(cid) >= 3)) then
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		doRemoveItem(itemEx.uid)
		return true
	end

	return destroyItem(cid, itemEx, toPosition)
end
