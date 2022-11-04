
-- damage types
--[[
	COMBAT_NONE = 0
	COMBAT_PHYSICALDAMAGE = 1
	COMBAT_ENERGYDAMAGE = 2
	COMBAT_EARTHDAMAGE = 4
	COMBAT_FIREDAMAGE = 8
	COMBAT_ICEDAMAGE = 512
	COMBAT_HOLYDAMAGE = 1024
	COMBAT_DEATHDAMAGE = 2048
--]]	

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, 1)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, true)
setCombatArea(combat, createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(cid, level, skill, attack, element, factor)
	local skillTotal, levelTotal = skill + attack, level / 5
	return -(skillTotal * 0.5 + levelTotal), -(skillTotal * 1.5 + levelTotal)
end
setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")


function getWeaponElement(cid)

	item = getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid
	left_hand_type = getItemInfo(item).abilities.elementType
	return left_hand_type

end


function onCastSpell(cid, var)
	--doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "elementType: " .. getWeaponElement(cid))
	doDecayItem(doCreateItem(2019, 2, getPlayerPosition(cid)))
	doCombat(cid, combat, var)
end
