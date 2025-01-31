function PaGlobalFunc_GuildInfo_All_Open()
  if nil == Panel_GuildInfo_All then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(false, "ToClient_GetguildWrapperWrapper is nil", "-")
    return
  end
  PaGlobal_GuildInfo_All:guildTodayCommentUpdate(guildWrapper)
  PaGlobal_GuildInfo_All:update()
end
function PaGlobalFunc_GuildInfo_All_ResetUrl()
  if true == _ContentsGroup_RenewUI then
    return
  end
  if nil ~= Panel_IME then
    FGlobal_ClearCandidate()
  end
  PaGlobal_GuildInfo_All._ui.stc_webControl:ResetUrl()
end
function HandleEventLUp_GuildInfo_All_GetVaction()
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if nil == PaGlobal_GuildInfo_All._isVacation or true == PaGlobal_GuildInfo_All._isVacation then
    return
  end
  local RequestApplyVaction = function()
    ToClient_RequestApplyVacation(true)
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GET_VACATION_MESSAGE_WINDOW_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GET_VACATION_MESSAGE_WINDOW_CONTENT"), RequestApplyVaction, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_GuildInfo_All_ReturnVaction()
  if nil == PaGlobal_GuildInfo_All._isVacation or false == PaGlobal_GuildInfo_All._isVacation then
    return
  end
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  local RequestReturnVaction = function()
    ToClient_RequestApplyVacation(false)
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_RETURN_VACATION_MESSAGE_WINDOW_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_RETURN_VACATION_MESSAGE_WINDOW_CONTENT"), RequestReturnVaction, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_GuildInfo_All_DismissGuild()
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    _PA_ASSERT(false, "ResponseGuildInviteForGuildGrade \236\151\144\236\132\156 \234\184\184\235\147\156 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.")
    return
  end
  local guildGrade = myGuildInfo:getGuildGrade()
  local isRightDismiss = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightDismiss = getSelfPlayer():get():isGuildMaster()
  else
    isRightDismiss = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildDestroy)
  end
  if true == isRightDismiss then
    if myGuildInfo:getMemberCount() <= 1 then
      local GuildDismiss = function()
        ToClient_RequestDestroyGuild()
        PaGlobal_GuildMain_All:prepareClose()
      end
      PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD_ASK"), GuildDismiss, MessageBox_Empty_function, nil, nil, false)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_CANT_DISPERSE"))
    end
  else
    local GuildOut = function()
      ToClient_RequestDisjoinGuild()
      PaGlobal_GuildMain_All:prepareClose()
    end
    local tempText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD_ASK") .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_MENTINFO")
    if 0 == guildGrade then
      tempText = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_CLANLIST_CLANOUT_ASK")
    end
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD"), tempText, GuildOut, MessageBox_Empty_function, nil, nil, false)
  end
end
function HandleEventLUp_GuildInfo_All_ChangeGuildMark()
  if true == _ContentsOption_CH_NoCustomGuildMark then
    PaGlobalFunc_GuildChangeMark_All_Open()
    return
  end
  local confirmChange = function()
    guildMarkUpdate(false)
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ADDMARK_MESSAGEBOX_TEXT"), confirmChange, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_GuildInfo_All_IncreaseMember()
  local skillPointInfo = ToClient_getSkillPointInfo(3)
  if skillPointInfo._remainPoint < 2 then
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_NEED_GUILDSKILLPOINT") .. tostring(skillPointInfo._remainPoint) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_POINT_LACK")
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT"), messageContent, nil, nil, MessageBox_Empty_function, nil)
  else
    local IncreaseConfirm = function()
      ToClient_RequestVaryJoinableGuildMemeberCount()
    end
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT_EXECUTE") .. tostring(skillPointInfo._remainPoint)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_MAX_COUNT"),
      content = messageContent,
      functionYes = IncreaseConfirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "top")
  end
