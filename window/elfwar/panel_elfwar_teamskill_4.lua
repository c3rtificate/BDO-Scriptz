function PaGlobalFunc_ElfWarTeamSkillManager_Clear()
  PaGlobal_ElfWarTeamSkillManager:clear()
end
function PaGlobalFunc_ElfWarTeamSkillManager_SelectSkillType(skillType)
  PaGlobal_ElfWarTeamSkillManager:setSkillType(skillType)
end
function PaGlobalFunc_ElfWarTeamSkillManager_UnSelectSkillType(skillType)
  local self = PaGlobal_ElfWarTeamSkillManager
  if self._skillType == skillType then
    PaGlobal_ElfWarTeamSkillManager:setSkillType(nil)
  end
end
function PaGlobalFunc_ElfWarTeamSkillManager_GetSelectedSkillType()
  return PaGlobal_ElfWarTeamSkillManager:getSkillType()
end
function PaGlobalFunc_ElfWarTeamSkillManager_isUsingSkill()
  return PaGlobal_ElfWarTeamSkillManager:getSkillType() ~= nil
end
function PaGlobalFunc_ElfWarTeamSkillManager_Update(deltaTime)
  PaGlobal_ElfWarTeamSkillManager:update(deltaTime)
end
function PaGlobalFunc_ElfWarTeamSkillManager_UpdatePosition(position)
  PaGlobal_ElfWarTeamSkillManager:setSkillParam_Position(position)
end
function PaGlobalFunc_ElfWarTeamSkillManager_UpdateFierceBattleKey(fierceBattleKeyRaw)
  PaGlobal_ElfWarTeamSkillManager:setSkillParam_FierceBattleKeyRaw(fierceBattleKeyRaw)
end
function PaGlobalFunc_ElfWarTeamSkillManager_UpdatePartyDataKey(partyDataKey)
  PaGlobal_ElfWarTeamSkillManager:setSkillParam_PartyDataKey(partyDataKey)
end
function PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(skillType)
  PaGlobal_ElfWarTeamSkillManager:useSkill(skillType)
end
function PaGlobalFunc_ElfWarTeamSkillManager_Initialize()
  PaGlobal_ElfWarTeamSkillManager:initialize()
end
function PaGlobalFunc_ElfWarTeamSkillManager_UseSkillAck(skillType, isSucceed)
  PaGlobal_ElfWarTeamSkillManager:activatedSkillEffect(skillType, isSucceed)
end
