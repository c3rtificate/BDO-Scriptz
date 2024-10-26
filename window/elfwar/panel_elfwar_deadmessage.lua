PaGlobal_ElfWarDeadMessage = {
  _ui = {
    static_circleBG = nil,
    static_centerBG = nil,
    text_deathTitle = nil,
    static_battleMap = nil,
    rdo_rapidRespawn = nil,
    rdo_normalRespawn = nil,
    text_leftRapidRespawnTime = nil,
    text_leftNormalRespawnTime = nil,
    btn_observer = nil,
    btn_devRevive = nil,
    static_KamaCastle = nil,
    static_OdilCastle = nil,
    static_SelectBG = nil,
    btn_OutsideCastleRespawn = nil,
    btn_InsideCastleRespawn = nil,
    btn_PlazaRespawn = nil,
    static_LastDead = nil
  },
  _fierceBattleList = {},
  _selectedFierceBattleKey = nil,
  _selectedRespawnPositionType = __eElfWarRespawnPositionType_Count,
  _attackerActorKeyRaw = nil,
  _respawnTime = ToClient_GetElfWarReviveTime(false),
  _rapidReviveTime = nil,
  _normalReviveTime = nil,
  _prevUIMode = nil,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarDeadMessageInit")
function FromClient_ElfWarDeadMessageInit()
  PaGlobal_ElfWarDeadMessage:initialize()
end
function PaGlobal_ElfWarDeadMessage:initialize()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui.static_circleBG = UI.getChildControl(Panel_ElfWar_DeadMessage, "Static_CircleBG")
  self._ui.static_centerBG = UI.getChildControl(Panel_ElfWar_DeadMessage, "Static_CenterBG")
  self._ui.text_deathTitle = UI.getChildControl(self._ui.static_centerBG, "StaticText_DeathTitle")
  self._ui.static_battleMap = UI.getChildControl(Panel_ElfWar_DeadMessage, "Static_BattleMap")
  self._ui.rdo_rapidRespawn = UI.getChildControl(self._ui.static_battleMap, "RadioButton_ResponFast")
  self._ui.rdo_normalRespawn = UI.getChildControl(self._ui.static_battleMap, "RadioButton_ResponNormal")
  self._ui.text_leftRapidRespawnTime = UI.getChildControl(self._ui.static_battleMap, "StaticText_LeftFastTime")
  self._ui.text_leftNormalRespawnTime = UI.getChildControl(self._ui.static_battleMap, "StaticText_LeftNormalTime")
  self._ui.btn_observer = UI.getChildControl(self._ui.static_battleMap, "Button_Obserber")
  self._ui.btn_devRevive = UI.getChildControl(self._ui.static_battleMap, "Button_Dev")
  for i = 1, 20 do
    local temp = {
      icon = UI.getChildControl(self._ui.static_battleMap, "Button_" .. tostring(i)),
      stc_cantRevive = nil
    }
    temp.stc_cantRevive = UI.getChildControl(temp.icon, "Static_CantRevive")
    temp.stc_cantRevive:SetShow(false)
    self._fierceBattleList[i] = temp
    self:changeFierceBattleColor(i, __eElfWarTeam_Neutral)
  end
  self._ui.static_KamaCastle = UI.getChildControl(self._ui.static_battleMap, "Button_Castle_Kama")
  self._ui.static_OdilCastle = UI.getChildControl(self._ui.static_battleMap, "Button_Castle_Othilita")
  self._ui.static_SelectBG = UI.getChildControl(self._ui.static_battleMap, "Static_SelectBg")
  self._ui.btn_OutsideCastleRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_1")
  self._ui.btn_InsideCastleRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_2")
  self._ui.btn_PlazaRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_3")
  self._ui.static_LastDead = UI.getChildControl(self._ui.static_battleMap, "Static_LastDead")
  self._ui.static_FixedResurrectionPoint = UI.getChildControl(self._ui.static_battleMap, "Static_FixedResurrectionPoint")
  self._ui.txt_FixedResurrectionPointTime = UI.getChildControl(self._ui.static_FixedResurrectionPoint, "StaticText_1")
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ElfWarDeadMessage:registerEventHandler()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  Panel_ElfWar_DeadMessage:RegisterUpdateFunc("ElfWarRevive_UpdatePerFrame")
  registerEvent("FromClient_UpdateElfWarFierceBattleDeadMessage", "FromClient_UpdateElfWarFierceBattleDeadMessage")
  registerEvent("EventSelfPlayerDeadInElfWar", "EventSelfPlayerDeadInElfWar")
  registerEvent("EventSelfPlayerReviveInElfWar", "EventSelfPlayerReviveInElfWar")
  registerEvent("onScreenResize", "FromClient_ElfWar_DeadMessage_All_OnScreenReSize")
  registerEvent("FromClient_ChangeElfWarState", "FromClient_ReviveToNearTown")
  self._ui.btn_observer:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_ChangeToObserverMode()")
  self._ui.btn_devRevive:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_SelectDevRevive()")
  self._ui.rdo_rapidRespawn:addInputEvent("Mouse_On", "HandleEventOn_ElfWarDeadMessage_ShowToolip(true,true)")
  self._ui.rdo_rapidRespawn:addInputEvent("Mouse_Out", "HandleEventOn_ElfWarDeadMessage_ShowToolip(true,false)")
  self._ui.rdo_normalRespawn:addInputEvent("Mouse_On", "HandleEventOn_ElfWarDeadMessage_ShowToolip(false,true)")
  self._ui.rdo_normalRespawn:addInputEvent("Mouse_Out", "HandleEventOn_ElfWarDeadMessage_ShowToolip(false,false)")
  for i = 1, 20 do
    self._fierceBattleList[i].icon:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_SelectRespawnFierceBattle(" .. i .. ")")
    self._fierceBattleList[i].icon:addInputEvent("Mouse_On", "HandleEventOn_ElfWarDeadMessage_ShowFierceBattleTooltip(true, " .. i .. ")")
    self._fierceBattleList[i].icon:addInputEvent("Mouse_Out", "HandleEventOn_ElfWarDeadMessage_ShowFierceBattleTooltip(false, " .. i .. ")")
  end
  self._ui.static_KamaCastle:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_ShowRespawnPosition(true)")
  self._ui.static_OdilCastle:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_ShowRespawnPosition(false)")
  self._ui.btn_OutsideCastleRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_SelectRespawnCastle(" .. 1 .. ")")
  self._ui.btn_InsideCastleRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_SelectRespawnCastle(" .. 2 .. ")")
  self._ui.btn_PlazaRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_ElfWarDeadMessage_SelectRespawnCastle(" .. 3 .. ")")
end
function ElfWarRevive_UpdatePerFrame(deltaTime)
  if PaGlobal_ElfWarDeadMessage._rapidReviveTime > 0 then
    PaGlobal_ElfWarDeadMessage._rapidReviveTime = PaGlobal_ElfWarDeadMessage._rapidReviveTime - deltaTime
  else
    PaGlobal_ElfWarDeadMessage._rapidReviveTime = 0
  end
  if 0 < PaGlobal_ElfWarDeadMessage._normalReviveTime then
    PaGlobal_ElfWarDeadMessage._normalReviveTime = PaGlobal_ElfWarDeadMessage._normalReviveTime - deltaTime
  else
    PaGlobal_ElfWarDeadMessage._normalReviveTime = 0
  end
  local rapidTime = math.floor(PaGlobal_ElfWarDeadMessage._rapidReviveTime)
  local normalTime = math.floor(PaGlobal_ElfWarDeadMessage._normalReviveTime)
  PaGlobal_ElfWarDeadMessage._ui.text_leftRapidRespawnTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(rapidTime)))
  PaGlobal_ElfWarDeadMessage._ui.text_leftNormalRespawnTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(normalTime)))
  local fixedPoint = ToClient_GetCurrentFixedResurrectionPoint()
  if fixedPoint ~= nil and PaGlobal_ElfWarDeadMessage._fierceBattleList ~= nil then
    local fixedResurrectionKey = fixedPoint:getFierceBattleKey()
    local control = PaGlobal_ElfWarDeadMessage._fierceBattleList[fixedResurrectionKey].icon
    if control ~= nil then
      local posX = control:GetPosX() - 10
      local posY = control:GetPosY() - 10
      PaGlobal_ElfWarDeadMessage._ui.static_FixedResurrectionPoint:SetPosXY(posX, posY)
      local leftTime = fixedPoint:getEndTime() - Int64toInt32(getServerUtc64())
      local time = convertSecondsToClockTime(leftTime)
      PaGlobal_ElfWarDeadMessage._ui.txt_FixedResurrectionPointTime:SetText(time)
    end
  end
  PaGlobal_ElfWarDeadMessage._ui.static_FixedResurrectionPoint:SetShow(fixedPoint ~= nil)
