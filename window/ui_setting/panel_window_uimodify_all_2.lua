function PaGlobal_UIModify_ButtonTooltip(_eBtnType, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if PaGlobal_UIModify._eBtnType.preset1 == _eBtnType then
    control = PaGlobal_UIModify._ui.btn_UIFreeSet1
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET1_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET1_DESC")
  elseif PaGlobal_UIModify._eBtnType.preset2 == _eBtnType then
    control = PaGlobal_UIModify._ui.btn_UIFreeSet2
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET2_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET2_DESC")
  elseif PaGlobal_UIModify._eBtnType.preset3 == _eBtnType then
    control = PaGlobal_UIModify._ui.btn_UIFreeSet3
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET3_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_PRESET3_DESC")
  elseif PaGlobal_UIModify._eBtnType.battleMode == _eBtnType then
    control = PaGlobal_UIModify._ui.btn_CleanMode
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_BATTLEMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_BATTLEMODE_DESC")
  elseif PaGlobal_UIModify._eBtnType.revertMode == _eBtnType then
    control = PaGlobal_UIModify._ui.btn_RevertMod
    name = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_REVERTMODE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_BTNTOOLTIP_REVERTMODE_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function UiSet_FreeSet_Open()
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    if true == PaGlobal_UIModify._ui.rdo_normal:IsCheck() then
      Panel_Window_SavePreset_All:SetShow(true)
      Panel_Window_UIModify_All:SetShow(false)
      PaGlobal_Panel_SaveSetting_Hide()
    else
      PaGlobal_UIModify._renderMode:reset()
      PaGlobal_UIModify:savePresetInfo(__eUISetting_BattlePreset, true)
      PaGlobal_UIModify:savePresetInfoByPanelControl(__eUISetting_BattlePreset, true)
      if true == PaGlobal_UIModify._ui.chk_useBattleMode:IsCheck() then
        if true == ToClient_getCurrentBattleFocusCondition() then
          PaGlobal_UIModify:applyPresetInfoWithChat(__eUISetting_BattlePreset)
        else
          PaGlobal_UIModify:applyPresetInfo(__eUISetting_Revert)
        end
        ToClient_SetBattleFocusMode(true)
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, true, CppEnums.VariableStorageType.eVariableStorageType_User)
      else
        PaGlobal_UIModify:applyPresetInfo(__eUISetting_Revert)
        ToClient_SetBattleFocusMode(false)
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
  else
    Panel_Window_SavePreset_All:SetShow(true)
    Panel_Window_UIModify_All:SetShow(false)
    PaGlobal_Panel_SaveSetting_Hide()
  end
  if _ContentsGroup_Crogdalo == true then
    PaGlobalFunc_CrogdaloStable_Close()
  end
end
function PaGlobal_UiSet_FreeSet_Close()
  Panel_Window_SavePreset_All:SetShow(false)
  Panel_Window_UIModify_All:SetShow(true)
  PaGlobal_UIModify._ui.chk_GridView:SetCheck(false)
end
function HandleLUp_ToggleGrid()
  local isCheck = PaGlobal_UIModify._ui.chk_GridView:IsCheck()
  PaGlobal_UIModify._ui.grid_BG:SetShow(isCheck)
end
function HandleLUp_UiSetting_DefaultSet(isShortcuts)
  PaGlobal_UIModify:prepareOpen(false)
  PaGlobal_UIModify:applyDefaultSet(isShortcuts, false)
end
function HandleEventLUp_UiSet_MoveControlSet_Start(idx)
  if PaGlobal_UIModify._panelControl[idx].posFixed then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_POSFIXED_ACK"))
    return
  end
  local control = PaGlobal_UIModify._panelPool[idx].control
  PaGlobal_UIModify._original_MouseX = getMousePosX()
  PaGlobal_UIModify._original_MouseY = getMousePosY()
  PaGlobal_UIModify._original_controlPosX = control:GetPosX()
  PaGlobal_UIModify._original_controlPosY = control:GetPosY()
  PaGlobal_UIModify._posGapX = PaGlobal_UIModify._original_MouseX - PaGlobal_UIModify._original_controlPosX
  PaGlobal_UIModify._posGapY = PaGlobal_UIModify._original_MouseY - PaGlobal_UIModify._original_controlPosY
end
function HandleEventLUp_UiSet_MoveControl(idx)
  if PaGlobal_UIModify._panelControl[idx].posFixed then
    return
  end
  local scale = PaGlobal_UIModify._currentScale / 100
  local mouseX = getMousePosX()
  local mouseY = getMousePosY()
  local control = PaGlobal_UIModify._panelPool[idx].control
  control:SetPosX(mouseX - PaGlobal_UIModify._posGapX)
  control:SetPosY(mouseY - PaGlobal_UIModify._posGapY)
  PaGlobal_UIModify._cachePosX[idx] = control:GetPosX()
  PaGlobal_UIModify._cachePosY[idx] = control:GetPosY()
  PaGlobal_UIModify._cachePreScale[idx] = scale
  PaGlobal_UIModify._cacheSizeX[idx] = control:GetSizeX()
  PaGlobal_UIModify._cacheSizeY[idx] = control:GetSizeY()
  PaGlobal_UIModify._panelControl[idx].isChange = true
