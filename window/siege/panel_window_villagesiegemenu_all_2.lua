function PaGlobalFunc_VillageSiegeMenu_Open()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_VillageSiegeMenu_Close()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancel(groupType)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local currentGroupNo = ToClient_GetParicipateGroupNoVillageSiege2024()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyVillageSiege2024()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw == ToClient_GetNotMatchedTerritoryKeyVillageSiege2024()
  if isParticipated == true then
    ToClient_RequestCancelParicipateVillageSiege2024(groupType)
  else
    ToClient_RequestParicipateVillageSiege2024(groupType)
  end
end
function HandleEventOnOut_VillageSiegeMenu_ApplyOrCancel(isOn, groupType, territoryKeyRaw)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local territoryParticipationData = self:getTerritoryParticipationData(groupType)
  if territoryParticipationData == nil then
    return
  end
  if isOn == true then
    self:changeTexture(territoryParticipationData._control, "Combine_Etc_StrongholdWar_CampBG_Select", 0)
    self:showFocusGroup(groupType, territoryKeyRaw)
  else
    self:changeTexture(territoryParticipationData._control, "Combine_Etc_StrongholdWar_CampBG_Normal", 0)
    self:showFocusGroup(nil, territoryKeyRaw)
  end
end
function HandleEventLUp_VillageSiegeMenu_ApplyOrCancelForDevXXXXX(groupType, territoryKeyRaw)
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  local function do_join()
    ToClient_RequestParicipateVillageSiege2024ForQA(groupType, territoryKeyRaw)
  end
  local function do_unjoin()
    ToClient_RequestCancelParicipateVillageSiege2024ForQA(groupType, territoryKeyRaw)
  end
  local descString = ""
  local functionYes
  local currentGroupNo = ToClient_GetParicipateGroupNoVillageSiege2024()
  local currentTerritoryRaw = ToClient_GetParicipateTerritoryKeyVillageSiege2024()
  local isParticipated = currentGroupNo >= 0 and currentTerritoryRaw >= 0
  if isParticipated == true then
    descString = "[DEV] \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\139\160\236\178\173 \236\183\168\236\134\140 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_unjoin
  else
    descString = "[DEV] \236\132\160\237\131\157\237\149\156 \236\152\129\236\167\128\235\161\156 \236\176\184\236\151\172 \236\139\160\236\178\173 \237\149\152\236\139\156\234\178\160\236\138\181\235\139\136\234\185\140?"
    functionYes = do_join
  end
  messageboxData = {
    title = "[DEV] \234\176\156\235\176\156\236\154\169 \234\184\176\235\138\165",
    content = descString,
    functionYes = functionYes,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_VillageSiegeMenu_StartSiegeForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_StartSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_StopSiegeForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_StopSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ResetApplyCountForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ResetApplyCountSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ResetApplyCountAllForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ResetApplyCountAllSiege2024ForQA()
end
function HandleEventLUp_VillageSiegeMenu_ChangeSiegeApplyNeedCountForQA()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false and isRealServiceMode() == true then
    return
  end
  ToClient_ChangeSiegeApplyNeedCountSiege2024ForQA()
end
function FromClient_UpdateVillageSiegeMenuUI()
  local self = PaGlobal_VillageSiegeMenu
  if self == nil then
    return
  end
  if Panel_Window_VillageSiegeMenu_All:GetShow() == false then
    return
  end
  if self._currentTabType == self._eTabType.APPLY then
    self:refreshApplyScene()
  elseif self._currentTabType == self._eTabType.APPLY_LIST then
    self:refreshApplyListScene()
  else
    return
  end
end
