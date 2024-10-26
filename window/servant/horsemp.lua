local UI_VT = CppEnums.VehicleType
local servantMpBar = {
  _staticBarBG = nil,
  _staticBar = nil,
  _staticText = nil,
  _actorKeyRaw = 0,
  _button_AutoCarrot = nil,
  _button_AutoSpeed = nil,
  staminaAlert = nil,
  repair_AutoNavi = nil,
  repair_Navi = nil,
  _originalAutoBtnPosY = 19,
  _originalAutoCarrotBtnPosY = 0,
  _autoBtnFlag = false
}
local horseCarrotItemKey = {
  [0] = 19945,
  [1] = 46906,
  [2] = 46912,
  [3] = 54001,
  [4] = 54004,
  [5] = 54005,
  [6] = 9321
}
local camelCarrotItemKey = {
  [0] = 54012,
  [1] = 54020,
  [2] = 54021,
  [3] = 54022,
  [4] = 9321
}
function HorseMP_init()
  if nil == Panel_HorseMp then
    return
  end
  Panel_HorseMp:SetShow(false, false)
  Panel_HorseMp:ComputePos()
  servantMpBar._staticBarBG = UI.getChildControl(Panel_HorseMp, "Static_3")
  servantMpBar._staticBar = UI.getChildControl(Panel_HorseMp, "HorseMpBar")
  servantMpBar._staticText = UI.getChildControl(Panel_HorseMp, "StaticText_Mp")
  servantMpBar._button_AutoCarrot = UI.getChildControl(Panel_HorseMp, "CheckButton_AutoCarrot")
  servantMpBar._button_AutoSpeed = UI.getChildControl(Panel_HorseMp, "CheckButton_AutoSpeed")
  servantMpBar.staminaAlert = UI.getChildControl(Panel_HorseMp, "StaticText_AlertStamina")
  servantMpBar.repair_AutoNavi = UI.getChildControl(Panel_HorseMp, "CheckButton_Repair_AutoNavi")
  servantMpBar.repair_Navi = UI.getChildControl(Panel_HorseMp, "Checkbox_Repair_Navi")
  servantMpBar._button_AutoCarrot:SetShow(false)
  servantMpBar._button_AutoCarrot:SetCheck(true)
  servantMpBar._button_AutoSpeed:SetShow(false)
  servantMpBar._button_AutoSpeed:SetCheck(false)
  servantMpBar.staminaAlert:SetShow(false)
  servantMpBar.repair_AutoNavi:SetShow(false)
  servantMpBar.repair_Navi:SetShow(false)
  servantMpBar.repair_AutoNavi:addInputEvent("Mouse_LUp", "HandleClick_Horse_Repair_Navi(true)")
  servantMpBar.repair_Navi:addInputEvent("Mouse_LUp", "HandleClick_Horse_Repair_Navi(false)")
  servantMpBar._button_AutoCarrot:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 2, nil )")
  servantMpBar._button_AutoCarrot:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 2, nil )")
  servantMpBar._button_AutoCarrot:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 2 )")
  servantMpBar._button_AutoSpeed:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips(true, 2, nil)")
  servantMpBar._button_AutoSpeed:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 2, nil )")
  servantMpBar._button_AutoSpeed:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 2 )")
  servantMpBar._originalAutoCarrotBtnPosY = servantMpBar._button_AutoCarrot:GetPosY()
end
function HorseMp_InitStaminaAlertText(vehicleType, isUseFoodText)
  if nil == Panel_HorseMp then
    return
  end
  local alertText = ""
  if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_1")
  elseif true == ToClient_isVehicleTypeWarter(vehicleType) then
    if true == _ContentsGroup_OceanCurrent then
      if false == isUseFoodText then
        alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_3")
      else
        alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_6")
      end
    elseif CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
      alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_4")
    else
      alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_3")
    end
  elseif UI_VT.Type_RepairableCarriage == vehicleType then
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_5")
  else
    alertText = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STAMINA_ALERT_2")
  end
  servantMpBar.staminaAlert:SetAutoResize()
  servantMpBar.staminaAlert:SetText(alertText)
