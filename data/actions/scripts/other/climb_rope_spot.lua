function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(getPlayerAccess(cid) >= 3) then
		return doTeleportThing(cid, { x = toPosition.x, y = toPosition.y+1, z = toPosition.z-1 }, false)
	else
		doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
	end
end