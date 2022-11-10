
local cfg = {
	box = 1990,
	items = { {2160,10} }
}

function onAdvance(cid, skill, oldLevel, newLevel)
	if skill == SKILL_LEVEL then
		doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
		doCreatureAddMana(cid, getCreatureMaxMana(cid))
	end
	return true
end