end
function PaGlobal_ElfWarDeadMessage:prepareOpen(attackerActorKeyRaw, respawnTime)
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  PaGlobal_ElfWarDeadMessage._attackerActorKeyRaw = attackerActorKeyRaw
  PaGlobal_ElfWarDeadMessage._respawnTime = respawnTime
  PaGlobal_ElfWarDeadMessage._isObserverMode = false
  if ToClient_isPlayingSequence() == true then
    return
  end
  self:closeOtherPanel()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  if respawnTime <= 0 then
    self._rapidReviveTime = 0
    self._normalReviveTime = 0
  else
    respawnTime = respawnTime / 1000
    self._rapidReviveTime = respawnTime - (ToClient_GetElfWarReviveTime(false) - ToClient_GetElfWarReviveTime(true))
    self._normalReviveTime = respawnTime
    if 0 >= self._rapidReviveTime then
      self._rapidReviveTime = 0
    end
    if 0 >= self._normalReviveTime then
      self._normalReviveTime = 0
    end
  end
  self._ui.static_FixedResurrectionPoint:SetShow(false)
  self._ui.rdo_rapidRespawn:SetCheck(false)
  self._ui.rdo_normalRespawn:SetCheck(true)
  self._ui.btn_observer:SetShow(true)
  ToClient_UpdateElfWarFierceBattleDeadMessage()
  self:updateDeathMessage(attackerActorKeyRaw)
  local fixedResurrectionPoint = ToClient_GetCurrentFixedResurrectionPoint()
  for fierceBattleKey = 1, 20 do
    self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(false)
    local fierceBattleStaticStatusWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKey)
    if fierceBattleStaticStatusWrapper ~= nil then
      local canRevive = fierceBattleStaticStatusWrapper:canRevive()
      self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(canRevive == false)
      if canRevive == false and fixedResurrectionPoint ~= nil and fixedResurrectionPoint:getFierceBattleKey() == fierceBattleKey then
        self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(false)
      end
    end
  end
  self:updateCastle()
  self._ui.btn_devRevive:SetShow(ToClient_IsDevelopment() == true)
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil then
    local sectorSize = 12800
    local leftSectorPosX = -49 * sectorSize
    local rightSectorPosX = -17 * sectorSize
    local leftSectorPosY = -33 * sectorSize
    local rightSectorPosY = -54 * sectorSize
    local position = selfPlayer:get():getPosition()
    local xRate = math.abs(position.x - leftSectorPosX) / math.abs(rightSectorPosX - leftSectorPosX)
    local yRate = math.abs(position.z - leftSectorPosY) / math.abs(rightSectorPosY - leftSectorPosY)
    local newPosX = self._ui.static_battleMap:GetSizeX() * xRate - self._ui.static_LastDead:GetSizeX() / 2
    local newPosY = self._ui.static_battleMap:GetSizeY() * 0.8 * yRate - self._ui.static_LastDead:GetSizeY() / 2
    self._ui.static_LastDead:SetPosXY(newPosX, newPosY)
    self._ui.static_LastDead:SetShow(true)
  end
  self:computePos()
  self:open()
  local aniInfo = self._ui.static_centerBG:addColorAnimation(0, 2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = self._ui.static_battleMap:addColorAnimation(0, 2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo2.IsChangeChild = true
end
function PaGlobal_ElfWarDeadMessage:open()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  Panel_ElfWar_DeadMessage:SetShow(true)
end
function PaGlobal_ElfWarDeadMessage:preapreClose()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  if self._prevUIMode ~= nil then
    SetUIMode(self._prevUIMode)
  end
  self._prevUIMode = nil
  self:close()
end
function PaGlobal_ElfWarDeadMessage:close()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  Panel_ElfWar_DeadMessage:SetShow(false)
end
function PaGlobal_ElfWarDeadMessage:closeOtherPanel()
  PanelCloseFunc_Skill()
  if PaGlobalFunc_Finish_WorldBossItemLooting ~= nil then
    PaGlobalFunc_Finish_WorldBossItemLooting()
  end
  PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  close_attacked_WindowPanelList(true)
end
function PaGlobal_ElfWarDeadMessage:updateFierceBattleDeadMessage(fierceBattleKey, elfWarTeamNo)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local fierceBattleIconSet = self._fierceBattleList[fierceBattleKey]
  if fierceBattleIconSet == nil then
    return
  end
  self:changeFierceBattleColor(fierceBattleKey, elfWarTeamNo)
  if self._selectedFierceBattleKey == fierceBattleKey then
    self._selectedFierceBattleKey = nil
    self._selectedRespawnPositionType = __eElfWarRespawnPositionType_Count
  end
end
function PaGlobal_ElfWarDeadMessage:changeFierceBattleColor(fierceBattleKey, elfWarTeamNo)
  local fierceBattleIconSet = self._fierceBattleList[fierceBattleKey]
  if fierceBattleIconSet == nil then
    return
  end
  local fierceBattle = self._fierceBattleList[fierceBattleKey].icon
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local myElfWarTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  if elfWarTeamNo == __eElfWarTeam_Neutral then
    fierceBattle:ChangeTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 831, 55, 881, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 831, 106, 881, 156)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1301, 346, 1351, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  elseif elfWarTeamNo == myElfWarTeamNo then
    fierceBattle:ChangeTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 513, 55, 563, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 525, 308, 575, 358)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1250, 346, 1300, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  else
    fierceBattle:ChangeTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 462, 55, 512, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 474, 308, 524, 358)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoName("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1199, 346, 1249, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_ElfWarDeadMessage:updateDeathMessage(attackerActorKeyRaw)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local attackerActorProxyWrapper
  if attackerActorKeyRaw ~= nil then
    attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  end
  local deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  if attackerActorProxyWrapper ~= nil then
    if attackerActorKeyRaw == selfPlayerWrapper:getActorKey() then
      deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
    else
      local nameType = ToClient_getChatNameType()
      if nameType == __eChatNameType_NickName then
        local playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
        if playerActorProxyWrapper ~= nil then
          deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", playerActorProxyWrapper:getUserNickname())
        else
          deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
        end
      else
        deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
      end
    end
  end
  self._ui.text_deathTitle:SetText(deadMessageString)
end
function PaGlobal_ElfWarDeadMessage:updateCastle()
  self._ui.static_SelectBG:SetShow(false)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local isKamasylviaTeam = selfPlayerWrapper:getElfWarTeamNo() == __eElfWarTeam_Kamasylvia
  self._ui.static_KamaCastle:SetShow(isKamasylviaTeam)
  self._ui.static_OdilCastle:SetShow(not isKamasylviaTeam)
  local backGroundTextureRoute = ""
  if isKamasylviaTeam == true then
    backGroundTextureRoute = "new_ui_common_forlua/Widget/Rader/ElfWar/ElfWarMap_Resurrectionarea_Kama.dds"
  else
    backGroundTextureRoute = "new_ui_common_forlua/Widget/Rader/ElfWar/ElfWarMap_Resurrectionarea_Odill.dds"
  end
  self._ui.static_battleMap:ChangeTextureInfoName(backGroundTextureRoute)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.static_battleMap, 0, 0, 1025, 880)
  self._ui.static_battleMap:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.static_battleMap:setRenderTexture(self._ui.static_battleMap:getBaseTexture())
