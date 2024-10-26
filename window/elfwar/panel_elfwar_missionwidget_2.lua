function PaGlobalFunc_ElfWarMissionWidget_Open()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ElfWarMissionWidget_Close()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarMissionWidget_IsShow()
  local panel = Panel_ElfWar_MissionWidget
  if panel == nil then
    return false
  end
  return Panel_ElfWar_MissionWidget:GetShow()
end
function PaGlobalFunc_ElfWarMissionWidget_Update(deltaTime)
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  self:updateResultTimer(deltaTime)
  self:updateTimer(deltaTime)
end
function FromClient_ElfWarMissionWidget_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil or state == nil then
    return
  end
  if state == __eElfWar_Start then
    if ToClient_IsElfWarObserveMode() == true then
      return
    end
    if ToClient_IsParticipateInElfWar() == false then
      return
    end
    self:hideQuestWidget(true)
    PaGlobalFunc_ElfWarScoreBoardWidget_Open()
    if IsSelfPlayerElfWarGrade_MercenaryPartyLeader() == true or IsSelfPlayerElfWarGrade_Mercenary() == true then
      PaGlobalFunc_ElfWarMissionWidget_Open()
    end
  else
    PaGlobalFunc_ElfWarScoreBoardWidget_Close()
    PaGlobalFunc_ElfWarMissionWidget_Close()
  end
end
function FromClient_ElfWarMissionWidget_CreateMission(missionKey)
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMissionWidget_IsShow() == false then
    if ToClient_IsParticipateInElfWar() == false then
      return
    end
    PaGlobalFunc_ElfWarScoreBoardWidget_Open()
    if IsSelfPlayerElfWarGrade_MercenaryPartyLeader() == true or IsSelfPlayerElfWarGrade_Mercenary() == true then
      PaGlobalFunc_ElfWarMissionWidget_Open()
    end
  end
  self:setProgressMission(missionKey)
end
function FromClient_ElfWarMissionWidget_CompleteMission()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMissionWidget_IsShow() == false then
    return
  end
  self:showResult(self._eResultType.COMPLTE)
  self:missionComplete()
end
function FromClient_ElfWarMissionWidget_FailedMission()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMissionWidget_IsShow() == false then
    return
  end
  self:showResult(self._eResultType.FAIL)
  self:missionFail()
end
function FromClient_ElfWarMissionWidget_UpdateMissionCondition()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMissionWidget_IsShow() == false then
    return
  end
  self:updateCondition()
end
function FromClient_ElfWarMissionWidget_UpdateSelfPlayerElfWarState()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarMissionWidget_IsShow() == true then
    return
  end
  if ToClient_IsParticipateInElfWar() == true then
    FromClient_ElfWarMissionWidget_ChangeElfWarState(ToClient_GetElfWarState())
    FromClient_ElfWarMissionWidget_CreateMission(ToClient_GetCurrentProgressElfWarMissionKey())
  end
end
function FromClient_ElfWarMissionWidget_OnScreenResize()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  self:onScreenResize()
end
function HandleEventLUp_ElfWarMissionWidget_FindNavi()
  local self = PaGlobal_ElfWarMissionWidget
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local missionDataWrapper = ToClient_GetElfWarMissionDataWrapper(self._currentProgressMissionKey)
  if missionDataWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  local missionType = missionDataWrapper:getMissionType()
  if missionType == __eElfWarMissionType_FierceAttack or missionType == __eElfWarMissionType_FierceDefence or missionType == __eElfWarMissionType_GimmikAttack then
    local fierceBattleKeyRaw = missionDataWrapper:getTargetFierceBattleKeyRaw()
    local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
    if fierceBattleObjectInfoWrapper == nil then
      return
    end
    ElfWarMiniMap_SetNavigationWithoutFromUserNo(fierceBattleObjectInfoWrapper:getPosition(), true)
  elseif missionType == __eElfWarMissionType_CastleAttack then
    local enemyTeamNo
    if selfPlayerTeamNo == __eElfWarTeam_Kamasylvia then
      enemyTeamNo = __eElfWarTeam_Odyllita
    elseif selfPlayerTeamNo == __eElfWarTeam_Odyllita then
      enemyTeamNo = __eElfWarTeam_Kamasylvia
    end
    if enemyTeamNo == nil then
      return
    end
    local enemyBossInfo = ToClient_GetElfWarBossInfoXXX(enemyTeamNo)
    if enemyBossInfo == nil then
      return
    end
    ElfWarMiniMap_SetNavigationWithoutFromUserNo(enemyBossInfo._position, true)
  elseif missionType == __eElfWarMissionType_CastleDefence then
    local bossInfo = ToClient_GetElfWarBossInfoXXX(selfPlayerTeamNo)
    if bossInfo == nil then
      return
    end
    ElfWarMiniMap_SetNavigationWithoutFromUserNo(bossInfo._position, true)
  end
end