end
function HandleEventLUp_GuildInfo_All_IncreaseProtectedMember()
  local skillPointInfo = ToClient_getSkillPointInfo(3)
  if 3 > skillPointInfo._remainPoint then
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_MOREPOINT") .. tostring(skillPointInfo._remainPoint) .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_EXPAND_POINT_LACK")
    PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_TITLE"), messageContent, nil, nil, MessageBox_Empty_function, nil)
  else
    local IncreaseProtectedConfirm = function()
      ToClient_RequestVaryProtectGuildMemeberCount()
    end
    local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_POINT") .. tostring(skillPointInfo._remainPoint)
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_TITLE"),
      content = messageContent,
      functionYes = IncreaseProtectedConfirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, "top")
  end
end
function HandleEventLUp_GuildInfo_All_RequestArsha()
  if false == PaGlobal_GuildInfo_All._contentsOption.isContentsArsha and false == ToClient_IsCanDoReservationArsha() then
    return
  end
  local isHost = ToClient_IsCompetitionHost()
  local messageBoxMemo = ""
  local requestArsha = function()
    ToClient_RequestGetHostByReservationInfo()
  end
  if false == isHost then
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_LENT_ARSHAHOST")
  else
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_RELEASE_ARSHAHOST")
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), messageBoxMemo, requestArsha, MessageBox_Empty_function, nil, nil)
end
function PaGlobalFunc_GuildInfo_All_CheckAdminArsha()
  local isGuildMaster = getSelfPlayer():get():isGuildMaster()
  local isGuildSubMaster = getSelfPlayer():get():isGuildSubMaster()
  local isMasters = true == isGuildSubMaster or true == isGuildMaster
  if true == PaGlobal_GuildInfo_All._contentsOption.isContentsArsha and true == ToClient_IsCanDoReservationArsha() and true == isMasters and _ContentsGroup_Arsha == true then
    return true
  end
  return false
end
function HandleEventLUp_GuildInfo_All_RequestWareHouseOpen()
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if _ContentsGroup_GuildAuthoritySeparation == true then
    if PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_UseGuildWarehouse) == true then
      warehouse_requestGuildWarehouseInfo(false)
    else
      PaGlobalFunc_Guild_Authorization_ShowErrMessage(__eGuildRightNew_UseGuildWarehouse)
    end
  else
    warehouse_requestGuildWarehouseInfo(false)
  end
end
function HandleEventLUp_GuildInfo_All_WarInfoChange(idx)
  if true == PaGlobal_GuildInfo_All._isUsePad then
    TooltipSimple_Hide()
  end
  local spanX = 0
  if 0 == idx then
    spanX = PaGlobal_GuildInfo_All._ui.rdo_Decleared:GetSpanSize().x
    PaGlobal_GuildInfo_All._ui.rdo_Decleared:SetCheck(true)
    PaGlobal_GuildInfo_All._ui.rdo_Recieved:SetCheck(false)
  else
    spanX = PaGlobal_GuildInfo_All._ui.rdo_Recieved:GetSpanSize().x
    PaGlobal_GuildInfo_All._ui.rdo_Decleared:SetCheck(false)
    PaGlobal_GuildInfo_All._ui.rdo_Recieved:SetCheck(true)
  end
  PaGlobal_GuildInfo_All._ui.stc_SelectLine:SetSpanSize(spanX, PaGlobal_GuildInfo_All._ui.stc_SelectLine:GetSpanSize().y)
  PaGlobal_GuildInfo_All._currentTabIdx = idx
  PaGlobal_GuildInfo_All:guildWarListUpdate()
end
function HandleEventPadUp_GuildInfo_All_DeclareWar()
  if true == PaGlobal_GuildInfo_All._ui.rdo_Decleared:IsCheck() then
    HandleEventLUp_GuildInfo_All_WarInfoChange(1)
    if _ContentsGroup_GuildArbitrationQuest == true then
      PaGlobal_GuildMain_All:setKeyguideTextWithShow(true, __eConsoleUIPadEvent_X, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_ARBITRATION_BTN"))
    end
  else
    HandleEventLUp_GuildInfo_All_WarInfoChange(0)
    if _ContentsGroup_GuildArbitrationQuest == true then
      PaGlobal_GuildMain_All:setKeyguideTextWithShow(false, __eConsoleUIPadEvent_X, "")
    end
  end
end
function HandleEventLUp_GuildInfo_All_DeclareWar()
  if nil == Panel_GuildDeclareWar_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isRightGuildWar = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightGuildWar = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_GuildWar)
  else
    isRightGuildWar = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildWar)
  end
  if true == isRightGuildWar then
    PaGlobalFunc_GuildDeclareWar_Open()
  end
