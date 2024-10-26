function PaGlobal_Solrare_PlayerStatus:initialize()
  if true == PaGlobal_Solrare_PlayerStatus._initialize or nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  self._ui._leftTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Static_LeftTeam")
  self._ui._leftTeam.stc_teamNameBg = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._leftTeam.txt_teamName = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._leftTeam.stc_memberTemplate = UI.getChildControl(self._ui._leftTeam.stc_mainBg, "Static_MemberArea")
  self._ui._leftTeam.stc_MyTeam = UI.getChildControl(self._ui._leftTeam.stc_teamNameBg, "StaticText_MyTeam")
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_mainBg = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Static_RightTeam")
  self._ui._rightTeam.stc_teamNameBg = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_TeamTitleBG")
  self._ui._rightTeam.txt_teamName = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_TeamName")
  self._ui._rightTeam.stc_memberTemplate = UI.getChildControl(self._ui._rightTeam.stc_mainBg, "Static_MemberArea")
  self._ui._rightTeam.stc_MyTeam = UI.getChildControl(self._ui._rightTeam.stc_teamNameBg, "StaticText_MyTeam")
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  self._ui.stc_VoiceIcon = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Button_SetState")
  self._ui.stc_VoiceListen = UI.getChildControl(self._ui.stc_VoiceIcon, "Static_Headphone")
  self._ui.stc_MICOnOff = UI.getChildControl(self._ui.stc_VoiceIcon, "Static_Mic")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_Solrare_PlayerStatus:validate()
  PaGlobal_Solrare_PlayerStatus:registEventHandler()
  PaGlobalFunc_Solrare_PlayerStatus_Create()
  PaGlobal_Solrare_PlayerStatus._initialize = true
  if __eInstanceSolareManagerState_Play == ToClient_GetSolareRoomState() then
    FromClient_Solare_SetPlayerStatus()
  end
end
function PaGlobal_Solrare_PlayerStatus:prepareOpen()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  self._ui._leftTeam.txt_teamName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_0"))
  self._ui._rightTeam.txt_teamName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_1"))
  PaGlobal_Solrare_PlayerStatus:resize()
  PaGlobal_Solrare_PlayerStatus:open()
  if 0 < ToClient_getPetUnsealedList() and nil ~= HandleEventLUp_PetList_SealAllPet_All then
    HandleEventLUp_PetList_SealAllPet_All()
  end
  if true == _ContentsGroup_VoiceChat then
    self._ui.stc_VoiceListen:SetShow(ToClient_isVoiceChatListen())
    self._ui.stc_MICOnOff:SetShow(ToClient_isVoiceChatMic())
  end
end
function PaGlobal_Solrare_PlayerStatus:open()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(true)
  self._ui._rightTeam.stc_mainBg:SetShow(true)
  Panel_Widget_Solare_PlayerStatus:SetShow(true)
end
function PaGlobal_Solrare_PlayerStatus:prepareClose()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  PaGlobal_Solrare_PlayerStatus:close()
end
function PaGlobal_Solrare_PlayerStatus:close()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  self._ui._leftTeam.stc_mainBg:SetShow(false)
  self._ui._rightTeam.stc_mainBg:SetShow(false)
  Panel_Widget_Solare_PlayerStatus:SetShow(false)
