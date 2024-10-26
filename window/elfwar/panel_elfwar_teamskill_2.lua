function PaGlobalFunc_ElfWarTeamSkill_Open(openInfo)
  PaGlobalFunc_ElfWarTeamSkillManager_Clear()
  PaGlobal_ElfWarTeamSkill:prepareOpen(openInfo)
end
function PaGlobalFunc_ElfWarTeamSkill_Close()
  PaGlobalFunc_ElfWarTeamSkillManager_Clear()
  PaGlobal_ElfWarTeamSkill:prepareClose()
end
function PaGlobalFunc_ElfWarTeamSkill_Update(deltaTime)
  PaGlobal_ElfWarTeamSkill:update(deltaTime)
end
function PaGlobalFunc_ElfWarTeamSkill_SetShowPartyList(flag)
  if flag == true then
    PaGlobal_ElfWarTeamSkill:prepareOpenPartyList()
  else
    PaGlobal_ElfWarTeamSkill:closePartyList()
  end
end
function PaGlobalFunc_ElfWarTeamSkill_ShowPartyList(fierceBattleKeyRaw)
  PaGlobal_ElfWarTeamSkill:showPartyList(fierceBattleKeyRaw)
end
function PaGlobalFunc_ElfWarTeamSkill_ShowSkillEffect(skillType, skillUseInfo)
  PaGlobal_ElfWarTeamSkill:showSkillEffect(skillType, skillUseInfo)
end
function PaGlobalFunc_ElfWarTeamSkill_HideSkillEffect(skillType)
  PaGlobal_ElfWarTeamSkill:hideSkillEffect(skillType)
end
function HandleEventLUp_ElfWarTeamSkill_SelectSkillType(skillType)
  PaGlobalFunc_ElfWarTeamSkillManager_SelectSkillType(skillType)
end
function HandleEventLUp_ElfWarTeamSkill_UnSelectSkillType(skillType)
  PaGlobalFunc_ElfWarTeamSkillManager_UnSelectSkillType(skillType)
end
function InputEventMOn_ElfWarTeamSkill_HideSkillTooltip()
  PaGlobal_ElfWarTeamSkill:hideTooltip()
end
function InputEventMOn_ElfWarTeamSkill_ShowSkillTooltip(skillType)
  PaGlobal_ElfWarTeamSkill:showTooltip(skillType)
end
function FromClient_PaGlobal_ElfWarTeamSkill_OnScreenResize()
  PaGlobal_ElfWarTeamSkill:resize()
end
function FromClient_ResponseElfWarUseSkillAck(skillType, isSucceed)
  PaGlobalFunc_ElfWarTeamSkillManager_UseSkillAck(skillType, isSucceed)
end
