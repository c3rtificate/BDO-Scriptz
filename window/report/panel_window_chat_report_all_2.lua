function HandleEventLUp_RequestReportChat()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if PaGlobal_Window_Chat_Report_All._selectedReportType == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASH_CUSTOMIZATION_NOSELECT"))
    return
  end
  ToClient_RequestReportChatByChatSubMenu(PaGlobal_Window_Chat_Report_All._senderUserNo, PaGlobal_Window_Chat_Report_All._clickedMsg, PaGlobal_Window_Chat_Report_All._ui._edit_reportWrite_multilineEdit:GetEditText(), PaGlobal_Window_Chat_Report_All._chattingTime, PaGlobal_Window_Chat_Report_All._chatType, PaGlobal_Window_Chat_Report_All._selectedReportType, PaGlobal_Window_Chat_Report_All._clickedUserNickName, PaGlobal_Window_Chat_Report_All._clickedUserId, PaGlobal_Window_Chat_Report_All._clickedName)
  PaGlobal_Window_Chat_Report_All_Close()
end
function HandleEventKey_Chat_Report_OnVirtualKeyboardEnd(str)
  if PaGlobal_Window_Chat_Report_All._MAX_REPORTDESCRIPTION_COUNT < getWstringLength(str) then
    PaGlobal_Window_Chat_Report_All._ui._edit_reportWrite_multilineEdit:SetEditText(getMaxSliceString(str, PaGlobal_Window_Chat_Report_All._MAX_REPORTDESCRIPTION_COUNT))
  else
    PaGlobal_Window_Chat_Report_All._ui._edit_reportWrite_multilineEdit:SetEditText(str)
  end
  FromClient_Chat_Report_EditBoxChange()
  ClearFocusEdit()
end
function FromClient_Chat_Report_Success()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  local messageBoxData = {
    content = PAGetString(Defines.StringSheet_GAME, "LUA_REPORTCHAT_COMPLETE_REPORT"),
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function FromClient_Chat_Report_Failed(stringKey, leftTime)
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  if stringKey == nil then
    return
  end
  local contentStr = PAGetString(Defines.StringSheet_GAME, stringKey)
  if leftTime ~= nil then
    local time = Uint64toUint32(leftTime)
    if time > 0 then
      contentStr = contentStr .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_REPORTCHAT_COOLTIME", "time", time)
    end
  end
  local messageBoxData = {
    content = contentStr,
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    functionApply = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function FromClient_Chat_Report_EditBoxChange()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  local editTextLength = PaGlobal_Window_Chat_Report_All._ui._edit_reportWrite_multilineEdit:GetEditTextSize()
  PaGlobal_Window_Chat_Report_All._ui._txt_characterCount:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_REPORTCHAT_CHARACTERCOUNT", "current", editTextLength, "max", PaGlobal_Window_Chat_Report_All._MAX_REPORTDESCRIPTION_COUNT))
  if editTextLength == 0 then
    PaGlobal_Window_Chat_Report_All._ui._edit_reportWrite_multilineEdit:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_REPORTCHAT_REPORTMEMO", "stringLength", PaGlobal_Window_Chat_Report_All._MAX_REPORTDESCRIPTION_COUNT))
  end
end
function FromClient_PaGlobal_Window_Chat_Report_Resize()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  Panel_Window_Chat_Report_All:ComputePos()
end
function PaGlobal_Window_Chat_Report_All_Open(clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  PaGlobal_Window_Chat_Report_All:prepareOpen(clickedName, clickedUserNickName, senderUserNo, clickedMsg, chatType, chatSendTime, chatSendServerTime, clickedUserId)
end
function PaGlobal_Window_Chat_Report_All_Close()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  PaGlobal_Window_Chat_Report_All:prepareClose()
end
function PaGloabl_Window_Chat_Report_All_ShowAni()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
end
function PaGloabl_Window_Chat_Report_All_HideAni()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
end
function PaGlobal_Window_Chat_Report_SetFocusTarget()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  ToClient_padSnapSetTargetPanel(Panel_Window_Chat_Report_All)
end
function PaGlobal_Window_Chat_Report_SelectReportType(index)
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  self._selectedReportType = self._reportType[index]
end
function HandleEventLUp_Chat_Report_SetFocusEdit()
  if Panel_Window_Chat_Report_All == nil then
    return
  end
  local self = PaGlobal_Window_Chat_Report_All
  if self == nil then
    return
  end
  SetFocusEdit(self._ui._edit_reportWrite_multilineEdit)
end
