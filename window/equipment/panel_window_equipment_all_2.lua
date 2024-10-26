function PaGlobal_Equipment_All:prepareOpen(isShowBlackSpiritInventory)
  if nil == Panel_Window_Equipment_All then
    return
  end
  if true == _ContentsGroup_isFairy and true == _ContentsGroup_NewUI_Fairy_All and (true == PaGlobal_FairyInfo_IsGetShow() or true == PaGlobal_FairyChangeSkill_IsGetShow()) then
    return
  end
  if true == _ContentsGroup_DeleteMaxEnchanterName and true == PaGlobal_DeleteMaxEnchanterName_GetShow() then
    return
  end
  if true == _ContentsGroup_ArtifactItem and true == PaGlobalFunc_Artifacts_All_GetShow() then
    return
  end
  if _ContentsGroup_ItemSkillOption == true and Panel_Window_MakeGoonWang:GetShow() == true then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if _ContentsGroup_NewUI_Camp_All then
    if nil ~= Panel_Window_Camp_All and Panel_Window_Camp_All:GetShow() then
      return
    end
  elseif nil ~= Panel_Window_Camp and Panel_Window_Camp:GetShow() then
    return
  end
  self._delayFuncList = {}
  self._openAfterTime = 0
  for slotNo = PaGlobal_Equipment_All._EquipNoMin, PaGlobal_Equipment_All._EquipNoMax do
    if true == PaGlobal_Equipment_All:checkUsableSlot(slotNo) then
      if nil ~= PaGlobal_Equipment_All.avataSlots[slotNo] and nil ~= PaGlobal_Equipment_All._checkFlag[slotNo] then
        local isCheck = ToClient_IsSetAvatarEquipSlotFlag(slotNo)
        PaGlobal_Equipment_All.avataSlots[slotNo]:SetCheck(isCheck)
      end
      if nil ~= PaGlobal_Equipment_All.effectCtrl[slotNo] then
        local isCheck = ToClient_isSetUniqueEquipEffectSlotFlag(slotNo)
        PaGlobal_Equipment_All.effectCtrl[slotNo]:SetCheck(isCheck == false)
      end
    end
  end
  local alchemyStoneQuickKeyString = keyCustom_GetString_UiKey(__eUiInputType_AlchemyStone)
  PaGlobal_Equipment_All._ui.txt_alchemyStoneQuickKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_QUICKCOMMAND", "keyString", alchemyStoneQuickKeyString))
  if true == selfPlayer:get():isWearingSwimmingSuit() then
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
  elseif true == selfPlayer:get():isWearingUnderwear() then
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
  else
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
  end
  local addPosY = 0
  local addBannerCount = 0
  if isShowBlackSpiritInventory ~= nil and isShowBlackSpiritInventory == true and ToClient_isShowBlackSpiritInventory() == true then
    addPosY = Panel_Window_NewbieInventory_All:GetSizeY() + 5
  end
  if true == selfPlayer:get():isSeasonCharacter() and 10 <= selfPlayer:get():getLevel() then
    PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetShow(_ContentsGroup_SeasonContents)
    PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetShow(true)
    if true == showTransferIcon then
      PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 90 + addPosY)
      PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerReward:GetSpanSize().x, 180 + addPosY)
    else
      PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 0 + addPosY)
      PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerReward:GetSpanSize().x, 90 + addPosY)
    end
    addBannerCount = addBannerCount + 2
  else
    PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetShow(false)
    PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetShow(false)
  end
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    if true == selfPlayer:get():isSeasonCharacter() and 10 <= selfPlayer:get():getLevel() then
      local equipInven = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eEquip)
      local Inventory = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eInventory)
      if true == equipInven or true == Inventory then
        if true == showTransferIcon then
          PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 90 + addPosY)
          PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 180 + addPosY)
          PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerReward:GetSpanSize().x, 270 + addPosY)
        else
          PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 0 + addPosY)
          PaGlobal_Equipment_All._ui.stc_seasonBannerPass:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerPass:GetSpanSize().x, 90 + addPosY)
          PaGlobal_Equipment_All._ui.stc_seasonBannerReward:SetSpanSize(PaGlobal_Equipment_All._ui.stc_seasonBannerReward:GetSpanSize().x, 180 + addPosY)
        end
        PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(true)
        PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:SetShow(true)
        addBannerCount = addBannerCount + 1
      else
        PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(false)
        PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:SetShow(false)
      end
    else
      PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(false)
      PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:SetShow(false)
    end
  end
  if isGameTypeGT() == false and isGameTypeKorea() == false and _ContentsGroup_ChinaOnly == false then
    PaGlobalFunc_Equipment_ShopBanner_Open()
  end
  self._ui.btn_newbieBag:SetShow(false)
  self._ui.btn_newbieBag:SetSpanSize()
  if _ContentsGroup_AccessoryStepUp == true and PaGlobal_Window_Accessory_StepUp_All_CheckDoAccessoryStepUp() == true then
    local addBannerSize = 90 * addBannerCount
    self._ui.stc_accessoryStepUpBanner:SetSpanSize(self._ui.stc_accessoryStepUpBanner:GetSpanSize().x, addBannerSize + addPosY)
    self._ui.stc_accessoryStepUpBanner:SetShow(true)
    if PaGlobal_Window_Accessory_StepUp_All_CheckCanGetStepUpAccessory() == true then
      self._ui.stc_accessoryStepUpBanner:EraseAllEffect()
      self._ui.stc_accessoryStepUpBanner:AddEffect("fUI_Equipment_DarkMoon_01A", true)
    else
      self._ui.stc_accessoryStepUpBanner:EraseAllEffect()
    end
    if PaGlobal_Window_Accessory_StepUp_All_CheckShowStepUpIconEffect() == true then
      self._ui.stc_accessoryStepUpBanner:AddEffect("fUI_Equipment_DarkMoon_01B")
    end
  end
  PaGlobal_Equipment_All:open()
  PaGlobal_Equipment_All:updateSlotData()
  if isShowBlackSpiritInventory ~= nil and isShowBlackSpiritInventory == true then
    PaGlobalFunc_NewbieInventory_Open()
  end
