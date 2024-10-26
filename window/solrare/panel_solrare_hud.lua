PaGlobal_Widget_Solare_Hud = {
  _ui = {
    _stc_TeamHud = nil,
    _prog2_HPRed = nil,
    _prog2_HPBlue = nil,
    _txt_prog2HPRed = nil,
    _txt_prog2HPBlue = nil,
    _txt_LeftName = nil,
    _txt_RightName = nil,
    _stc_RedPointDot = Array.new(),
    _stc_BluePointDot = Array.new(),
    _txt_Round = nil,
    _txt_LeftTime = nil,
    _stc_countDown = Array.new(),
    _panel_waitOther = nil,
    _txt_waitOtherTime = nil
  },
  _currentRoomState = -1,
  _currentPlayState = -1,
  _currentRoundTime = 0,
  _currentTimeForPerFrame = 0,
  _waitMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_WAITMEMBER"),
  _currentDeltaTime = 0,
  _currentMaxCountDown = -1,
  _maxCountDown = 5,
  _maxRound = 3,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_Solare_Hud_Init")
registerEvent("FromClient_SolareKillLog", "FromClient_SolareKillLog")
function FromClient_Widget_Solare_Hud_Init()
  PaGlobal_Widget_Solare_Hud:initialize()
end
function FromClient_SolareKillLog(killPlayer, deadPlayer, killerTeamNo)
  local color = "<PAColor0xFF2C7BFF>"
  local isAlly = false
  local myTeamNo = ToClient_GetSolareMyTeamType()
  if myTeamNo ~= killerTeamNo then
    color = "<PAColor0xFFC02A2A>"
    isAlly = true
  end
  PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.solrare, killPlayer, deadPlayer, nil, isAlly)
  PaGlobal_Widget_Solare_Hud_SetKillEffect(killerTeamNo)
  local mainMessage = color .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", killPlayer, "deadPlayer", deadPlayer) .. "<PAOldColor>"
  local msg = {
    main = mainMessage,
    sub = "",
    addMsg = ""
  }
  if nil ~= msg.main then
    chatting_sendMessage("", msg.main, CppEnums.ChatType.Battle)
  end
end
function PaGlobal_Widget_Solare_Hud:initialize()
  if true == PaGlobal_Widget_Solare_Hud._initialize or nil == Panel_Widget_Solare_Hud then
    return
  end
  self._ui._stc_TeamHud = UI.getChildControl(Panel_Widget_Solare_Hud, "Static_TeamHud")
  self._ui._prog2_HPRed = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Red")
  self._ui._prog2_HPBlue = UI.getChildControl(self._ui._stc_TeamHud, "Progress2_Blue")
  local prog2_RedHead = UI.getChildControl(self._ui._prog2_HPRed, "Progress2_1_Bar_Head")
  local prog2_BlueHead = UI.getChildControl(self._ui._prog2_HPBlue, "Progress2_1_Bar_Head")
  self._ui._txt_prog2HPRed = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftPoint")
  self._ui._txt_prog2HPBlue = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightPoint")
  self._ui._txt_LeftName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_LeftTeamName")
  self._ui._txt_RightName = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_RightTeamName")
  for idx = 1, self._maxRound do
    local redBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_RedDotBG" .. tostring(idx))
    local blueBg = UI.getChildControl(self._ui._stc_TeamHud, "Static_BlueDotBG" .. tostring(idx))
    local redDot = UI.getChildControl(redBg, "Static_Icon")
    local blueDot = UI.getChildControl(blueBg, "Static_Icon")
    self._ui._stc_RedPointDot:push_back(redDot)
    self._ui._stc_BluePointDot:push_back(blueDot)
  end
  self._ui._txt_Round = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_Round")
  self._ui._txt_LeftTime = UI.getChildControl(self._ui._stc_TeamHud, "StaticText_CenterTime")
  self._ui._txt_LeftName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_0"))
  self._ui._txt_RightName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_TEAMNAME_1"))
  Panel_Widget_Solare_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_Countdown:ComputePosAllChild()
  for idx = 0, 10 do
    local control = UI.getChildControl(Panel_Widget_Solare_Countdown, "Static_Count" .. tostring(idx))
    self._ui._stc_countDown:push_back(control)
  end
  self._ui._panel_waitOther = Panel_Widget_Solare_WaitOther
  local waitOtherBg = UI.getChildControl(Panel_Widget_Solare_WaitOther, "Static_Wait_BG")
  self._ui._txt_waitOtherTime = UI.getChildControl(waitOtherBg, "StaticText_Time")
  PaGlobal_Widget_Solare_Hud:registEventHandler()
  PaGlobal_Widget_Solare_Hud._initialize = true
  PaGlobal_Widget_Solare_Hud:prepareOpen()
  PaGlobal_Widget_Solare_Hud:unRenderPanel()
