function PaGlobalFunc_ElfWarMiniMap_Open()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:prepareOpen()
  ElfWarMiniMap_MoveMapToSelfPlayer()
end
function PaGlobalFunc_ElfWarMiniMap_Close()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ElfWarMiniMap_IsShow()
  if Panel_ElfWar_MiniMap == nil then
    return false
  end
  return Panel_ElfWar_MiniMap:GetShow()
end
function PaGlobalFunc_ElfWarMiniMap_AddPingAndMarker(commandEventType, worldPosition)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:addPingAndMarker(commandEventType, worldPosition)
end
function PaGlobalFunc_ElfWarMiniMap_GetMiniMapViewLeftTopPos()
  local rv = float2(0, 0)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX()
  rv.y = self._ui._stc_miniMapBg:GetParentPosY()
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetMiniMapViewRightBottomPos()
  local rv = float2(0, 0)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX()
  rv.y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY()
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetMiniMapViewCenterPos()
  local rv = float2(0, 0)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return rv
  end
  rv.x = self._ui._stc_miniMapBg:GetParentPosX() + self._ui._stc_miniMapBg:GetSizeX() / 2
  rv.y = self._ui._stc_miniMapBg:GetParentPosY() + self._ui._stc_miniMapBg:GetSizeY() / 2
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPosRB(fierceBattleKeyRaw)
  local rv = float2(0, 0)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return rv
  end
  local control = self:getFierceBattleObjectIcon(fierceBattleKeyRaw)
  if control == nil then
    return rv
  end
  rv.x = control:GetParentPosX() + control:GetSizeX()
  rv.y = control:GetParentPosY() + control:GetSizeY()
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetBossIconCenterPosRB(elfWarTeamNo)
  local rv = float2(0, 0)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return rv
  end
  local bossIconData = self._miniMapBossIconList[elfWarTeamNo]
  if bossIconData == nil then
    return rv
  end
  local control = bossIconData._control
  if control == nil then
    return rv
  end
  rv.x = control:GetParentPosX() + control:GetSizeX()
  rv.y = control:GetParentPosY() + control:GetSizeY()
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetFierceBattleObjectIconCenterPos(fierceBattleKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or fierceBattleKeyRaw == nil then
    return nil
  end
  local control = self:getFierceBattleObjectIcon(fierceBattleKeyRaw)
  if control == nil then
    return nil
  end
  rv = {
    x = control:GetParentPosX() + control:GetSizeX() / 2,
    y = control:GetParentPosY() + control:GetSizeY() / 2
  }
  return rv
end
function PaGlobalFunc_ElfWarMiniMap_GetMiniMapLTRB()
  return PaGlobal_ElfWarMiniMap:getMiniMapLTRB()
end
function ElfWarMiniMap_Update_Always(deltaTime)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:update_always(deltaTime)
end
function ElfWarMiniMap_MouseScroll(isUp)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:processMiniMapScroll(isUp)
  self:setTooltipPos()
end
function ElfWarMiniMap_MoveMapToSelfPlayer()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  self:aniationMoveMiniMap(selfPlayer:getUserNo())
end
function ElfWarMiniMap_ShowToolTip_MoveMapToSelfPlayerButton(isShow)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._btn_moveMapToSelfPlayerPos
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_INMYPOSITION")
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function ElfWarMiniMap_MouseLDown()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if PaGlobalFunc_ElfWarTeamSkillManager_isUsingSkill() == true then
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = ToClient_ConvertMinimapPosRateToWorldMapPos(mousePosRate.x, mousePosRate.y)
    PaGlobalFunc_ElfWarTeamSkillManager_UpdatePosition(worldPosition)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Scan)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Conceal)
    return
  end
  PaGlobalFunc_ElfWarCommand_Close()
