function HandleEventOnOut_Window_Stat_All_Show(isShow)
  if nil == Panel_Window_Stat_All then
    return
  end
  if ToClient_isPlayingSequence() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    return
  end
  if true == isShow then
    if true == Panel_Window_Stat_All:GetShow() then
      PaGlobal_Window_Stat_All:prepareClose()
    else
      PaGlobal_Window_Stat_All:prepareOpen()
    end
  else
    PaGlobal_Window_Stat_All:prepareClose()
  end
end
function PaGlobal_Window_Stat_All_prepareOpen()
  if nil == Panel_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All:prepareOpen()
end
function PaGlobal_Window_Stat_All_prepareClose()
  if nil == Panel_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All:prepareClose()
end
function PaGlobal_Window_Stat_All_Update()
  if false == _ContentsGroup_NewCharacterStatInfo then
    return
  end
  if nil == Panel_Window_Stat_All or nil == PaGlobal_Window_Stat_All then
    return
  end
  PaGlobal_Window_Stat_All:update(true)
end
function PaGlobal_Window_Stat_All_NotCheck_Update()
  if _ContentsGroup_NewCharacterStatInfo == false then
    return
  end
  if Panel_Window_Stat_All == nil or PaGlobal_Window_Stat_All == nil then
    return
  end
  PaGlobal_Window_Stat_All:update(false)
end
function PaGlobal_Window_Stat_All_GetTotalStat(index)
  if false == _ContentsGroup_NewCharacterStatInfo then
    return
  end
  if nil == Panel_Window_Stat_All or nil == PaGlobal_Window_Stat_All then
    return
  end
  return PaGlobal_Window_Stat_All:getTotalStat(index)
end
function SetShowShowNewStatInfo(isShow)
  if false == ToClient_SelfPlayerIsGM() then
    return
  end
  _ContentsGroup_NewCharacterStatInfo = isShow
end
registerEvent("FromClient_UpdatePlayerStatNew", "PaGlobal_Window_Stat_All_Update")
registerEvent("FromClient_UpdateTolerance", "PaGlobal_Window_Stat_All_Update")