end
function HandleEventLUp_GuildInfo_All_StopWar(index)
  if nil == index then
    UI.ASSERT_NAME(false, "HandleEventLUp_GuildInfo_All_StopWar() / index is nil /" .. tostring(index), "-")
    return
  end
  if false == HandleEventLUp_GuildInfo_All_SaveNotice_Console() then
    return
  end
  local function ExecuteStopGuildWar()
    ToClient_RequestStopGuildWar(index)
  end
  local guildWarInfo = ToClient_GetWarringGuildListAt(index)
  local guildExit = guildWarInfo:isExist()
  local guildName = guildWarInfo:getGuildName()
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_STOPGUILDWAR_MSG_DEFAULT")
  if guildExit then
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_STOPGUILDWAR_MSG_GUILDNAME", "guildName", tostring(guildName))
  else
    contentString = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_STOPGUILDWAR_MSG_NOGUILD")
  end
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), contentString, ExecuteStopGuildWar, MessageBox_Empty_function, nil, nil, false)
end
function HandleEventLUp_GuildInfo_All_SaveNotice_Console()
  if false == PaGlobal_GuildInfo_All._isUsePad then
    return true
  end
  if true == PaGlobal_GuildInfo_All._ui.edit_Notice:GetFocusEdit() and true == PaGlobal_GuildInfo_All._isUsePad then
    HandleEventLUp_GuildInfo_All_SaveNoticeText()
    return false
  end
end
function HandleEventLUp_GuildInfo_All_SetFocusEdit()
  local isRightNotice = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightNotice = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Notice)
  else
    isRightNotice = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_Notice)
  end
  if false == isRightNotice then
    return
  end
  SetFocusEdit(PaGlobal_GuildInfo_All._ui.edit_Notice)
  if true == PaGlobal_GuildInfo_All._isUsePad then
    TooltipSimple_Hide()
    local keyguide = {
      PaGlobal_GuildMain_All._ui.stc_Keyguide_Y,
      PaGlobal_GuildMain_All._ui.stc_Keyguide_A,
      PaGlobal_GuildMain_All._ui.stc_Keyguide_B
    }
    PaGlobal_GuildMain_All._ui.stc_Keyguide_A:SetShow(true)
    PaGlobal_GuildMain_All._ui.stc_Keyguide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, PaGlobal_GuildMain_All._ui.stc_Keyguide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function HandleEventLUp_GuildInfo_All_ClearFocusEdit()
  ClearFocusEdit()
  CheckChattingInput()
end
function PaGlobalFunc_GuildInfo_All_EndVirtualKeyboard(str)
  ClearFocusEdit()
  PaGlobal_GuildInfo_All._ui.edit_Notice:SetEditText(str, true)
  HandleEventLUp_GuildInfo_All_SaveNoticeText()
