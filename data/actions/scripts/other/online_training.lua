
---@ Create by Sarah Wesker | Tested Version: TFS 0.4
---@ list of training dummies.
local dummies = {
    [5777] = { skillRate = 1, skillSpeed = 1 },
    [5787] = { skillRate = 1, skillSpeed = 1 }
}

---@ Global training parameters of the system.
local staminaTries = 1 --# on minutes
local skillTries = 7 --# tries by blow
local skillSpent = function() return math.random(425, 575) end --# mana consumed by blow
local slotForUse = CONST_SLOT_AMMO

---@ list of weapons to train.
local weapons = {
	-- sword
	[12560] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_SWORD },

	-- axe
    	[12563] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_AXE },

	-- club
    	[12561] = { shootEffect = CONST_ME_HITAREA, skillType = SKILL_CLUB },

	-- distance
    	[12562] = { shootEffect = CONST_ME_HITAREA, shootDistEffect = CONST_ANI_SIMPLEARROW, skillType = SKILL_DISTANCE },

	-- magic
    	--[12559] = { shootEffect = CONST_ME_HITAREA, shootDistEffect = CONST_ANI_CAKE, skillType = SKILL_MAGLEVEL }

}

---@ EDTE is the global event table to control the system correctly.
if not EDTE then EDTE = {} end

---@ functions to assign or obtain the training status of a player.
function getPlayerExerciseTrain(cid) return EDTE[cid] or false end
function setPlayerExerciseTrain(cid, status) EDTE[cid] = status return status end

---@ local training function.
local function exerciseDummyTrainEvent(params, weapon)
    if isPlayer(params.cid) then
        --local item = getPlayerItemById(params.cid, true, params.itemid)
	local item = getPlayerSlotItem(params.cid, slotForUse)
        local playerPosition = getCreaturePosition(params.cid)
        if getDistanceBetween(playerPosition, params.currentPos) == 0 then
            local weaponCharges = getItemAttribute(item.uid, "charges") or getItemInfo(params.itemid).charges
            local reloadMs = getVocationInfo(getPlayerVocation(params.cid)).attackSpeed * params.dummy.skillSpeed
            if weaponCharges >= 1 then
                doItemSetAttribute(item.uid, "charges", weaponCharges -1)
                if weapon.shootDistEffect then doSendDistanceShoot(playerPosition, params.dummyPos, weapon.shootDistEffect) end
                if weapon.shootEffect then doSendMagicEffect(params.dummyPos, weapon.shootEffect) end
                if weapon.skillType == SKILL_MAGLEVEL then
                    --addManaSpent(params.cid, (skillSpent() * params.dummy.skillRate) * getConfigValue("rateMagic"))
			addManaSpent((skillSpent() * params.dummy.skillRate) * getConfigValue("rateMagic"))
                else
                    doPlayerAddSkillTry(params.cid, weapon.skillType, (skillTries * params.dummy.skillRate) * getConfigValue("rateSkill"))
                end
                local currentStamina = getPlayerStamina(params.cid)
                doPlayerSetStamina(params.cid, currentStamina + staminaTries)
                if weaponCharges <= 1 then
                    exerciseDummyTrainEvent(params, weapon)
                else
                    setPlayerExerciseTrain(params.cid, addEvent(exerciseDummyTrainEvent, reloadMs, params, weapon))
                end
                return true
            else
                doRemoveItem(item.uid)
                doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "Your exercise weapon has expired.")
            end
        else
            doPlayerSendTextMessage(params.cid, MESSAGE_EVENT_ADVANCE, "You have canceled the training.")
        end
    end
    return setPlayerExerciseTrain(params.cid, nil)
end

function onUse(cid, item, fromPos, target, toPos, isHotkey)
    local ammo = getPlayerSlotItem(cid, slotForUse)
    if ammo.uid ~= item.uid then
        return doPlayerSendCancel(cid, "The weapon must be located in your slot ammunition.")
    end
    if not target then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
    end
    local playerPosition = getCreaturePosition(cid)
    if not getTileInfo(playerPosition).protection then
        return doPlayerSendCancel(cid, "You can only train in protection zone.")
    end
    local dummy = dummies[target.itemid]
    local weapon = weapons[item.itemid]
    if not weapon or not dummy then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_CANNOTUSETHISOBJECT)
    end
    local dummyPosition = getThingPosition(target.uid)
    if getDistanceBetween(playerPosition, dummyPosition) > 1 then
        return doPlayerSendDefaultCancel(cid, RETURNVALUE_THEREISNOWAY)
    end
    if not getPlayerExerciseTrain(cid) then
        local params = {}
        params.cid = cid
        params.currentPos = playerPosition
        params.dummyPos = dummyPosition
        params.itemid = item.itemid
        params.dummy = dummy
        exerciseDummyTrainEvent(params, weapon)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You have started training.")
    else
        doPlayerSendCancel(cid, "You can not train.")
    end
    return true
end