end
function HandleEventLUp_UiSet_PositionCheck(index)
  if not PaGlobal_UIModify._ui.chk_QuickSlotMagnetic:IsCheck() then
    return
  end
  if index >= PaGlobal_UIModify._panelID.NewQuickSlot0 and index <= PaGlobal_UIModify._panelID.NewQuickSlot19 then
    HandleEventLUp_UiSet_PositionCheck_SetPos(index, PaGlobal_UIModify._panelID.NewQuickSlot0, PaGlobal_UIModify._panelID.NewQuickSlot19)
  elseif index >= PaGlobal_UIModify._panelID.SkillCoolTimeQuickSlot0 and index <= PaGlobal_UIModify._panelID.SkillCoolTimeQuickSlot19 then
    HandleEventLUp_UiSet_PositionCheck_SetPos(index, PaGlobal_UIModify._panelID.SkillCoolTimeQuickSlot0, PaGlobal_UIModify._panelID.SkillCoolTimeQuickSlot19)
  end
end
function HandleEventLUp_UiSet_PositionCheck_SetPos(index, startIndex, endIndex)
  local basePosX = PaGlobal_UIModify._panelPool[index].control:GetPosX()
  local basePosY = PaGlobal_UIModify._panelPool[index].control:GetPosY()
  for qIndex = startIndex, endIndex do
    if index ~= qIndex then
      local control = PaGlobal_UIModify._panelPool[qIndex].control
      if basePosX < control:GetPosX() + control:GetSizeX() + 25 and basePosX > control:GetPosX() and basePosY > control:GetPosY() - 20 and basePosY < control:GetPosY() + 20 then
        PaGlobal_UIModify._panelPool[index].control:SetPosX(control:GetPosX() + control:GetSizeX())
        PaGlobal_UIModify._panelPool[index].control:SetPosY(control:GetPosY())
        break
      end
      if basePosY < control:GetPosY() + control:GetSizeY() + 32 and basePosY > control:GetPosY() and basePosX > control:GetPosX() - 20 and basePosX < control:GetPosX() + 20 then
        PaGlobal_UIModify._panelPool[index].control:SetPosX(control:GetPosX())
        PaGlobal_UIModify._panelPool[index].control:SetPosY(control:GetPosY() + control:GetSizeY())
        break
      end
      if basePosX > control:GetPosX() - control:GetSizeX() - 25 and basePosX < control:GetPosX() and basePosY > control:GetPosY() - 20 and basePosY < control:GetPosY() + 20 then
        PaGlobal_UIModify._panelPool[index].control:SetPosX(control:GetPosX() - control:GetSizeX())
        PaGlobal_UIModify._panelPool[index].control:SetPosY(control:GetPosY())
        break
      end
      if basePosY > control:GetPosY() - control:GetSizeY() - 32 and basePosY < control:GetPosY() and basePosX > control:GetPosX() - 20 and basePosX < control:GetPosX() + 20 then
        PaGlobal_UIModify._panelPool[index].control:SetPosX(control:GetPosX())
        PaGlobal_UIModify._panelPool[index].control:SetPosY(control:GetPosY() - control:GetSizeY())
        break
      end
    end
  end
end
function HandleEventLUp_UiModify_NewQuickSlotShowToggle(idx)
  local quickslotData = getQuickSlotItem(idx - PaGlobal_UIModify._panelID.NewQuickSlot0)
  if nil ~= quickslotData and 0 ~= quickslotData._type and true == PaGlobal_UIModify._panelControl[idx].isShow then
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(PaGlobal_UIModify._panelControl[idx].isShow)
    local function controlToggle()
      HandleEventLUp_UiSet_ControlShowToggle(idx)
    end
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UIMODIFY_NEWQUICKSLOT_OFFMESSAGE_DESC")
    local messageBoxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionYes = controlToggle,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  HandleEventLUp_UiSet_ControlShowToggle(idx)
