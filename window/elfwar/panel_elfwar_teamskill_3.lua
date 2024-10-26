PaGlobal_ElfWarTeamSkillManager = {
  _skillType = nil,
  _skillParam = {},
  _minimapSubPanelList = {},
  _minimapSubPanelOnOffInfo = {},
  _lastSkillUseInfo = {},
  _config = {_effectIconLifeTime = 5}
}
function PaGlobal_ElfWarTeamSkillManager:initialize()
  self._minimapSubPanelList = {}
  self._minimapSubPanelList[1] = Panel_ElfWar_Command
  self._minimapSubPanelList[2] = Panel_ElfWar_MiniMapPartyList
  self._minimapSubPanelList[3] = Panel_ElfWar_Mission
  self._minimapSubPanelList[4] = Panel_ElfWar_MissionWidget
  self._minimapSubPanelList[5] = Panel_ElfWar_MissionAccept
  self._minimapSubPanelList[6] = Panel_ElfWar_Menu
  self._minimapSubPanelList[7] = Panel_ElfWar_EditParty_Drag
  self._minimapSubPanelList[8] = Panel_ElfWar_EditParty
  self._minimapSubPanelList[9] = Panel_ElfWar_ScoreBoard
  self._minimapSubPanelOnOffInfo = {}
  self:initializeSkillUseInfo()
end
function PaGlobal_ElfWarTeamSkillManager:initializeSkillUseInfo()
  self._lastSkillUseInfo = {}
  for _, value in ipairs(PaGlobal_ElfWarSkillList) do
    self._lastSkillUseInfo[value] = {
      _effectLifeTime = 0,
      _usedSkillParam = nil,
      _isActivated = false
    }
    PaGlobalFunc_ElfWarTeamSkill_HideSkillEffect(value)
  end
end
function PaGlobal_ElfWarTeamSkillManager:clear()
  self._skillType = nil
  self._skillParam = {}
  self:revertPanelShowFlag()
  PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  PaGlobalFunc_ElfWarMiniMap_UpdatePreblendSightInfo(0)
  PaGlobalFunc_ElfWarTeamSkill_SetShowPartyList(false)
end
function PaGlobal_ElfWarTeamSkillManager:hideSubPanelList()
  self:revertPanelShowFlag()
  for idx, panel in ipairs(self._minimapSubPanelList) do
    if panel ~= nil then
      self._minimapSubPanelOnOffInfo[idx] = panel:GetShow()
      panel:SetShow(false)
    end
  end
end
function PaGlobal_ElfWarTeamSkillManager:revertPanelShowFlag()
  for idx, flag in ipairs(self._minimapSubPanelOnOffInfo) do
    if self._minimapSubPanelList[idx] ~= nil then
      self._minimapSubPanelList[idx]:SetShow(flag)
    end
  end
  self._minimapSubPanelOnOffInfo = {}
end
function PaGlobal_ElfWarTeamSkillManager:setSkillType(skillType)
  self:clear()
  if skillType ~= nil then
    if ToClient_CheckExistElfWarValidTarget(skillType) == false then
      if skillType == __eElfWarSkillType_Zonya then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SANCTUM_NOSELECT"))
      end
      return
    end
    if ToClient_GetElfWarSkillCooltime(skillType) ~= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_COOLTIME"))
      return
    end
  end
  self._skillType = skillType
  self:hideSubPanelList()
end
function PaGlobal_ElfWarTeamSkillManager:getSkillType()
  return self._skillType
end
function PaGlobal_ElfWarTeamSkillManager:update(deltaTime)
  self:updateAlways(deltaTime)
  self:updateWhenUsingSkill(deltaTime)
end
function PaGlobal_ElfWarTeamSkillManager:updateAlways(deltaTime)
  self:update_skillUseEffect(deltaTime)