end
function PaGlobal_ElfWarDeadMessage:computePos()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  Panel_ElfWar_DeadMessage:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.static_circleBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.static_centerBG:SetPosX((getScreenSizeX() - self._ui.static_centerBG:GetSizeX()) / 2)
  self._ui.static_centerBG:SetPosY((getScreenSizeY() - self._ui.static_centerBG:GetSizeY()) / 2)
  self._ui.static_battleMap:SetPosX((getScreenSizeX() - self._ui.static_battleMap:GetSizeX()) / 2)
  self._ui.static_battleMap:SetPosY((getScreenSizeY() - self._ui.static_battleMap:GetSizeY()) / 2)
end
function PaGlobal_ElfWarDeadMessage:validate()
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  self._ui.static_circleBG:isValidate()
  self._ui.static_centerBG:isValidate()
  self._ui.text_deathTitle:isValidate()
  self._ui.static_battleMap:isValidate()
  self._ui.rdo_rapidRespawn:isValidate()
  self._ui.rdo_normalRespawn:isValidate()
  self._ui.text_leftRapidRespawnTime:isValidate()
  self._ui.text_leftNormalRespawnTime:isValidate()
  self._ui.btn_observer:isValidate()
  for i = 1, 20 do
    self._fierceBattleList[i].icon:isValidate()
  end
  self._ui.static_KamaCastle:isValidate()
  self._ui.static_OdilCastle:isValidate()
  self._ui.static_SelectBG:isValidate()
  self._ui.btn_OutsideCastleRespawn:isValidate()
  self._ui.btn_InsideCastleRespawn:isValidate()
  self._ui.btn_PlazaRespawn:isValidate()
  self._ui.static_LastDead:isValidate()