end
function HandleEventLUp_UiSet_ControlShowToggle(idx)
  local panelOpen = 0
  if idx == PaGlobal_UIModify._panelID.Adrenallin and not getSelfPlayer():isEnableAdrenalin() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTYETSPRIT_ACK"))
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(PaGlobal_UIModify._panelControl[idx].isShow)
    return
  elseif idx == PaGlobal_UIModify._panelID.House or idx == PaGlobal_UIModify._panelID.NewEquip or idx == PaGlobal_UIModify._panelID.Party or idx == PaGlobal_UIModify._panelID.QuickSlot or idx == PaGlobal_UIModify._panelID.Adrenallin or idx == PaGlobal_UIModify._panelID.LargeParty then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NOTRANDOMHIDE_ACK"))
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(PaGlobal_UIModify._panelControl[idx].isShow)
    return
  elseif idx >= PaGlobal_UIModify._panelID.NewQuickSlot0 and idx <= PaGlobal_UIModify._panelID.NewQuickSlot19 and not isUseNewQuickSlot() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_NEWQUICKSETTING"))
    PaGlobal_UIModify._panelPool[idx].close:SetCheck(PaGlobal_UIModify._panelControl[idx].isShow)
    return
  else
    if PaGlobal_UIModify._panelControl[idx].isShow == true and idx == PaGlobal_UIModify._panelID.Chat0 then
      PaGlobal_UIModify:ControlSetShowPanel(PaGlobal_UIModify._panelID.Chat1, false)
      PaGlobal_UIModify:ControlSetShowPanel(PaGlobal_UIModify._panelID.Chat2, false)
      PaGlobal_UIModify:ControlSetShowPanel(PaGlobal_UIModify._panelID.Chat3, false)
      PaGlobal_UIModify:ControlSetShowPanel(PaGlobal_UIModify._panelID.Chat4, false)
    end
    if PaGlobal_UIModify._panelControl[idx].isShow == false and idx == PaGlobal_UIModify._panelID.Chat1 or PaGlobal_UIModify._panelControl[idx].isShow == false and idx == PaGlobal_UIModify._panelID.Chat2 or PaGlobal_UIModify._panelControl[idx].isShow == false and idx == PaGlobal_UIModify._panelID.Chat3 or PaGlobal_UIModify._panelControl[idx].isShow == false and idx == PaGlobal_UIModify._panelID.Chat4 then
      PaGlobal_UIModify:ControlSetShowPanel(PaGlobal_UIModify._panelID.Chat0, true)
    end
    if PaGlobal_UIModify._panelControl[idx].isShow then
      PaGlobal_UIModify._panelControl[idx].isShow = false
      PaGlobal_UIModify._panelPool[idx].close:SetCheck(false)
      PaGlobal_UIModify:changePanelBGTexture(idx, 1)
      if 21 == idx then
        PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_SKILLGUIDE_EXTRA"))
      else
        PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_OFF", "name", PaGlobal_UIModify._panelControl[idx].name))
      end
      if idx == PaGlobal_UIModify._panelID.RightIcon and nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Close then
        PaGlobalFunc_Widget_TownSimpleNavi_All_Close()
      end
      panelOpen = false
    else
      PaGlobal_UIModify._panelControl[idx].isShow = true
      PaGlobal_UIModify._panelPool[idx].close:SetCheck(true)
      if PaGlobal_UIModify._panelControl[idx].posFixed then
        PaGlobal_UIModify:changePanelBGTexture(idx, 3)
      else
        PaGlobal_UIModify:changePanelBGTexture(idx, 2)
      end
      if PaGlobal_UIModify._panelControl[idx].posFixed then
        PaGlobal_UIModify._panelPool[idx].control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SLOTCONTROL_IMPOSSIBLE", "name", PaGlobal_UIModify._panelControl[idx].name))
      else
        PaGlobal_UIModify._panelPool[idx].control:SetText(PaGlobal_UIModify._panelControl[idx].name)
      end
      if idx == PaGlobal_UIModify._panelID.RightIcon and nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Update then
        PaGlobalFunc_Widget_TownSimpleNavi_All_Update()
      end
      panelOpen = true
    end
  end
end
function HandleClicked_UiSet_ConfirmSetting(isShortcuts)
  PaGlobal_UiSet_FreeSet_Close()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  PaGlobal_UIModify._renderMode:reset()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, PaGlobal_UIModify._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
  if PaGlobal_UIModify._prevRemasterUI ~= PaGlobal_UIModify._isShowRemasterUI then
    FromClient_MainStatus_SwapUIOption(PaGlobal_UIModify._isShowRemasterUI, false)
  end
  local scale = PaGlobal_UIModify:confrimSetting_Sub()
  ToClient_CopyEditUiInfo()
  if false == _ContentsGroup_RemasterUI_Main_Alert then
    Panel_NewEquip_EffectLastUpdate()
  end
  FGlobal_PetListNew_NoPet()
  scale = scale + 0.002
  local uiScale_Percent = math.floor(scale * 100)
  scale = uiScale_Percent / 100
  if true == UI.checkResolution4KForXBox() then
    scale = 2
  end
  setUIScale(scale)
  GameOption_SetUIMode(scale)
  saveGameOption(false)
  if false == isShortcuts then
    if PaGlobal_UIModify._isMenu then
      Panel_Menu_ShowToggle()
    elseif false == _ContentsGroup_UISkillGroupTreeLayOut then
      Panel_Window_Skill:SetShow(true, true)
      PaGlobal_Window_Skill_CoolTimeSlot:showFunc()
    end
  end
  if false == ToClient_isConsole() then
    ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  end
  FromClient_Widget_Alert_Resize()
  if nil ~= Panel_GuildInvite_Alert then
    PaGlobal_GuildInviteAlert_SetPos()
  end
  if nil ~= Panel_Window_GameOption_All then
    PaGlobal_GameOption_All:setOptionValue("DetachtedHpBar", not PaGlobal_UIModify._isShowRemasterUI)
  end
  if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
    if false == isShortcuts then
      PaGlobal_UIModify:savePresetInfoByPanelControl(__eUISetting_Revert, false)
      PaGlobal_UIModify:saveBattlePresetWithChange(scale)
    end
    local isUseBattleMode = PaGlobal_UIModify._ui.chk_useBattleMode:IsCheck()
    if true == isUseBattleMode then
      ToClient_SetBattleFocusMode(true)
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    else
      ToClient_SetBattleFocusMode(false)
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUiSetting_useMode, false, CppEnums.VariableStorageType.eVariableStorageType_User)
    end
  end
end
function HandleEventLUp_UiSet_FieldViewToggle()
  if PaGlobal_UIModify._ui.chk_FieldView:IsCheck() then
    FieldViewMode_ShowToggle(true)
  else
    FieldViewMode_ShowToggle(false)
  end
end
function HandleEventLUp_UiSet_SwapRemasterUI()
  if PaGlobal_UIModify._ui.chk_remsaterUI:IsCheck() then
    PaGlobal_UIModify._isShowRemasterUI = false
  else
    PaGlobal_UIModify._isShowRemasterUI = true
  end
  PaGlobal_UIModify:update(true)