end
function ElfWarMiniMap_MouseRUp()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  if ToClient_IsParticipateInElfWar() == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerElfWarGradeType = selfPlayerWrapper:getElfWarGradeType()
  if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) == true then
    if selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_Commander or selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_SubCommander then
      if PaGlobalFunc_ElfWarCommand_IsShow() == true then
        PaGlobalFunc_ElfWarCommand_Close()
      else
        local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
        local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
        PaGlobalFunc_ElfWarCommand_OpenByMiniMap(selfPlayerElfWarGradeType, worldPosition)
      end
    elseif selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_GuildPartyLeader then
      return
    elseif selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_GuildMember then
      return
    elseif selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_MercenaryPartyLeader then
      return
    elseif selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_Mercenary then
      return
    else
      UI.ASSERT_NAME(false, "\235\130\152\236\157\152 \236\151\152\237\148\132\236\160\132\236\159\129 GradeType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
      return
    end
  elseif selfPlayerElfWarGradeType == __eElfWarPlayerGradeType_Commander and ToClient_GetElfWarSelectIconListCount() > 0 then
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
    ToClient_ProcessElfWarCommandEvent(__eElfWarCommandEventType_Move, worldPosition, false)
    self:showMiniMapMovePin(mousePosRate)
  else
    if ToClient_IsShowNaviGuideGroup(0) == true then
      self:hideMiniMapPin()
      ToClient_clearShowAALineList()
      ToClient_DeleteNaviGuideByGroup(0)
      return
    end
    local mousePosRate = self:getCurrentMousePosRateOnMiniMap()
    local worldPosition = self:calcMiniMapPosRateToActorPosition(mousePosRate.x, mousePosRate.y)
    local drawNaviKey = ToClient_WorldMapNaviStart(worldPosition, NavigationGuideParam(), false, true)
    if drawNaviKey ~= -1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
      self:showMiniMapPin(mousePosRate)
    end
  end
end
function PaGlobalFunc_ElfWarMiniMap_ConvertWorldMapPosToMinimapBGRate(worldPos)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or worldPos == nil or worldPos.x == nil or worldPos.y == nil then
    return nil
  end
  local worldPosXZ = {
    x = worldPos.x,
    z = worldPos.y
  }
  local totalMiniMapPosRate = self:calcWorldPositionToMiniMapPosRate(worldPosXZ)
  local rv = {
    x = self._miniMapControl:GetParentPosX() + self:getMiniMapSizeX() * totalMiniMapPosRate.x,
    y = self._miniMapControl:GetParentPosY() + self:getMiniMapSizeY() * totalMiniMapPosRate.y
  }
  return rv
end
function ElfWarMiniMap_SetNavigation(fromUserNo, worldPosition)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or fromUserNo == nil or worldPosition == nil then
    return
  end
  if getSelfPlayer():get():getUserNo() ~= fromUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoReceivedRoseWarMiniMapNavigation"))
  end
  ElfWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, false)
end
function ElfWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, useNotify)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or worldPosition == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local posRate = self:calcWorldPositionToMiniMapPosRate(worldPosition)
  local drawNaviKey = ToClient_WorldMapNaviStart(worldPosition, NavigationGuideParam(), false, false)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  if useNotify == true and drawNaviKey ~= -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
  end
  self:showMiniMapPin(posRate)