end
function PaGlobal_Solrare_PlayerStatus:createTeamUi_Round()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  if 0 < #self._redTeamMemberUI or 0 < #self._blueTeamMemberUI then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_PlayerStatus:ComputePosAllChild()
  self._ui._leftTeam.stc_memberTemplate:SetShow(true)
  self._ui._rightTeam.stc_memberTemplate:SetShow(true)
  self._ui._leftTeam.stc_teamNameBg:SetShow(true)
  self._ui._rightTeam.stc_teamNameBg:SetShow(true)
  local selfPlayer = getSelfPlayer()
  local ATeamContorlNum = 0
  local BTeamContorlNum = 0
  for teamIndex = 1, self._maxTeamCount do
    for memberIndex = 1, self._maxControlCount do
      local temp = {}
      local redTeamControlCount = #self._redTeamMemberUI
      local blueTeamControlCount = #self._blueTeamMemberUI
      local gab = 5
      local spanY = 0
      if 1 == teamIndex then
        temp._memberBg = UI.cloneControl(self._ui._leftTeam.stc_memberTemplate, self._ui._leftTeam.stc_mainBg, "Static_MemberArea_Left_" .. teamIndex .. "_" .. redTeamControlCount + 1)
        spanY = self._ui._leftTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * redTeamControlCount + 1
      elseif 2 == teamIndex then
        temp._memberBg = UI.cloneControl(self._ui._rightTeam.stc_memberTemplate, self._ui._rightTeam.stc_mainBg, "Static_MemberArea_Right_" .. teamIndex .. "_" .. blueTeamControlCount + 1)
        spanY = self._ui._rightTeam.stc_memberTemplate:GetPosY() + (temp._memberBg:GetSizeY() + gab) * blueTeamControlCount + 1
      end
      temp._memberBg:SetSpanSize(temp._memberBg:GetSpanSize().x, spanY)
      temp._memberBg:SetShow(false)
      if nil ~= temp._memberBg then
        temp._teamNo = teamIndex
        temp._circleBg = UI.getChildControl(temp._memberBg, "Static_CircleBG")
        temp._classIcon = UI.getChildControl(temp._circleBg, "Static_ClassIcon")
        temp._leftCount = UI.getChildControl(temp._circleBg, "StaticText_LeftCount")
        temp._name = UI.getChildControl(temp._memberBg, "StaticText_CharName")
        temp._gaugeRate = UI.getChildControl(temp._memberBg, "StaticText_BlackSpiritPercent")
        temp._progress = UI.getChildControl(temp._memberBg, "Progress2_1")
        temp._percent = UI.getChildControl(temp._memberBg, "StaticText_Percent")
        temp._buffList = {}
        temp._userNo = nil
        temp._actorKeyRaw = nil
        temp._isLogin = false
        temp._hpPercent = 0
        for ii = 1, self._buffMaxCount do
          temp._buffList[ii] = UI.getChildControl(temp._memberBg, "Static_Buff_Temp_" .. ii)
        end
        if 1 == teamIndex then
          self._redTeamMemberUI:push_back(temp)
        elseif 2 == teamIndex then
          self._blueTeamMemberUI:push_back(temp)
        end
      end
    end
  end
  self._ui._leftTeam.stc_memberTemplate:SetShow(false)
  self._ui._rightTeam.stc_memberTemplate:SetShow(false)
