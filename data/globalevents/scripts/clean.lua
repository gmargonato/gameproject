function executeClean()
	doCleanMap()
	doBroadcastMessage("Map cleaned, next clean in 2 hours.")
	return true
end

function onThink(interval)
	doBroadcastMessage("Map cleaning within 30 seconds, please pick up your items!")
	addEvent(executeClean, 30000)
	return true
end
