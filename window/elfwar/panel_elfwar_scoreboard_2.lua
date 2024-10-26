function PaGlobalFunc_ElfWarScoreBoard_Open()
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  self:prepareOpen()
  PaGlobal_ElfWarMiniMap._ui._chk_toggleScoreBoard:SetCheck(true)
end
function PaGlobalFunc_ElfWarScoreBoard_Close()
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobal_ElfWarMiniMap._ui._chk_toggleScoreBoard:SetCheck(false)
end
function PaGlobalFunc_ElfWarScoreBoard_IsShow()
  local panel = Panel_ElfWar_ScoreBoard
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_ElfWarScoreBoard_OnCreateListContent(content, key)
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil or content == nil or key == nil then
    return
  end
  self:createRecoardContent(content, key)
end
function HandleEventLUp_ElfWarScoreBoard_OnClickedTab(tabType)
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  self:changeTab(tabType)
end
function HandleEventLUp_ElfWarScoreBoard_OnClickedReload()
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  self:changeTab(self._lastSelectedTabType)
end
function HandleEventLUp_ElfWarScoreBoard_OnClickedSort(sortOption)
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  ToClient_SortElfWarMemberData(selfPlayer:getElfWarTeamNo(), sortOption)
end
function FromClient_ElfWarScoreBoard_SortResult(sortOption, isAscending)
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarScoreBoard_IsShow() == false then
    return
  end
  local addString = ""
  if isAscending == true then
    addString = "\226\150\188"
  else
    addString = "\226\150\178"
  end
  self:resetRecordTitleText()
  if sortOption == __eElfWarMemberDataSortOption_UserNickName then
    self._ui._stc_name:SetText(self._ui._stc_name:GetText() .. addString)
  elseif sortOption == __eElfWarMemberDataSortOption_GradeType then
    self._ui._stc_rank:SetText(self._ui._stc_rank:GetText() .. addString)
  elseif sortOption == __eElfWarMemberDataSortOption_Kill then
    self._ui._stc_kill:SetText(self._ui._stc_kill:GetText() .. addString)
  elseif sortOption == __eElfWarMemberDataSortOption_Death then
    self._ui._stc_death:SetText(self._ui._stc_death:GetText() .. addString)
  else
    UI.ASSERT_NAME(false, "SortType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self:changeTab(self._lastSelectedTabType)
end
function FromClient_ElfWarScoreBoard_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarScoreBoard
  if self == nil then
    return
  end
  if state == __eElfWar_Stop and PaGlobalFunc_ElfWarScoreBoard_IsShow() == true then
    PaGlobalFunc_ElfWarScoreBoard_Close()
  end
end