end
function PaGlobal_Solrare_PlayerStatus:createTeamUi_FreeForAll()
end
function PaGlobal_Solrare_PlayerStatus:createTeamUi_Personal()
end
function PaGlobal_Solrare_PlayerStatus:setting_Round(userInfo, userInfoIndex)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  PaGlobal_Solrare_PlayerStatus:createTeamUi_Round()
  local myTeamNo = ToClient_GetSolareMyTeamType()
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  if 0 == myTeamNo then
    self._ui._leftTeam.stc_MyTeam:SetShow(true)
    self._ui.stc_VoiceIcon:SetHorizonLeft()
  else
    self._ui._rightTeam.stc_MyTeam:SetShow(true)
    self._ui.stc_VoiceIcon:SetHorizonRight()
  end
  self._ui.stc_VoiceIcon:ComputePos()
  local myUserNo = getSelfPlayer():get():getUserNo()
  local hpPercent = 0
  local adrenalinPoint = 0
  if nil == userInfo or nil == userInfoIndex then
    return
  end
  local self = PaGlobal_Solrare_PlayerStatus
  local teamNo = userInfo:getTeamNo()
  local actorkeyRaw = userInfo:getActorKeyRaw()
  local userNo = userInfo:getUserNo()
  local isLogin = userInfo:isLogin()
  local userSlot
  if 0 == teamNo then
    if nil ~= self._redTeamMemberUI[self._redTeamSettedCount] then
      self._redTeamMemberUI[self._redTeamSettedCount]._userNo = userNo
      self._redTeamMemberUI[self._redTeamSettedCount]._actorKeyRaw = actorkeyRaw
      self._redTeamMemberUI[self._redTeamSettedCount]._isLogin = isLogin
      userSlot = self._redTeamMemberUI[self._redTeamSettedCount]
      self._redTeamSettedCount = self._redTeamSettedCount + 1
    end
  elseif 1 == teamNo and nil ~= self._blueTeamMemberUI[self._blueTeamSettedCount] then
    self._blueTeamMemberUI[self._blueTeamSettedCount]._userNo = userNo
    self._blueTeamMemberUI[self._blueTeamSettedCount]._actorKeyRaw = actorkeyRaw
    self._blueTeamMemberUI[self._blueTeamSettedCount]._isLogin = isLogin
    userSlot = self._blueTeamMemberUI[self._blueTeamSettedCount]
    self._blueTeamSettedCount = self._blueTeamSettedCount + 1
  end
  if nil ~= userInfo and nil ~= userSlot then
    userSlot._memberBg:SetShow(true)
    userSlot._circleBg:SetShow(true)
    local classType = userInfo:getClassTypeRaw()
    userSlot._classIcon:SetShow(true)
    PaGlobalFunc_Util_ChangeTextureClass(userSlot._classIcon, classType)
    userSlot._gaugeRate:SetShow(false)
    userSlot._gaugeRate:SetText("")
    local userLevel = userInfo:getLevel()
    local userName = userInfo:getName()
    userSlot._name:SetShow(true)
    userSlot._name:SetText(userLevel .. " " .. userName)
    userSlot._leftCount:SetShow(false)
    userSlot._progress:SetShow(true)
    userSlot._memberBg:SetMonoTone(not isLogin, not isLogin)
    for ii = 1, self._buffMaxCount do
      userSlot._buffList[ii]:SetShow(false)
    end
  end