end
function HandleEventLDown_UiSet_ChangeScale()
  local scale = PaGlobal_UIModify._currentScale / 100
  for idx = 1, PaGlobal_UIModify._panelCount do
    local control = PaGlobal_UIModify._panelPool[idx].control
    PaGlobal_UIModify._cachePosX[idx] = control:GetPosX()
    PaGlobal_UIModify._cachePosY[idx] = control:GetPosY()
    PaGlobal_UIModify._cachePreScale[idx] = scale
    PaGlobal_UIModify._cacheSizeX[idx] = control:GetSizeX()
    PaGlobal_UIModify._cacheSizeY[idx] = control:GetSizeY()
  end
end
function HandleEventLPress_UiSet_ChangeScale()
  local nowPercent = PaGlobal_UIModify._ui.slider_UI_Scale:GetControlPos()
  local realPercent = math.ceil(PaGlobal_UIModify._replaceScale / 100 * (nowPercent * 100) + PaGlobal_UIModify._minScale)
  local scaleText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UI_SETTING_SCALETEXT", "currentScale", realPercent)
  PaGlobal_UIModify._currentScale = realPercent
  PaGlobal_UIModify._ui.txt_UISize:SetText(tostring(scaleText))
  PaGlobal_UIModify:changePanelPoolScale(PaGlobal_UIModify._currentScale / 100)
