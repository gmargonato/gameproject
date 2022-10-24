
local cfg = {
	box = 1990,
	items = { {2160,10} }
}

function onAdvance(cid, skill, oldLevel, newLevel)
	if (getPlayerLevel(cid) > 1) then
		--heal player to full health
		doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
		doCreatureAddMana(cid, getCreatureMaxMana(cid))
	end
	return true
end