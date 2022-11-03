local config = {
    healFor = 15, -- hp healed
    every = 2, -- every 2 sec
    forHowLong = 1 * 60, -- buff lasts for 1 minutes
    spellId = 29999 -- should be the same for all uturas (rl tibia) unless players will be able to use utura and utura gran at the same time.
}

local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, 0)

local condition = createConditionObject(CONDITION_REGENERATION)
setConditionParam(condition, CONDITION_PARAM_SUBID, config.spellId)
setConditionParam(condition, CONDITION_PARAM_TICKS, config.forHowLong * 1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, config.healFor)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, config.every * 1000)
setConditionParam(condition, CONDITION_PARAM_BUFF, TRUE)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    if hasCondition(cid, CONDITION_REGENERATION, config.spellId) == true then
        doPlayerSendCancel(cid, "This spell is still active.")
        return false
    else
        doCombat(cid, combat, var)
    end
    return true
end