end
function PaGlobal_Widget_Solare_Hud:registEventHandler()
  if nil == Panel_Widget_Solare_Hud then
    return
  end
  Panel_Widget_Solare_Hud:RegisterUpdateFunc("FromClient_SolareHud_UpdatePerFrame")
  registerEvent("FromClient_SolareJoinAck", "FromClient_SolareJoinAck")
  registerEvent("FromClient_SolareChangeStateAck", "FromClient_SolareChangeStateAck")
  registerEvent("onScreenResize", "PaGlobalFunc_Solrare_Hud_Resize")
end
function PaGlobal_Widget_Solare_Hud_SetKillEffect(killerTeamNo)
  if 0 == teamNo then
    PaGlobal_Widget_Solare_Hud._ui._prog2_HPBlue:AddEffect("fUI_Solrare_Dir_Red_01", false, 0, 0)
  elseif 1 == teamNo then
    PaGlobal_Widget_Solare_Hud._ui._prog2_HPRed:AddEffect("fUI_Solrare_Dir_Blue_01", false, 0, 0)
  end
end
function PaGlobal_Widget_Solare_Hud:prepareOpen()
  if nil == Panel_Widget_Solare_Hud then
    return
  end
  Panel_Widget_Solare_Hud:ComputePosAllChild()
  PaGlobal_Widget_Solare_Hud:open()
  PaGlobal_Widget_Solare_Hud:update()
end
function PaGlobal_Widget_Solare_Hud:update()
  self._currentRoomState = ToClient_GetSolareRoomState()
  self._currentPlayState = ToClient_GetSolarePlayState()
  local redTeamPoint = ToClient_GetSolareWinScore(0)
  local blueTeamPoint = ToClient_GetSolareWinScore(1)
  PaGlobal_Widget_Solare_Hud:setWinCountUI(redTeamPoint, blueTeamPoint)
end
function PaGlobal_Widget_Solare_Hud:setWinCountUI(redTeamPoint, blueTeamPoint)
  if nil == redTeamPoint or nil == blueTeamPoint or -1 == redTeamPoint or -1 == blueTeamPoin then
    return
  end
  for idx = 1, self._maxRound do
    self._ui._stc_RedPointDot[idx]:SetShow(false)
    self._ui._stc_BluePointDot[idx]:SetShow(false)
  end
  if redTeamPoint > 0 then
    for idx = 1, redTeamPoint do
      if nil ~= self._ui._stc_RedPointDot[idx] then
        self._ui._stc_RedPointDot[idx]:SetShow(true)
      end
    end
  end
  if blueTeamPoint > 0 then
    for idx = 1, blueTeamPoint do
      if nil ~= self._ui._stc_BluePointDot[idx] then
        self._ui._stc_BluePointDot[idx]:SetShow(true)
      end
    end
  end
end
function PaGlobal_Widget_Solare_Hud:open()
  if nil == Panel_Widget_Solare_Hud then
    return
  end
  Panel_Widget_Solare_Hud:SetShow(true)
end
function PaGlobal_Widget_Solare_Hud:prepareClose()
  if nil == Panel_Widget_Solare_Hud then
    return
  end
  Panel_Widget_Solare_Hud:ClearUpdateLuaFunc()
  PaGlobal_Widget_Solare_Hud:close()
end
function PaGlobal_Widget_Solare_Hud:close()
  if nil == Panel_Widget_Solare_Hud then
    return
  end
  Panel_Widget_Solare_Hud:SetShow(false)
