function PaGlobalFunc_Solrare_PlayerStatus_Open()
  PaGlobal_Solrare_PlayerStatus:prepareOpen()
end
function PaGlobalFunc_Solrare_PlayerStatus_Close()
  PaGlobal_Solrare_PlayerStatus:prepareClose()
end
function HandleEventLUp_Arsha_Party_All_Close()
  PaGlobalFunc_Solrare_PlayerStatus_Close()
end
function PaGlobalFunc_Solrare_PlayerStatus_CameraControl(teamNo)
  ToClient_ForceChangeScreenModeActor(toInt64(0, teamNo))
end
function PaGlobalFunc_Solrare_PlayerStatus_Create()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  PaGlobalFunc_Solrare_PlayerStatus_Resize()
  local isReplay = ToClient_IsPlayingReplay()
  if true == isReplay then
    return
  end
  local roundType = ToClient_GetSolareRoundType()
  if __eSolare3vs3GameMode_Team == roundType then
    PaGlobal_Solrare_PlayerStatus:createTeamUi_Round()
  elseif __eSolare3vs3GameMode_Leader == roundType then
  elseif __eSolare3vs3GameMode_Relay == roundType then
  end
end
function PaGlobalFunc_Solrare_PlayerStatus_Setting(userInfo, userInfoIndex)
  local roundType = ToClient_GetSolareRoundType()
  if __eSolare3vs3GameMode_Team == roundType then
    PaGlobal_Solrare_PlayerStatus:setting_Round(userInfo, userInfoIndex)
  elseif __eSolare3vs3GameMode_Leader == roundType then
  elseif __eSolare3vs3GameMode_Relay == roundType then
  end
end
function PaGlobalFunc_Solrare_PlayerStatus_Resize()
  PaGlobal_Solrare_PlayerStatus:resize()
end
function FromClient_Solrare_PlayerStatus_DeadHP(killPlayer, deadPlayer)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  local self = PaGlobal_Solrare_PlayerStatus
  local userSlot
  local isRedTeam = false
  local targetActorKey = -1
  for idx = 1, #self._redTeamUserInfo do
    if tostring(deadPlayer) == self._redTeamUserInfo[idx]._userInfo:getName() then
      isRedTeam = true
      targetActorKey = self._redTeamUserInfo[idx]._userInfo:getActorKeyRaw()
      break
    end
  end
  if -1 == targetActorKey then
    for idx = 1, #self._blueTeamUserInfo do
      if tostring(deadPlayer) == self._blueTeamUserInfo[idx]._userInfo:getName() then
        targetActorKey = self._blueTeamUserInfo[idx]._userInfo:getActorKeyRaw()
        break
      end
    end
  end
  if -1 == targetActorKey then
    return
  end
  if true == isRedTeam then
    for idx = 1, #self._redTeamMemberUI do
      if nil ~= self._redTeamMemberUI[idx] and self._redTeamMemberUI[idx]._actorKeyRaw == targetActorKey then
        userSlot = self._redTeamMemberUI[idx]
        break
      end
    end
  else
    for idx = 1, #self._blueTeamMemberUI do
      if nil ~= self._blueTeamMemberUI[idx] and self._blueTeamMemberUI[idx]._actorKeyRaw == targetActorKey then
        userSlot = self._blueTeamMemberUI[idx]
        break
      end
    end
  end
  if nil == userSlot then
    return
  end
  userSlot._progress:SetProgressRate(0)
  userSlot._percent:SetText("0%")
  userSlot._name:SetMonoTone(true, true)
end
function FromClient_Solrare_PlayerStatus_UpdateUserHP(teamNo, userNo, currentHp, maxHp, leftPercent)
  local isReplay = ToClient_IsPlayingReplay()
  if true == isReplay then
    return
  end
  local roundType = ToClient_GetSolareRoundType()
  if __eSolare3vs3GameMode_Team == roundType then
    PaGlobal_Solrare_PlayerStatus:updateUserHP_Round(teamNo, userNo, currentHp, maxHp, leftPercent)
  elseif __eSolare3vs3GameMode_Leader == roundType then
  elseif __eSolare3vs3GameMode_Relay == roundType then
  end
