function onUse(cid, item, fromPosition, itemEx, toPosition)
	local pos = {x= 106, y= 112, z= 7}
	doSummonCreature("Cockroach", pos)
	doSendMagicEffect(pos, 10)
end