end
function HandleClicked_Reset_UiSetting_Msg()
  local reset_GameUI = function()
    local panelID = PaGlobal_UIModify._panelID
    local panelControl = PaGlobal_UIModify._panelControl
    local panelPool = PaGlobal_UIModify._panelPool
    local cachePosX = PaGlobal_UIModify._cachePosX
    local cachePosY = PaGlobal_UIModify._cachePosY
    local screenSizeX = getScreenSizeX()
    local screenSizeY = getScreenSizeY()
    local const_LowMaxScaleValue = 90
    local const_MidleMaxScaleValue = 100
    local const_HightMaxScaleValue = 120
    local minScaleHeight = 720
    local midleScaleHeight = 900
    local uiScale = 1
    local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
    local screenWidth = gameOptionSetting:getScreenResolutionWidth()
    local screenHeight = gameOptionSetting:getScreenResolutionHeight()
    if false == isGameTypeThisCountry(CppEnums.ContryCode.eContryCode_KOR) then
      const_LowMaxScaleValue = 100
    end
    if minScaleHeight >= screenHeight then
      maxScaleValue = const_LowMaxScaleValue
    elseif minScaleHeight < screenHeight and midleScaleHeight >= screenHeight then
      maxScaleValue = const_MidleMaxScaleValue
    else
      maxScaleValue = const_HightMaxScaleValue
    end
    uiScale = math.floor(uiScale * 100) / 100
    if uiScale * 100 > maxScaleValue then
      uiScale = 0.8
    end
    if true == UI.checkResolution4KForXBox() then
      uiScale = 2
    end
    PaGlobal_UIModify._uiSet.nowCurrentPercent = uiScale
    SetUIMode(Defines.UIMode.eUIMode_Default)
    PaGlobal_UIModify._renderMode:reset()
    for idx = 1, PaGlobal_UIModify._panelCount do
      panelControl[idx].control:SetRelativePosX(0)
      panelControl[idx].control:SetRelativePosY(0)
      panelControl[idx].isChange = false
      if idx == panelID.ServantIcon or idx == panelID.House or idx == panelID.NewEquip or idx == panelID.Party or idx == panelID.Adrenallin or idx == panelID.QuickSlot or idx == panelID.LargeParty or idx == panelID.ServantIconRemaster or idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
      else
        panelControl[idx].isShow = true
      end
      if panelControl[idx].posFixed then
        PaGlobal_UIModify:changePanelBGTexture(idx, 3)
      else
        PaGlobal_UIModify:changePanelBGTexture(idx, 2)
      end
      if idx == panelID.Pvp then
        if isPvpEnable() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.Adrenallin then
        if getSelfPlayer():isEnableAdrenalin() then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.GameTip then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        if false == _ContentsGroup_RenewUI then
          Panel_GameTipMask:SetShow(panelControl[idx].isShow)
          Panel_GameTipMask:SetPosX(panelPool[idx].control:GetPosX() + 15)
          Panel_GameTipMask:SetPosY(panelPool[idx].control:GetPosY() - 7)
        end
      elseif idx == panelID.ClassResource then
        local classType = getSelfPlayer():getClassType()
        if PaGlobal_ClassResource_CanUseResourceIcon ~= nil and PaGlobal_ClassResource_CanUseResourceIcon(classType) == true then
          panelControl[idx].control:SetShow(panelControl[idx].isShow)
        end
      elseif idx == panelID.QuickSlot then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.ActionGuide then
        setShowSkillCmd(panelControl[idx].isShow)
        if true == _ContentsGroup_NewUI_GameOption_All then
          PaGlobal_GameOption_All_SetSkillCommandPanel(panelControl[idx].isShow)
        else
          isChecked_SkillCommand = panelControl[idx].isShow
        end
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        GameOption_UpdateOptionChanged()
      elseif idx == panelID.KeyGuide then
        panelControl[idx].isShow = false
        Panel_KeyViewer_Hide()
        PanelMovieKeyViewer_RestorePosition()
      elseif idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.Party then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.LargeParty then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 or idx >= panelID.SkillCoolTimeQuickSlot10 and idx <= panelID.SkillCoolTimeQuickSlot19 then
        panelControl[idx].control:SetShow(false)
      elseif idx == panelID.AppliedBuffList then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.LeftIcon then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
      elseif idx == panelID.RightIcon then
        panelControl[idx].control:SetShow(panelControl[idx].isShow)
        if true == panelControl[idx].isShow then
          if nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Update then
            PaGlobalFunc_Widget_TownSimpleNavi_All_Update()
          end
        elseif nil ~= PaGlobalFunc_Widget_TownSimpleNavi_All_Close then
          PaGlobalFunc_Widget_TownSimpleNavi_All_Close()
        end
      else
        panelControl[idx].control:SetShow(true)
      end
      if idx == panelID.ServantIcon then
        cachePosX[idx] = 10
        cachePosY[idx] = panelPool[panelID.MainStatusRemaster].control:GetPosY() + panelPool[panelID.MainStatusRemaster].control:GetSizeY()
      elseif idx == panelID.ServantIconRemaster then
        cachePosX[idx] = 10
        cachePosY[idx] = panelPool[panelID.MainStatusRemaster].control:GetPosY() + panelPool[panelID.MainStatusRemaster].control:GetSizeY()
      elseif idx == panelID.Quest then
        cachePosX[idx] = screenSizeX - panelPool[panelID.Quest].control:GetSizeX() - 20
        cachePosY[idx] = panelPool[panelID.Radar].control:GetPosY() + panelPool[panelID.Radar].control:GetSizeY() + panelPool[panelID.MainQuest].control:GetSizeY() + 20 + panelPool[panelID.NewEquip].control:GetSizeY()
      elseif idx >= panelID.Chat0 and idx <= panelID.Chat4 then
        cachePosX[idx] = 0
        cachePosY[idx] = screenSizeY - panelPool[idx].control:GetSizeY() - Panel_GameTips:GetSizeY()
      elseif idx == panelID.QuickSlot then
        cachePosX[idx] = (screenSizeX - panelPool[panelID.QuickSlot].control:GetSizeX()) / 2
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY()
      elseif idx == panelID.HPBar then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.HPBar].control:GetSizeY()
      elseif idx == panelID.Pvp then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2 - 20
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.Pvp].control:GetSizeY()
      elseif idx == panelID.ClassResource then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.HPBar].control:GetSizeX() / 2 + panelPool[panelID.ClassResource].control:GetSizeX() - 5
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - panelPool[panelID.HPBar].control:GetSizeY() - panelPool[panelID.ClassResource].control:GetSizeY() + 5
      elseif idx == panelID.Adrenallin then
        cachePosX[idx] = screenSizeX / 2 - panelPool[panelID.Adrenallin].control:GetSizeX() / 2 + 225
        cachePosY[idx] = screenSizeY - panelPool[panelID.QuickSlot].control:GetSizeY() - 76
      elseif idx == panelID.House then
        cachePosX[idx] = 10
        if Panel_Window_Servant:GetShow() then
          cachePosX[idx] = panelPool[panelID.ServantIcon].control:GetSizeX() + 10
        end
        cachePosY[idx] = panelPool[panelID.ExpGage].control:GetPosY() + panelPool[panelID.ExpGage].control:GetSizeY() + 15
      elseif idx == panelID.NewEquip then
        cachePosX[idx] = FGlobal_GetPersonalIconPosY(4) + FGlobal_GetPersonalIconSizeY()
        cachePosY[idx] = FGlobal_GetPersonalIconPosX(4)
      elseif idx == panelID.ActionGuide then
        cacahePosX[idx] = screenSizeX / 2 * 1.2
        cachePosY[idx] = screenSizeY / 2 * 0.85
      elseif idx == panelID.KeyGuide then
        cachePosX[idx] = panelPool[panelID.KeyGuide].control:GetSizeX() / 3
        cachePosY[idx] = panelPool[panelID.KeyGuide].control:GetSizeY() * 2.3
      elseif idx == panelID.SkillCoolTime then
        cachePosX[idx] = screenSizeX * 0.33
        cachePosY[idx] = screenSizeY * 0.42
      elseif idx == panelID.MainQuest then
        cachePosX[idx] = screenSizeX - panelPool[panelID.MainQuest].control:GetSizeX() - 20
        cachePosY[idx] = panelPool[panelID.Radar].control:GetPosY() + panelPool[panelID.Radar].control:GetSizeY() + 10
      end
      if idx >= panelID.NewQuickSlot0 and idx <= panelID.NewQuickSlot19 then
        local panelIdx = idx - panelID.NewQuickSlot0
        cachePosX[idx] = screenSizeX * 0.35 + (panelControl[idx].control:GetSizeX() + 5) * panelIdx
        cachePosY[idx] = screenSizeY - panelControl[idx].control:GetSizeY() - 5
      end
      if idx >= panelID.SkillCoolTimeQuickSlot0 and idx <= panelID.SkillCoolTimeQuickSlot9 or idx >= panelID.SkillCoolTimeQuickSlot10 and idx <= panelID.SkillCoolTimeQuickSlot19 then
        local panelIdx = idx - panelID.SkillCoolTimeQuickSlot0
        cachePosX[idx] = screenSizeX * 0.25 + panelControl[idx].control:GetSizeX() * (panelIdx % 2)
        cachePosY[idx] = screenSizeY * 0.29 + panelControl[idx].control:GetSizeY() * math.floor(panelIdx / 2)
      end
    end
    if false == _ContentsGroup_RemasterUI_Main_Alert then
      Panel_NewEquip_EffectLastUpdate()
    end
    FGlobal_ResetRadarUI(true)
    if nil ~= PaGlobal_WorldMiniMap then
      PaGlobal_WorldMiniMap:resetPanelSize()
    end
    HouseNaviBasicInitPosition()
    FGlobal_PetListNew_NoPet()
    local count = ToClient_getChattingPanelCount()
    for chattingPanelindex = 0, count - 1 do
      Chatting_setIsOpenValue(chattingPanelindex, PaGlobal_UIModify._chatPanelIsOpenState[chattingPanelindex + 1])
      PaGlobal_UIModify._chatPanelIsOpenState[chattingPanelindex + 1] = false
    end
    Chatting_setIsOpenValue(0, true)
    PaGlobal_UIModify._chatPanelIsOpenState[1] = true
    FGlobal_ChattingPanel_Reset()
    FGlobal_NewQuickSlot_InitPos(false)
    PaGlobal_SkillCoolTimeQuickSlot:settingPos(false)
    FGlobal_SkillCommand_ResetPosition()
    PaGlobalFunc_AppliedBuffList_ResetPosition()
    PaGlobal_UIModify._isShowRemasterUI = true
    if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
      PaGlobal_UIModify._ui.chk_remsaterUI:SetCheck(false)
    end
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSwapRemasterUISetting, PaGlobal_UIModify._isShowRemasterUI, CppEnums.VariableStorageType.eVariableStorageType_User)
    FromClient_MainStatus_SwapUIOption(PaGlobal_UIModify._isShowRemasterUI, false)
    PaGlobal_UIModify:checkOldMainStatus()
    PaGlobal_Stamina_ResetPosition()
    resetGameUI()
    PaGlobal_UIModify:update()
    ToClient_SaveUiInfo(true)
    if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
      if true == PaGlobal_UIModify._ui.rdo_normal:IsCheck() then
        PaGlobal_UIModify:savePresetInfo(__eUISetting_Revert, false)
      else
        PaGlobal_UIModify:savePresetInfo(__eUISetting_BattlePreset, false)
      end
    end
    FGlobal_MyHouseNavi_Update()
    if false == ToClient_isConsole() then
      ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
    end
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET_CONFIRM")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_UI_SETTING_ALLINTERFACERESET"),
    content = messageBoxMemo,
    functionYes = reset_GameUI,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_ApplyPresetInfo(presetIndex, isShortcuts)
  local function localFunc_applyPresetInfo()
    PaGlobal_UIModify:applyPresetInfo(presetIndex, isShortcuts)
    PaGlobal_UIModify._isMenu = false
    PaGlobal_UIModify:savePresetInfo(presetIndex, true)
    if true == _ContentsGroup_UseBattleFocusUIModeVer2 then
      PaGlobal_UIModify:savePresetInfo(__eUISetting_Revert, false)
    end
  end
  if __eUISetting_Revert ~= presetIndex then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_UIEDIT_CONFIRM_DESC")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionYes = localFunc_applyPresetInfo,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  elseif false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    localFunc_applyPresetInfo()
  else
    PaGlobal_UIModify:deactivateBattleFocusMode()
  end
