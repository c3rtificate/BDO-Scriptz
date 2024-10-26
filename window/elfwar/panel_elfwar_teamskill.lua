PaGlobal_ElfWarSkillList = {
  __eElfWarSkillType_Scan,
  __eElfWarSkillType_Recall,
  __eElfWarSkillType_Bombard,
  __eElfWarSkillType_Summon,
  __eElfWarSkillType_Conceal,
  __eElfWarSkillType_Zonya,
  __eElfWarSkillType_FixedResurrection
}
PaGlobal_ElfWarTeamSkill = {
  _ui = {
    _stc_bg = nil,
    _stc_skillList = nil,
    _stc_lineDeco = nil
  },
  _skillSlotConfig = {
    createIcon = true,
    createEffect = false,
    createFG = false,
    createFGDisabled = false,
    createLevel = false,
    createLearnButton = false,
    createCooltime = true,
    createCooltimeText = true
  },
  _initialize = false,
  _isMakeSkillButton = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamSkill_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamSkill_2.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamSkill_3.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamSkill_4.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarTeamSkillInit")
function FromClient_ElfWarTeamSkillInit()
  PaGlobal_ElfWarTeamSkill:initialize()
end
