function onSay(cid, words, param, channel)

	pos = getCreaturePosition(cid)
	doCreateNpc(param, pos)
	doSendMagicEffect(pos, CONST_ME_MAGIC_RED)
	return true

end