end
function HorseMP_Update()
  if Panel_HorseMp == nil then
    return
  end
  if Panel_HorseMp:GetShow() == false then
    return
  end
  local self = servantMpBar
  local vehicleProxy = getVehicleActor(self._actorKeyRaw)
  if vehicleProxy == nil then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local vehicleSubType = vehicleProxy:get():getVehicleSubType()
  local characterKey = vehicleProxy:getCharacterKey()
  local mp = getMpToActor(vehicleProxy)
  local maxMp = getMaxMpToActor(vehicleProxy)
  local staminaPercent = mp / maxMp * 100
  if CppEnums.VehicleType.Type_Carriage ~= vehicleType and CppEnums.VehicleType.Type_CowCarriage ~= vehicleType and CppEnums.VehicleType.Type_Boat ~= vehicleType and CppEnums.VehicleType.Type_Raft ~= vehicleType and CppEnums.VehicleType.Type_FishingBoat ~= vehicleType and CppEnums.VehicleType.Type_SailingBoat ~= vehicleType and CppEnums.VehicleType.Type_PersonalBattleShip ~= vehicleType and CppEnums.VehicleType.Type_PersonalBoat ~= vehicleType and CppEnums.VehicleType.Type_CashPersonalTradeShip ~= vehicleType and CppEnums.VehicleType.Type_CashPersonalBattleShip ~= vehicleType and CppEnums.VehicleType.Type_PersonTradeShip ~= vehicleType and CppEnums.VehicleType.Type_Carrack ~= vehicleType then
    self._staticBarBG:EraseAllEffect()
    if staminaPercent < 10 then
      self._staticBarBG:AddEffect("fUI_Horse_Gauge01", true, 0, 0)
      servantMpBar.repair_AutoNavi:SetShow(true)
      if ToClient_isVehicleTypeWarter(vehicleType) == false then
        servantMpBar.repair_Navi:SetShow(true)
      end
    else
      servantMpBar.repair_AutoNavi:SetShow(false)
      servantMpBar.repair_Navi:SetShow(false)
    end
  end
  self._staticBar:SetProgressRate(staminaPercent)
  if UI_VT.Type_Horse == vehicleType or UI_VT.Type_Camel == vehicleType or UI_VT.Type_Donkey == vehicleType or UI_VT.Type_MountainGoat == vehicleType or UI_VT.Type_RidableBabyElephant == vehicleType then
    self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_LIFE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
    self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
    self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 0 )")
    self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 0, " .. staminaPercent .. ")")
  elseif UI_VT.Type_Elephant == vehicleType then
    self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_LIFE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
    self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 3, " .. staminaPercent .. ")")
    self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 3 )")
    self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 3, " .. staminaPercent .. ")")
  elseif UI_VT.Type_RepairableCarriage == vehicleType then
    self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
    self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
    self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 4 )")
    self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
  elseif ToClient_isVehicleTypeWarter(vehicleType) == true then
    if _ContentsGroup_OceanCurrent == true then
      local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
      if shipStaticStatus ~= nil and shipStaticStatus:getIsSummonFull() == false then
        self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
        self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 5, " .. staminaPercent .. ")")
        self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 5 )")
        self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 5, " .. staminaPercent .. ")")
      else
        self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
        self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
        self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
        self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
      end
    elseif CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
      self._staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME") .. " : " .. makeDotMoney(mp) .. "/" .. makeDotMoney(maxMp))
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 4 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 4, " .. staminaPercent .. ")")
    else
      self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
      self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
      self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
      self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
    end
  elseif UI_VT.Type_WoodenFence == vehicleType then
    Panel_HorseMp:SetShow(false, false)
  else
    self._staticText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_MPBAR_MACHINE", "getMp", makeDotMoney(mp), "getMaxMp", makeDotMoney(maxMp)))
    self._staticBar:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
    self._staticBar:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 1 )")
    self._staticBar:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 1, " .. staminaPercent .. ")")
  end
  local oceanShipSkillUI = false
  if _ContentsGroup_OceanCurrent == true then
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if shipStaticStatus ~= nil and shipStaticStatus:getOceanShipSkillUI() == true and getSelfPlayer():get():getVehicleSeatIndex() == 0 then
      oceanShipSkillUI = true
    end
  end
  local tooltipValue = 0
  local skillKey = 0
  local lifeType = CppEnums.LifeExperienceType.Type_Count
  if oceanShipSkillUI == true then
    if 21 <= getSelfPlayer():get():getLifeExperienceLevel(9) then
      servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPFASTMOVE_AUTOUSE"))
      tooltipValue = 6
    else
      servantMpBar._button_AutoSpeed:SetShow(false)
    end
  elseif vehicleType == __eVehicleType_Horse then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE"))
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 4
    tooltipValue = 7
  elseif vehicleType == __eVehicleType_Camel then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CAMEL"))
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 22
    tooltipValue = 8
  elseif vehicleType == CppEnums.VehicleType.Type_RidableBabyElephant then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_ELEPHANT"))
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 28
    tooltipValue = 9
  elseif vehicleType == __eVehicleType_Donkey then
    if vehicleSubType == 1 then
      servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_DONKEY"))
      lifeType = CppEnums.LifeExperienceType.training
      skillKey = 62
      tooltipValue = 10
    end
  elseif vehicleType == __eVehicleType_RepairableCarriage then
    servantMpBar._button_AutoSpeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CARRIAGE"))
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 55
    tooltipValue = 11
  else
    servantMpBar._button_AutoSpeed:SetShow(false)
  end
  if tooltipValue ~= 0 and getSelfPlayer():get():isVehicleDriver() == true then
    if servantMpBar._button_AutoSpeed:GetShow() == false then
      servantMpBar._button_AutoSpeed:SetShow(true)
    end
    if servantMpBar._autoBtnFlag == false then
      servantMpBar._autoBtnFlag = true
      if oceanShipSkillUI == true then
        servantMpBar._button_AutoSpeed:SetCheck(ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMovePastForSeaVehicle))
      else
        servantMpBar._button_AutoSpeed:SetCheck(ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMovePastForGroundVehicle))
      end
      servantMpBar._button_AutoSpeed:SetPosY(servantMpBar._originalAutoBtnPosY - 54)
      servantMpBar._button_AutoSpeed:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips(true, " .. tostring(tooltipValue) .. ", nil)")
      servantMpBar._button_AutoSpeed:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips(false, " .. tostring(tooltipValue) .. ")")
      servantMpBar._button_AutoSpeed:setTooltipEventRegistFunc("HorseMP_SimpleTooltips(true, " .. tostring(tooltipValue) .. ", nil)")
    end
    if lifeType ~= CppEnums.LifeExperienceType.Type_Count then
      if getSelfPlayer():get():getLifeExperienceLevel(lifeType) < vehicleProxy:getNeedLifeLevelForAutoSkill(skillKey) then
        servantMpBar._button_AutoSpeed:addInputEvent("Mouse_LUp", "HorseMP_SetAutoSpeedBtn(false)")
      else
        servantMpBar._button_AutoSpeed:removeInputEvent("Mouse_LUp")
      end
    end
    local isAutoRun = servantMpBar._button_AutoSpeed:IsCheck()
    if ToClient_IsCanMoveFast() ~= isAutoRun then
      ToClient_SetCanMoveFast(isAutoRun)
      if oceanShipSkillUI == true then
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMovePastForSeaVehicle, isAutoRun, CppEnums.VariableStorageType.eVariableStorageType_User)
      else
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMovePastForGroundVehicle, isAutoRun, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
  end
  if getSelfPlayer():isNavigationLoop() and getSelfPlayer():isNavigationMoving() then
    if __eVehicleType_Boat == vehicleType or __eVehicleType_Raft == vehicleType or __eVehicleType_FishingBoat == vehicleType or __eVehicleType_Carriage == vehicleType or __eVehicleType_CowCarriage == vehicleType or __eVehicleType_RepairableCarriage == vehicleType or __eVehicleType_Cannon == vehicleType or __eVehicleType_PracticeCannon == vehicleType or __eVehicleType_Elephant == vehicleType or __eVehicleType_BabyElephant == vehicleType or __eVehicleType_ThrowFire == vehicleType or __eVehicleType_ThrowStone == vehicleType or __eVehicleType_Ballista == vehicleType or __eVehicleType_SailingBoat == vehicleType or __eVehicleType_CashPersonalTradeShip == vehicleType or __eVehicleType_CashPersonalBattleShip == vehicleType or __eVehicleType_PersonalBattleShip == vehicleType or __eVehicleType_PersonTradeShip == vehicleType or __eVehicleType_Carrack == vehicleType then
      servantMpBar._button_AutoCarrot:SetShow(false)
    else
      servantMpBar._button_AutoCarrot:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HORSEMP_AUTOCARROT"))
      servantMpBar._button_AutoCarrot:SetShow(true)
      if false == servantMpBar._autoBtnFlag then
        servantMpBar._autoBtnFlag = true
        servantMpBar._button_AutoCarrot:SetCheck(true)
        servantMpBar._button_AutoCarrot:SetPosY(servantMpBar._originalAutoBtnPosY)
        servantMpBar._button_AutoCarrot:addInputEvent("Mouse_On", "HorseMP_SimpleTooltips( true, 2, nil )")
        servantMpBar._button_AutoCarrot:addInputEvent("Mouse_Out", "HorseMP_SimpleTooltips( false, 2 )")
        servantMpBar._button_AutoCarrot:setTooltipEventRegistFunc("HorseMP_SimpleTooltips( true, 2, nil )")
      end
      if staminaPercent <= 10 and true == servantMpBar._button_AutoCarrot:IsCheck() then
        if __eVehicleType_Horse == vehicleType or __eVehicleType_Donkey == vehicleType or __eVehicleType_Ridable_BabyElephant == vehicleType then
          HorseAutoCarrotFunc(horseCarrotItemKey)
        elseif __eVehicleType_Camel == vehicleType then
          HorseAutoCarrotFunc(camelCarrotItemKey)
        end
      end
    end
  else
    servantMpBar._button_AutoCarrot:SetShow(false)
  end
  HorseMP_UpdateCarrotPosBySubMpBar()