end
function FromClient_refreshBattleFocusMode(currentBattleFocusMode)
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  PaGlobal_UIModify:refreshBattleFocusUI(currentBattleFocusMode)
end
function FromClient_UISetting_Resize()
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  PaGlobal_UIModify._panelPoolBG:SetSize(currentScreenSize.x, currentScreenSize.y)
  Panel_Window_UIModify_All:ComputePos()
  Panel_Window_SavePreset_All:ComputePos()
  PaGlobal_UIModify._ui.grid_BG:ComputePos()
  PaGlobal_UIModify._uiSave.bg_Block:ComputePos()
  local scale = ToClient_GetUIScale()
  scale = scale + 0.002
  scale = math.floor(scale * 100)
  FGlobal_saveUIScale(scale)
end
function FromClient_getUiSettingChattingPanelInfo(chatWindowIndex, isOpen, isCombined, sizeX, sizeY, isUsedSmoothChattingup)
  local index = chatWindowIndex + PaGlobal_UIModify._panelID.Chat0
  PaGlobal_UIModify._closePanelState[chatWindowIndex] = false
  PaGlobal_UIModify._closeEmptyPanelState[chatWindowIndex] = false
  local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
  if isOpen then
    PaGlobal_UIModify._chatPanelIsOpenState[chatWindowIndex + 1] = true
    HandleClicked_Chatting_AddTabByIndex(chatWindowIndex)
    if index == PaGlobal_UIModify._panelID.Chat0 then
      PaGlobal_UIModify._panelPool[index].control:SetShow(true)
      PaGlobal_UIModify._panelPool[index].close:SetShow(true)
      PaGlobal_UIModify._panelControl[index].control:SetSize(sizeX, sizeY)
      PaGlobal_UIModify._panelPool[index].control:SetSize(sizeX, sizeY)
      chatPanel:setPanelSize(sizeX, sizeY)
    elseif isCombined then
      HandleClicked_Chatting_CombineTab(chatWindowIndex)
      PaGlobal_UIModify._panelPool[index].control:SetShow(false)
      PaGlobal_UIModify._panelPool[index].close:SetShow(false)
    else
      HandleClicked_Chatting_Division(chatWindowIndex)
      PaGlobal_UIModify._panelPool[index].control:SetShow(true)
      PaGlobal_UIModify._panelPool[index].close:SetShow(true)
      PaGlobal_UIModify._panelControl[index].control:SetSize(sizeX, sizeY)
      PaGlobal_UIModify._panelPool[index].control:SetSize(sizeX, sizeY)
      chatPanel:setPanelSize(sizeX, sizeY)
    end
  elseif isCombined == false or index == PaGlobal_UIModify._panelID.Chat0 then
    if index ~= PaGlobal_UIModify._panelID.Chat0 then
      HandleClicked_Chatting_Division(chatWindowIndex)
    end
    PaGlobal_UIModify._panelPool[index].control:SetShow(true)
    PaGlobal_UIModify._panelPool[index].close:SetShow(true)
    PaGlobal_UIModify._panelControl[index].control:SetSize(sizeX, sizeY)
    PaGlobal_UIModify._panelPool[index].control:SetSize(sizeX, sizeY)
    PaGlobal_UIModify._panelControl[index].control:SetShow(true)
    chatPanel:setPanelSize(sizeX, sizeY)
    PaGlobal_UIModify._closeEmptyPanelState[chatWindowIndex] = true
    PaGlobal_UIModify._chatPanelIsOpenState[chatWindowIndex + 1] = false
  else
    PaGlobal_UIModify._panelPool[index].control:SetShow(false)
    PaGlobal_UIModify._panelPool[index].close:SetShow(false)
    HandleClicked_Chatting_Close(chatWindowIndex, 0)
    PaGlobal_UIModify._closePanelState[chatWindowIndex] = true
  end
  Chatting_setIsOpenValue(chatWindowIndex, isOpen)
  PaGlobal_UIModify._chatPanelIsOpenState[chatWindowIndex + 1] = isOpen
  Chatting_setUsedSmoothChattingUp(isUsedSmoothChattingup)