end
function PaGlobal_Equipment_All:open()
  if nil == Panel_Window_Equipment_All or true == Panel_Window_Equipment_All:GetShow() then
    return
  end
  Panel_Window_Equipment_All:SetShow(true, true)
end
function PaGlobal_Equipment_All:prepareClose()
  if nil == Panel_Window_Equipment_All then
    return
  end
  if Panel_Window_Equipment_All:IsUISubApp() then
    return
  end
  if Panel_Window_Equipment_All:IsShow() then
    PaGlobal_Equipment_All:close()
    PaGlobalFunc_ServantIcon_LifeRingMenu_Alarm()
    if ToClient_IsSavedUi() then
      ToClient_SaveUiInfo(false)
      ToClient_SetSavedUi(false)
    end
  end
  HelpMessageQuestion_Out()
  PaGlobal_Equipment_All._slotRingIndex = 0
  PaGlobal_Equipment_All._slotEaringIndex = 0
  PaGlobal_Equipment_All._slotArtifactIndex = 0
  PaGlobal_EquipmentTooltip:show(false)
  PAGlobalFunc_CrystalTooltip_Show(false)
  PaGlobal_Tooltip_BattlePoint:show(false)
  PAGlobalFunc_ArtifactsTooltip_Show(false)
  PaGlobalFunc_Equipment_ShopBanner_Close()
end
function PaGlobal_Equipment_All:close()
  if nil == Panel_Window_Equipment_All or false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  Panel_Window_Equipment_All:SetShow(false, false)
end
function PaGlobal_Equipment_All:updateAbility()
  local isSetAwakenWeapon = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
  local isShyWomen = __eClassType_ShyWaman == getSelfPlayer():getClassType()
  if self._awakenWeaponContentsOpen and nil ~= isSetAwakenWeapon then
    if true == isShyWomen then
      self._ui.txt_awakenText:SetShow(false)
      self._ui.txt_awakenValue:SetShow(false)
      self._ui.txt_shyStatText:SetShow(true)
      self._ui.txt_shyStatValue:SetShow(true)
    else
      self._ui.txt_awakenText:SetShow(true)
      self._ui.txt_awakenValue:SetShow(true)
      self._ui.txt_shyStatText:SetShow(false)
      self._ui.txt_shyStatValue:SetShow(false)
    end
    self._ui.txt_attackText:SetSpanSize(self._ui.txt_attackText:GetSpanSize().x, 0)
    self._ui.txt_attackValue:SetSpanSize(self._ui.txt_attackValue:GetSpanSize().x, 1)
    self._ui.txt_defenceText:SetSpanSize(self._ui.txt_defenceText:GetSpanSize().x, 0)
    self._ui.txt_defenceValue:SetSpanSize(self._ui.txt_defenceValue:GetSpanSize().x, -1)
  else
    self._ui.txt_awakenText:SetShow(false)
    self._ui.txt_awakenValue:SetShow(false)
    self._ui.txt_shyStatText:SetShow(false)
    self._ui.txt_shyStatValue:SetShow(false)
    self._ui.txt_attackText:SetSpanSize(self._ui.txt_attackText:GetSpanSize().x, 15)
    self._ui.txt_attackValue:SetSpanSize(self._ui.txt_attackValue:GetSpanSize().x, 17)
    self._ui.txt_defenceText:SetSpanSize(self._ui.txt_defenceText:GetSpanSize().x, 15)
    self._ui.txt_defenceValue:SetSpanSize(self._ui.txt_defenceValue:GetSpanSize().x, 13)
  end
  self._offenceValue = ToClient_getOffence()
  self._awakenOffecnValue = ToClient_getAwakenOffence()
  self._defenceValue = ToClient_getDefence()
  self._ui.txt_attackValue:SetText(tostring(self._offenceValue))
  self._ui.txt_awakenValue:SetText(tostring(self._awakenOffecnValue))
  self._ui.txt_defenceValue:SetText(tostring(self._defenceValue))
  self._ui.txt_shyStatValue:SetText(tostring(self._awakenOffecnValue))