end
function HorseMP_UpdateCarrotPosBySubMpBar(isShowSubMp)
  if nil == servantMpBar._button_AutoCarrot then
    return
  end
  if nil == isShowSubMp then
    return
  end
  if true == isShowSubMp then
    servantMpBar._button_AutoCarrot:SetPosY(servantMpBar._originalAutoCarrotBtnPosY + 20)
  else
    servantMpBar._button_AutoCarrot:SetPosY(servantMpBar._originalAutoCarrotBtnPosY)
  end
end
function HorseAutoCarrotFunc(carrotItemKey)
  local useAutoCarrot = function(itemWhereType, invenSlot)
    local itemWrapper = getInventoryItemByType(itemWhereType, invenSlot)
    local itemStatic = itemWrapper:getStaticStatus():get()
    local selfProxy = getSelfPlayer():get()
    if nil == selfProxy then
      return
    end
    if selfProxy:doRideMyVehicle() and itemStatic:isUseToVehicle() then
      local equipSlotNo = itemWrapper:getStaticStatus():getEquipSlotNo()
      local carrotName = itemWrapper:getStaticStatus():getName()
      inventoryUseItem(itemWhereType, invenSlot, equipSlotNo, false)
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_AUTO_USE_CARROT", "carrotName", carrotName))
    end
  end
  if true == _ContentsGroup_FamilyInventory then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local carrotItemSlot = {}
    local selfPlayer = selfPlayerWrapper:get()
    local itemWhereType = CppEnums.ItemWhereType.eFamilyInventory
    local inventory = selfPlayer:getInventoryByType(itemWhereType)
    local invenSize = inventory:sizeXXX()
    for invenidx = __eTInventorySlotNoUseStart, invenSize - 1 do
      local itemWrapper = getInventoryItemByType(itemWhereType, invenidx)
      if nil ~= itemWrapper then
        local itemKey = itemWrapper:get():getKey():getItemKey()
        for i = 0, #carrotItemKey do
          if carrotItemKey[i] == itemKey then
            local carrotCoolTime = getItemCooltime(itemWhereType, invenidx)
            if 0 ~= carrotCoolTime then
              return
            end
            local isCheckedConditions = itemWrapper:checkConditions()
            if isCheckedConditions then
              if nil == carrotItemSlot[i] then
                carrotItemSlot[i] = {slot = "", key = ""}
              end
              carrotItemSlot[i].itemWhereType = itemWhereType
              carrotItemSlot[i].slot = invenidx
              carrotItemSlot[i].key = itemKey
              break
            end
          end
        end
      end
    end
    for i = 0, #carrotItemKey do
      if nil ~= carrotItemSlot[i] and "" ~= carrotItemSlot[i].slot and carrotItemKey[i] == carrotItemSlot[i].key then
        useAutoCarrot(carrotItemSlot[i].itemWhereType, carrotItemSlot[i].slot)
        return
      end
    end
  end
  local inventory = getSelfPlayer():get():getInventory()
  local invenSize = inventory:sizeXXX()
  local carrotItemSlot = {}
  for invenidx = 2, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, invenidx)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      for i = 0, #carrotItemKey do
        if carrotItemKey[i] == itemKey then
          local carrotCoolTime = getItemCooltime(CppEnums.ItemWhereType.eInventory, invenidx)
          if 0 ~= carrotCoolTime then
            return
          end
          local isCheckedConditions = itemWrapper:checkConditions()
          if isCheckedConditions then
            if nil == carrotItemSlot[i] then
              carrotItemSlot[i] = {slot = "", key = ""}
            end
            carrotItemSlot[i].itemWhereType = CppEnums.ItemWhereType.eInventory
            carrotItemSlot[i].slot = invenidx
            carrotItemSlot[i].key = itemKey
            break
          end
        end
      end
    end
  end
  for i = 0, #carrotItemKey do
    if nil ~= carrotItemSlot[i] and "" ~= carrotItemSlot[i].slot and carrotItemKey[i] == carrotItemSlot[i].key then
      useAutoCarrot(carrotItemSlot[i].itemWhereType, carrotItemSlot[i].slot)
      break
    end
  end