end
function FromClient_getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
  PaGlobal_UIModify:getUiSettingPanelInfo(panelIndex, posX, posY, isShow, chatWindowIndex, relativePosX, relativePosY)
end
function FromClient_applyChattingOptionToLua(presetIndex, chatWindowIndex, chatFontSizeType, chatNameType, isCombined, transparency, isUsedSmoothChattingUp)
  ChattingOption_Open(chatWindowIndex, chatWindowIndex, isCombined)
  FGlobal_Chatting_PanelTransparency(chatWindowIndex, transparency, false)
  HandleClicked_ChattingTypeFilter_Notice(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_World(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Battle(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Public(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_RolePlay(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Team(chatWindowIndex)
  HandleClicked_ChattingDivision()
  HandleClicked_ChattingTypeFilter_WorldWithItem(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Guild(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Party(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Private(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_Arsha(chatWindowIndex)
  HandleClicked_ChattingTypeFilter_System(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Undefine(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_PrivateItem(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_PartyItem(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Market(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Worker(chatWindowIndex)
  HandleClicked_ChattingSystemTypeFilter_Harvest(chatWindowIndex)
  HandleClicked_ChattingColor_Notice(chatWindowIndex)
  HandleClicked_ChattingColor_World(chatWindowIndex)
  HandleClicked_ChattingColor_Public(chatWindowIndex)
  HandleClicked_ChattingColor_RolePlay(chatWindowIndex)
  HandleClicked_ChattingColor_Team(chatWindowIndex)
  HandleClicked_ChattingColor_WorldWithItem(chatWindowIndex)
  HandleClicked_ChattingColor_Guild(chatWindowIndex)
  HandleClicked_ChattingColor_Party(chatWindowIndex)
  HandleClicked_ChattingColor_Private(chatWindowIndex)
  HandleClicked_ChattingColor_Arsha(chatWindowIndex)
  HandleClicked_ChattingColor_MainSystem(chatWindowIndex)
  Panel_ChatOption:SetShow(false, false)
  Panel_ChatOption:SetIgnore(true)
  ChattingColor_Hide()
  Chatting_setUsedSmoothChattingUp(isUsedSmoothChattingUp)
  ChattingOption_UpdateChattingAnimationControl(isUsedSmoothChattingUp)
  setisChangeFontSize(true)
end
function PaGlobal_SimpleTooltips(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEOPTION_SAVESETTING")
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAVESETTING_BTN_DESC")
  control = PaGlobal_UIModify._uiSet.btn_save
  TooltipSimple_Show(control, name, desc, false)
end
function PaGlobal_SimpleTooltips_Index(isShow, idx)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  if idx >= 46 and idx <= 55 or idx >= 64 and idx <= 73 then
    local name, desc, control
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLCOOLTIME_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_UISETTING_COOLTIME_DESC")
    control = PaGlobal_UIModify._panelPool[idx].control
    TooltipSimple_Show(control, name, desc, false)
  end
end
function setChangeUiSettingRadarUI(panel, uiType)
  PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.Radar].control = panel
  PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.Radar].PAGameUIType = uiType
end
function FGlobal_UiSet_Open(isMenu)
  if nil == isMenu then
    PaGlobal_UIModify._isMenu = true
  else
    PaGlobal_UIModify._isMenu = isMenu
  end
  PaGlobal_UIModify:prepareOpen()
end
function PaGlobal_Prepare_Replay()
  PaGlobal_UIModify:prepareOpen()
end
function FGlobal_UiSet_Close()
  PaGlobal_UIModify:prepareClose()
end
function UiSet_update(isRemasterSwap)
  PaGlobal_UIModify:update(isRemasterSwap)
end
function PaGlobalFunc_UiSet_SetRemasterUIBtn(set)
  if nil == FromClient_MainStatus_SwapUIOption or nil == PackageIconPosition or nil == PaGlobal_UIModify then
    return
  end
  PaGlobal_UIModify._ui.chk_remsaterUI:SetCheck(set)
  if PaGlobal_UIModify._ui.chk_remsaterUI:IsCheck() then
    PaGlobal_UIModify._isShowRemasterUI = false
  else
    PaGlobal_UIModify._isShowRemasterUI = true
  end
  if PaGlobal_UIModify._prevRemasterUI ~= PaGlobal_UIModify._isShowRemasterUI then
    PaGlobal_UIModify:update(true)
  else
    PaGlobal_UIModify:update(false)
  end
  PaGlobal_UIModify._prevRemasterUI = PaGlobal_UIModify._isShowRemasterUI
  PaGlobal_UIModify:scaleSet()
  FromClient_MainStatus_SwapUIOption(PaGlobal_UIModify._isShowRemasterUI, false)
  local scale = PaGlobal_UIModify:confrimSetting_Sub()
  ToClient_CopyEditUiInfo()
  PackageIconPosition()
end
function PaGlobalFunc_UiSet_GetSkillLogIsShow()
  if nil == PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.SkillLog] then
    return false
  end
  return PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.SkillLog].isShow
end
function PaGlobalFunc_UiSet_GetItemLogRenewIsShow()
  if PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.ItemLogReNew] == nil then
    return false
  end
  return PaGlobal_UIModify._panelControl[PaGlobal_UIModify._panelID.ItemLogReNew].isShow
end
function PaGlobalFunc_Save_ChattingPanel()
  if false == _ContentsGroup_UseBattleFocusUIModeVer2 then
    return
  end
  if false == PaGlobal_UIModify._initialize then
    return
  end
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  for idx = PaGlobal_UIModify._panelID.Chat0, PaGlobal_UIModify._panelID.Chat4 do
    local slot
    slot = PaGlobal_UIModify._panelPool[idx].control
    local controlPos = float2()
    controlPos.x = slot:GetPosX()
    controlPos.y = slot:GetPosY()
    local rateX = controlPos.x + slot:GetSizeX() / 2
    local rateY = controlPos.y + slot:GetSizeY() / 2
    local relativePos = float2()
    relativePos.x = rateX / currentScreenSize.x
    relativePos.y = rateY / currentScreenSize.y
    local isShow = PaGlobal_UIModify._panelControl[idx].isShow
    local controlShowToggle = PaGlobal_UIModify._panelPool[idx].close:IsCheck()
    local uiType = PaGlobal_UIModify._panelControl[idx].PAGameUIType
    local chatWindowIndex = idx - PaGlobal_UIModify._panelID.Chat0
    local chatPanel = ToClient_getChattingPanel(chatWindowIndex)
    local chatPanelSize = float2()
    chatPanelSize.x = chatPanel:getPanelSizeX()
    chatPanelSize.y = chatPanel:getPanelSizeY()
    controlPos.x = chatPanel:getPositionX()
    controlPos.y = chatPanel:getPositionY()
    ToClient_setUISettingChattingPanelInfo(__eUISetting_Revert, chatWindowIndex, chatPanel:isOpen(), chatPanel:isCombinedToMainPanel(), uiType, controlPos, controlShowToggle, relativePos, chatPanelSize, setUISettingChattingPanelInfo)
    ToClient_setUISettingChattingOption(__eUISetting_Revert, chatWindowIndex, Chatting_getUsedSmoothChattingUp())
    ToClient_setUISettingPanelInfo(uiType, controlPos.x, controlPos.y, controlShowToggle, chatWindowIndex, relativePos.x, relativePos.y)
  end
  ToClient_getGameUIManagerWrapper():saveUISettingOnlyChattingPresetInfo(__eUISetting_Revert)
  ToClient_getGameUIManagerWrapper():saveUISettingChattingPresetInfo(__eUISetting_Revert)
end
function PAGlobal_setIsChangePanelState(index, state, ischatPanel)
  if false == ischatPanel then
    for idx = 1, PaGlobal_UIModify._panelCount do
      if PaGlobal_UIModify._panelControl[idx].PAGameUIType == index then
        PaGlobal_UIModify._panelControl[idx].isChange = state
        return
      end
    end
  else
    PaGlobal_UIModify._panelControl[index].isChange = state
  end
end
function PAGlobal_setPanelChattingPoolRelativeSize(index, sizex, sizey)
  local scale = PaGlobal_UIModify._currentScale / 100
  local preScale = PaGlobal_UIModify._preScale
  local currentScreenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  index = index + PaGlobal_UIModify._panelID.Chat0
  local slot = PaGlobal_UIModify._panelControl[index].control
  local posX = slot:GetPosX()
  local posY = slot:GetPosY()
  local rateX = 0
  local rateY = 0
  rateX = posX + slot:GetSizeX() / 2
  rateY = posY + slot:GetSizeY() / 2
  if PaGlobal_UIModify._panelControl[index].isChange == false then
    PaGlobal_UIModify._panelPool[index].control:SetRelativePosX(0)
    PaGlobal_UIModify._panelPool[index].control:SetRelativePosY(0)
    slot:SetRelativePosX(0)
    slot:SetRelativePosY(0)
  else
    PaGlobal_UIModify._panelPool[index].control:SetRelativePosX(rateX / currentScreenSize.x)
    PaGlobal_UIModify._panelPool[index].control:SetRelativePosY(rateY / currentScreenSize.y)
    slot:SetRelativePosX(rateX / currentScreenSize.x)
    slot:SetRelativePosY(rateY / currentScreenSize.y)
  end
end
