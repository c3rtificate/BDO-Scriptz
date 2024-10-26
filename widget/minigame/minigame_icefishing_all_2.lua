function PaGlobal_MiniGame_IceFishing_All_Open()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if true == Panel_MiniGame_IceFishing_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_IceFishing_All:prepareOpen()
end
function PaGlobal_MiniGame_IceFishing_All_Close()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if false == Panel_MiniGame_IceFishing_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_IceFishing_All:prepareClose()
end
function PaGlobal_MiniGame_IceFishing_All_GetShow()
  if nil == Panel_MiniGame_IceFishing_All then
    return false
  end
  return Panel_MiniGame_IceFishing_All:GetShow()
end
function PaGlobal_MiniGame_IceFishing_All_SettingIceFishingMiniGame(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  local fishAreaSize = self._ui.stc_waterBG:GetSizeY() - self._ui.stc_fish_up:GetSizeY() * 2
  local damageAreaMinY = -(self._ui.stc_waterBG:GetSizeY() * 0.5) + self._ui.stc_fising_area:GetPosY()
  local damageAreaMaxY = damageAreaMinY + self._ui.stc_fising_area:GetSizeY()
  ToClient_SetIceFishingDefaultInfo(fishAreaSize, damageAreaMinY, damageAreaMaxY, self._ui.stc_fish_up:GetSizeY(), self._ui.stc_aim)
end
function PaGlobal_MiniGame_IceFishing_All_Wait(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._ui.stc_result_board:SetShow(false)
  self._ui.stc_game_borad:SetShow(true)
  self._ui.stc_waterBG:SetShow(false)
  self._ui.stc_space:SetShow(false)
  self._ui.txt_space_console:SetShow(false)
  self._ui.stc_fish_msg_BG:SetShow(true)
  self._ui.stc_fish_title:SetShow(true)
  self._ui.txt_leftTime:SetShow(false)
  self._ui.stc_fish_stateBG[self.FISH_STATE.NORMAL]:SetShow(true)
  self._ui.txt_fish_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ICEFISHING_DESC_WAIT"))
  self._ui.stc_key_Guide_BG:SetShow(false)
  self._ui.stc_fishHp_BG:SetShow(false)
  self._ui.progress_fishHp:SetShow(false)
  PaGlobal_MiniGame_IceFishing_All_Open()
end
function PaGlobal_MiniGame_IceFishing_All_Catch(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if false == PaGlobal_MiniGame_IceFishing_All_GetShow() then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._ui.stc_result_board:SetShow(false)
  self._ui.txt_fish_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_XBOX1_GLOBALMANUAL_FISHING_3"))
  if false == _ContentsGroup_UsePadSnapping then
    self._ui.stc_space:SetShow(true)
    self._ui.txt_space_console:SetShow(false)
  else
    self._ui.stc_space:SetShow(false)
    self._ui.txt_space_console:SetShow(true)
  end
end
function PaGlobal_MiniGame_IceFishing_All_Start(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if false == PaGlobal_MiniGame_IceFishing_All_GetShow() then
    return
  end
  PaGlobal_MiniGame_IceFishing_All_CloseOtherUI()
  local self = PaGlobal_MiniGame_IceFishing_All
  self._ui.stc_game_borad:SetShow(true)
  self._ui.stc_result_board:SetShow(false)
  self._ui.stc_waterBG:SetShow(true)
  self._ui.stc_space:SetShow(false)
  self._ui.txt_space_console:SetShow(false)
  self._ui.stc_fish_title:SetShow(false)
  self._ui.txt_leftTime:SetShow(true)
  self._ui.stc_fish_stateBG[self.FISH_STATE.NORMAL]:SetShow(false)
  self._ui.stc_key_Guide_BG:SetShow(true)
  self._ui.stc_fishHp_BG:SetShow(true)
  self._ui.progress_fishHp:SetShow(true)
  FromClient_IceFishingCurrentEndurance(2)
  ToClient_StartIceFishingMiniGame()
end
function PaGlobal_MiniGame_IceFishing_All_Fail(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if false == PaGlobal_MiniGame_IceFishing_All_GetShow() then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._ui.stc_result_board:SetShow(true)
  self._ui.stc_game_borad:SetShow(false)
  self._ui.stc_success:SetShow(false)
  self._ui.stc_fail:SetShow(true)
end
function PaGlobal_MiniGame_IceFishing_All_Success(actorKeyRaw, isSelf)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  if false == PaGlobal_MiniGame_IceFishing_All_GetShow() then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._ui.stc_result_board:SetShow(true)
  self._ui.stc_game_borad:SetShow(false)
  self._ui.stc_success:SetShow(true)
  self._ui.stc_fail:SetShow(false)
end
function FromClient_IceFishingMovePos(posY, direct)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._currentPlayerPosY = posY
  self._currentFishDirection = direct
  self:setPositionData()
end
function FromClient_IceFishingCurrentEndurance(currentEndurance)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  if currentEndurance <= 0 then
    self._currentEndurance = self.HOOK_LEVEL.VERYHARD
  elseif currentEndurance == 1 then
    self._currentEndurance = self.HOOK_LEVEL.HARD
  elseif currentEndurance == 2 then
    self._currentEndurance = self.HOOK_LEVEL.NORMAL
  end
  for index = 0, 2 do
    if self._currentEndurance == index then
      self._ui.stc_hook[index]:SetShow(true)
    else
      self._ui.stc_hook[index]:SetShow(false)
    end
  end
end
function FromClient_IceFishingNoticeDirect(direct)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  if self.FISH_DIRECTION.UP == self._currentFishDirection then
    self._ui.stc_fish_stateBG[self.FISH_STATE.WARNING]:SetShow(true)
    self._ui.txt_fish_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ICEFISHING_DESC_2"))
    self._ui.stc_direct_Left:SetShow(false)
    self._ui.stc_direct_Right:SetShow(true)
  elseif self.FISH_DIRECTION.DOWN == self._currentFishDirection then
    self._ui.stc_fish_stateBG[self.FISH_STATE.WARNING]:SetShow(true)
    self._ui.txt_fish_state:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ICEFISHING_DESC_1"))
    self._ui.stc_direct_Left:SetShow(true)
    self._ui.stc_direct_Right:SetShow(false)
  end
end
function FromClient_IceFishingLeftTimeAndLeftHP(leftTime, totalTime, leftHp, totalHp)
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
  self._fishHp = leftHp
  self._fishTotalHp = totalHp
  self._leftTime = leftTime
  self._totalPlayTime = totalTime
  self:setProgressData()
end
function FromClient_IceFishingCriticalDamage()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
  local self = PaGlobal_MiniGame_IceFishing_All
end
function PaGlobal_MiniGame_IceFishing_All_CloseOtherUI()
  close_WindowPanelList()
  if nil ~= Panel_Menu and true == Panel_Menu:GetShow() then
    Panel_Menu:SetShow(false, false)
  elseif nil ~= Panel_Menu_New and true == Panel_Menu_New:GetShow() then
    Panel_Menu_New:SetShow(false, false)
  elseif nil ~= Panel_Widget_Menu_Remake and true == Panel_Widget_Menu_Remake:GetShow() then
    Panel_Widget_Menu_Remake:SetShow(false, false)
  end
end
function PaGlobal_MiniGame_IceFishing_All_ShowAni()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
end
function PaGlobal_MiniGame_IceFishing_All_HideAni()
  if nil == Panel_MiniGame_IceFishing_All then
    return
  end
end