end
function HandleOn_HorseMp_Bar()
  if nil == Panel_HorseMp then
    return
  end
  servantMpBar._staticText:SetShow(true)
end
function HandleOut_HorseMp_Bar()
  if nil == Panel_HorseMp then
    return
  end
  servantMpBar._staticText:SetShow(false)
end
function HorseMP_OpenByInteraction()
  local self = servantMpBar
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfProxy = selfPlayer:get()
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if UI_VT.Type_Ballista == vehicleType or UI_VT.Type_ThrowFire == vehicleType or UI_VT.Type_ThrowStone == vehicleType or UI_VT.Type_PracticeCannon == vehicleType or UI_VT.Type_Cannon == vehicleType or UI_VT.Type_RaceHorse == vehicleType then
    return
  end
  self._actorKeyRaw = actorKeyRaw
  HorseMP_Open()
  if PaGlobal_HorseSubMp_All_Open ~= nil then
    PaGlobal_HorseSubMp_All_Open()
  end
  FGlobal_ServantIcon_IsNearMonster_Effect(false)
end
function HorseMP_SetAutoSpeedBtn(isCheck)
  servantMpBar._button_AutoSpeed:SetCheck(isCheck)
end
function HorseMP_SimpleTooltips(isShow, servantTooltipType, staminaStatus)
  if nil == Panel_HorseMp then
    return
  end
  local name, desc, uiControl
  if 0 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEMP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEMP_DESC")
    uiControl = Panel_HorseHp
  elseif 1 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_CARRIAGEMP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_CARRIAGEMP_DESC")
    uiControl = Panel_HorseHp
  elseif 2 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEMP_TOOLTIP_AUTO_USE_CARROT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEMP_TOOLTIP_AUTO_USE_CARROT_DESC")
    uiControl = servantMpBar._button_AutoCarrot
  elseif 3 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_STAMINA")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_ELEPHANTMP_DESC")
    uiControl = Panel_HorseMp
  elseif 4 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_DESC")
    uiControl = Panel_HorseMp
  elseif 5 == servantTooltipType then
    local self = servantMpBar
    local vehicleProxy = getVehicleActor(self._actorKeyRaw)
    local strFood
    if nil ~= vehicleProxy then
      local currentMp = getMpToActor(vehicleProxy)
      local maxMp = getMaxMpToActor(vehicleProxy)
      strFood = makeDotMoney(currentMp) .. "/" .. makeDotMoney(maxMp)
    end
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME")
    if nil ~= strFood then
      desc = strFood .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_DESC")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_DESC")
    end
    uiControl = Panel_HorseMp
  elseif 6 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 7 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 8 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 9 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 10 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  elseif 11 == servantTooltipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_TOOLTIP_AUTO_USE_FAST_MOVE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_TOOLTIP_AUTO_USE_FAST_MOVE_DESC")
    uiControl = servantMpBar._button_AutoSpeed
  end
  if isShow == true and nil ~= staminaStatus then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
    HandleOn_HorseMp_Bar()
    if staminaStatus < 30 then
      servantMpBar.staminaAlert:SetShow(true)
    else
      servantMpBar.staminaAlert:SetShow(false)
    end
  elseif isShow == true and nil == staminaStatus then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
    HandleOut_HorseMp_Bar()
    servantMpBar.staminaAlert:SetShow(false)
  end