end
function PaGlobal_ElfWarDeadMessage_ReOpen()
  if PaGlobal_ElfWarDeadMessage == nil then
    return
  end
  PaGlobal_ElfWarDeadMessage._ui.static_circleBG:SetShow(true)
  PaGlobal_ElfWarDeadMessage._ui.static_centerBG:SetShow(true)
  PaGlobal_ElfWarDeadMessage._ui.static_battleMap:SetShow(true)
  if PaGlobal_ElfWarDeadMessage._rapidReviveTime <= 0 and 0 >= PaGlobal_ElfWarDeadMessage._normalReviveTime then
    PaGlobal_ElfWarDeadMessage._ui.btn_observer:SetShow(false)
    PaGlobal_ElfWarDeadMessage._isObserverMode = false
  end
end
function FromClient_UpdateElfWarFierceBattleDeadMessage(fierceBattleKey, elfWarTeamNo)
  PaGlobal_ElfWarDeadMessage:updateFierceBattleDeadMessage(fierceBattleKey, elfWarTeamNo)
end
function HandleEventOn_ElfWarDeadMessage_SelectRespawnFierceBattle(fierceBattleKey)
  local fierceBattleStaticStatusWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKey)
  if fierceBattleStaticStatusWrapper == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local canRevive = fierceBattleStaticStatusWrapper:canRevive()
  if canRevive == false then
    local myElfWarTeamNo = selfPlayerWrapper:getElfWarTeamNo()
    local fixedResurrectionPoint = ToClient_GetCurrentFixedResurrectionPoint()
    if fixedResurrectionPoint == nil then
      if fierceBattleStaticStatusWrapper:getTeamNo() ~= myElfWarTeamNo then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotMyFierceBattleTeam"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistAdvancedBase"))
      end
      return
    end
    if fixedResurrectionPoint:getFierceBattleKey() ~= fierceBattleKey or fixedResurrectionPoint:getEndTime() < Int64toInt32(getServerUtc64()) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistAdvancedBase"))
      return
    end
  end
  PaGlobal_ElfWarDeadMessage._ui.static_SelectBG:SetShow(false)
  PaGlobal_ElfWarDeadMessage._selectedFierceBattleKey = fierceBattleKey
  PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_FierceBattle
  local isRapidRevive
  if PaGlobal_ElfWarDeadMessage._ui.rdo_rapidRespawn:IsCheck() == true then
    isRapidRevive = true
  elseif PaGlobal_ElfWarDeadMessage._ui.rdo_normalRespawn:IsCheck() == true then
    isRapidRevive = false
  end
  if isRapidRevive == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarReviveType"))
    return
  end
  local function revive()
    local servantNo = toInt64(0, 0)
    local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(CppEnums.ServantType.Type_Vehicle)
    if servantInfo ~= nil then
      servantNo = servantInfo:getServantNo()
    end
    deadMessage_Revival(__eRespawnType_ElfWar, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo, false, false, PaGlobal_ElfWarDeadMessage._selectedFierceBattleKey, PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType, isRapidRevive, 0)
  end
  local fierceBattleName = ""
  if fierceBattleStaticStatusWrapper ~= nil then
    fierceBattleName = fierceBattleStaticStatusWrapper:getName()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_SANCTUM", "target", fierceBattleName),
    functionYes = revive,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventOn_ElfWarDeadMessage_ShowRespawnPosition(isKamasylviaTeam)
  PaGlobal_ElfWarDeadMessage._ui.static_SelectBG:SetShow(not PaGlobal_ElfWarDeadMessage._ui.static_SelectBG:GetShow())
  if isKamasylviaTeam == true then
    PaGlobal_ElfWarDeadMessage._ui.static_SelectBG:SetPosXY(PaGlobal_ElfWarDeadMessage._ui.static_KamaCastle:GetPosX() + 50, PaGlobal_ElfWarDeadMessage._ui.static_KamaCastle:GetPosY())
  else
    PaGlobal_ElfWarDeadMessage._ui.static_SelectBG:SetPosXY(PaGlobal_ElfWarDeadMessage._ui.static_OdilCastle:GetPosX() + 50, PaGlobal_ElfWarDeadMessage._ui.static_OdilCastle:GetPosY())
  end
