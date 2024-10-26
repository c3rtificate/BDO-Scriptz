function PaGlobalFunc_ElfWarNakWarLog_Open()
  local self = PaGlobal_ElfWar_NakWarLog
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ElfWarNakWarLog_Close()
  local self = PaGlobal_ElfWar_NakWarLog
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarNakWarLog_IsShow()
  if Panel_ElfWar_Nak_WarLog == nil then
    return false
  end
  return Panel_ElfWar_Nak_WarLog:GetShow()
end
function FromClient_ElfWarNakWarLog_ChangeElfWarState(state)
  local self = PaGlobal_ElfWar_NakWarLog
  if self == nil or state == nil then
    return
  end
  if state == __eElfWar_Start then
    PaGlobalFunc_ElfWarNakWarLog_Open()
  else
    PaGlobalFunc_ElfWarNakWarLog_Close()
  end
end