end
function PaGlobal_Solrare_PlayerStatus:setting_FreeForAll(teamNo)
end
function PaGlobal_Solrare_PlayerStatus:setting_Personal(teamNo)
end
function PaGlobal_Solrare_PlayerStatus:updateUserHP_Round(teamNo, userNo, currentHp, maxHp, leftPercent)
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  local userNo32 = Int64toInt32(userNo)
  local userSlot
  if 0 == teamNo then
    for idx = 1, #self._redTeamMemberUI do
      if nil ~= self._redTeamMemberUI and userNo32 == self._redTeamMemberUI[idx]._userNo then
        userSlot = self._redTeamMemberUI[idx]
      end
    end
  elseif 1 == teamNo then
    for idx = 1, #self._blueTeamMemberUI do
      if nil ~= self._blueTeamMemberUI and userNo32 == self._blueTeamMemberUI[idx]._userNo then
        userSlot = self._blueTeamMemberUI[idx]
      end
    end
  end
  if nil ~= userSlot and nil ~= leftPercent then
    local hpPercent = math.ceil(leftPercent + 0.5)
    if hpPercent >= 100 then
      hpPercent = 100
    end
    if currentHp <= 0 then
      hpPercent = 0
      userSlot._name:SetMonoTone(true, true)
    else
      userSlot._name:SetMonoTone(false, false)
    end
    userSlot._progress:SetProgressRate(hpPercent)
    userSlot._hpPercent = hpPercent
    userSlot._percent:SetText(hpPercent .. "%")
  end
  if 0 == teamNo then
    local totalCurHpPercent = 0
    local totalMaxHpPercent = 0
    for idx = 1, #self._redTeamMemberUI do
      if nil ~= self._redTeamMemberUI[idx] and nil ~= self._blueTeamMemberUI[idx]._userNo then
        totalCurHpPercent = totalCurHpPercent + self._redTeamMemberUI[idx]._hpPercent
        totalMaxHpPercent = totalMaxHpPercent + 100
      end
    end
    local percent = 0
    if totalCurHpPercent > 0 then
      percent = math.floor(totalCurHpPercent / totalMaxHpPercent * 100 + 0.5)
      if percent >= 100 then
        percent = 100
      end
    end
    if nil ~= PaGlobal_Widget_Solare_Hud_SetHPProgressBar then
      PaGlobal_Widget_Solare_Hud_SetHPProgressBar(true, percent)
    end
  elseif 1 == teamNo then
    local totalCurHpPercent = 0
    local totalMaxHpPercent = 0
    for idx = 1, #self._blueTeamMemberUI do
      if nil ~= self._blueTeamMemberUI[idx] and nil ~= self._blueTeamMemberUI[idx]._userNo then
        totalCurHpPercent = totalCurHpPercent + self._blueTeamMemberUI[idx]._hpPercent
        totalMaxHpPercent = totalMaxHpPercent + 100
      end
    end
    local percent = 0
    if totalCurHpPercent > 0 then
      percent = math.floor(totalCurHpPercent / totalMaxHpPercent * 100 + 0.5)
      if percent >= 100 then
        percent = 100
      end
    end
    if nil ~= PaGlobal_Widget_Solare_Hud_SetHPProgressBar then
      PaGlobal_Widget_Solare_Hud_SetHPProgressBar(false, percent)
    end
  end
end
function PaGlobal_Solrare_PlayerStatus:updateUserHP_FreeForAll(teamNo, userNo, hpRate)
end
function PaGlobal_Solrare_PlayerStatus:updateUserHP_Personal(teamNo, userNo, hpRate)
end
function PaGlobal_Solrare_PlayerStatus:registEventHandler()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  registerEvent("FromClient_SolareKillLog", "FromClient_Solrare_PlayerStatus_DeadHP")
  registerEvent("FromClient_SolareUpdateHp", "FromClient_Solrare_PlayerStatus_UpdateUserHP")
  registerEvent("FromClient_SolareChangeStateAck", "FromClient_Solare_UpdatePlayerStatus")
  registerEvent("FromClient_SolareRoundResultAck", "FromClient_Solare_UpdatePlayerStatus")
  registerEvent("FromClient_SolareUnJoinAck", "FromClient_SolareUnJoinAck")
  registerEvent("onScreenResize", "PaGlobalFunc_Solrare_PlayerStatus_Resize")
  if true == _ContentsGroup_VoiceChat then
    if nil ~= Widget_Function_Type and nil ~= PaGlobalFunc_Widget_FunctionButton_HandleOver then
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_On", "PaGlobalFunc_Widget_FunctionButton_HandleOver(" .. Widget_Function_Type.SetVoice .. ")")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_Out", "PaGlobalFunc_Widget_FunctionButton_HandleOut(" .. Widget_Function_Type.SetVoice .. ")")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_PlayerStatus_VoiceLClick()")
      self._ui.stc_VoiceIcon:addInputEvent("Mouse_RUp", "PaGlobalFunc_Widget_FunctionButton_HandleRClick(" .. Widget_Function_Type.SetVoice .. ")")
    end
    registerEvent("FromClient_ListenOnOffPAVoiceChat", "PaGlobalFunc_Solrare_PlayerStatus_VoiceOnOff")
    registerEvent("FromClient_SpeakOnOffPAVoiceChat", "PaGlobalFunc_Solrare_PlayerStatus_SpeakOnOff")
  else
    self._ui.stc_VoiceIcon:SetShow(false)
  end