end
function HandleEventOn_ElfWarDeadMessage_SelectRespawnCastle(positionType)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  PaGlobal_ElfWarDeadMessage._selectedFierceBattleKey = 0
  PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Count
  if positionType == 1 then
    if selfPlayerWrapper:getElfWarTeamNo() == 0 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Kamasylvia_OuterCastleGate
    elseif selfPlayerWrapper:getElfWarTeamNo() == 1 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Odyllita_OuterCastleGate
    end
  elseif positionType == 2 then
    if selfPlayerWrapper:getElfWarTeamNo() == 0 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Kamasylvia_InsideCastleGate
    elseif selfPlayerWrapper:getElfWarTeamNo() == 1 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Odyllita_InsideCastleGate
    end
  elseif positionType == 3 then
    if selfPlayerWrapper:getElfWarTeamNo() == 0 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Kamasylvia_Plaza
    elseif selfPlayerWrapper:getElfWarTeamNo() == 1 then
      PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType = __eElfWarRespawnPositionType_Odyllita_Plaza
    end
  end
  local isRapidRevive
  if PaGlobal_ElfWarDeadMessage._ui.rdo_rapidRespawn:IsCheck() == true then
    isRapidRevive = true
  elseif PaGlobal_ElfWarDeadMessage._ui.rdo_normalRespawn:IsCheck() == true then
    isRapidRevive = false
  end
  if isRapidRevive == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarReviveType"))
    return
  end
  if PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType == __eElfWarRespawnPositionType_Count then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarRevivePositionType"))
    return
  end
  local function revive()
    local servantNo = toInt64(0, 0)
    local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(CppEnums.ServantType.Type_Vehicle)
    if servantInfo ~= nil then
      servantNo = servantInfo:getServantNo()
    end
    deadMessage_Revival(__eRespawnType_ElfWar, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo, false, false, PaGlobal_ElfWarDeadMessage._selectedFierceBattleKey, PaGlobal_ElfWarDeadMessage._selectedRespawnPositionType, isRapidRevive, 0)
  end
  local messageBoxDesc = ""
  if positionType == 1 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_OUTGATE")
  elseif positionType == 2 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_INGATE")
  elseif positionType == 3 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_SQUARE")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxDesc,
    functionYes = revive,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function EventSelfPlayerDeadInElfWar(attackerActorKeyRaw, respawnTime)
  PaGlobal_ElfWarDeadMessage:prepareOpen(attackerActorKeyRaw, respawnTime)