end
function PaGlobal_Equipment_All:updateSlotData()
  if false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  self._extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if true == PaGlobal_Equipment_All:checkUsableSlot(slotNo) then
      local itemWrapper = ToClient_getEquipmentItem(slotNo)
      local slot = self.slots[slotNo]
      local slotBG = self.slotBGs[slotNo]
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local slotNoMax = itemSSW:getExtendedSlotCount()
        for i = 1, slotNoMax do
          local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
          if slotNoMax ~= extendSlotNo then
            self._extendedSlotInfoArray[extendSlotNo] = slotNo
            checkExtendedSlot = true
          end
        end
        slot.icon:EraseAllEffect()
        slot.border:EraseAllEffect()
        if true == _ContentsGroup_Season_EquipmentUpgrade then
          if true == self._seasonUpgradeEffect then
            if true == itemSSW:get():isChangeEquipItem() then
              slot.border:AddEffect("UI_Inventory_Filtering_NoOutline", true, 0, 0)
              PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo)
            else
              PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, true, false, slotNo)
            end
          else
            PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo)
          end
        else
          PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo)
        end
        if _ContentsGroup_ItemSkillOption == true and self.effectCtrl[slotNo] ~= nil then
          local contentsEventType = itemSSW:get():getContentsEventType()
          local isShow = contentsEventType == __eContentsType_ItemSkillOption
          if isShow == true and __eEquipSlotNoAwakenWeapon == slotNo and __eClassType_ShyWaman == getSelfPlayer():getClassType() then
            isShow = false
          end
          self.effectCtrl[slotNo]:SetShow(isShow)
          local isSet = ToClient_isSetUniqueEquipEffectSlotFlag(slotNo)
          self.effectCtrl[slotNo]:SetCheck(isSet == true)
        end
        slotBG:SetShow(false)
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",false)")
      else
        slot:clearItem()
        slot.icon:SetEnable(true)
        slotBG:SetShow(true)
        slot.icon:EraseAllEffect()
        if _ContentsGroup_ItemSkillOption == true and self.effectCtrl[slotNo] ~= nil then
          self.effectCtrl[slotNo]:SetShow(false)
          self.effectCtrl[slotNo]:SetCheck(true)
        end
        if __eEquipSlotNoAwakenWeapon == slotNo then
          local isAwakenWeaponSlotShow = true == self._awakenWeaponContentsOpen or true == _ContentsGroup_AwakenWeaponCommonSlot
          slotBG:SetShow(isAwakenWeaponSlotShow)
          slot.icon:SetEnable(isAwakenWeaponSlotShow)
          slot.icon:SetShow(isAwakenWeaponSlotShow)
        elseif __eEquipSlotNoAvatarAwakenWeapon == slotNo then
          local isShow = self._awakenWeaponContentsOpen
          if __eClassType_ShyWaman == getSelfPlayer():getClassType() then
            isShow = false
          end
          slotBG:SetShow(isShow)
          slot.icon:SetEnable(isShow)
          slot.icon:SetShow(isShow)
        end
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_EmptySlotTooltip(" .. slotNo .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_EmptySlotTooltip(" .. slotNo .. ",false)")
        if __eEquipSlotNoLantern == slotNo then
          slot.icon:SetShow(false)
          slotBG:SetShow(false)
        end
        if _ContentsGroup_ArtifactItem == false and (__eEquipSlotNoArtifact1 == slotNo or __eEquipSlotNoArtifact2 == slotNo) then
          slot.icon:SetShow(false)
          slotBG:SetShow(false)
        end
      end
    end
  end
  if true == checkExtendedSlot then
    for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = ToClient_getEquipmentItem(parentSlotNo)
      local setSlotBG = self.slotBGs[extendSlotNo]
      slot = self.slots[extendSlotNo]
      setSlotBG:SetShow(false)
      PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, true, true)
    end
  end
  if false == _ContentsGroup_AlchemyStone then
    self.slotBGs[__eEquipSlotNoAlchemyStone]:SetShow(false)
    self.slots[__eEquipSlotNoAlchemyStone].icon:SetShow(false)
    self._ui.txt_alchemyStoneQuickKey:SetShow(false)
  end
  local alchemyStoneItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAlchemyStone)
  if nil == alchemyStoneItemWrapper then
    self._ui.check_alchemyStone:SetShow(false)
    self._ui.check_alchemyStone:SetCheck(false)
    HandleEventLUp_Equipment_All_AlchemyStoneCheckEvent(false)
  elseif true == Panel_Dialog_Repair_Function_All:GetShow() then
    self._ui.check_alchemyStone:SetShow(false)
  else
    self._ui.check_alchemyStone:SetShow(true)
  end
  if true == self._isUsedAlchemyStone then
    self._isUsedAlchemyStone = false
    if nil ~= alchemyStoneItemWrapper and nil ~= alchemyStoneItemWrapper and self._ui.check_alchemyStone:IsCheck() and 0 < alchemyStoneItemWrapper:get():getEndurance() then
      useAlchemyStone()
    end
  end
  local alchemyStoneQuickKeyString = keyCustom_GetString_UiKey(__eUiInputType_AlchemyStone)
  self._ui.txt_alchemyStoneQuickKey:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_QUICKCOMMAND", "keyString", alchemyStoneQuickKeyString))
  if true == _ContentsGroup_NewUI_Fishing_All then
    if Panel_Global_Manual:GetShow() or PaGlobal_Fishing_All_GetShowPanel() then
      PaGlobal_Fishing_All_UpdateFishingResourceText()
    end
  else
    if Panel_Global_Manual:GetShow() then
      setFishingResourcePool_text()
    end
    if Panel_Fishing:GetShow() then
      setFishingResourcePool_text()
    end
  end
  if false == ToClient_IsContentsGroupOpen("335") then
    self.slotBGs[__eEquipSlotNoQuestBook]:SetShow(false)
    self.slots[__eEquipSlotNoQuestBook].icon:SetShow(false)
    self.slots[__eEquipSlotNoQuestBook].icon:addInputEvent("Mouse_LUp", "")
  else
    self.slots[__eEquipSlotNoQuestBook].icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_QuestBook()")
  end
  interaction_Forceed()
  ToClient_updateAttackStat()
  PaGlobal_Equipment_All:updateAbility()
