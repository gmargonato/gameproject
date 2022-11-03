local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, true)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, true)

local area = createCombatArea(AREA_WAVE6, AREADIAGONAL_WAVE6)

function onGetFormulaValues(cid, level, skill, attack, factor)
	local min = (level / 5) + (skill * attack * 0.04) + 11
	local max = (level / 5) + (skill * attack * 0.08) + 21
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
setCombatArea(combat, area)

function onCastSpell(cid, var)
	doDecayItem(doCreateItem(2019, 2, getPlayerPosition(cid)))
	return doCombat(cid, combat, var)
end