end
function EventSelfPlayerReviveInElfWar()
  PaGlobal_ElfWarDeadMessage:preapreClose()
end
function HandleEventOn_ElfWarDeadMessage_SelectDevRevive()
  local servantNo = toInt64(0, 0)
  local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(CppEnums.ServantType.Type_Vehicle)
  if servantInfo ~= nil then
    servantNo = servantInfo:getServantNo()
  end
  deadMessage_Revival(__eRespawnType_Immediately, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, servantNo, false, false, 0, __eElfWarRespawnPositionType_Count, false, 0)
end
function HandleEventOn_ElfWarDeadMessage_ChangeToObserverMode()
  PaGlobal_ElfWarDeadMessage._ui.static_circleBG:SetShow(false)
  PaGlobal_ElfWarDeadMessage._ui.static_centerBG:SetShow(false)
  PaGlobal_ElfWarDeadMessage._ui.static_battleMap:SetShow(false)
  PaGlobal_ElfWarDeadMessage._isObserverMode = true
  observerCameraModeStart()
  if PaGlobal_ElfWarDeadMessage._rapidReviveTime <= 0 then
    ShowCommandFunc(PaGlobal_ElfWarDeadMessage._normalReviveTime)
  else
    ShowCommandFunc(PaGlobal_ElfWarDeadMessage._rapidReviveTime)
  end
  PaGlobal_DeadMessage_All:actionGuideOnOff(false)