end
function HorseMP_Open()
  if nil ~= Panel_HorseMp and true == Panel_HorseMp:GetShow() then
    return
  end
  if Panel_WorldMap:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  local isDriver = selfProxy:isVehicleDriver()
  if false == isDriver then
  end
  local self = servantMpBar
  local vehicleProxy = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleProxy then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local characterKey = vehicleProxy:getCharacterKeyRaw()
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  if UI_VT.Type_Ladder == vehicleType or UI_VT.Type_Cow == vehicleType or UI_VT.Type_Bomb == vehicleType or UI_VT.Type_QuestObjectBox == vehicleType or UI_VT.Type_QuestObjectSack == vehicleType or UI_VT.Type_QuestObjectSheep == vehicleType or UI_VT.Type_QuestObjectCart == vehicleType or UI_VT.Type_QuestObjectOak == vehicleType or UI_VT.Type_QuestObjectBoat == vehicleType or UI_VT.Type_QuestObjectPumpkin == vehicleType or UI_VT.Type_QuestObjectBrokenFrag == vehicleType or UI_VT.Type_QuestObjectHerbalMachines == vehicleType or UI_VT.Type_QuestObjectExtractor == vehicleType or UI_VT.Type_Training == vehicleType or UI_VT.Type_BossMonster == vehicleType or UI_VT.Type_Train == vehicleType then
    return
  end
  if true == _ContentsGroup_OceanCurrent and ToClient_isVehicleTypeWater(vehicleType) == true and selfProxy:isVehicleDriver() == false then
    return
  end
  PaGlobalFunc_ServantMpBar_SetShowPanel(true, false)
  Panel_HorseMp:SetShow(true)
  servantMpBar.repair_AutoNavi:SetShow(false)
  servantMpBar.repair_Navi:SetShow(false)
  HorseMp_InitStaminaAlertText(vehicleType, nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull())
  servantMpBar._autoBtnFlag = false
  HorseMP_Update()
  if nil ~= PaGlobal_HorseSubMp_All_Open then
    PaGlobal_HorseSubMp_All_Open()
  end
