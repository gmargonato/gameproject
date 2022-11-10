function onUse(cid, item, fromPosition, itemEx, toPosition)
	local pos = {x= 111, y= 95, z= 7}
	doSummonCreature("Cockroach", pos)
	doSendMagicEffect(pos, 10)
end