end
function FromClient_ElfWar_DeadMessage_All_OnScreenReSize()
  PaGlobal_ElfWarDeadMessage:computePos()
end
function FromClient_ReviveToNearTown(state)
  if state == __eElfWar_Start then
    return
  end
  if Panel_ElfWar_DeadMessage:GetShow() == false then
    return
  end
  deadMessage_Revival(__eRespawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false, false, 0, __eElfWarRespawnPositionType_Count, false, 0)
  if EventSelfPlayerReviveInElfWar ~= nil then
    EventSelfPlayerReviveInElfWar()
  end
end
function HandleEventOn_ElfWarDeadMessage_ShowToolip(isRapidRevive, isShow)
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  if isShow == nil or isRapidRevive == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  if isRapidRevive == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_TYPE_FAST_TOOLTIP")
    TooltipSimple_Show(PaGlobal_ElfWarDeadMessage._ui.rdo_rapidRespawn, name)
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_TYPE_NORMAL_TOOLTIP")
    TooltipSimple_Show(PaGlobal_ElfWarDeadMessage._ui.rdo_normalRespawn, name)
  end
end
function HandleEventOn_ElfWarDeadMessage_ShowFierceBattleTooltip(isShow, fierceBattleKey)
  if Panel_ElfWar_DeadMessage == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local fierceBattleStaticStatusWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKey)
  if fierceBattleStaticStatusWrapper ~= nil then
    local name = fierceBattleStaticStatusWrapper:getName()
    local control = PaGlobal_ElfWarDeadMessage._fierceBattleList[fierceBattleKey].icon
    if control ~= nil then
      TooltipSimple_Show(control, name)
    end
  end
end