end
function PaGlobal_Widget_Solare_Hud:countDownInit()
  for idx = 0, 10 do
    if nil ~= self._ui._stc_countDown[idx] then
      self._ui._stc_countDown[idx]:SetShow(false)
    end
  end
  self._currentMaxCountDown = -1
end
function PaGlobal_Widget_Solare_Hud:countDownOpen()
  Panel_Widget_Solare_Countdown:SetShow(true)
end
function PaGlobal_Widget_Solare_Hud:countDownClose()
  self._currentMaxCountDown = -1
  Panel_Widget_Solare_Countdown:SetShow(false)
end
function PaGlobal_Widget_Solare_Hud:showCountDown(time)
  if nil == self._ui._stc_countDown[time + 1] or nil == self._ui._stc_countDown[time] then
    return
  end
  self._ui._stc_countDown[time + 1]:SetShow(false)
  self._ui._stc_countDown[time]:SetShow(true)
  if 1 ~= time then
    if 6 == time or 5 == time then
      audioPostEvent_SystemUi(30, 1)
      _AudioPostEvent_SystemUiForXBOX(30, 1)
    else
      audioPostEvent_SystemUi(30, 16)
      _AudioPostEvent_SystemUiForXBOX(30, 16)
    end
  else
    audioPostEvent_SystemUi(30, 2)
    _AudioPostEvent_SystemUiForXBOX(30, 2)
  end
end
function PaGlobal_Widget_Solare_Hud:waitOtherBgShow(isShow)
  if nil == Panel_Widget_Solare_WaitOther then
    return
  end
  Panel_Widget_Solare_WaitOther:SetShow(isShow)
end
function FromClient_SolareJoinAck()
  PaGlobal_Widget_Solare_Hud:prepareOpen()
  PaGlobal_Widget_Solare_Hud:unRenderPanel()
end
function FromClient_SolareChangeStateAck(solareMatchMode, playState, roomState, redMVPUserNo, blueMVPUserNo)
  local self = PaGlobal_Widget_Solare_Hud
  local currentRound = ToClient_GetSolareCurrentRound()
  self._currentRoomState = ToClient_GetSolareRoomState()
  self._currentPlayState = ToClient_GetSolarePlayState()
  self._ui._txt_Round:SetShow(0 ~= currentRound)
  self._ui._txt_Round:SetText(currentRound)
  if __eInstanceSolareManagerState_Wait ~= self._currentRoomState then
    PaGlobal_Widget_Solare_Hud:waitOtherBgShow(false)
  end
  local msg = ""
  if __eInstanceSolareManagerState_Wait == self._currentRoomState then
    msg = self._waitMsg
    self._waitMsg = ""
  elseif __eInstanceSolareManagerState_Ready == self._currentRoomState then
    if nil ~= FromClient_Solare_SetPlayerStatus then
      FromClient_Solare_SetPlayerStatus()
    end
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_WAITBATTLE")
  elseif __eInstanceSolareManagerState_Play == self._currentRoomState then
    PaGlobal_Widget_Solare_Hud:unRenderPanel()
    ToClient_RequestSolareInGameInfo()
    if nil ~= FromClient_Solare_SetPlayerStatus then
      FromClient_Solare_SetPlayerStatus()
    end
    PaGlobal_Widget_Solare_Hud:prepareOpen()
    if __eSolareRoundState_Ready == self._currentPlayState then
      if nil ~= PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge then
        PaGlobalFunc_Solrare_PlayerStatus_ResetHpGauge()
      end
      PaGlobal_Widget_Solare_Hud:countDownInit()
      local currentRound = ToClient_GetSolareCurrentRound()
      if 1 == currentRound then
        PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, -1, -1)
      end
    elseif __eSolareRoundState_Duel == self._currentPlayState then
      msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_START", "round", ToClient_GetSolareCurrentRound())
      if true == Panel_Widget_Solare_Countdown:GetShow() then
        PaGlobal_Widget_Solare_Hud:countDownClose()
      end
    elseif __eSolareRoundState_End == self._currentPlayState then
      self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(0))
    end
  elseif __eInstanceSolareManagerState_Result == self._currentRoomState then
    PaGlobalFunc_Solrare_MatchNotice_Open(solareMatchMode, redMVPUserNo, blueMVPUserNo)
  elseif __eInstanceSolareManagerState_End == self._currentRoomState then
    msg = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_SYSMSG_LEAVE")
    PaGlobal_Widget_Solare_Hud:prepareClose()
  end
  if "" ~= msg then
    Proc_NoticeAlert_Ack(msg, CppEnums.EChatNoticeType.ActionNakAll, 0)
  end