end
function PaGlobalFunc_ElfWarMiniMap_GetGradeTypeString(gradeType)
  if gradeType == __eElfWarPlayerGradeType_Commander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_COMMANDER")
  elseif gradeType == __eElfWarPlayerGradeType_SubCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_SUBCOMMANDER")
  elseif gradeType == __eElfWarPlayerGradeType_GuildPartyLeader or gradeType == __eElfWarPlayerGradeType_MercenaryPartyLeader then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_CAPTAIN")
  elseif gradeType == __eElfWarPlayerGradeType_GuildMember then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_GUILDMEMBER")
  elseif gradeType == __eElfWarPlayerGradeType_Mercenary then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_MERCENARY")
  elseif gradeType == __eElfWarPlayerGradeType_EnemyCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYCOMMANDER")
  elseif gradeType == __eElfWarPlayerGradeType_EnemySubCommander then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYSUBCOMMANDER")
  elseif gradeType == __eElfWarPlayerGradeType_EnemyGuildPartyLeader or gradeType == __eElfWarPlayerGradeType_EnemyMercenaryPartyLeader then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYCAPTAIN")
  elseif gradeType == __eElfWarPlayerGradeType_EnemyGuildMember then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYMEMBER")
  elseif gradeType == __eElfWarPlayerGradeType_EnemyMercenary then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_ENEMYMERCENARY")
  else
    UI.ASSERT_NAME(false, "ElfWarGradeType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return nil
  end
end
function FromClient_ElfWarMiniMap_OnScreenSize()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsParticipateInElfWar() == false and ToClient_IsElfWarObserveMode() == false then
    return
  end
  self:ComputePanelSize()
  self:InitializeMiniMapView()
end
function FromClient_ElfWarMiniMap_ChangeElfWarState(state)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or state == nil then
    return
  end
  if state == __eElfWar_Start then
    ToClient_RequestElfWarFierceBattleObjectInfo()
    ToClient_RequestElfWarBossInfotList()
  elseif state == __eElfWar_Stop then
    ToClient_ClearElfWarFierceBattleObjectInfo()
    PaGlobalFunc_ElfWarMinimap_RemoveAllPing()
    self:InitializeMiniMapView()
  end
end
function FromClient_ElfWarCreateActorIcon(userNo, gradeType, isSelf)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:activateActorIcon(userNo, gradeType, isSelf)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_ElfWarRemoveActorIcon(removeUserNo)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:deactivateActorIcon(removeUserNo)
end
function FromClient_ElfWarUpdateActorIcon()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if Panel_ElfWar_MiniMap:GetShow() == false then
    return
  end
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:refreshActorIcon(false)
end
function FromClient_ElfWarClearActorIcon()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:clearActorIconList()
end
function FromClient_ElfWarCreateVehicleIcon(actorKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:activateVehicleIcon(actorKeyRaw)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_ElfWarRemoveVehicleIcon(actorKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:deactivateVehicleIcon(actorKeyRaw)
end
function FromClient_ElfWarUpdateVehicleIcon()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if Panel_ElfWar_MiniMap:GetShow() == false then
    return
  end
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:refreshVehicleIcon(false)
end
function FromClient_ElfWarClearVehicleIcon()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:clearVehicleIconList()
end
function FromClient_ElfWarAddSelectActorIcon(userNo64)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil or userNo64 == nil then
    return
  end
  self:showSelectedActorIcon(userNo64)
end
function FromClient_ElfWarClearSelectActorIcon()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:hideSelectedActorIcon()
end
function FromClient_ElfWarMiniMap_SetElfWarObserveMode()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
end
function FromClient_ElfWarMiniMap_UnsetElfWarObserveMode()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:ComputePanelSize()
  self:InitializeMiniMapView()
end
function FromClient_ElfWarCreateFierceBattleObjectIcon(fierceBattleKeyRaw, elfWarTeamNo, position)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:activateFierceBattleObjectIcon(fierceBattleKeyRaw, elfWarTeamNo, position)
  self._ui._stc_miniMapBg:SetDepthSort()
  self._ui._stc_miniMapBg:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_miniMapBg:GetSizeX(), self._ui._stc_miniMapBg:GetSizeY()))
  self:updateAllHpBarXXX()
end
function FromClient_ElfWarClearFierceBattleObjectIcon()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:deactivateFierceBattleObjectIconAll()
  self:deactivateBossIconAll()
end
function FromClient_UpdateElfWarFierceBattleInfo(fierceBattleKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:updateFierceBattleObjectIcon(fierceBattleKeyRaw)
end
function HandleEventLUp_ElfWarMiniMap_ClickedActorIcon(userNo64)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
end
function HandleEventOnOut_ElfWarMiniMap_OnOutActorIcon(isOn, userNo32)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if isOn == true then
    local actorIconData = self:getActorIconDataByUserNo(userNo32)
    if actorIconData == nil then
      return
    end
    local actorIconDataWrapper = ToClient_GetElfWarMiniMapIconDataWrapper(toInt64(0, userNo32))
    if actorIconDataWrapper == nil then
      return
    end
    local classTypeString = CppEnums.ClassType2String[actorIconDataWrapper:getClassTypeRaw()]
    if classTypeString == nil then
      classTypeString = ""
    end
    local gradeTypeString = PaGlobalFunc_ElfWarMiniMap_GetGradeTypeString(actorIconDataWrapper:getGradeType())
    local control = actorIconData._actorIcon
    local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDLIST_FAMILYNAME", "name", actorIconDataWrapper:getUserName())
    local desc = "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_DUTY", "param", gradeTypeString) .. "\n" .. "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_CLASS", "param", classTypeString) .. "\n" .. "- " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_LEVEL", "param", actorIconDataWrapper:getLevel())
    if control ~= nil then
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_ElfWarMiniMap_OnOutVehicleIcon(isOn, actorKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if isOn == true then
    local vehicleIconData = self:getVehicleIconDataByActorKeyRaw(actorKeyRaw)
    if vehicleIconData == nil then
      return
    end
    local vehicleIconDataWrapper = ToClient_GetElfWarMiniMapVehicleIconDataWrapper(actorKeyRaw)
    if vehicleIconDataWrapper == nil then
      return
    end
    local vehicleType = vehicleIconDataWrapper:getVehicleType()
    local vehicleSubType = vehicleIconDataWrapper:getVehicleSubType()
    local vehicleString
    if vehicleType == __eVehicleType_Cannon and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_0")
    elseif vehicleType == __eVehicleType_Ballista and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_1")
    elseif vehicleType == __eVehicleType_Tank and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_2")
    elseif vehicleType == __eVehicleType_MonsterRide and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_3")
    elseif vehicleType == __eVehicleType_Elephant and vehicleSubType == 0 then
      vehicleString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_WORLDMAP_TOOLTIP_WARWEAPON_4")
    else
      UI.ASSERT_NAME(false, "\236\151\152\237\148\132\236\160\132\236\159\129 \235\175\184\235\139\136\235\167\181 \234\179\181\236\132\177\235\179\145\234\184\176 \236\149\132\236\157\180\236\189\152 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164! \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
      return
    end
    local control = vehicleIconData._vehicleIcon
    local name = vehicleString
    local desc = ""
    if control ~= nil then
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function HandleEventRUp_ElfWarMiniMap_VehicleIcon(actorKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  local vehicleIconDataWrapper = ToClient_GetElfWarMiniMapVehicleIconDataWrapper(actorKeyRaw)
  if vehicleIconDataWrapper == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local worldPosition = vehicleIconDataWrapper:getPosition()
  ElfWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function HandleEventLUp_ElfWarMiniMap_ClickedMarkerIcon(index)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerElfWarGradeType = selfPlayerWrapper:getElfWarGradeType()
  if selfPlayerElfWarGradeType ~= __eElfWarPlayerGradeType_Commander then
    return
  end
  local markerIconData = self._miniMapMarkerList[index]
  if markerIconData == nil then
    return
  end
  if markerIconData._eventType < __eElfWarCommandEventType_Ping_Red or markerIconData._eventType > __eElfWarCommandEventType_Ping_Yellow then
    return
  end
  ToClient_RequestRemoveElfWarPing(markerIconData._eventType)
end
function HandleEventOnOut_ElfWarMiniMap_OnOutMarkerIcon(isOn, index)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
end
function HandleEventLUp_ElfWarMiniMap_ClickedFierceBattleObjectIcon(fierceBattleKeyRaw, isGimmick)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if IsSelfPlayerElfWarGrade_Commander() == false and IsSelfPlayerElfWarGrade_SubCommander() == false then
    return
  end
  if IsSelfPlayerElfWarGrade_Commander() == true and PaGlobalFunc_ElfWarTeamSkillManager_isUsingSkill() == true and isGimmick == false then
    PaGlobalFunc_ElfWarTeamSkillManager_UpdateFierceBattleKey(fierceBattleKeyRaw)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Recall)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Bombard)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Summon)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_Zonya)
    PaGlobalFunc_ElfWarTeamSkillManager_UseElfWarSkill(__eElfWarSkillType_FixedResurrection)
    return
  end
  if isGimmick == true then
    PaGlobalFunc_ElfWarMission_Open(PaGlobal_ElfWarMission._eOpenMode._SET_GIMMICK_FIERCE, fierceBattleKeyRaw)
  else
    PaGlobalFunc_ElfWarMission_Open(PaGlobal_ElfWarMission._eOpenMode._SET_FIERCE_BATTLE, fierceBattleKeyRaw)
  end
