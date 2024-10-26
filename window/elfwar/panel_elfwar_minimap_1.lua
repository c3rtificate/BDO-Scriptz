function PaGlobal_ElfWarMiniMap:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._gimmickRespawnTime = ToClient_GetElfWarGimmickFierceBattleObjectRespawnTime()
  self._ui._stc_miniMapNavigationGuideBg = UI.getChildControl(self._ui._stc_miniMapBg, "Static_NavigationGuideBg")
  self._ui._stc_miniMapNavigationGuideBg:SetShowAALineList(false)
  self._ui._stc_miniMapNavigationGuideBg:SetElfWarMiniMapAALineList(true)
  self._ui._stc_miniMapNavigationGuideBg:SetElfWarMiniMapLines(true)
  self._ui._stc_miniMapNavigationGuideBg:SetDepth(self._eRenderOrder.MINIMAP_LINES)
  self._ui._chk_toggleChatting:SetCheck(true)
  self._miniMapActorIconPoolCount = self._eInitPoolCount.ACTOR_ICON
  self._miniMapVehicleIconPoolCount = self._eInitPoolCount.VEHICLE_ICON
  self._miniMapMarkerPoolCount = self._eInitPoolCount.MINIMAP_MARKER
  self._miniMapFierceBattleIconPoolCount = self._eInitPoolCount.MINIMAP_FIERCEBATTLE_OBJECT
  self:makeMiniMap(Defines.ElfWarTeamNo.KAMASYLVIA)
  self:makeMiniMap(Defines.ElfWarTeamNo.ODYLLITA)
  self._miniMapControl = self._miniMapBgTexture_Kamasilvia
  self:makeMiniMapPinData()
  self:makeMiniMapMovePinData()
  self:makeMiniMapDragSelectData()
  self:makeActorIcon()
  self:makeVehicleIcon()
  self:makeMiniMapMarker()
  self:makeMiniMapFierceBattleObject()
  self:makeMiniMapGimmickFierceBattleObject()
  self:makeMiniMapFierceBattleObjectTooltip()
  self:ComputePanelSize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
  FromClient_ElfWarMiniMap_ChangeElfWarState(ToClient_GetElfWarState())
end
function PaGlobal_ElfWarMiniMap:update_always(deltaTime)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if ToClient_IsParticipateInElfWar() == false and ToClient_IsElfWarObserveMode() == false then
    return
  end
  if Panel_ElfWar_MiniMap:GetShow() == true then
    self:update_onlyShow(deltaTime)
  end
end
function PaGlobal_ElfWarMiniMap:update_onlyShow(deltaTime)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  self:updateMiniMapMoveAnimation(deltaTime)
  self:updateMiniMapInputProcess(deltaTime)
  self:requestUpdateMiniMapToServer(deltaTime)
  self:updateMiniMapNavigationGuide()
  self:updateChildIconsMiniMapPosRate()
  self:updateFierceBattleObjectRespawnTime(deltaTime)
  self:updateTooltipProgressUI()
end
function PaGlobal_ElfWarMiniMap:updateChildIconsMiniMapPosRate()
  for index = 0, self._miniMapActorIconPoolCount - 1 do
    local actorIconData = self._miniMapActorIconList[index]
    if actorIconData ~= nil and actorIconData._isSet == true then
      local actorIconDataWrapper = ToClient_GetElfWarMiniMapIconDataWrapperXXX(actorIconData._userNo_s64)
      if actorIconDataWrapper ~= nil then
        local iconDataPtr = actorIconDataWrapper:getXXX()
        if iconDataPtr ~= nil and actorIconData._control:GetShow() == true then
          iconDataPtr._elfWarMinimapPosRate.x = actorIconData._control:GetPosX() + actorIconData._control:GetSizeX() / 2
          iconDataPtr._elfWarMinimapPosRate.y = actorIconData._control:GetPosY() + actorIconData._control:GetSizeY() / 2
        end
      end
    end
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local iconData = self._miniMapFierceBattleIconList[index]
    if iconData ~= nil and iconData._isSet == true then
      local objectInfo = ToClient_GetElfWarFierceBattleObjectInfoWrapper(iconData._fierceBattleKeyRaw)
      if objectInfo ~= nil then
        local object = objectInfo:getXXX()
        if object ~= nil then
          local controlBg = iconData._control
          if controlBg:GetShow() == true then
            object._elfWarMinimapPosRate.x = controlBg:GetPosX() + controlBg:GetSizeX() / 2
            object._elfWarMinimapPosRate.y = controlBg:GetPosY() + controlBg:GetSizeY() / 2
          end
        end
      end
    end
  end