end
function FromClient_Solare_UpdatePlayerStatus(solareMatchMode, playState, roomState, nextStartTime)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
end
function FromClient_Solare_SetPlayerStatus()
  if nil == Panel_Widget_Solare_PlayerStatus or false == PaGlobal_Solrare_PlayerStatus._initialize then
    return
  end
  local self = PaGlobal_Solrare_PlayerStatus
  self._redTeamUserInfo = Array.new()
  self._blueTeamUserInfo = Array.new()
  self._redTeamSettedCount = 1
  self._blueTeamSettedCount = 1
  local playerCount = ToClient_GetSolareInGameInfoCount()
  if 0 == playerCount then
    return
  end
  for Index = 0, playerCount - 1 do
    local userInfo = ToClient_GetSolareInGameInfoByIndex(Index)
    if nil ~= userInfo then
      local teamNo = userInfo:getTeamNo()
      local tempTable = {_userInfo = userInfo, _index = Index}
      if 0 == teamNo then
        self._redTeamUserInfo:push_back(tempTable)
      elseif 1 == teamNo then
        self._blueTeamUserInfo:push_back(tempTable)
      end
    end
  end
  if 0 == #self._redTeamUserInfo and 0 == #self._blueTeamUserInfo then
    return
  end
  for idx = 1, #self._redTeamUserInfo do
    if nil ~= self._redTeamUserInfo[idx] then
      PaGlobalFunc_Solrare_PlayerStatus_Setting(self._redTeamUserInfo[idx]._userInfo, self._redTeamUserInfo[idx]._index)
    end
  end
  for idx = 1, #self._blueTeamUserInfo do
    if nil ~= self._blueTeamUserInfo[idx] then
      PaGlobalFunc_Solrare_PlayerStatus_Setting(self._blueTeamUserInfo[idx]._userInfo, self._blueTeamUserInfo[idx]._index)
    end
  end
  PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
  PaGlobal_Solrare_PlayerStatus:prepareOpen()
end
function PaGlobalFunc_Solrare_PlayerStatus_VoiceOnOff(isVoiceListen)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  PaGlobal_Solrare_PlayerStatus._ui.stc_VoiceListen:SetShow(isVoiceListen)
end
function PaGlobalFunc_Solrare_PlayerStatus_SpeakOnOff(isSpeakerOnOff)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  PaGlobal_Solrare_PlayerStatus._ui.stc_MICOnOff:SetShow(isSpeakerOnOff)
end
function PaGlobalFunc_Solrare_PlayerStatus_VoiceLClick()
  if true == Panel_VoiceChat_List_New:GetShow() then
    PaGlobal_VoiceChat_List_New_Close()
    return
  end
  PaGlobalFunc_Widget_FunctionButton_HandleLClick(Widget_Function_Type.SetVoice)
end
function FromClient_SolareUnJoinAck(teamNo, userNo64)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  local self = PaGlobal_Solrare_PlayerStatus
  local userNo32 = Int64toInt32(userNo64)
  if 0 == teamNo then
    for idx = 1, #self._redTeamMemberUI do
      if nil ~= self._redTeamMemberUI[idx] and self._redTeamMemberUI[idx]._userNo == userNo32 then
        self._redTeamMemberUI[idx]._isLogin = false
      end
    end
  elseif 1 == teamNo then
    for idx = 1, #self._blueTeamMemberUI do
      if nil ~= self._blueTeamMemberUI[idx] and self._blueTeamMemberUI[idx]._userNo == userNo32 then
        self._blueTeamMemberUI[idx]._isLogin = false
      end
    end
  end
  Proc_NoticeAlert_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_ESCAPE_MSG"), CppEnums.EChatNoticeType.ActionNakAll, 0)
  PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
end
