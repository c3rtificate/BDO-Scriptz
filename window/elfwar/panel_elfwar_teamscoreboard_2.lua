function PaGlobalFunc_ElfWarTeamScoreBoard_Open()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  ToClient_RequestOpenElfWarTeamScoreBoardUI()
end
function PaGlobalFunc_ElfWarTeamScoreBoard_Close()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarTeamScoreBoard_IsShow()
  local panel = Panel_ElfWar_TeamScoreBoard
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_ElfWarTeamScoreBoard_OnCreateListContent(content, key)
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil or content == nil or key == nil then
    return
  end
  self:createScoreContent(content, key)
end
function HandleEventLUp_ElfWarTeamScoreBoard_OnClickedTab(tabType)
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTab(tabType)
end
function HandleEventLUp_ElfWarTeamScoreBoard_OnClickedReload()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTab(self._lastSelectedTabType)
end
function HandleEventLUp_ElfWarTeamScoreBoard_OnClickedSort(sortOption)
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  ToClient_SortElfWarMemberData(self._lastSelectedTeamNo, sortOption)
end
function HandleEventLUp_ElfWarTeamScoreBoard_ComboBoxItem()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self:changeTeam(self._ui._cbx_team:GetSelectIndex())
end
function HandleEventLUp_ElfWarTeamScoreBoard_ComboBox()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self._ui._cbx_team:ToggleListbox()
end
function FromClient_ElfWarTeamScoreBoard_OnLoadComplete()
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  self:prepareOpen()
end
function FromClient_ElfWarTeamScoreBoard_SortResult(sortOption, isAscending)
  local self = PaGlobal_ElfWarTeamScoreBoard
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarTeamScoreBoard_IsShow() == false then
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