end
function PaGlobal_ElfWarMiniMap:registEventHandler()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  self._ui._stc_miniMapBg:addInputEvent("Mouse_LDown", "ElfWarMiniMap_MouseLDown()")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_RUp", "ElfWarMiniMap_MouseRUp()")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_UpScroll", "ElfWarMiniMap_MouseScroll(true)")
  self._ui._stc_miniMapBg:addInputEvent("Mouse_DownScroll", "ElfWarMiniMap_MouseScroll(false)")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_LUp", "ElfWarMiniMap_MoveMapToSelfPlayer()")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_On", "ElfWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(true)")
  self._ui._btn_moveMapToSelfPlayerPos:addInputEvent("Mouse_Out", "ElfWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(false)")
  registerEvent("onScreenResize", "FromClient_ElfWarMiniMap_OnScreenSize")
  registerEvent("FromClient_ChangeElfWarState", "FromClient_ElfWarMiniMap_ChangeElfWarState")
  registerEvent("FromClient_ElfWarCreateActorIcon", "FromClient_ElfWarCreateActorIcon")
  registerEvent("FromClient_ElfWarRemoveActorIcon", "FromClient_ElfWarRemoveActorIcon")
  registerEvent("FromClient_ElfWarUpdateActorIcon", "FromClient_ElfWarUpdateActorIcon")
  registerEvent("FromClient_ElfWarClearActorIcon", "FromClient_ElfWarClearActorIcon")
  registerEvent("FromClient_ElfWarCreateVehicleIcon", "FromClient_ElfWarCreateVehicleIcon")
  registerEvent("FromClient_ElfWarRemoveVehicleIcon", "FromClient_ElfWarRemoveVehicleIcon")
  registerEvent("FromClient_ElfWarUpdateVehicleIcon", "FromClient_ElfWarUpdateVehicleIcon")
  registerEvent("FromClient_ElfWarClearVehicleIcon", "FromClient_ElfWarClearVehicleIcon")
  registerEvent("FromClient_ElfWarAddSelectActorIcon", "FromClient_ElfWarAddSelectActorIcon")
  registerEvent("FromClient_ElfWarClearSelectActorIcon", "FromClient_ElfWarClearSelectActorIcon")
  registerEvent("FromClient_SetElfWarObserveMode", "FromClient_ElfWarMiniMap_SetElfWarObserveMode")
  registerEvent("FromClient_UnsetElfWarObserveMode", "FromClient_ElfWarMiniMap_UnsetElfWarObserveMode")
  registerEvent("FromClient_ElfWarCreateFierceBattleObjectIcon", "FromClient_ElfWarCreateFierceBattleObjectIcon")
  registerEvent("FromClient_ElfWarClearFierceBattleObjectIcon", "FromClient_ElfWarClearFierceBattleObjectIcon")
  registerEvent("FromClient_UpdateElfWarFierceBattleInfo", "FromClient_UpdateElfWarFierceBattleInfo")
  registerEvent("FromClient_ElfWarUpdateBossInfo", "FromClient_ElfWarUpdateBossInfo")
  registerEvent("FromClient_ResponseElfWarFierceBattleMonsterDead", "FromClient_ResponseElfWarFierceBattleMonsterDead")
  registerEvent("FromClient_ResponseElfWarGimmickFierceBattleObjectAdrenalin", "FromClient_ResponseElfWarGimmickFierceBattleObjectAdrenalin")
  registerEvent("FromClient_ElfWarRemovePing", "FromClient_ElfWarRemovePing")
