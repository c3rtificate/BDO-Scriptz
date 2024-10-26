function PaGlobalElfWarTeamBuff_Open()
  local self = PaGlobal_ElfWarTeamBuff
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalElfWarTeamBuff_UpdateBuffDataList()
  local self = PaGlobal_ElfWarTeamBuff
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  self:makeBuffDataList()
  self:updateBuffIcon()
end
