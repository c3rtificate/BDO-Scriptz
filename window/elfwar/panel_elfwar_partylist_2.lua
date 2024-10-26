function PaGlobalFunc_ElfWarPartyList_Open()
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_ElfWarPartyList_Close()
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarPartyList_IsShow()
  if Panel_ElfWar_PartyList == nil then
    return false
  end
  return Panel_ElfWar_PartyList:GetShow()
end
function HandleEventLUp_ElfWarPartyList_ShowMinify()
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  self:updateSlot()
end
function HandleEventLUp_ElfWarPartyList_SelectCommander(index)
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  self:selectCommanderIndex(index)
end
function HandleEventLUp_ElfWarPartyList_Appoint()
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  self:selectCommander()
end
function HandleEventLUp_ElfWarPartyList_ShowFamilyName()
  local self = PaGlobal_ElfWarPartyList
  if self == nil then
    return
  end
  self:updateSlot()
end
function FromClient_ElfWarPartyList_ChangeElfWarCommander()
  PaGlobalFunc_ElfWarPartyList_Close()
end