end
function PaGlobal_ElfWarTeamSkillManager:updateWhenUsingSkill(deltaTime)
  if self._skillType == nil then
    return
  end
  if self._skillType == __eElfWarSkillType_Scan then
    PaGlobalFunc_ElfWarMiniMap_UpdatePreblendSightInfo(deltaTime)
  elseif self._skillType == __eElfWarSkillType_Recall then
    PaGlobalFunc_ElfWarTeamSkill_ShowPartyList(self._skillParam._fierceBattleKeyRaw)
    PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  elseif self._skillType == __eElfWarSkillType_Bombard then
    PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  elseif self._skillType == __eElfWarSkillType_Summon then
    PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  elseif self._skillType == __eElfWarSkillType_Conceal then
    PaGlobalFunc_ElfWarMiniMap_UpdatePreblendSightInfo(deltaTime)
  elseif self._skillType == __eElfWarSkillType_Zonya then
    PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  elseif self._skillType == __eElfWarSkillType_FixedResurrection then
    PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  end
end
function PaGlobal_ElfWarTeamSkillManager:setSkillParam_Position(position)
  if self._skillType == nil then
    return
  end
  self._skillParam._position = position
end
function PaGlobal_ElfWarTeamSkillManager:setSkillParam_FierceBattleKeyRaw(fierceBattleKeyRaw)
  if self._skillType == nil then
    return
  end
  self._skillParam._fierceBattleKeyRaw = fierceBattleKeyRaw
end
function PaGlobal_ElfWarTeamSkillManager:setSkillParam_PartyDataKey(partyDataKey)
  if self._skillType == nil then
    return
  end
  self._skillParam._partyDataKey = partyDataKey
end
function PaGlobal_ElfWarTeamSkillManager:scan()
  if self._skillParam._position == nil then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:setPosition(self._skillParam._position.x, 0, self._skillParam._position.y)
  skillSystem:setComplete(__eElfWarSkillType_Scan)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Scan)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:recall()
  if self._skillParam._fierceBattleKeyRaw == nil then
    return false
  end
  if self._skillParam._partyDataKey == nil then
    PaGlobalFunc_ElfWarTeamSkill_SetShowPartyList(true)
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:addElemPartyDataKey(self._skillParam._partyDataKey)
  skillSystem:setFierceBattleKey(self._skillParam._fierceBattleKeyRaw)
  skillSystem:setComplete(__eElfWarSkillType_Recall)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Recall)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:bombard()
  if self._skillParam._fierceBattleKeyRaw == nil then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:setFierceBattleKey(self._skillParam._fierceBattleKeyRaw)
  skillSystem:setComplete(__eElfWarSkillType_Bombard)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Bombard)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:summon()
  if self._skillParam._fierceBattleKeyRaw == nil then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:setFierceBattleKey(self._skillParam._fierceBattleKeyRaw)
  skillSystem:setComplete(__eElfWarSkillType_Summon)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Summon)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:conceal()
  if self._skillParam._position == nil then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:setPosition(self._skillParam._position.x, 0, self._skillParam._position.y)
  skillSystem:setComplete(__eElfWarSkillType_Conceal)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Conceal)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:zonya()
  if self._skillParam._fierceBattleKeyRaw == nil then
    return false
  end
  if ToClient_IsFierceBattleObjectAlly(self._skillParam._fierceBattleKeyRaw) == false then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  skillSystem:setFierceBattleKey(self._skillParam._fierceBattleKeyRaw)
  skillSystem:setComplete(__eElfWarSkillType_Zonya)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_Zonya)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:fixedResurrection()
  if self._skillParam._fierceBattleKeyRaw == nil then
    return false
  end
  local skillSystem = ToClient_GetElfWarTeamSkillArguments()
  if skillSystem == nil then
    return false
  end
  if self._skillParam._fierceBattleKeyRaw == 1 or self._skillParam._fierceBattleKeyRaw == 11 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return false
  end
  skillSystem:setFierceBattleKey(self._skillParam._fierceBattleKeyRaw)
  skillSystem:setComplete(__eElfWarSkillType_FixedResurrection)
  ToClient_RequestUseElfWarTeamSkill(__eElfWarSkillType_FixedResurrection)
  return true
end
function PaGlobal_ElfWarTeamSkillManager:useSkill(skillType)
  if self._skillType == nil or self._skillType ~= skillType then
    return
  end
  local useResult = false
  if self._skillType == __eElfWarSkillType_Scan then
    useResult = self:scan()
  elseif self._skillType == __eElfWarSkillType_Recall then
    useResult = self:recall()
  elseif self._skillType == __eElfWarSkillType_Bombard then
    useResult = self:bombard()
  elseif self._skillType == __eElfWarSkillType_Summon then
    useResult = self:summon()
  elseif self._skillType == __eElfWarSkillType_Conceal then
    useResult = self:conceal()
  elseif self._skillType == __eElfWarSkillType_Zonya then
    useResult = self:zonya()
  elseif self._skillType == __eElfWarSkillType_FixedResurrection then
    useResult = self:fixedResurrection()
  end
  if useResult == true then
    self:useSkill_postProcess(skillType)
  end
