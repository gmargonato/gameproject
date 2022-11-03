function onSay(cid, words, param, channel)

	pos = getCreaturePosition(cid)
	doCreateMonster(param, pos)
	doSendMagicEffect(pos, CONST_ME_MAGIC_RED)
	return true

end
