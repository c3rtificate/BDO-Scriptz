function PaGlobalFunc_Artifacts_List_All_Open()
  PaGlobal_Artifacts_List_All:prepareOpen()
end
function PaGlobalFunc_Artifacts_List_All_Close()
  PaGlobal_Artifacts_List_All:prepareClose()
end
function PaGlobalFunc_Artifacts_List_All_ToggleShow()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  if true == Panel_Window_Artifacts_List_All:GetShow() then
    PaGlobalFunc_Artifacts_List_All_Close()
  else
    PaGlobalFunc_Artifacts_List_All_Open()
  end
end
function HandleEventScroll_Artifacts_List_All_Scroll(isUp)
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  if false == Panel_Window_Artifacts_List_All:GetShow() then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  local memberCount = guildWrapper:getMemberCount()
  UIScroll.ScrollEvent(PaGlobal_Artifacts_List_All._ui.frame_vscroll, isUp, PaGlobal_Artifacts_List_All._listCount, PaGlobal_Artifacts_List_All._listCount, 0, 1)
  PaGlobal_Artifacts_List_All:update()
end
function HandleEventLUp_Artifacts_List_All_SelectSearchText()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  PaGlobal_Artifacts_List_All:selectSearchText()
end
function HandleEventKeyBoard_Artifacts_List_All_SearchLightStoneSet()
  if nil == Panel_Window_Artifacts_List_All then
    return
  end
  PaGlobal_Artifacts_List_All:searchLightStoneSet()
end
function HandleEventLUp_ContentsName_updateAppleList()
  if nil == Panel_ContentsName then
    return
  end
end
function FromClient_ContentsName_updateAppleList(param1)
  if nil == Panel_ContentsName then
    return
  end
end
function PaGloabl_ContentsName_ShowAni()
  if nil == Panel_ContentsName then
    return
  end
end
function PaGloabl_ContentsName_HideAni()
  if nil == Panel_ContentsName then
    return
  end
end
registerEvent("FromClient_AppleDataUpdate", "FromClient_ContentsName_updateAppleList")