end
function PaGlobal_ElfWarTeamSkillManager:useSkill_postProcess(skillType)
  self._lastSkillUseInfo[skillType]._usedSkillParam = self._skillParam
  self._lastSkillUseInfo[skillType]._effectLifeTime = 0
  self._lastSkillUseInfo[skillType]._isActivated = false
  self:clear()
end
function PaGlobal_ElfWarTeamSkillManager:update_skillUseEffect(deltaTime)
  for _, value in ipairs(PaGlobal_ElfWarSkillList) do
    if self._lastSkillUseInfo[value]._effectLifeTime > 0 then
      self._lastSkillUseInfo[value]._effectLifeTime = self._lastSkillUseInfo[value]._effectLifeTime - deltaTime
      if self._lastSkillUseInfo[value]._effectLifeTime <= 0 then
        self._lastSkillUseInfo[value]._effectLifeTime = 0
      else
        self:showSkillEffect(value)
      end
    else
      PaGlobalFunc_ElfWarTeamSkill_HideSkillEffect(value)
    end
  end
end
function PaGlobal_ElfWarTeamSkillManager:showSkillEffect(skillType)
  if skillType == nil then
    return
  end
  local effectInfo = self._lastSkillUseInfo[skillType]
  if effectInfo == nil or effectInfo._usedSkillParam == nil then
    return
  end
  local skillUseInfo = {}
  if skillType == __eElfWarSkillType_Scan then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_ConvertWorldMapPosToMinimapBGRate(effectInfo._usedSkillParam._position)
  elseif skillType == __eElfWarSkillType_Recall then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(effectInfo._usedSkillParam._fierceBattleKeyRaw)
  elseif skillType == __eElfWarSkillType_Bombard then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(effectInfo._usedSkillParam._fierceBattleKeyRaw)
  elseif skillType == __eElfWarSkillType_Summon then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(effectInfo._usedSkillParam._fierceBattleKeyRaw)
  elseif skillType == __eElfWarSkillType_Conceal then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_ConvertWorldMapPosToMinimapBGRate(effectInfo._usedSkillParam._position)
  elseif skillType == __eElfWarSkillType_Zonya then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(effectInfo._usedSkillParam._fierceBattleKeyRaw)
  elseif skillType == __eElfWarSkillType_FixedResurrection then
    skillUseInfo.castPos = PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(effectInfo._usedSkillParam._fierceBattleKeyRaw)
  end
  if self._lastSkillUseInfo[skillType]._isActivated == true then
    self._lastSkillUseInfo[skillType]._isActivated = false
    if skillType == __eElfWarSkillType_Scan then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01A"
    elseif skillType == __eElfWarSkillType_Recall then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01B"
    elseif skillType == __eElfWarSkillType_Bombard then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01D"
    elseif skillType == __eElfWarSkillType_Summon then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01C"
    elseif skillType == __eElfWarSkillType_Conceal then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01F"
    elseif skillType == __eElfWarSkillType_Zonya then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01E"
    elseif skillType == __eElfWarSkillType_FixedResurrection then
      skillUseInfo.effectName = "fUI_RoseWar_Skill_01G"
    end
    audioPostEvent_SystemUi(35, 10)
    _AudioPostEvent_SystemUiForXBOX(35, 10)
  end
  PaGlobalFunc_ElfWarTeamSkill_ShowSkillEffect(skillType, skillUseInfo)
end
function PaGlobal_ElfWarTeamSkillManager:activatedSkillEffect(skillType, isSucceed)
  if skillType == nil or isSucceed == nil then
    return
  end
  if isSucceed == true then
    if skillType == __eElfWarSkillType_FixedResurrection then
      PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
    end
    self._lastSkillUseInfo[skillType]._effectLifeTime = self._config._effectIconLifeTime
    self._lastSkillUseInfo[skillType]._isActivated = true
  end
end