end
function HandleEventLUp_GuildInfo_All_SaveNoticeText()
  local isRightNotice = false
  if _ContentsGroup_GuildAuthoritySeparation == true then
    isRightNotice = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_Notice)
  else
    isRightNotice = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_Notice)
  end
  if false == isRightNotice then
    return
  end
  if true == PaGlobal_GuildInfo_All._ui.edit_Notice:GetFocusEdit() then
    ToClient_RequestSetGuildNotice(PaGlobal_GuildInfo_All._ui.edit_Notice:GetEditText())
    HandleEventLUp_GuildInfo_All_ClearFocusEdit()
  end
  if true == PaGlobal_GuildInfo_All._isUsePad then
    ClearFocusEdit()
    ToClient_RequestSetGuildNotice(PaGlobal_GuildInfo_All._ui.edit_Notice:GetEditText())
    PaGlobal_GuildMain_All._ui.stc_Keyguide_A:SetShow(false)
    local keyguide = {
      PaGlobal_GuildMain_All._ui.stc_Keyguide_Y,
      PaGlobal_GuildMain_All._ui.stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, PaGlobal_GuildMain_All._ui.stc_Keyguide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
end
function HandleEventLUp_GuildInfo_All_OpenIntroduce()
  if nil == Panel_GuildIntroduce_All then
    return
  end
  PaGlobalFunc_GuildIntroduce_Open()
end
function HandleEventLUp_GuildInfo_All_GuildMasterMandateConfirmMSG()
  if ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_GuildBossField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  local msgBox_Content = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMASTER_GET_MSG_DESC")
  PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMASTER_GET_MSG_TITLE"), msgBox_Content, HandleEventLUp_GuildInfo_All_GuildMasterMandate, MessageBox_Empty_function, nil, nil, false)
end
function HandleEventLUp_GuildInfo_All_GuildMasterMandate()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  local memberCount = myGuildListInfo:getMemberCount()
  local myIndex
  for ii = 1, memberCount do
    local memberInfo = myGuildListInfo:getMember(ii - 1)
    if true == memberInfo:isSelf() then
      myIndex = ii
      break
    end
  end
  if not ToClient_IsAbleChangeMaster() or nil == myIndex then
    return
  end
  ToClient_RequestChangeGuildMaster(myIndex)
  PaGlobal_GuildInfo_All:update()
end
function HandleEventLUp_GuildInfo_All_TaxPayment()
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local businessFunds_s64 = myGuildInfo:getGuildBusinessFunds_s64()
  local taxValue = myGuildInfo:getAccumulateTax()
  local costValue = myGuildInfo:getAccumulateGuildHouseCost()
  local Confirm_DoTaxPayMent = function()
    ToClient_PayComporateTax()
  end
  local Confirm_DoGuildHouseCost = function()
    ToClient_PayGuildHouseCost()
  end
  local isCantPayment = false
  if taxValue > toInt64(0, 0) then
    if businessFunds_s64 >= taxValue then
      local msgBox_Content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDLAWTAX_ASK", "taxValue", makeDotMoney(taxValue))
      PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_GUILDLAWTAX"), msgBox_Content, Confirm_DoTaxPayMent, MessageBox_Empty_function, nil, nil)
    else
      isCantPayment = true
    end
  elseif costValue > toInt64(0, 0) then
    if businessFunds_s64 >= costValue then
      local msgBox_Content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS_PAY_ASK", "taxValue", makeDotMoney(costValue))
      PaGlobal_GuildMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_HOUSECOSTS_PAY"), msgBox_Content, Confirm_DoGuildHouseCost, MessageBox_Empty_function, nil, nil)
    else
      isCantPayment = true
    end
  end
  if isCantPayment == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOTENOUGH_GUILDFUNDS"))
    return
  end
end
function HandleEventLUp_GuildInfo_All_OpenGuildServerSet()
  if nil ~= PaGlobalFunc_GuildMainServerSet_Open then
    PaGlobalFunc_GuildMainServerSet_Open()
  end
end
function PaGlobalFunc_GuildInfo_All_SetShowGuildServerTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_GuildInfo_All._ui.stc_GuildServer
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  local title = PaGlobal_GuildInfo_All._ui.txt_GuildServerName:GetText()
  local desc
  TooltipSimple_Show(control, title, desc)
end
function HandleEventLUp_GuildInfo_All_ShowGuildMansionTeleportMessageBox()
  if Panel_GuildInfo_All == nil then
    return
  end
  PaGlobal_GuildInfo_All:showGuildMansionTeleportMessageBox()
end
function HandleEventLUp_GuildInfo_All_OpenSelectGuildMansion()
  if nil ~= PaGlobalFunc_Guild_SelectGuildMansion_All_Open then
    PaGlobalFunc_Guild_SelectGuildMansion_All_Open()
  end
end
function PaGlobalFunc_GuildInfo_All_SetShowGuildMansionTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_GuildInfo_All._ui.stc_GuildMansion
  if nil == control then
    TooltipSimple_Hide()
    return
  end
  local title = PaGlobal_GuildInfo_All._ui.txt_GuildMansionName:GetText()
  local desc
  TooltipSimple_Show(control, title, desc)
end
function HandleEventOnOut_GuildInfo_All_ShowUnpaidTooltip(isShow)
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    UI.ASSERT_NAME(false, "ToClient_GetguildWrapperWrapper is nil", "-")
    TooltipSimple_Hide()
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  control = PaGlobal_GuildInfo_All._ui.btn_TaxPayment
  if toInt64(0, 0) < guildWrapper:getAccumulateTax() then
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX", "getAccumulateTax", tostring(guildWrapper:getAccumulateTax()))
  elseif toInt64(0, 0) < guildWrapper:getAccumulateGuildHouseCost() then
    name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_GUILD_UNPAIDTAX_HOUSE", "getAccumulateGuildHouseCost", tostring(guildWrapper:getAccumulateGuildHouseCost()))
  else
    UI.ASSERT_NAME(false, "\235\175\184\235\130\169\234\184\136\236\157\180 \236\151\134\235\138\148\235\141\176 \235\133\184\236\182\156\235\144\152\234\179\160\236\158\136\235\139\164!?", "-")
    TooltipSimple_Hide()
    return
  end
  if nil == control then
    UI.ASSERT_NAME(false, "Tooltop Control is nil / type = " .. tostring(tipType), "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleClickedOpenSiegeGate()
  ToClient_RequestOpenSiegeGate()
end
function HandleEventOnOut_GuildInfo_All_ShowSimpleTooltip(isShow, tipType)
  if false == isShow or nil == tipType then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control, icon = nil, nil, nil, false
  if 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMASTER_MANDATE_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_GetMaster
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMARK_BTN_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDMARK_BTN_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_MarkChange
  elseif 3 == tipType then
    local isRightDismiss = false
    if _ContentsGroup_GuildAuthoritySeparation == true then
      isRightDismiss = getSelfPlayer():get():isGuildMaster()
    else
      isRightDismiss = PaGlobalFunc_GuildInfo_All_RightCheck(__eGuildRightType_GuildDestroy)
    end
    if true == isRightDismiss then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_DISPERSE_GUILD")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDEL_BTN_TOOLTIP_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WITHDRAW_GUILD")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_GUILDDEL_BTN_TOOLTIP_DESC2")
    end
    control = PaGlobal_GuildInfo_All._ui.btn_Dismiss
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GUILDNAME")
    control = PaGlobal_GuildInfo_All._ui.txt_Name
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GUILDNICKNAME")
    control = PaGlobal_GuildInfo_All._ui.txt_MasterName
  elseif 6 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_WEBINFO")
    control = PaGlobal_GuildInfo_All._ui.btn_InfoWeb
  elseif 7 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_WAREHOUSE")
    control = PaGlobal_GuildInfo_All._ui.btn_WareHouse
  elseif 8 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIMPLETOOLTIP_GETARSHAHOST")
    control = PaGlobal_GuildInfo_All._ui.btn_Arsha
  elseif 9 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_LIST_NOTICE_TITLE")
    control = PaGlobal_GuildInfo_All._ui.stc_Notice_Title
  elseif 10 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINFO_TOOLTIPTITLE")
    control = PaGlobal_GuildInfo_All._ui.btn_SaveNotice
  elseif 11 == tipType then
  elseif 12 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TEXT_WARHELP")
    control = PaGlobal_GuildInfo_All._ui.stc_QuestionWar
  elseif 13 == tipType then
    local isGuildMaster = PaGlobal_GuildInfo_All._selfPlayer:get():isGuildMaster()
    local isGuildSubMaster = PaGlobal_GuildInfo_All._selfPlayer:get():isGuildSubMaster()
    if false == (true == isGuildSubMaster or true == isGuildMaster) then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INTRODUCETITLE")
    else
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDINTRODUCEREGIST_TITLE")
    end
    control = PaGlobal_GuildInfo_All._ui.btn_Introduce
  elseif 14 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_GET_VACATION_BUTTON_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_GET_VACATION_BUTTON_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_Vaction
  elseif 15 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_RELEASE_VACATION_BUTTON_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_GUILD_RELEASE_VACATION_BUTTON_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_VactionReturn
  elseif 16 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_HELP_WARINFO")
    control = PaGlobal_GuildInfo_All._ui.btn_GradeUp
  elseif 17 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_BUTTON_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDJOINREQUEST_BUTTON_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_Recruit
  elseif 18 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_HELP_PROTECTADD")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_PROTECTADD_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_IncreaseProtectedCount
  elseif 19 == tipType then
    name = PaGlobal_GuildInfo_All._ui.txt_Vehicle:GetText()
    control = PaGlobal_GuildInfo_All._ui.txt_Vehicle
  elseif 21 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDPEARLSHOP_TITLE")
    control = PaGlobal_GuildInfo_All._ui.btn_giveaway
  elseif 22 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MININGREWARD_TITLE")
    control = PaGlobal_GuildInfo_All._ui.btn_giveaway
  elseif 23 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ITEMSHARE_TITLE")
    control = PaGlobal_GuildInfo_All._ui.btn_ItemShare
  elseif 24 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYLIST_TITLE")
    control = PaGlobal_GuildInfo_All._ui.btn_GuildParty
  elseif 25 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDNAME_COLOR_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDNAME_COLOR_TOOLTIP_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_GuildColor
  elseif 26 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIEGECHANCE_NAME")
    if _ContentsGroup_Siege2024 == true then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIEGECHANCE_DESC_2024")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_SIEGECHANCE_DESC")
    end
    control = PaGlobal_GuildInfo_All._ui.btn_MinorSiegeJoinable
  elseif 27 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_LIST_BTN_WELFARE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ALL_GUILDFUNDS_DESC_TOOLTIP")
    control = PaGlobal_GuildInfo_All._ui.btn_GuildLifeFund
  elseif 28 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMEMBER_REFRESHBTN_TOOLTIPNAME")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDMEMBER_REFRESHBTN_TOOLTIPDESC", "min", 5)
    control = PaGlobal_GuildInfo_All._ui.btn_GuildLifeFund
  elseif 29 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDINFO_VEHICLEGETMETHOD_TITLE")
    desc = ""
    control = PaGlobal_GuildInfo_All._ui.stc_VehicleHelp
  elseif 30 == tipType then
    local dropRateTargetString
    if ToClient_IsAppliedDropRateBuffSiege2024() == true then
      local isEraseComma = true
      local addedDropTargetString = ""
      local currentApplyGroupBuffCount = ToClient_GetAppliedDropRateBuffCountSiege2024()
      for index = 0, currentApplyGroupBuffCount - 1 do
        local applyBuffGroupName = ""
        local applyBuffGroup = ToClient_GetAppliedDropRateBuffTerritoryGroupNoSiege2024(index)
        if applyBuffGroup == 0 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_0")
        elseif applyBuffGroup == 1 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_1")
        elseif applyBuffGroup == 2 then
          applyBuffGroupName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_2")
        else
          UI.ASSERT_NAME(false, "SiegeTerritoryGroupNo \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128 \235\144\152\236\151\136\236\156\188\235\169\180 \236\151\172\234\184\176\235\143\132 \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148!", "\236\157\180\236\163\188")
        end
        if applyBuffGroupName ~= "" then
          if isEraseComma == true then
            isEraseComma = false
            addedDropTargetString = addedDropTargetString .. applyBuffGroupName
          else
            addedDropTargetString = addedDropTargetString .. ", " .. applyBuffGroupName
          end
        end
      end
      if addedDropTargetString ~= "" then
        dropRateTargetString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_FORM", "name", addedDropTargetString)
      else
        dropRateTargetString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_NONE")
        UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\157\180\235\139\164!", "\236\157\180\236\163\188")
      end
    else
      dropRateTargetString = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORY_OPTION_GROUPNAME_NONE")
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILDINFO_DROPRATE_TOOLTIP_TITLE")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDINFO_DROPRATE_TOOLTIP_DESC", "target", dropRateTargetString)
    control = PaGlobal_GuildInfo_All._ui.btn_DropRate
  elseif 31 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYSIEGECHANCE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYSIEGECHANCE_DESC")
    control = PaGlobal_GuildInfo_All._ui.btn_MajorSiegeJoinable
  end
  if nil == control then
    UI.ASSERT_NAME(false, "Tooltop Control is nil / type = " .. tostring(tipType), "-")
    return
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_GuildInfo_All_List2Tooltip(isShow, index, tipType)
  if false == isShow or nil == index or nil == tipType or nil == PaGlobal_GuildInfo_All._guildlistTable then
    TooltipSimple_Hide()
    return
  end
  if nil == PaGlobal_GuildInfo_All._guildlistTable[index] then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if 0 == tipType then
    if nil == PaGlobal_GuildInfo_All._guildlistTable[index]._btn_Add then
      return
    end
    name = PAGetString(Defines.StringSheet_RESOURCE, "GUILD_BTN_LETSWAR")
    control = PaGlobal_GuildInfo_All._guildlistTable[index]._btn_Add
  elseif 1 == tipType then
    if nil == PaGlobal_GuildInfo_All._guildlistTable[index]._btn_Cancel then
      return
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_WARSTOP")
    control = PaGlobal_GuildInfo_All._guildlistTable[index]._btn_Cancel
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_GuildInfo_All_OwnedAreaTooltip(isShow, isSiege)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if false == isSiege then
    local guildArea1 = ""
    local territoryKey = ""
    local territoryWarName = ""
    local myGuildAllianceCache = ToClient_GetMyGuildAlliancChairGuild()
    if nil == myGuildAllianceCache then
      return
    end
    if 0 < myGuildAllianceCache:getTerritoryCount() then
      for idx = 0, myGuildAllianceCache:getTerritoryCount() - 1 do
        territoryKey = myGuildAllianceCache:getTerritoryKeyAt(idx)
        if territoryKey >= 0 then
          local territoryInfoWrapper = getTerritoryInfoWrapperByIndex(territoryKey)
          if nil ~= territoryInfoWrapper then
            if 2 == territoryKey then
              desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYBENEFIT_1")
            end
            if 3 == territoryKey then
              if nil == desc then
                desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYBENEFIT_2")
              else
                desc = desc .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYBENEFIT_3")
              end
            end
            if 4 == territoryKey then
              if nil == desc then
                desc = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYBENEFIT_4")
              else
                desc = desc .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_TERRITORYBENEFIT_5")
              end
            end
          end
        end
      end
    end
  end
  name = PaGlobal_GuildInfo_All._ui.txt_OwnedArea:GetText()
  control = PaGlobal_GuildInfo_All._ui.txt_OwnedArea
  if nil == control then
    UI.ASSERT_NAME(false, "Tooltop Control is nil / territoryIdx = " .. tostring(territoryIdx), "-")
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_GuildInfo_All_CheckUiEdit(targetUI)
  if false == PaGlobalFunc_GuildMain_All_GetBgShow(PaGlobal_GuildMain_All._eTABINDEX._BASIC) then
    return false
  end
  return nil ~= targetUI and targetUI:GetKey() == PaGlobal_GuildInfo_All._ui.edit_Notice:GetKey()
