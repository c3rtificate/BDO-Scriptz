function PaGlobalFunc_ElfWarNakWarLog_L_Open()
  local self = PaGlobal_ElfWar_NakWarLog_L
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ElfWarNakWarLog_L_Close()
  local self = PaGlobal_ElfWar_NakWarLog_L
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarNakWarLog_L_IsShow()
  if Panel_ElfWar_Nak_WarLog_L == nil then
    return false
  end
  return Panel_ElfWar_Nak_WarLog_L:GetShow()
end
function FromClient_ElfWarNakWarLog_L_ChangeElfWarState(state)
  local self = Panel_ElfWar_Nak_WarLog_L
  if self == nil or state == nil then
    return
  end
  if state == __eElfWar_Start then
    PaGlobalFunc_ElfWarNakWarLog_L_Open()
  else
    PaGlobalFunc_ElfWarNakWarLog_L_Close()
  end
end
function PaGlobalFunc_ElfWarNakWarLog_L_PushData(eventType, teamNo, param1, param2)
  if Panel_ElfWar_Nak_WarLog_L == nil then
    return false
  end
  local logInfo = {
    _type = eventType,
    _teamNo = teamNo,
    _param1 = param1,
    _param2 = param2
  }
  table.insert(PaGlobal_ElfWar_NakWarLog_L._logInfoList, logInfo)
end