end
function PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  local self = PaGlobal_Solrare_PlayerStatus
  local redTotalPercent = 0
  local blueTotalPercent = 0
  local redTeamMember = 0
  for idx = 1, #self._redTeamMemberUI do
    if nil ~= self._redTeamMemberUI then
      if true == self._redTeamMemberUI[idx]._isLogin then
        self._redTeamMemberUI[idx]._hpPercent = 100
        self._redTeamMemberUI[idx]._name:SetMonoTone(false, false)
        redTeamMember = redTeamMember + 1
      else
        self._redTeamMemberUI[idx]._hpPercent = 0
        self._redTeamMemberUI[idx]._name:SetMonoTone(true, true)
      end
      self._redTeamMemberUI[idx]._percent:SetText(string.format("%d", self._redTeamMemberUI[idx]._hpPercent) .. "%")
      self._redTeamMemberUI[idx]._progress:SetProgressRate(self._redTeamMemberUI[idx]._hpPercent)
      redTotalPercent = redTotalPercent + self._redTeamMemberUI[idx]._hpPercent
    end
  end
  if redTeamMember > 0 then
    redTotalPercent = redTotalPercent / redTeamMember
  end
  local blueTeamMember = 0
  for idx = 1, #self._blueTeamMemberUI do
    if nil ~= self._blueTeamMemberUI then
      if true == self._blueTeamMemberUI[idx]._isLogin then
        self._blueTeamMemberUI[idx]._hpPercent = 100
        self._blueTeamMemberUI[idx]._name:SetMonoTone(false, false)
        blueTeamMember = blueTeamMember + 1
      else
        self._blueTeamMemberUI[idx]._hpPercent = 0
        self._blueTeamMemberUI[idx]._name:SetMonoTone(true, true)
      end
      self._blueTeamMemberUI[idx]._progress:SetProgressRate(self._blueTeamMemberUI[idx]._hpPercent)
      self._blueTeamMemberUI[idx]._percent:SetText(string.format("%d", self._blueTeamMemberUI[idx]._hpPercent) .. "%")
      blueTotalPercent = blueTotalPercent + self._blueTeamMemberUI[idx]._hpPercent
    end
  end
  if blueTeamMember > 0 then
    blueTotalPercent = blueTotalPercent / blueTeamMember
  end
  if nil ~= PaGlobal_Widget_Solare_Hud_SetHPProgressBar then
    PaGlobal_Widget_Solare_Hud_SetHPProgressBar(true, redTotalPercent)
    PaGlobal_Widget_Solare_Hud_SetHPProgressBar(false, blueTotalPercent)
  end
end
function PaGlobal_Solrare_PlayerStatus:validate()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  self._ui._leftTeam.stc_mainBg:isValidate()
  self._ui._leftTeam.stc_teamNameBg:isValidate()
  self._ui._leftTeam.txt_teamName:isValidate()
  self._ui._leftTeam.stc_memberTemplate:isValidate()
  self._ui._rightTeam.stc_mainBg:isValidate()
  self._ui._rightTeam.stc_teamNameBg:isValidate()
  self._ui._rightTeam.txt_teamName:isValidate()
  self._ui._rightTeam.stc_memberTemplate:isValidate()
end
function PaGlobal_Solrare_PlayerStatus:resize()
  if nil == Panel_Widget_Solare_PlayerStatus then
    return
  end
  Panel_Widget_Solare_PlayerStatus:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_PlayerStatus:ComputePosAllChild()
  local myTeamNo = ToClient_GetSolareMyTeamType()
  self._ui._leftTeam.stc_MyTeam:SetShow(false)
  self._ui._rightTeam.stc_MyTeam:SetShow(false)
  if nil ~= myTeamNo then
    if 0 == myTeamNo then
      self._ui._leftTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonLeft()
    else
      self._ui._rightTeam.stc_MyTeam:SetShow(true)
      self._ui.stc_VoiceIcon:SetHorizonRight()
    end
  end
end