end
function FromClient_SolareHud_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Widget_Solare_Hud
  if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Duel == self._currentPlayState then
    local remainTime = ToClient_GetSolareRemainTime(false)
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
  elseif __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Ready == self._currentPlayState or __eInstanceSolareManagerState_Ready == self._currentRoomState then
    local remainTime = ToClient_GetSolareRemainTime(true)
    self._ui._txt_LeftTime:SetText(convertSecondsToClockTime(remainTime))
    if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Ready == self._currentPlayState and remainTime < 6 and self._currentMaxCountDown ~= remainTime then
      self._currentMaxCountDown = remainTime
      if false == Panel_Widget_Solare_Countdown:GetShow() then
        PaGlobal_Widget_Solare_Hud:countDownOpen()
      end
      PaGlobal_Widget_Solare_Hud:showCountDown(self._currentMaxCountDown + 1)
    end
    if __eInstanceSolareManagerState_Play == self._currentRoomState and __eSolareRoundState_Duel == self._currentPlayState then
      PaGlobal_Widget_Solare_Hud:countDownClose()
    end
  elseif __eInstanceSolareManagerState_Wait == self._currentRoomState then
    if nil == Panel_Widget_Solare_WaitOther then
      return
    end
    if false == Panel_Widget_Solare_WaitOther:GetShow() then
      PaGlobal_Widget_Solare_Hud:waitOtherBgShow(true)
    end
    local remainTime = ToClient_GetSolarePlayerWaitingTime()
    self._ui._txt_waitOtherTime:SetText(convertSecondsToClockTime(remainTime))
  end
end
function PaGlobal_Widget_Solare_Hud:unRenderPanel()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local targetPanel = Array.new()
  targetPanel:push_back(Panel_PersonalIcon_Left)
  targetPanel:push_back(Panel_MainQuest)
  targetPanel:push_back(Panel_CheckedQuest)
  targetPanel:push_back(Panel_Widget_Function)
  targetPanel:push_back(Panel_Widget_Function)
  targetPanel:push_back(Panel_Widget_ServantIcon)
  for idx = 1, #targetPanel do
    if nil ~= targetPanel[idx] then
      targetPanel[idx]:SetRenderAndEventHide(true)
    end
  end
end
function PaGlobal_Widget_Solare_Hud_SetWinCountUI(redWinCount, blueWinCount)
  PaGlobal_Widget_Solare_Hud:setWinCountUI(redWinCount, blueWinCount)
end
function PaGlobal_Widget_Solare_Hud_SetHPProgressBar(isRed, value)
  if nil == PaGlobal_Widget_Solare_Hud then
    return
  end
  if true == isRed then
    PaGlobal_Widget_Solare_Hud._ui._prog2_HPRed:SetProgressRate(value)
    PaGlobal_Widget_Solare_Hud._ui._txt_prog2HPRed:SetText(value .. "%")
  else
    PaGlobal_Widget_Solare_Hud._ui._prog2_HPBlue:SetProgressRate(value)
    PaGlobal_Widget_Solare_Hud._ui._txt_prog2HPBlue:SetText(value .. "%")
  end
end
function PaGlobalFunc_Solrare_Hud_Resize()
  if Panel_Widget_Solare_Hud == nil then
    return
  end
  Panel_Widget_Solare_Hud:ComputePosAllChild()
  if Panel_Widget_Solare_Countdown == nil then
    return
  end
  Panel_Widget_Solare_Countdown:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Solare_Countdown:ComputePosAllChild()
end