end
function HorseMP_Close()
  if PaGlobal_HorseSubMp_All_Close ~= nil then
    PaGlobal_HorseSubMp_All_Close()
  end
  if Panel_HorseMp == nil then
    return
  end
  if Panel_HorseMp:GetShow() == false then
    return
  end
  servantMpBar._autoBtnFlag = false
  servantMpBar._actorKeyRaw = 0
  Panel_HorseMp:SetShow(false)
  PaGlobalFunc_ServantMpBar_SetShowPanel(false, false)
end
function HandleClick_Horse_Repair_Navi(isAuto)
  if nil == Panel_HorseMp then
    return
  end
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  if ToClient_IsShowNaviGuideGroup(0) then
    if true == isAuto and true == servantMpBar.repair_AutoNavi:IsCheck() then
      servantMpBar.repair_Navi:SetCheck(true)
      servantMpBar.repair_AutoNavi:SetCheck(true)
    else
      servantMpBar.repair_Navi:SetCheck(false)
      servantMpBar.repair_AutoNavi:SetCheck(false)
      audioPostEvent_SystemUi(0, 15)
      return
    end
  elseif true == isAuto then
    servantMpBar.repair_Navi:SetCheck(true)
    servantMpBar.repair_AutoNavi:SetCheck(true)
  else
    servantMpBar.repair_Navi:SetCheck(true)
    servantMpBar.repair_AutoNavi:SetCheck(false)
  end
  local position = player:get3DPos()
  local spawnType = CppEnums.SpawnType.eSpawnType_Stable
  local vehicleProxy = getVehicleActor(servantMpBar._actorKeyRaw)
  if nil ~= vehicleProxy then
    local vehicleType = vehicleProxy:get():getVehicleType()
    if true == ToClient_isVehicleTypeWarter(vehicleType) then
      spawnType = CppEnums.SpawnType.eSpawnType_Wharf
    end
  end
  local nearNpcInfo = getNearNpcInfoByType(spawnType, position)
  if nil ~= nearNpcInfo then
    local pos = nearNpcInfo:getPosition()
    local repairNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), isAuto, true)
    audioPostEvent_SystemUi(0, 14)
    local selfPlayer = getSelfPlayer():get()
    selfPlayer:setNavigationMovePath(repairNaviKey)
    selfPlayer:checkNaviPathUI(repairNaviKey)
  end