end
function PaGlobal_ElfWarMiniMap:prepareOpen()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self._miniMapBgTexture_Kamasilvia:SetShow(false)
  self._miniMapBgTexture_Odilita:SetShow(false)
  local teamNo = selfPlayerWrapper:getElfWarTeamNo()
  if ToClient_IsElfWarObserveMode() == true then
    teamNo = ToClient_GetElfObserveTeamNo()
  end
  if teamNo == Defines.ElfWarTeamNo.KAMASYLVIA then
    self._miniMapControl = self._miniMapBgTexture_Kamasilvia
  elseif teamNo == Defines.ElfWarTeamNo.ODYLLITA then
    self._miniMapControl = self._miniMapBgTexture_Odilita
  else
    UI.ASSERT_NAME(false, "ElfWarTeamNo\234\176\128 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._miniMapControl:SetShow(true)
  ToClient_setElfWarFogTextureParentUI(self._miniMapControl)
  if PaGlobalFunc_ElfWarCommand_IsShow() == true then
    PaGlobalFunc_ElfWarCommand_Close()
  end
  if PaGlobalFunc_ElfWarMiniMapPartyList_IsShow() == true then
    PaGlobalFunc_ElfWarMiniMapPartyList_Close()
  end
  if PaGlobalFunc_ElfWarEditParty_IsShow() == true then
    PaGlobalFunc_ElfWarEditParty_Close()
  end
  if PaGlobalFunc_ElfWarMission_IsShow() == true then
    PaGlobalFunc_ElfWarMission_Close()
  end
  if PaGlobalFunc_ElfWarScoreBoard_IsShow() == true then
    PaGlobalFunc_ElfWarScoreBoard_Close()
  end
  if ToClient_IsElfWarObserveMode() == true then
    self._ui._chk_togglePartyList:SetShow(false)
    self._ui._chk_toggleEditParty:SetShow(false)
    self._ui._chk_toggleElfWarMission:SetShow(false)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(false)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(false)
  elseif IsSelfPlayerElfWarGrade_Commander() == true then
    self._ui._chk_togglePartyList:SetShow(true)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleElfWarMission:SetShow(true)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(true)
    self._ui._stc_pingGuide:SetShow(true)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
    local openInfo = {
      _x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX() / 2,
      _y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY(),
      _align = "CB"
    }
    PaGlobalFunc_ElfWarTeamSkill_Open(openInfo)
  elseif IsSelfPlayerElfWarGrade_SubCommander() == true then
    self._ui._chk_togglePartyList:SetShow(true)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleElfWarMission:SetShow(true)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
  else
    self._ui._chk_togglePartyList:SetShow(false)
    self._ui._chk_toggleEditParty:SetShow(true)
    self._ui._chk_toggleElfWarMission:SetShow(false)
    self._ui._chk_toggleChatting:SetShow(true)
    self._ui._chk_toggleScoreBoard:SetShow(true)
    self._ui._stc_naviGuide:SetShow(true)
    self._ui._stc_dragGuide:SetShow(false)
    self._ui._stc_pingGuide:SetShow(false)
    self._ui._btn_moveMapToSelfPlayerPos:SetShow(true)
  end
  self._closeFlag_m = false
  self:refreshMiniMap(self._currentMiniMapRate, true)
  self._accumulatedDeltaTime = self._updateCycleTime
  PaGlobalElfWarTeamBuff_Open()
  PaGlobalFunc_ElfWarMiniMap_ToggleChattingUI(false)
  ToClient_SetUseAlphaForAALine(false)
  self:ComputePanelSize()
  ToClient_RequestElfWarFierceBattleObjectInfo()
  ToClient_RequestElfWarBossInfotList()
  self:gimmickFierceBattleComputeProgressValue()
  self:open()
  self:initMiniMapPinPos()
end
function PaGlobal_ElfWarMiniMap:open()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  Panel_ElfWar_MiniMap:SetShow(true)
end
function PaGlobal_ElfWarMiniMap:prepareClose()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if IsSelfPlayerElfWarGrade_SubCommander() == true then
    PaGlobalFunc_ElfWarCommand_Open(__eElfWarPlayerGradeType_SubCommander)
  end
  ToClient_SetUseAlphaForAALine(true)
  PaGlobalFunc_ElfWarTeamSkill_Close()
  PaGlobalFunc_ElfWarMiniMap_ToggleChattingUI(true)
  TooltipSimple_Hide()
  self._miniMapDragSelectData._beginWorldPos = float3(0, 0, 0)
  self._miniMapDragSelectData._endWorldPos = float3(0, 0, 0)
  self._miniMapDragSelectData._control:SetSize(0, 0)
  self._miniMapDragSelectData._control:SetShow(false)
  self:clearMiniMapMoveAnimationInfo()
  self:close()
end
function PaGlobal_ElfWarMiniMap:close()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  Panel_ElfWar_MiniMap:SetShow(false)
end
function PaGlobal_ElfWarMiniMap:validate()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  self._ui._stc_miniMapBg:isValidate()
  self._ui._chk_togglePartyList:isValidate()
  self._ui._chk_toggleEditParty:isValidate()
  self._ui._chk_toggleElfWarMission:isValidate()
  self._ui._chk_toggleChatting:isValidate()
  self._ui._chk_toggleScoreBoard:isValidate()
  self._ui._stc_naviGuide:isValidate()
  self._ui._stc_dragGuide:isValidate()
  self._ui._stc_pingGuide:isValidate()
  self._ui._stc_objectTooltip:isValidate()
  self._ui._btn_moveMapToSelfPlayerPos:isValidate()
end