end
function HandleEventOnOut_ElfWarMiniMap_OnOutFierceBattleObjectIcon(fierceBattleKeyRaw, isShow)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  local fierceBattleIconData = PaGlobal_ElfWarMiniMap:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if fierceBattleIconData == nil then
    return
  end
  ElfWarMinimap_ShowFierceBattleObjectTooltip(false, -1, fierceBattleKeyRaw, isShow)
  fierceBattleIconData._isFocused = isShow
end
function HandleEventRUp_ElfWarMiniMap_RClickedFierceBattleObjectIcon(fierceBattleKeyRaw)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  if self._miniMapFierceBattleIconList == nil then
    return
  end
  local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
  if fierceBattleObjectInfoWrapper == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
  end
  local worldPosition = fierceBattleObjectInfoWrapper:getPosition()
  ElfWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function HandleEventRUp_ElfWarMiniMap_RClickedElfwarBossIcon(teamNo)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  local iconData = self._miniMapBossIconList[teamNo]
  if iconData == nil then
    return
  end
  if ToClient_IsShowNaviGuideGroup(0) == true then
    self:hideMiniMapPin()
    ToClient_clearShowAALineList()
    ToClient_DeleteNaviGuideByGroup(0)
    return
  end
  local worldPosition = iconData._position
  ElfWarMiniMap_SetNavigationWithoutFromUserNo(worldPosition, true)
end
function PaGlobalFunc_ElfWarMiniMap_UpdatePreblendSightInfo(deltaTime)
  PaGlobal_ElfWarMiniMap:updatePreblendSightInfo(deltaTime)