end
function PaGlobalFunc_GuildInfo_All_OpenGuildInfoWeb()
  if nil ~= Panel_GuildWebInfo_All then
    PaGlobalFunc_GuildWebInfo_All_GuildMainOpen()
  end
end
function HandleEventLUp_GuildInfo_All_RequestGuildWelfare()
  local IncreaseConfirm = function()
    ToClient_RequestGuildWelfare()
  end
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_ALL_GUILDFUNDS_DESC_TOOLTIP")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "FRAME_GUILD_LIST_BTN_WELFARE"),
    content = messageContent,
    functionYes = IncreaseConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "top")
end
function HandleEventLUp_GuildInfo_All_RequestItemShareWareHouse()
  if false == _ContentsGroup_GuildShareItemWareHouse then
    return
  end
  if true == _ContentsGroup_GuildItemRentLiveSpec then
    warehouse_requestGuildWareRental()
  else
    warehouse_requestGuildWarehouseInfo(true)
  end
end
function HandleEventLUp_GuildInfo_All_OpenSetGuildColorPanel()
  PaGlobalFunc_GuildWarColor_All_Open()
end
function HandleEventLUp_GuildInfo_All_OpenArbitration(warringGuildIndex)
  PaGlobalFunc_Guild_Arbitration_Open(warringGuildIndex)
end
function HandleEventLUp_GuildInfo_All_HelpWikiOpen()
  Panel_WebHelper_ShowToggle("GuildVehicle")
end
function FromClient_ChangeUserNicknameDirectly_GuildInfo()
  local self = PaGlobal_GuildInfo_All
  if self == nil then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if guildWrapper == nil then
    return
  end
  self._ui.txt_MasterName:SetText(guildWrapper:getGuildMasterName())
end