end
function PaGlobal_Equipment_All:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  if false == isExtended then
    slot.icon:SetEnable(true)
  else
    slot.icon:SetEnable(false)
  end
  if true == isMono then
    slot.icon:SetMonoTone(true)
  elseif false == isMono then
    slot.icon:SetMonoTone(false)
  end
end
function PaGlobal_Equipment_All:hideUnderwear()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  selfPlayer:get():setUnderwearModeInhouse(false)
  selfPlayer:get():setSwimmingSuitMode(false)
  Toclient_setShowAvatarEquip()
  PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
end
function PaGlobal_Equipment_All:updateUnderwearSlot(slotNo)
  if __eEquipSlotNoAvatarUnderwear ~= slotNo then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:get():isWearingUnderwear() then
    if true == selfPlayer:get():getSwimmingSuitMode() then
      selfPlayer:get():setSwimmingSuitMode(false)
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
    end
  elseif true == selfPlayer:get():isWearingSwimmingSuit() and true == selfPlayer:get():getUnderwearModeInhouse() then
    selfPlayer:get():setUnderwearModeInhouse(false)
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
  end
end
function PaGlobal_Equipment_All:updateHelmIcon()
  if true == self._ui.check_helmInvisual:IsCheck() then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_helmInvisualIcon, 79, 163, 104, 188)
    self._ui.stc_helmInvisualIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_helmInvisualIcon:setRenderTexture(self._ui.stc_helmInvisualIcon:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_helmInvisualIcon, 53, 163, 78, 188)
    self._ui.stc_helmInvisualIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_helmInvisualIcon:setRenderTexture(self._ui.stc_helmInvisualIcon:getBaseTexture())
  end
  if true == self._ui.check_helmOpen:IsCheck() then
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_helmOpenIcon, 53, 163, 78, 188)
    self._ui.stc_helmOpenIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_helmOpenIcon:setRenderTexture(self._ui.stc_helmOpenIcon:getBaseTexture())
  else
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_helmOpenIcon, 79, 163, 104, 188)
    self._ui.stc_helmOpenIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_helmOpenIcon:setRenderTexture(self._ui.stc_helmOpenIcon:getBaseTexture())
  end
end