end
function PaGlobalFunc_ElfWarMiniMap_UpdateFierceBattleObjectIconTextureAll()
  PaGlobal_ElfWarMiniMap:updateFierceBattleObjectIconTextureAll()
end
function HandleEventLUp_ElfWarMiniMap_LClickedBossIcon(elfWarTeamNo)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  if ToClient_IsElfWarObserveMode() == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  if selfPlayerTeamNo == elfWarTeamNo then
    PaGlobalFunc_ElfWarMission_Open(PaGlobal_ElfWarMission._eOpenMode._SET_MY_CASTLE, elfWarTeamNo)
  else
    PaGlobalFunc_ElfWarMission_Open(PaGlobal_ElfWarMission._eOpenMode._SET_ENEMY_CASTLE, elfWarTeamNo)
  end
end
function HandleEventOnOut_ElfWarMiniMap_OnOutBossIcon(elfWarTeamNo, isShow)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  ElfWarMinimap_ShowFierceBattleObjectTooltip(true, elfWarTeamNo, -1, isShow)
end
function ElfWarMinimap_ShowFierceBattleObjectTooltip(isCommander, teamNo, fierceBattleKeyRaw, isShow)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:setShowMiniMapFierceBattleObjectTooltip(isCommander, teamNo, fierceBattleKeyRaw, isShow)
end
function ElfWarMinimap_GetElfWarGimicFierceBattleObjectBuffIcon(elfWarGimicFierceBattleBuffType)
  if elfWarGimicFierceBattleBuffType == __eElfWarGimicFierceBattleBuffType_Skill then
    return "Combine_Etc_ElfWar_Command_Wight_Icon_Buff_1"
  elseif elfWarGimicFierceBattleBuffType == __eElfWarGimicFierceBattleBuffType_Spawn then
    return "Combine_Etc_ElfWar_Command_Wight_Icon_Buff_2"
  elseif elfWarGimicFierceBattleBuffType == __eElfWarGimicFierceBattleBuffType_Item then
    return "Combine_Etc_ElfWar_Command_Wight_Icon_Buff_3"
  elseif elfWarGimicFierceBattleBuffType == __eElfWarGimicFierceBattleBuffType_Count then
    return ""
  end
end
function FromClient_ElfWarUpdateBossInfo(elfWarTeamNo)
  local elfWarBossInfo = ToClient_GetElfWarBossInfoXXX(elfWarTeamNo)
  if elfWarBossInfo ~= nil then
    PaGlobal_ElfWarMiniMap:updateMiniMapBossObject(elfWarTeamNo)
  end
end
function PaGlobalFunc_ElfWarMiniMap_HideMinimapPin()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:hideMiniMapPin()
end
function PaGlobalFunc_ElfWarMinimap_ShowMinimapPin(posRate)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:showMiniMapPin(posRate)
end
function PaGlobalFunc_ElfWarMinimap_RemoveAllPing()
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  for pingType = 0, __eElfWarCommandEventType_Count do
    self:removePingAndMarkerByPingType(pingType)
  end
end
function PaGlobalFunc_ElfWarMiniMap_ToggleChattingUI(setForceRelease)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  local doIgnore = false
  if setForceRelease ~= nil and setForceRelease == true then
    doIgnore = false
  else
    doIgnore = self._ui._chk_toggleChatting:IsCheck() == false
  end
  Panel_Chat0:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat1:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat2:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat3:SetIgnoreRenderAndEvent(doIgnore)
  Panel_Chat4:SetIgnoreRenderAndEvent(doIgnore)
end
function FromClient_ResponseElfWarFierceBattleMonsterDead(fierceBattleKeyRaw, nextRespawnTime)
  PaGlobal_ElfWarMiniMap:setFierceBattleObjectRespawnTime(fierceBattleKeyRaw, nextRespawnTime)
end
function FromClient_ResponseElfWarGimmickFierceBattleObjectAdrenalin(fierceBattleKeyRaw, adrenalinPoint)
  PaGlobal_ElfWarMiniMap:updateGimmickFierceBattleObjectIcon(fierceBattleKeyRaw, adrenalinPoint)
  PaGlobal_ElfWarMiniMap:updateHpBarFireceBattleObjectTooltip(fierceBattleKeyRaw, false)
end
function FromClient_ElfWarRemovePing(pingType)
  local self = PaGlobal_ElfWarMiniMap
  if self == nil then
    return
  end
  self:removePingAndMarkerByPingType(pingType)
end