end
function renderModechange_HorseMP_OpenByInteraction(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  HorseMP_OpenByInteraction()
end
function FGlobal_ToggleServantAutoCarrot()
  if nil == Panel_HorseMp then
    return
  end
  servantMpBar._button_AutoCarrot:SetCheck(true)
end
function HandlePadEventX_ServantMpBar_ToggleAutoCarrot()
  if nil == Panel_HorseMp then
    return
  end
  servantMpBar._button_AutoCarrot:SetCheck(not servantMpBar._button_AutoCarrot:IsCheck())
end
function PaGlobalFunc_ServantMpBar_CheckLoadUI()
  local rv = reqLoadUI("UI_Data/Window/Servant/UI_HorseMp.XML", "Panel_HorseMp", Defines.UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_DEFULAT())
  if nil ~= rv and 0 ~= rv then
    Panel_HorseMp = rv
    rv = nil
    HorseMP_init()
  end
end
function PaGlobalFunc_ServantMpBar_CheckCloseUI(isAni)
  if nil == Panel_HorseMp then
    return
  end
end
function PaGlobalFunc_ServantMpBar_SetShowPanel(isShow, isAni)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobalFunc_ServantMpBar_SetShowPanel isShow nil", "\236\160\149\236\167\128\237\152\156")
  if false == _ContentsGroup_PanelReload_Develop then
    Panel_HorseMp:SetShow(isShow, isAni)
    return
  end
  if true == isShow then
    PaGlobalFunc_ServantMpBar_CheckLoadUI()
    if nil ~= Panel_HorseMp then
      Panel_HorseMp:SetShow(isShow, isAni)
    end
  else
    PaGlobalFunc_ServantMpBar_CheckCloseUI(isAni)
  end
end
function HorseMP_CheckAutoSpeedButton()
  if nil == servantMpBar then
    return false
  end
  return nil ~= servantMpBar._button_AutoSpeed
end
function FGlobal_ToggleCanMoveFast_PadInput(isShip)
  if false == servantMpBar._button_AutoSpeed:GetShow() then
    return
  end
  if false == servantMpBar._autoBtnFlag then
    return
  end
  local isBtnCheck = servantMpBar._button_AutoSpeed:IsCheck()
  if false == isShip and 0 ~= servantMpBar._actorKeyRaw then
    local vehicleProxy = getVehicleActor(servantMpBar._actorKeyRaw)
    if nil == vehicleProxy then
      return
    end
    local vehicleType = vehicleProxy:get():getVehicleType()
    FGlobal_HorseMp_ShowAutoSpeedPopUp(vehicleType, isBtnCheck)
  elseif false == isBtnCheck then
    servantMpBar._button_AutoSpeed:SetCheck(true)
  else
    servantMpBar._button_AutoSpeed:SetCheck(false)
  end
end
function FGlobal_HorseMp_GetAutoSpeedText()
  if nil ~= servantMpBar._button_AutoSpeed then
    return servantMpBar._button_AutoSpeed:GetText()
  else
    return PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE")
  end
end
function FGlobal_HorseMp_ShowAutoSpeedPopUp(vehicleType, isBtnCheck)
  if nil == vehicleType then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfPlayerGet = selfPlayer:get()
  if nil == selfPlayerGet then
    return
  end
  local skillKey = 0
  local lifeType = CppEnums.LifeExperienceType.Type_Count
  local txt_Title = ""
  local txt_Desc = ""
  if __eVehicleType_Horse == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_HORSE")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_HORSE_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 4
  elseif __eVehicleType_Camel == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CAMEL")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMEL_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 22
  elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_ELEPHANT")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_ELEPHANT_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 28
  elseif __eVehicleType_Donkey == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_DONKEY")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_DONKEY_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 62
  elseif __eVehicleType_RepairableCarriage == vehicleType then
    txt_Title = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEAUTOSKILL_CARRIAGE")
    txt_Desc = PAGetString(Defines.StringSheet_GAME, "LUA_CARRIAGE_POPUP_DESC")
    lifeType = CppEnums.LifeExperienceType.training
    skillKey = 55
  end
  if lifeType ~= CppEnums.LifeExperienceType.Type_Count then
    local vehicleProxy = getVehicleActor(servantMpBar._actorKeyRaw)
    if nil == vehicleProxy then
      return
    end
    local needLifeLv = vehicleProxy:getNeedLifeLevelForAutoSkill(skillKey)
    local myLifeLv = selfPlayerGet:getLifeExperienceLevel(lifeType)
    if needLifeLv > myLifeLv then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOSPRINT_CANNOTUSE"))
      servantMpBar._button_AutoSpeed:SetCheck(false)
    elseif true == isBtnCheck then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOSPRINT_DISABLE"))
      servantMpBar._button_AutoSpeed:SetCheck(false)
    elseif false == isBtnCheck then
      local function useAutoSkill()
        servantMpBar._button_AutoSpeed:SetCheck(true)
      end
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
      local messageBoxData = {
        title = txt_Title,
        content = txt_Desc,
        functionYes = useAutoSkill,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  end
end
function servantMpBar:registMessageHandler()
  registerEvent("EventSelfServantUpdate", "HorseMP_Update")
  registerEvent("EventSelfServantUpdateOnlyMp", "HorseMP_Update")
  registerEvent("EventSelfPlayerRideOn", "HorseMP_OpenByInteraction")
  registerEvent("FromClient_RenderModeChangeState", "renderModechange_HorseMP_OpenByInteraction")
  registerEvent("EventSelfPlayerRideOff", "HorseMP_Close")
  registerEvent("FromClient_UpdateSelfPlayerLifeExp", "HorseMP_Update")
  registerEvent("EventCanMoveFastForConsole", "FGlobal_ToggleCanMoveFast_PadInput")
end
function FromClient_luaLoadComplete_HorseMp()
  servantMpBar:registMessageHandler()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_HorseMp")
