function PaGlobal_ElfWarMiniMap:updateMiniMapBossObject(elfWarTeamNo)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local elfWarBossInfo = ToClient_GetElfWarBossInfoXXX(elfWarTeamNo)
  if elfWarBossInfo == nil then
    return
  end
  local elfWarBossInfoWrapper = ToClient_GetElfWarBossInfoWrapper(elfWarTeamNo)
  if elfWarBossInfoWrapper == nil then
    return
  end
  if self._miniMapBossIconList[elfWarTeamNo] == nil or self._miniMapBossIconList[elfWarTeamNo]._isSet == false then
    local newControl
    if self._miniMapBossIconList[elfWarTeamNo] == nil then
      local boss_Template = UI.getChildControl(Panel_ElfWar_MiniMap, "Static_Castle_Template")
      local controlId = "Static_Castle_" .. tostring(elfWarTeamNo)
      newControl = UI.cloneControl(boss_Template, self._ui._stc_miniMapBg, controlId)
      if newControl == nil then
        UI.ASSERT_NAME(false, "\236\151\152\237\148\132\236\160\132\236\159\129 \234\178\169\236\160\132\236\167\128 \236\180\157\236\130\172\235\160\185\234\180\128 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
        return
      end
    else
      newControl = self._miniMapBossIconList[elfWarTeamNo]._control
    end
    local iconBox = UI.getChildControl(newControl, "Static_BossIcon_Box")
    local iconBg = UI.getChildControl(iconBox, "Static_BossIconBG")
    local iconImg = UI.getChildControl(iconBox, "Static_BossIcon")
    local iconProgressBar = UI.getChildControl(iconBox, "CircularProgress_BossHP")
    local miniIconBox = UI.getChildControl(newControl, "Static_BossIcon_MiniBox")
    local miniIconBg = UI.getChildControl(miniIconBox, "Static_BossIconBG")
    local miniIconImg = UI.getChildControl(miniIconBox, "Static_BossIcon")
    local miniIconProgressBar = UI.getChildControl(miniIconBox, "CircularProgress_BossHP")
    iconProgressBar:SetProgressRate(100)
    miniIconProgressBar:SetProgressRate(100)
    newControl:SetIgnore(false)
    newControl:SetShow(true)
    newControl:SetDepth(self._eRenderOrder.FIERCE_BATTLE_ICON)
    newControl:SetPosX(3000)
    newControl:SetPosY(3000)
    newControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMiniMap_LClickedBossIcon(" .. tostring(elfWarTeamNo) .. ")")
    newControl:addInputEvent("Mouse_On", "HandleEventOnOut_ElfWarMiniMap_OnOutBossIcon(" .. tostring(elfWarTeamNo) .. ", true)")
    newControl:addInputEvent("Mouse_Out", "HandleEventOnOut_ElfWarMiniMap_OnOutBossIcon(" .. tostring(elfWarTeamNo) .. ", false)")
    newControl:addInputEvent("Mouse_RUp", "HandleEventRUp_ElfWarMiniMap_RClickedElfwarBossIcon(" .. tostring(elfWarTeamNo) .. ")")
    newControl:addInputEvent("Mouse_UpScroll", "ElfWarMiniMap_MouseScroll(true)")
    newControl:addInputEvent("Mouse_DownScroll", "ElfWarMiniMap_MouseScroll(false)")
    local bossIconOrigianlSize = float2(0, 0)
    local hpProgressOriginalSize = float2(0, 0)
    local miniBossIconOrigianlSize = float2(0, 0)
    local miniHpProgressOriginalSize = float2(0, 0)
    bossIconOrigianlSize.x = iconImg:GetSizeX()
    bossIconOrigianlSize.y = iconImg:GetSizeY()
    miniBossIconOrigianlSize.x = miniIconImg:GetSizeX()
    miniBossIconOrigianlSize.y = miniIconImg:GetSizeY()
    hpProgressOriginalSize.x = iconProgressBar:GetSizeX()
    hpProgressOriginalSize.y = iconProgressBar:GetSizeY()
    miniHpProgressOriginalSize.x = miniIconProgressBar:GetSizeX()
    miniHpProgressOriginalSize.y = miniIconProgressBar:GetSizeY()
    local bigIconControl = {
      _box = iconBox,
      _bg = iconBg,
      _icon = iconImg,
      _progressBar = iconProgressBar,
      _iconOrgSize = bossIconOrigianlSize,
      _progressBarOrgSize = hpProgressOriginalSize
    }
    local miniIconControl = {
      _box = miniIconBox,
      _bg = miniIconBg,
      _icon = miniIconImg,
      _progressBar = miniIconProgressBar,
      _iconOrgSize = miniBossIconOrigianlSize,
      _progressBarOrgSize = miniHpProgressOriginalSize
    }
    self._miniMapBossIconList[elfWarTeamNo] = {
      _control = newControl,
      _bigIconControl = bigIconControl,
      _miniIconControl = miniIconControl,
      _characterKey = elfWarBossInfoWrapper:getCharacterKeyRaw(),
      _position = elfWarBossInfo._position,
      _originUiSize = float2(0, 0),
      _lastCalcPosRate = float2(0, 0),
      _hpRatio = 100,
      _isSet = true
    }
    local selfPlayerWrapper = getSelfPlayer()
    if selfPlayerWrapper == nil then
      return
    end
    local textureKey, textureKeyOn, textureKeyClick, onX1, onY1, onX2, onY2, clickX1, clickY1, clickX2, clickY2
    local selfElfWarTeamNo = selfPlayerWrapper:getElfWarTeamNo()
    if ToClient_IsElfWarObserveMode() == true then
      selfElfWarTeamNo = ToClient_GetElfObserveTeamNo()
    end
    local isBlue = elfWarTeamNo == selfElfWarTeamNo
    if isBlue == true then
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Main_BlueCastle"
      textureKeyOn = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Main_BlueCastle_On"
      textureKeyClick = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Main_BlueCastle_OnClick"
      newControl:ChangeTextureInfoTextureIDKey(textureKeyOn, __eUITextureTypeOn)
      newControl:ChangeTextureInfoTextureIDKey(textureKeyClick, __eUITextureTypeClick)
      newControl:ChangeTextureInfoTextureIDKey(textureKey)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(newControl, 555, 359, 635, 439)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(newControl, 1144, 858, 1224, 938)
    else
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Main_RedCastle"
      textureKeyOn = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Main_RedCastle_On"
      textureKeyClick = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Main_RedCastle_OnClick"
      newControl:ChangeTextureInfoTextureIDKey(textureKeyOn, __eUITextureTypeOn)
      newControl:ChangeTextureInfoTextureIDKey(textureKeyClick, __eUITextureTypeClick)
      newControl:ChangeTextureInfoTextureIDKey(textureKey)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(newControl, 474, 359, 554, 439)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(newControl, 1063, 858, 1143, 938)
    end
    newControl:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
    newControl:getOnTexture():setUV(onX1, onY1, onX2, onY2)
    newControl:setRenderTexture(newControl:getBaseTexture())
    local miniProfileTexture = "Combine_Etc_ElfWar_Command_Wight_Progress_Map_Info_Profile_Small_Odil"
    local profileTexture = "Combine_Etc_ElfWar_Command_Wight_Frm_Map_Info_Profile_Odil"
    if elfWarTeamNo == Defines.ElfWarTeamNo.KAMASYLVIA then
      miniProfileTexture = "Combine_Etc_ElfWar_Command_Wight_Progress_Map_Info_Profile_Small_Kama"
      profileTexture = "Combine_Etc_ElfWar_Command_Wight_Frm_Map_Info_Profile_Kama"
    end
    iconImg:ChangeTextureInfoTextureIDKey(profileTexture)
    iconImg:setRenderTexture(iconImg:getBaseTexture())
    miniIconImg:ChangeTextureInfoTextureIDKey(miniProfileTexture)
    miniIconImg:setRenderTexture(miniIconImg:getBaseTexture())
  else
    local bossIconData = self._miniMapBossIconList[elfWarTeamNo]
    local hpRatioHundred = elfWarBossInfo._currentHpRatio * 100
    if bossIconData._hpRatio > 20 and hpRatioHundred <= 20 then
      bossIconData._control:EraseAllEffect()
      bossIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Fire_01B", true, 0, 0)
    elseif bossIconData._hpRatio > 40 and hpRatioHundred <= 40 then
      bossIconData._control:EraseAllEffect()
      bossIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Fire_01A", true, 0, 0)
    elseif bossIconData._hpRatio > 60 and hpRatioHundred <= 60 then
      bossIconData._control:EraseAllEffect()
      bossIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Smoke_01B", true, 0, 0)
    elseif bossIconData._hpRatio > 80 and hpRatioHundred <= 80 then
      bossIconData._control:EraseAllEffect()
      bossIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Smoke_01A", true, 0, 0)
    elseif hpRatioHundred == 100 then
      bossIconData._control:EraseAllEffect()
    end
    if math.floor(hpRatioHundred / 20) < math.floor(bossIconData._hpRatio / 20) then
      bossIconData._control:AddEffect("fUI_RoseWar_Map_Circle_01A", false, 0, 0)
      audioPostEvent_SystemUi(35, 1)
      _AudioPostEvent_SystemUiForXBOX(35, 1)
    end
    bossIconData._bigIconControl._progressBar:SetProgressRate(hpRatioHundred)
    bossIconData._miniIconControl._progressBar:SetProgressRate(hpRatioHundred)
    bossIconData._hpRatio = hpRatioHundred
  end
  if elfWarBossInfo ~= nil then
    local viewRange = ToClient_GetElfWarMiniMapDetectDistanceLimitForCastle()
    local centerPos = elfWarBossInfo._position
    local leftTopPos = float3(centerPos.x - viewRange, centerPos.y, centerPos.z + viewRange)
    local rightBottomPos = float3(centerPos.x + viewRange, centerPos.y, centerPos.z - viewRange)
    local leftTopPosRate = self:calcWorldPositionToMiniMapPosRate(leftTopPos)
    local rightBottomPosRate = self:calcWorldPositionToMiniMapPosRate(rightBottomPos)
    elfWarBossInfo._fogLeftTopPos.x = leftTopPosRate.x
    elfWarBossInfo._fogLeftTopPos.y = leftTopPosRate.y
    elfWarBossInfo._fogRightBottomPos.x = rightBottomPosRate.x
    elfWarBossInfo._fogRightBottomPos.y = rightBottomPosRate.y
  end
end
function PaGlobal_ElfWarMiniMap:refreshMiniMapBossObject()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  for index = 0, Defines.ElfWarTeamNo.COUNT - 1 do
    local elfWarBossData = self._miniMapBossIconList[index]
    if elfWarBossData ~= nil then
      local posRate = self:calcWorldPositionToMiniMapPosRate(elfWarBossData._position)
      local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * posRate.x - elfWarBossData._control:GetSizeX() / 2
      local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * posRate.y - elfWarBossData._control:GetSizeY() / 1.5
      elfWarBossData._control:SetPosX(newPosX)
      elfWarBossData._control:SetPosY(newPosY)
      self:correctCircleProgressbar(elfWarBossData._control, newPosX, newPosY)
    end
  end
end
function PaGlobal_ElfWarMiniMap:deactivateBossIconAll()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  for index = 0, Defines.ElfWarTeamNo.COUNT - 1 do
    local elfWarBossData = self._miniMapBossIconList[index]
    if elfWarBossData ~= nil then
      elfWarBossData._isSet = false
      elfWarBossData._control:SetShow(false)
    end
  end
end
function PaGlobal_ElfWarMiniMap:makeMiniMapFierceBattleObject()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local totalIndex = 0
  self._miniMapFierceBattleIconList = {}
  local fierceBattleObject_Template = UI.getChildControl(Panel_ElfWar_MiniMap, "Static_FierceBattleObject_Template")
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    self:addMiniMapFierceBattleObject(fierceBattleObject_Template, index)
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_ElfWarMiniMap:exepandMiniMapFierceBattleObjectPool()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local exepandCount = self._eExpandPoolCount.MINIMAP_FIERCEBATTLE_OBJECT
  local currentPoolCount = self._miniMapFierceBattleIconPoolCount
  local newPoolCount = currentPoolCount + exepandCount
  local totalIndex = currentPoolCount
  local fierceBattleObject_Template = UI.getChildControl(Panel_ElfWar_MiniMap, "Static_FierceBattleObject_Template")
  for index = currentPoolCount, newPoolCount - 1 do
    self:addMiniMapFierceBattleObject(fierceBattleObject_Template, index)
    totalIndex = totalIndex + 1
  end
  self._miniMapFierceBattleIconPoolCount = newPoolCount
end
function PaGlobal_ElfWarMiniMap:addMiniMapFierceBattleObject(cloneControl, index)
  local controlId = "Static_Minimap_FierceBattleObject_" .. tostring(index)
  local newControl = UI.cloneControl(cloneControl, self._ui._stc_miniMapBg, controlId)
  if newControl == nil then
    UI.ASSERT_NAME(false, "\236\151\152\237\148\132\236\160\132\236\159\129 \234\178\169\236\160\132\236\167\128 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local iconBox = UI.getChildControl(newControl, "Static_BossIcon_Box")
  local iconBg = UI.getChildControl(iconBox, "Static_BossIconBG")
  local iconImg = UI.getChildControl(iconBox, "Static_BossIcon")
  local iconProgressBar = UI.getChildControl(iconBox, "CircularProgress_BossHP")
  local miniIconBox = UI.getChildControl(newControl, "Static_BossIcon_MiniBox")
  local miniIconBg = UI.getChildControl(miniIconBox, "Static_BossIconBG")
  local miniIconImg = UI.getChildControl(miniIconBox, "Static_BossIcon")
  local miniIconProgressBar = UI.getChildControl(miniIconBox, "CircularProgress_BossHP")
  iconProgressBar:SetProgressRate(100)
  miniIconProgressBar:SetProgressRate(100)
  newControl:SetShow(false)
  newControl:SetIgnore(false)
  newControl:SetSize(0, 0)
  newControl:SetPosX(0)
  newControl:SetPosY(0)
  newControl:SetDepth(self._eRenderOrder.FIERCE_BATTLE_ICON)
  local bossIconOrigianlSize = float2(0, 0)
  local bgOrigianlSize = float2(0, 0)
  local hpProgressOriginalSize = float2(0, 0)
  local miniBossIconOrigianlSize = float2(0, 0)
  local miniBgOrigianlSize = float2(0, 0)
  local miniHpProgressOriginalSize = float2(0, 0)
  bossIconOrigianlSize.x = iconImg:GetSizeX()
  bossIconOrigianlSize.y = iconImg:GetSizeY()
  miniBossIconOrigianlSize.x = miniIconImg:GetSizeX()
  miniBossIconOrigianlSize.y = miniIconImg:GetSizeY()
  bgOrigianlSize.x = iconBg:GetSizeX()
  bgOrigianlSize.y = iconBg:GetSizeY()
  miniBgOrigianlSize.x = miniIconBg:GetSizeX()
  miniBgOrigianlSize.y = miniIconBg:GetSizeY()
  hpProgressOriginalSize.x = iconProgressBar:GetSizeX()
  hpProgressOriginalSize.y = iconProgressBar:GetSizeY()
  miniHpProgressOriginalSize.x = miniIconProgressBar:GetSizeX()
  miniHpProgressOriginalSize.y = miniIconProgressBar:GetSizeY()
  local cooltimeText = UI.getChildControl(newControl, "StaticText_CoolTime")
  local rate_GreyBg = UI.getChildControl(newControl, "Static_Rate_CoolTime_Gray")
  local progGrey = UI.getChildControl(rate_GreyBg, "CircularProgress_Rate_CoolTime_Gray")
  local rate_RedBg = UI.getChildControl(newControl, "Static_Rate_CoolTime_Red")
  local progRed = UI.getChildControl(rate_RedBg, "CircularProgress_Rate_CoolTime_Red")
  local rate_BlueBG = UI.getChildControl(newControl, "Static_Rate_CoolTime_Blue")
  local progBlue = UI.getChildControl(rate_BlueBG, "CircularProgress_Rate_CoolTime_Blue")
  progGrey:SetProgressRate(0)
  progRed:SetProgressRate(0)
  progBlue:SetProgressRate(0)
  cooltimeText:SetShow(false)
  rate_GreyBg:SetShow(false)
  rate_RedBg:SetShow(false)
  rate_BlueBG:SetShow(false)
  local coolTimeTextOriginSize = float2(0, 0)
  local rateGreyBgOriginSize = float2(0, 0)
  local prog_GreyOriginSize = float2(0, 0)
  local prog_RedOriginSize = float2(0, 0)
  local prog_BlueOriginSize = float2(0, 0)
  coolTimeTextOriginSize.x = cooltimeText:GetSizeX()
  coolTimeTextOriginSize.y = cooltimeText:GetSizeY()
  rateGreyBgOriginSize.x = rate_GreyBg:GetSizeX()
  rateGreyBgOriginSize.y = rate_GreyBg:GetSizeY()
  prog_GreyOriginSize.x = progGrey:GetSizeX()
  prog_GreyOriginSize.y = progGrey:GetSizeY()
  prog_RedOriginSize.x = progRed:GetSizeX()
  prog_RedOriginSize.y = progRed:GetSizeY()
  prog_BlueOriginSize.x = progBlue:GetSizeX()
  prog_BlueOriginSize.y = progBlue:GetSizeY()
  local coolTimeControl = {
    _cooltimeText = cooltimeText,
    _rate_GreyBg = rate_GreyBg,
    _prog_Grey = progGrey,
    _rate_RedBg = rate_RedBg,
    _prog_Red = progRed,
    _rate_BlueBG = rate_BlueBG,
    _prog_Blue = progBlue,
    _coolTimeTextOriginSize = coolTimeTextOriginSize,
    _rateOriginBg = rateGreyBgOriginSize,
    _prog_GreyOriginSize = prog_GreyOriginSize,
    _prog_RedOriginSize = prog_RedOriginSize,
    _prog_BlueOriginSize = prog_BlueOriginSize
  }
  local bigIconControl = {
    _box = iconBox,
    _bg = iconBg,
    _icon = iconImg,
    _progressBar = iconProgressBar,
    _iconOrgSize = bossIconOrigianlSize,
    _bgOrgSize = bgOrigianlSize,
    _progressBarOrgSize = hpProgressOriginalSize
  }
  local miniIconControl = {
    _box = miniIconBox,
    _bg = miniIconBg,
    _icon = miniIconImg,
    _progressBar = miniIconProgressBar,
    _iconOrgSize = miniBossIconOrigianlSize,
    _bgOrgSize = miniBgOrigianlSize,
    _progressBarOrgSize = miniHpProgressOriginalSize
  }
  local static_FixedResurrectionPoint = UI.getChildControl(newControl, "Static_FixedResurrectionPoint")
  local txt_FixedResurrectionPointTime = UI.getChildControl(static_FixedResurrectionPoint, "StaticText_1")
  local fixedResurrectionSkillCoolTimeIcon = {
    _stc_bg = static_FixedResurrectionPoint,
    _txt_leftTime = txt_FixedResurrectionPointTime,
    _leftTime = 0
  }
  local fierceBattleIconData = {
    _control = newControl,
    _bigIconControl = bigIconControl,
    _miniIconControl = miniIconControl,
    _coolTimeControl = coolTimeControl,
    _fixedResurrectionSkillCoolTimeIcon = fixedResurrectionSkillCoolTimeIcon,
    _fierceBattleKeyRaw = nil,
    _elfWarTeamNo = nil,
    _originalSize = float2(0, 0),
    _lastCalcPosRate = float2(0, 0),
    _hpRatio = 100,
    _showFixedResurrectionSkillTime = false,
    _isFocused = false,
    _isSet = false
  }
  self._miniMapFierceBattleIconList[index] = fierceBattleIconData
end
function PaGlobal_ElfWarMiniMap:setFierceBattleObjectIconData(fierceBattleIconData, fierceBattleKeyRaw, elfWarTeamNo, lastCalcPosRate, isSet)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if fierceBattleIconData == nil then
    return
  end
  fierceBattleIconData._fierceBattleKeyRaw = fierceBattleKeyRaw
  fierceBattleIconData._elfWarTeamNo = elfWarTeamNo
  fierceBattleIconData._lastCalcPosRate = lastCalcPosRate
  fierceBattleIconData._isSet = isSet
  fierceBattleIconData._control:SetShow(isSet)
  if isSet == true then
    fierceBattleIconData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMiniMap_ClickedFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", false)")
    fierceBattleIconData._control:addInputEvent("Mouse_On", "HandleEventOnOut_ElfWarMiniMap_OnOutFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", true)")
    fierceBattleIconData._control:addInputEvent("Mouse_Out", "HandleEventOnOut_ElfWarMiniMap_OnOutFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", false)")
    fierceBattleIconData._control:addInputEvent("Mouse_RUp", "HandleEventRUp_ElfWarMiniMap_RClickedFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ")")
    fierceBattleIconData._control:addInputEvent("Mouse_UpScroll", "ElfWarMiniMap_MouseScroll(true)")
    fierceBattleIconData._control:addInputEvent("Mouse_DownScroll", "ElfWarMiniMap_MouseScroll(false)")
  else
    fierceBattleIconData._control:addInputEvent("Mouse_RUp", "")
    fierceBattleIconData._control:addInputEvent("Mouse_On", "")
    fierceBattleIconData._control:addInputEvent("Mouse_Out", "")
  end
  if fierceBattleKeyRaw ~= nil then
    local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
    if fierceBattleObjectInfoWrapper ~= nil then
      self:setFierceBattleObjectRespawnTime(fierceBattleKeyRaw, Int64toInt32(fierceBattleObjectInfoWrapper:getNextSpawnTime()))
    end
    local fixedPoint = ToClient_GetCurrentFixedResurrectionPoint()
    if fixedPoint ~= nil and fixedPoint:getFierceBattleKey() == fierceBattleKeyRaw and fixedPoint:getEndTime() > Int64toInt32(getServerUtc64()) then
      fierceBattleIconData._showFixedResurrectionSkillTime = true
      fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._stc_bg:SetShow(true)
      fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._leftTime = fixedPoint:getEndTime()
    end
  end
end
function PaGlobal_ElfWarMiniMap:makeMiniMapGimmickFierceBattleObject()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local totalIndex = 0
  self._miniMapGimmickFierceBattleIconList = {}
  local gimmickFierceBattleObject_Template = UI.getChildControl(Panel_ElfWar_MiniMap, "Static_GimmickFierceBattleObject_Template")
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    self:addMiniMapGimmickFierceBattleObject(gimmickFierceBattleObject_Template, index)
    totalIndex = totalIndex + 1
  end
end
function PaGlobal_ElfWarMiniMap:exepandMiniMapGimmickFierceBattleObjectPool()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  local exepandCount = self._eExpandPoolCount.MINIMAP_FIERCEBATTLE_OBJECT
  local currentPoolCount = self._miniMapGimmickFierceBattleIconPoolCount
  local newPoolCount = currentPoolCount + exepandCount
  local totalIndex = currentPoolCount
  local fierceBattleObject_Template = UI.getChildControl(Panel_ElfWar_MiniMap, "Static_GimmickFierceBattleObject_Template")
  for index = currentPoolCount, newPoolCount - 1 do
    self:addMiniMapGimmickFierceBattleObject(fierceBattleObject_Template, index)
    totalIndex = totalIndex + 1
  end
  self._miniMapGimmickFierceBattleIconPoolCount = newPoolCount
end
function PaGlobal_ElfWarMiniMap:addMiniMapGimmickFierceBattleObject(cloneControl, index)
  local controlId = "Static_Minimap_GimmickFierceBattleObject_" .. tostring(index)
  local newControl = UI.cloneControl(cloneControl, self._ui._stc_miniMapBg, controlId)
  if newControl == nil then
    UI.ASSERT_NAME(false, "\236\151\152\237\148\132\236\160\132\236\159\129 \234\178\169\236\160\132\236\167\128 \236\149\132\236\157\180\236\189\152 \236\131\157\236\132\177 \236\139\164\237\140\168. \236\136\152\236\160\149\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
    return
  end
  local cooltimeText = UI.getChildControl(newControl, "StaticText_CoolTime")
  local rateBG = UI.getChildControl(newControl, "Static_GimmickRateBG")
  local rateCoolTimeProgressBarBox = UI.getChildControl(newControl, "Static_GimmickRate_CoolTime")
  local rateCoolTimeProgressBar = UI.getChildControl(rateCoolTimeProgressBarBox, "CircularProgress_GimmickRate_CoolTime")
  local rateProgressBarBox = UI.getChildControl(newControl, "Static_GimmickRate_Rate")
  local rateProgressBar = UI.getChildControl(rateProgressBarBox, "CircularProgress_GimmickRate_Rate")
  rateCoolTimeProgressBar:SetProgressRate(100)
  rateCoolTimeProgressBarBox:SetShow(false)
  rateProgressBar:SetProgressRate(0)
  rateProgressBarBox:SetShow(true)
  newControl:SetShow(false)
  newControl:SetIgnore(false)
  newControl:SetPosX(0)
  newControl:SetPosY(0)
  newControl:SetDepth(self._eRenderOrder.FIERCE_BATTLE_ICON)
  local coolTimeTextOriginSize = float2(0, 0)
  local rateBGOriginSize = float2(0, 0)
  local rateCoolTimeProgressBarOriginSize = float2(0, 0)
  local rateProgressBarOriginSize = float2(0, 0)
  coolTimeTextOriginSize.x = cooltimeText:GetSizeX()
  coolTimeTextOriginSize.y = cooltimeText:GetSizeY()
  rateBGOriginSize.x = rateBG:GetSizeX()
  rateBGOriginSize.y = rateBG:GetSizeY()
  rateCoolTimeProgressBarOriginSize.x = rateCoolTimeProgressBar:GetSizeX()
  rateCoolTimeProgressBarOriginSize.y = rateCoolTimeProgressBar:GetSizeY()
  rateProgressBarOriginSize.x = rateProgressBar:GetSizeX()
  rateProgressBarOriginSize.y = rateProgressBar:GetSizeY()
  local childControl = {
    _cooltimeText = cooltimeText,
    _rateBG = rateBG,
    _rateCoolTimeProgressBarBox = rateCoolTimeProgressBarBox,
    _rateCoolTimeProgressBar = rateCoolTimeProgressBar,
    _rateProgressBarBox = rateProgressBarBox,
    _rateProgressBar = rateProgressBar,
    _coolTimeTextOriginSize = coolTimeTextOriginSize,
    _rateBGOriginSize = rateBGOriginSize,
    _rateCoolTimeProgressBarOriginSize = rateCoolTimeProgressBarOriginSize,
    _rateProgressBarOriginSize = rateProgressBarOriginSize
  }
  local fierceBattleIconData = {
    _control = newControl,
    _childControl = childControl,
    _fierceBattleKeyRaw = nil,
    _elfWarTeamNo = nil,
    _nextSpawnTime = 0,
    _isDead = false,
    _isEffectOn = false,
    _adrenalinRate = 0,
    _originalSize = float2(0, 0),
    _lastCalcPosRate = float2(0, 0),
    _isFocused = false,
    _isSet = false
  }
  self._miniMapGimmickFierceBattleIconList[index] = fierceBattleIconData
end
function PaGlobal_ElfWarMiniMap:setGimmickFierceBattleObjectIconData(elfWarGimmickIconData, fierceBattleKeyRaw, elfWarTeamNo, lastCalcPosRate, nextSpawnTime, isSet)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if elfWarGimmickIconData == nil then
    return
  end
  elfWarGimmickIconData._fierceBattleKeyRaw = fierceBattleKeyRaw
  elfWarGimmickIconData._elfWarTeamNo = elfWarTeamNo
  elfWarGimmickIconData._lastCalcPosRate = lastCalcPosRate
  elfWarGimmickIconData._nextSpawnTime = nextSpawnTime
  elfWarGimmickIconData._isSet = isSet
  elfWarGimmickIconData._control:SetShow(isSet)
  if isSet == true then
    elfWarGimmickIconData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarMiniMap_ClickedFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", true)")
    elfWarGimmickIconData._control:addInputEvent("Mouse_On", "HandleEventOnOut_ElfWarMiniMap_OnOutFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", true)")
    elfWarGimmickIconData._control:addInputEvent("Mouse_Out", "HandleEventOnOut_ElfWarMiniMap_OnOutFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ", false)")
    elfWarGimmickIconData._control:addInputEvent("Mouse_RUp", "HandleEventRUp_ElfWarMiniMap_RClickedFierceBattleObjectIcon(" .. tostring(fierceBattleKeyRaw) .. ")")
    elfWarGimmickIconData._control:addInputEvent("Mouse_UpScroll", "ElfWarMiniMap_MouseScroll(true)")
    elfWarGimmickIconData._control:addInputEvent("Mouse_DownScroll", "ElfWarMiniMap_MouseScroll(false)")
    if fierceBattleKeyRaw ~= nil then
      local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
      if fierceBattleObjectInfoWrapper ~= nil then
        self:updateGimmickFierceBattleObjectIcon(fierceBattleKeyRaw, fierceBattleObjectInfoWrapper:getAdrenalinPoint())
        self:setFierceBattleObjectRespawnTime(fierceBattleKeyRaw, Int64toInt32(fierceBattleObjectInfoWrapper:getNextSpawnTime()))
      end
    end
  else
    elfWarGimmickIconData._control:addInputEvent("Mouse_RUp", "")
    elfWarGimmickIconData._control:addInputEvent("Mouse_On", "")
    elfWarGimmickIconData._control:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_ElfWarMiniMap:refreshMiniMapGimmickFierceBattleObject()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    local elfWarGimmickIconData = self._miniMapGimmickFierceBattleIconList[index]
    if elfWarGimmickIconData ~= nil then
      self:updateFierceBattleObjectIconPosition(elfWarGimmickIconData)
    end
  end
end
function PaGlobal_ElfWarMiniMap:activateFierceBattleObjectIcon(fierceBattleKeyRaw, elfWarTeamNo, worldPosition)
  if Panel_ElfWar_MiniMap == nil then
    return nil
  end
  local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
  if fierceBattleObjectInfoWrapper == nil then
    return nil
  end
  if ToClient_IsElfWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == true then
    for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
      local fierceBattleIconData = self._miniMapGimmickFierceBattleIconList[index]
      if fierceBattleIconData ~= nil and (fierceBattleIconData._fierceBattleKeyRaw == fierceBattleKeyRaw or fierceBattleIconData._isSet == false) then
        local posRate = self:calcWorldPositionToMiniMapPosRate(worldPosition)
        if 0 > posRate.x or 1 < posRate.x or 0 > posRate.y or 1 < posRate.y then
          self:setGimmickFierceBattleObjectIconData(fierceBattleIconData, nil, nil, float2(0, 0), 0, false)
          return nil
        else
          fierceBattleIconData._lastCalcPosRate = posRate
          local fierceBattleObjectPtr = fierceBattleObjectInfoWrapper:getXXX()
          if fierceBattleObjectPtr ~= nil then
            local viewRange = ToClient_GetElfWarMiniMapDetectDistanceLimitForFierceBattle()
            local centerPos = worldPosition
            local leftTopPos = float3(centerPos.x - viewRange, centerPos.y, centerPos.z + viewRange)
            local rightBottomPos = float3(centerPos.x + viewRange, centerPos.y, centerPos.z - viewRange)
            local leftTopPosRate = self:calcWorldPositionToMiniMapPosRate(leftTopPos)
            local rightBottomPosRate = self:calcWorldPositionToMiniMapPosRate(rightBottomPos)
            fierceBattleObjectPtr._fogLeftTopPos.x = leftTopPosRate.x
            fierceBattleObjectPtr._fogLeftTopPos.y = leftTopPosRate.y
            fierceBattleObjectPtr._fogRightBottomPos.x = rightBottomPosRate.x
            fierceBattleObjectPtr._fogRightBottomPos.y = rightBottomPosRate.y
          end
          self:setGimmickFierceBattleObjectIconTexture(fierceBattleIconData)
          self:updateFierceBattleObjectIconPosition(fierceBattleIconData)
        end
        local nextSpawnTime = Int64toInt32(fierceBattleObjectInfoWrapper:getNextSpawnTime())
        self:setGimmickFierceBattleObjectIconData(fierceBattleIconData, fierceBattleKeyRaw, elfWarTeamNo, posRate, nextSpawnTime, true)
        return index
      end
    end
    self:exepandMiniMapGimmickFierceBattleObjectPool()
  else
    for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
      local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
      if fierceBattleIconData ~= nil and (fierceBattleIconData._fierceBattleKeyRaw == fierceBattleKeyRaw or fierceBattleIconData._isSet == false) then
        local isSuccess = self:setFierceBattleObjectIconTexture(fierceBattleIconData, elfWarTeamNo)
        if isSuccess == nil or isSuccess == false then
          self:setFierceBattleObjectIconData(fierceBattleIconData, nil, nil, float2(0, 0), false)
          return nil
        end
        local posRate = self:calcWorldPositionToMiniMapPosRate(worldPosition)
        if 0 > posRate.x or 1 < posRate.x or 0 > posRate.y or 1 < posRate.y then
          self:setFierceBattleObjectIconData(fierceBattleIconData, nil, nil, float2(0, 0), false)
          return nil
        else
          fierceBattleIconData._lastCalcPosRate = posRate
          local fierceBattleObjectPtr = fierceBattleObjectInfoWrapper:getXXX()
          if fierceBattleObjectPtr ~= nil then
            local viewRange = ToClient_GetElfWarMiniMapDetectDistanceLimitForFierceBattle()
            local centerPos = worldPosition
            local leftTopPos = float3(centerPos.x - viewRange, centerPos.y, centerPos.z + viewRange)
            local rightBottomPos = float3(centerPos.x + viewRange, centerPos.y, centerPos.z - viewRange)
            local leftTopPosRate = self:calcWorldPositionToMiniMapPosRate(leftTopPos)
            local rightBottomPosRate = self:calcWorldPositionToMiniMapPosRate(rightBottomPos)
            fierceBattleObjectPtr._fogLeftTopPos.x = leftTopPosRate.x
            fierceBattleObjectPtr._fogLeftTopPos.y = leftTopPosRate.y
            fierceBattleObjectPtr._fogRightBottomPos.x = rightBottomPosRate.x
            fierceBattleObjectPtr._fogRightBottomPos.y = rightBottomPosRate.y
          end
          local characterKey = fierceBattleObjectInfoWrapper:getCharacterKeyRaw()
          self:updateFierceBattleObjectCircleIcon(fierceBattleIconData, characterKey)
          self:updateFierceBattleObjectIconSize(fierceBattleIconData)
          self:updateFierceBattleObjectIconPosition(fierceBattleIconData)
        end
        self:setFierceBattleObjectIconData(fierceBattleIconData, fierceBattleKeyRaw, elfWarTeamNo, posRate, true)
        return index
      end
    end
    self:exepandMiniMapFierceBattleObjectPool()
  end
  return self:activateFierceBattleObjectIcon(fierceBattleKeyRaw, elfWarTeamNo, worldPosition)
end
function PaGlobal_ElfWarMiniMap:deactivateFierceBattleObjectIconAll()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if self._miniMapFierceBattleIconList == nil then
    return
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
    if fierceBattleIconData ~= nil then
      self:setFierceBattleObjectIconData(fierceBattleIconData, nil, nil, float2(0, 0), false)
    end
  end
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    local elfWarGimmickIconData = self._miniMapGimmickFierceBattleIconList[index]
    if elfWarGimmickIconData ~= nil then
      self:setGimmickFierceBattleObjectIconData(elfWarGimmickIconData, nil, nil, float2(0, 0), 0, false)
    end
  end
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectIcon(fierceBattleKeyRaw)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if self._miniMapFierceBattleIconList == nil then
    return
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
    if fierceBattleIconData ~= nil and fierceBattleIconData._isSet == true and fierceBattleIconData._fierceBattleKeyRaw == fierceBattleKeyRaw then
      if fierceBattleKeyRaw ~= nil then
        local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
        if fierceBattleObjectInfoWrapper ~= nil then
          local prevTeamNo = fierceBattleIconData._elfWarTeamNo
          local currTeamNo = fierceBattleObjectInfoWrapper:getTeamNo()
          if prevTeamNo ~= currTeamNo then
            self:responseChangeFierceBattleObjectTeamNo(fierceBattleIconData, currTeamNo)
          end
          self:updateHpBarFierceBattleObjectIcon(fierceBattleIconData, fierceBattleObjectInfoWrapper:getCurrentHpRatio())
          self:updateHpBarFireceBattleObjectTooltip(fierceBattleKeyRaw, false)
          PaGlobalElfWarTeamBuff_UpdateBuffDataList()
        end
      end
      break
    end
  end
end
function PaGlobal_ElfWarMiniMap:responseChangeFierceBattleObjectTeamNo(fierceBattleIconData, teamNo)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  self:setFierceBattleObjectIconTexture(fierceBattleIconData, teamNo)
  self:updateFierceBattleObjectIconSize(fierceBattleIconData)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  if ToClient_IsElfWarObserveMode() == true then
    selfPlayerTeamNo = ToClient_GetElfObserveTeamNo()
  end
  fierceBattleIconData._control:EraseAllEffect()
  if teamNo == Defines.ElfWarTeamNo.NEUTRAL then
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Change_02A_White", false, 0, 0)
    audioPostEvent_SystemUi(35, 11)
    _AudioPostEvent_SystemUiForXBOX(35, 11)
  elseif teamNo == selfPlayerWrapper:getElfWarTeamNo() then
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Change_02A_Blue", false, 0, 0)
    audioPostEvent_SystemUi(35, 16)
    _AudioPostEvent_SystemUiForXBOX(35, 16)
  else
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Change_02A_Red", false, 0, 0)
    audioPostEvent_SystemUi(35, 15)
    _AudioPostEvent_SystemUiForXBOX(35, 15)
  end
  fierceBattleIconData._elfWarTeamNo = teamNo
end
function PaGlobal_ElfWarMiniMap:updateAllHpBarXXX()
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
    if fierceBattleIconData ~= nil and fierceBattleIconData._isSet == true then
      local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleIconData._fierceBattleKeyRaw)
      if fierceBattleObjectInfoWrapper ~= nil then
        local hpRatioHundred = fierceBattleObjectInfoWrapper:getCurrentHpRatio() * 100
        fierceBattleIconData._bigIconControl._progressBar:SetProgressRate(hpRatioHundred)
        fierceBattleIconData._miniIconControl._progressBar:SetProgressRate(hpRatioHundred)
        fierceBattleIconData._bigIconControl._progressBar:ComputeProgressValue()
        fierceBattleIconData._miniIconControl._progressBar:ComputeProgressValue()
      end
    end
  end
  for index = 0, Defines.ElfWarTeamNo.COUNT - 1 do
    local elfWarBossData = self._miniMapBossIconList[index]
    if elfWarBossData ~= nil and elfWarBossData._isSet == true then
      local elfWarBossInfo = ToClient_GetElfWarBossInfoXXX(index)
      if elfWarBossInfo ~= nil then
        local hpRatioHundred = elfWarBossInfo._currentHpRatio * 100
        elfWarBossData._bigIconControl._progressBar:SetProgressRate(hpRatioHundred)
        elfWarBossData._miniIconControl._progressBar:SetProgressRate(hpRatioHundred)
        elfWarBossData._bigIconControl._progressBar:ComputeProgressValue()
        elfWarBossData._miniIconControl._progressBar:ComputeProgressValue()
      end
    end
  end
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    local gimicFierceBattleIconData = self._miniMapGimmickFierceBattleIconList[index]
    if gimicFierceBattleIconData ~= nil and gimicFierceBattleIconData._isSet == true then
      local gimmicFierceBattleIconDataWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(gimicFierceBattleIconData._fierceBattleKeyRaw)
      if gimmicFierceBattleIconDataWrapper ~= nil then
        local adrenalinPoint = gimmicFierceBattleIconDataWrapper:getAdrenalinPoint()
        self:updateGimmickFierceBattleObjectIcon(gimicFierceBattleIconData._fierceBattleKeyRaw, adrenalinPoint)
      end
    end
  end
end
function PaGlobal_ElfWarMiniMap:updateHpBarFierceBattleObjectIcon(fierceBattleIconData, hpRatio)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if fierceBattleIconData == nil then
    return
  end
  local hpRatioHundred = hpRatio * 100
  if fierceBattleIconData._hpRatio < 20 and hpRatioHundred >= 80 then
    fierceBattleIconData._control:EraseAllEffect()
  elseif fierceBattleIconData._hpRatio > 20 and hpRatioHundred <= 20 then
    fierceBattleIconData._control:EraseAllEffect()
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Fire_02B", true, 0, 0)
  elseif fierceBattleIconData._hpRatio > 40 and hpRatioHundred <= 40 then
    fierceBattleIconData._control:EraseAllEffect()
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Fire_02A", true, 0, 0)
  elseif fierceBattleIconData._hpRatio > 60 and hpRatioHundred <= 60 then
    fierceBattleIconData._control:EraseAllEffect()
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Smoke_02B", true, 0, 0)
  elseif fierceBattleIconData._hpRatio > 80 and hpRatioHundred <= 80 then
    fierceBattleIconData._control:EraseAllEffect()
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Damage_Smoke_02A", true, 0, 0)
  end
  if math.floor(hpRatioHundred / 20) < math.floor(fierceBattleIconData._hpRatio / 20) then
    fierceBattleIconData._control:AddEffect("fUI_RoseWar_Map_Circle_01A", false, 0, 0)
    audioPostEvent_SystemUi(35, 1)
    _AudioPostEvent_SystemUiForXBOX(35, 1)
  end
  fierceBattleIconData._bigIconControl._progressBar:SetProgressRate(hpRatioHundred)
  fierceBattleIconData._miniIconControl._progressBar:SetProgressRate(hpRatioHundred)
  fierceBattleIconData._hpRatio = hpRatioHundred
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectCircleIcon(fierceBattleIconData, characterKey)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  if characterKey == nil then
    return
  end
  if fierceBattleIconData == nil then
    return
  end
  local imagePath = ToClient_GetElfWarFierceBattleObjectIconPath(characterKey)
  if imagePath ~= "" then
    fierceBattleIconData._bigIconControl._icon:ChangeTextureInfoName(imagePath)
    fierceBattleIconData._miniIconControl._icon:ChangeTextureInfoName(imagePath)
  else
    UI.ASSERT_NAME(false, "\235\170\172\236\138\164\237\132\176 \236\149\132\236\157\180\236\189\152\236\157\132 \235\179\180\236\151\172\236\163\188\234\184\176 \236\156\132\237\149\156 \235\141\176\236\157\180\237\132\176\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164. Sheet::ElfWarNodeMonsterInfo", "\234\182\140\236\132\160\236\154\169")
  end
end
local minValue = 0.3
local maxValue = 0.8
local diff = maxValue - minValue
local period = 1.2
local ratio = math.pi / period
local accumulateTime = 0
function PaGlobal_ElfWarMiniMap:updatePreblendSightInfo(deltaTime)
  local skillType = PaGlobalFunc_ElfWarTeamSkillManager_GetSelectedSkillType()
  ToClient_RenderPreBlendSightInfo(skillType ~= nil)
  if skillType == nil then
    accumulateTime = 0
    return
  end
  accumulateTime = (accumulateTime + deltaTime) % period
  local pos = self:getCurrentMousePosRateOnMiniMap()
  local power = minValue + math.sin(accumulateTime * ratio) * diff
  ToClient_SetPreBlendSightInfo(skillType, pos.x, pos.y, power)
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectIconTextureAll()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  if ToClient_IsElfWarObserveMode() == true then
    selfPlayerTeamNo = ToClient_GetElfObserveTeamNo()
  end
  local TeamType = {
    NEUTRAL = 0,
    ALLY = 1,
    ENEMY = 2
  }
  local FocusType = {
    Base = 1,
    Over = 2,
    FixedResurrectionSkill = 3
  }
  local function updateFunc(iconData)
    if iconData == nil or iconData._isSet == false then
      return
    end
    local beforeTeamType = iconData._iconTeamType
    local beforeFocusType = iconData._iconFocusType
    iconData._iconTeamType = nil
    iconData._iconFocusType = nil
    if iconData._control == nil then
      return
    end
    if iconData._elfWarTeamNo == nil then
      return
    end
    local textureKey
    if iconData._elfWarTeamNo == Defines.ElfWarTeamNo.NEUTRAL then
      iconData._iconTeamType = TeamType.NEUTRAL
    elseif iconData._elfWarTeamNo == selfPlayerTeamNo then
      iconData._iconTeamType = TeamType.ALLY
    else
      iconData._iconTeamType = TeamType.ENEMY
    end
    local selectedSkillType = PaGlobal_ElfWarTeamSkillManager:getSkillType()
    if selectedSkillType ~= nil then
      if iconData._isFocused == true then
        iconData._iconFocusType = FocusType.Over
      else
        iconData._iconFocusType = FocusType.Base
      end
      if selectedSkillType == __eElfWarSkillType_Zonya and iconData._iconTeamType ~= TeamType.ALLY then
        iconData._iconFocusType = nil
      elseif selectedSkillType == __eElfWarSkillType_FixedResurrection and (iconData._fierceBattleKeyRaw == 1 or iconData._fierceBattleKeyRaw == 11) then
        iconData._iconFocusType = nil
      end
    end
    local fixedPoint = ToClient_GetCurrentFixedResurrectionPoint()
    local fixedResurrectionKey = -1
    if fixedPoint ~= nil and fixedPoint:getEndTime() > Int64toInt32(getServerUtc64()) and fixedPoint:getFierceBattleKey() == iconData._fierceBattleKeyRaw then
      iconData._showFixedResurrectionSkillTime = true
      iconData._fixedResurrectionSkillCoolTimeIcon._leftTime = fixedPoint:getEndTime()
      iconData._fixedResurrectionSkillCoolTimeIcon._stc_bg:SetShow(true)
    end
    if beforeFocusType == iconData._iconFocusType and beforeTeamType == iconData._iconTeamType then
      return
    end
    if iconData._iconFocusType == FocusType.FixedResurrectionSkill or beforeFocusType == FocusType.FixedResurrectionSkill then
    elseif iconData._iconFocusType == FocusType.Over then
      if iconData._iconTeamType == TeamType.ENEMY then
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_RedCastle_Point_Over"
      elseif iconData._iconTeamType == TeamType.ALLY then
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_BlueCastle_Point_Over"
      else
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_GrayCastle_Point_Over"
      end
    elseif iconData._iconFocusType == FocusType.Base then
      if iconData._iconTeamType == TeamType.ENEMY then
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_RedCastle_Point_Normal"
      elseif iconData._iconTeamType == TeamType.ALLY then
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_BlueCastle_Point_Normal"
      else
        textureKey = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_GrayCastle_Point_Normal"
      end
    elseif iconData._iconTeamType == TeamType.ENEMY then
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_RedCastle"
    elseif iconData._iconTeamType == TeamType.ALLY then
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_BlueCastle"
    else
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_Neutrality_Castle"
    end
    if textureKey == nil then
      return
    end
    iconData._control:ChangeTextureInfoTextureIDKey(textureKey)
    iconData._control:setRenderTexture(iconData._control:getBaseTexture())
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    updateFunc(self._miniMapFierceBattleIconList[index])
  end
end
function PaGlobal_ElfWarMiniMap:setGimmickFierceBattleObjectIconTexture(fierceBattleIconData)
  if Panel_ElfWar_MiniMap == nil then
    return false
  end
  if fierceBattleIconData == nil then
    return false
  end
  fierceBattleIconData._control:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Command_Icon_Map_Mode_3_Over", __eUITextureTypeOn)
  fierceBattleIconData._control:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Command_Icon_Map_Mode_3_Click", __eUITextureTypeClick)
  fierceBattleIconData._control:ChangeTextureInfoTextureIDKey("Combine_Etc_ElfWar_Command_Icon_Map_Mode_3", __eUITextureTypeBase)
  local onX1, onY1, onX2, onY2 = setTextureUV_Func(fierceBattleIconData._control, 1002, 959, 1072, 1029)
  local clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(fierceBattleIconData._control, 1073, 959, 1143, 1029)
  fierceBattleIconData._control:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
  fierceBattleIconData._control:getOnTexture():setUV(onX1, onY1, onX2, onY2)
  fierceBattleIconData._control:setRenderTexture(fierceBattleIconData._control:getBaseTexture())
end
function PaGlobal_ElfWarMiniMap:setFierceBattleObjectIconTexture(fierceBattleIconData, elfWarTeamNo)
  if Panel_ElfWar_MiniMap == nil then
    return false
  end
  if fierceBattleIconData == nil or elfWarTeamNo == nil then
    return false
  end
  local control = fierceBattleIconData._control
  if control == nil then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  local selfPlayerTeamNo = selfPlayerWrapper:getElfWarTeamNo()
  if ToClient_IsElfWarObserveMode() == true then
    selfPlayerTeamNo = ToClient_GetElfObserveTeamNo()
  end
  local textureKey, textureKeyOn, textureKeyClick, progressTextureKey, baseX1, baseY1, baseX2, baseY2, onX1, onY1, onX2, onY2, clickX1, clickY1, clickX2, clickY2
  if elfWarTeamNo == Defines.ElfWarTeamNo.NEUTRAL then
    textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_Neutrality_Castle"
    textureKeyOn = "Combine_Etc_ElfWar_Command_Icon_Map_Base_Neutrality_Castle_On"
    textureKeyClick = "Combine_Etc_ElfWar_Command_Icon_Map_Base_Neutrality_Castle_OnClick"
    progressTextureKey = "Combine_Etc_ElfWar_Command_Wight_Progress_Map_Info_Gray_Small"
    control:ChangeTextureInfoTextureIDKey(textureKeyClick, __eUITextureTypeClick)
    control:ChangeTextureInfoTextureIDKey(textureKeyOn, __eUITextureTypeOn)
    control:ChangeTextureInfoTextureIDKey(textureKey, __eUITextureTypeBase)
    baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 831, 55, 881, 105)
    onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 831, 106, 881, 156)
    clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 1301, 346, 1351, 396)
  else
    local isBlue = elfWarTeamNo == selfPlayerTeamNo
    if isBlue == true then
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_BlueCastle"
      textureKeyOn = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_BlueCastle_On"
      textureKeyClick = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_BlueCastle_OnClick"
      progressTextureKey = "Combine_Etc_ElfWar_Command_Wight_Progress_Map_Info_Blue_Small"
      control:ChangeTextureInfoTextureIDKey(textureKeyClick, __eUITextureTypeClick)
      control:ChangeTextureInfoTextureIDKey(textureKeyOn, __eUITextureTypeOn)
      control:ChangeTextureInfoTextureIDKey(textureKey, __eUITextureTypeBase)
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 513, 55, 563, 105)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 525, 308, 575, 358)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 1250, 346, 1300, 396)
    else
      textureKey = "Combine_Etc_ElfWar_Command_Icon_Map_Base_RedCastle"
      textureKeyOn = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_RedCastle_On"
      textureKeyClick = "Combine_Etc_ElfWar_Command_Wight_Icon_Map_Base_RedCastle_OnClick"
      progressTextureKey = "Combine_Etc_ElfWar_Command_Wight_Progress_Map_Info_Red_Small"
      control:ChangeTextureInfoTextureIDKey(textureKeyClick, __eUITextureTypeClick)
      control:ChangeTextureInfoTextureIDKey(textureKeyOn, __eUITextureTypeOn)
      control:ChangeTextureInfoTextureIDKey(textureKey, __eUITextureTypeBase)
      baseX1, baseY1, baseX2, baseY2 = setTextureUV_Func(control, 462, 55, 512, 105)
      onX1, onY1, onX2, onY2 = setTextureUV_Func(control, 474, 308, 524, 358)
      clickX1, clickY1, clickX2, clickY2 = setTextureUV_Func(control, 1199, 346, 1249, 396)
    end
  end
  if textureKey == nil then
    UI.ASSERT_NAME(false, "\236\151\152\237\148\132\236\160\132\236\159\129 \234\178\169\236\160\132\236\167\128 \236\149\132\236\157\180\236\189\152 \237\133\141\236\138\164\236\179\144 \237\130\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  control:getBaseTexture():setUV(baseX1, baseY1, baseX2, baseY2)
  control:getClickTexture():setUV(clickX1, clickY1, clickX2, clickY2)
  control:getOnTexture():setUV(onX1, onY1, onX2, onY2)
  control:setRenderTexture(control:getBaseTexture())
  fierceBattleIconData._bigIconControl._progressBar:ChangeTextureInfoTextureIDKey(progressTextureKey, __eUITextureTypeBase)
  fierceBattleIconData._bigIconControl._progressBar:setRenderTexture(fierceBattleIconData._bigIconControl._progressBar:getBaseTexture())
  fierceBattleIconData._miniIconControl._progressBar:ChangeTextureInfoTextureIDKey(progressTextureKey, __eUITextureTypeBase)
  fierceBattleIconData._miniIconControl._progressBar:setRenderTexture(fierceBattleIconData._miniIconControl._progressBar:getBaseTexture())
  local textureSize = ToClient_GetTextureSizeByKey(textureKey)
  fierceBattleIconData._originalSize.x = textureSize.x
  fierceBattleIconData._originalSize.y = textureSize.y
  control:SetSize(fierceBattleIconData._originalSize)
  control:SetEnableArea(0, 0, textureSize.x, textureSize.y)
  return true
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectIconPosition(fierceBattleIconData)
  if Panel_ElfWar_MiniMap == nil or fierceBattleIconData == nil then
    return
  end
  if self._miniMapControl == nil then
    return
  end
  local newPosX = self._miniMapControl:GetPosX() + self:getMiniMapSizeX() * fierceBattleIconData._lastCalcPosRate.x - fierceBattleIconData._control:GetSizeX() / 2
  local newPosY = self._miniMapControl:GetPosY() + self:getMiniMapSizeY() * fierceBattleIconData._lastCalcPosRate.y - fierceBattleIconData._control:GetSizeY() / 1.5
  fierceBattleIconData._control:SetPosX(newPosX)
  fierceBattleIconData._control:SetPosY(newPosY)
  self:correctCircleProgressbar(fierceBattleIconData._control, newPosX, newPosY)
end
function PaGlobal_ElfWarMiniMap:correctCircleProgressbar(uiCotrol, posX, posY)
  local childCount = uiCotrol:getChildControlCount()
  if childCount == 0 then
    return
  end
  for index = 0, childCount - 1 do
    local childControl = UI.getChildControlByIndex(uiCotrol, index)
    if childControl ~= nil then
      local tempPosX = posX + childControl:GetPosX()
      local tempPosY = posY + childControl:GetPosY()
      if childControl:GetType() == __ePAUIControl_CircularProgress then
        local limitPosMinX = self._miniMapBGLimitMinXY.x
        local limitPosMinY = self._miniMapBGLimitMinXY.y
        local limitPosMaxX = self._miniMapBGLimitMaxXY.x - childControl:GetSizeX()
        local limitPosMaxY = self._miniMapBGLimitMaxXY.y - childControl:GetSizeY()
        local isShow = tempPosX >= limitPosMinX and tempPosY >= limitPosMinY and tempPosX <= limitPosMaxX and tempPosY <= limitPosMaxY
        childControl:SetShow(isShow)
      end
      self:correctCircleProgressbar(childControl, tempPosX, tempPosY)
    end
  end
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectIconSize(fierceBattleIconData)
  if Panel_ElfWar_MiniMap == nil or fierceBattleIconData == nil then
    return
  end
  local newSizeRatio = 1 + (self._miniMapFierceBattleIconImageRateMax - 1) * self:getMiniMapScrollRate()
  self:updateFierceBattleObjectUISize(fierceBattleIconData._bigIconControl, newSizeRatio)
  self:updateFierceBattleObjectUISize(fierceBattleIconData._miniIconControl, newSizeRatio)
  local newSizeX = fierceBattleIconData._originalSize.x * newSizeRatio
  local newSizeY = fierceBattleIconData._originalSize.y * newSizeRatio
  fierceBattleIconData._control:SetSize(newSizeX, newSizeY)
  fierceBattleIconData._control:ComputePosAllChild()
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectUISize(controlData, newSizeRatio)
  local bossIconNewSizeX = controlData._iconOrgSize.x * newSizeRatio
  local bossIconNewSizeY = controlData._iconOrgSize.y * newSizeRatio
  controlData._icon:SetSize(bossIconNewSizeX, bossIconNewSizeY)
  local bgNewSizeX = controlData._bgOrgSize.x * newSizeRatio
  local bgNewSizeY = controlData._bgOrgSize.y * newSizeRatio
  controlData._bg:SetSize(bgNewSizeX, bgNewSizeY)
  local hpProgressNewSizeX = controlData._progressBarOrgSize.x * newSizeRatio
  local hpProgressNewSizeY = controlData._progressBarOrgSize.y * newSizeRatio
  controlData._progressBar:SetSize(hpProgressNewSizeX, hpProgressNewSizeY)
end
function PaGlobal_ElfWarMiniMap:refreshMiniMapFierceBattleObjectIconPos(doRefreshSize)
  if Panel_ElfWar_MiniMap == nil then
    return
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
    if fierceBattleIconData ~= nil and fierceBattleIconData._isSet == true then
      if doRefreshSize ~= nil and doRefreshSize == true then
        self:updateFierceBattleObjectIconSize(fierceBattleIconData)
      end
      self:updateFierceBattleObjectIconPosition(fierceBattleIconData)
    end
  end
  self:refreshMiniMapGimmickFierceBattleObject()
  self:refreshMiniMapBossObject()
end
function PaGlobal_ElfWarMiniMap:getFierceBattleObjectIcon(fierceBattleKeyRaw)
  if Panel_ElfWar_MiniMap == nil then
    return nil
  end
  local iconData = self:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if iconData == nil then
    return nil
  end
  return iconData._control
end
function PaGlobal_ElfWarMiniMap:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if Panel_ElfWar_MiniMap == nil then
    return nil
  end
  if fierceBattleKeyRaw == nil then
    return nil
  end
  local fierceBattleObjectInfoWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
  if fierceBattleObjectInfoWrapper == nil then
    return nil
  end
  if ToClient_IsElfWarGimicFierceBattle(fierceBattleObjectInfoWrapper:getCharacterKeyRaw()) == true then
    if self._miniMapGimmickFierceBattleIconList == nil then
      return nil
    end
    for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
      local gimmickFierceBattleIconData = self._miniMapGimmickFierceBattleIconList[index]
      if gimmickFierceBattleIconData ~= nil and gimmickFierceBattleIconData._isSet == true and gimmickFierceBattleIconData._fierceBattleKeyRaw == fierceBattleKeyRaw then
        return gimmickFierceBattleIconData
      end
    end
  else
    if self._miniMapFierceBattleIconList == nil then
      return nil
    end
    for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
      local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
      if fierceBattleIconData ~= nil and fierceBattleIconData._isSet == true and fierceBattleIconData._fierceBattleKeyRaw == fierceBattleKeyRaw then
        return fierceBattleIconData
      end
    end
  end
  return nil
end
function PaGlobal_ElfWarMiniMap:getFierceBattleObjectBuffDesc(fierceBattleKeyRaw)
  if fierceBattleKeyRaw == nil then
    return ""
  end
  local skillNo = ToClient_GetElfWarFierceBattleObjectSkillNo(fierceBattleKeyRaw)
  if skillNo == 0 then
    return ""
  end
  local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
  local buffList = ""
  if skillStaticWrapper ~= nil then
    for buffIdx = 0, skillStaticWrapper:getBuffCount() - 1 do
      local desc = skillStaticWrapper:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if nil == buffList or "" == buffList then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
    end
  end
  return buffList
end
function PaGlobal_ElfWarMiniMap:updateFierceBattleObjectRespawnTime(deltaTime)
  local curTime = Int64toInt32(getServerUtc64())
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    local elfWarGimmickIconData = self._miniMapGimmickFierceBattleIconList[index]
    if elfWarGimmickIconData ~= nil and elfWarGimmickIconData._isSet == true then
      if curTime < elfWarGimmickIconData._nextSpawnTime then
        local remainTime = elfWarGimmickIconData._nextSpawnTime - curTime
        local remainHundredRate = remainTime / self._gimmickRespawnTime * 100
        elfWarGimmickIconData._childControl._cooltimeText:SetShow(true)
        elfWarGimmickIconData._childControl._rateProgressBarBox:SetShow(false)
        elfWarGimmickIconData._childControl._rateCoolTimeProgressBarBox:SetShow(true)
        elfWarGimmickIconData._childControl._cooltimeText:SetText(tostring(remainTime))
        elfWarGimmickIconData._childControl._rateCoolTimeProgressBar:SetProgressRate(remainHundredRate + deltaTime)
        if elfWarGimmickIconData._isEffectOn == true then
          elfWarGimmickIconData._control:EraseAllEffect()
        end
      elseif elfWarGimmickIconData._isDead == true then
        local fierceBattleIconDataWrapper = ToClient_GetElfWarFierceBattleObjectInfoWrapper(elfWarGimmickIconData._fierceBattleKeyRaw)
        if fierceBattleIconDataWrapper ~= nil then
          self:updateGimmickFierceBattleObjectIcon(elfWarGimmickIconData._fierceBattleKeyRaw, 0)
        end
        elfWarGimmickIconData._childControl._cooltimeText:SetShow(false)
        elfWarGimmickIconData._childControl._rateCoolTimeProgressBarBox:SetShow(false)
        elfWarGimmickIconData._childControl._rateProgressBarBox:SetShow(true)
        elfWarGimmickIconData._isDead = false
      end
    end
  end
  for index = 0, self._miniMapFierceBattleIconPoolCount - 1 do
    local fierceBattleIconData = self._miniMapFierceBattleIconList[index]
    if fierceBattleIconData ~= nil and fierceBattleIconData._isSet == true then
      if curTime < fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._leftTime then
        fierceBattleIconData._showFixedResurrectionSkillTime = true
        fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._stc_bg:SetShow(true)
        local remainTime = fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._leftTime - curTime
        local time = convertSecondsToClockTime(remainTime)
        fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._txt_leftTime:SetText(time)
      elseif fierceBattleIconData._showFixedResurrectionSkillTime == true then
        fierceBattleIconData._showFixedResurrectionSkillTime = false
        fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._stc_bg:SetShow(false)
        fierceBattleIconData._fixedResurrectionSkillCoolTimeIcon._txt_leftTime:SetText(0)
        if PaGlobal_ElfWarTeamSkillManager ~= nil then
          PaGlobal_ElfWarTeamSkillManager:useSkill_postProcess(__eElfWarSkillType_FixedResurrection)
        end
      end
      if fierceBattleIconData._nextSpawnTime ~= nil and 0 < fierceBattleIconData._nextSpawnTime then
        if curTime < fierceBattleIconData._nextSpawnTime then
          local remainTime = fierceBattleIconData._nextSpawnTime - curTime
          local remainHundredRate = 0
          remainHundredRate = remainTime / self._gimmickRespawnTime * 100
          fierceBattleIconData._coolTimeControl._rate_GreyBg:SetShow(true)
          fierceBattleIconData._coolTimeControl._prog_Grey:SetProgressRate(remainHundredRate + deltaTime)
          fierceBattleIconData._coolTimeControl._cooltimeText:SetShow(true)
          fierceBattleIconData._coolTimeControl._cooltimeText:SetText(tostring(remainTime))
        else
          fierceBattleIconData._coolTimeControl._cooltimeText:SetShow(false)
          fierceBattleIconData._coolTimeControl._rate_GreyBg:SetShow(false)
          fierceBattleIconData._coolTimeControl._rate_BlueBG:SetShow(false)
        end
      end
    end
  end
end
function PaGlobal_ElfWarMiniMap:setFierceBattleObjectRespawnTime(fierceBattleKeyRaw, nextRespawnTime)
  if nextRespawnTime <= Int64toInt32(getServerUtc64()) then
    return
  end
  local miniMapIconData = self:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if miniMapIconData == nil then
    return
  end
  miniMapIconData._isDead = true
  miniMapIconData._nextSpawnTime = nextRespawnTime
end
function PaGlobal_ElfWarMiniMap:updateGimmickFierceBattleObjectIcon(fierceBattleKeyRaw, adrenalinPoint)
  if Panel_ElfWar_MiniMap == nil then
    return nil
  end
  local miniMapIconData = self:getFierceBattleObjectIconData(fierceBattleKeyRaw)
  if miniMapIconData == nil then
    return
  end
  local adrenalinRate = self:getAdrenalinRate(adrenalinPoint)
  if IsSelfPlayerElfWarGrade_Commander() == false and IsSelfPlayerElfWarGrade_SubCommander() == false then
    adrenalinRate = 0
  end
  if adrenalinRate < 90 then
    miniMapIconData._control:EraseAllEffect()
    miniMapIconData._isEffectOn = false
  elseif adrenalinRate > miniMapIconData._adrenalinRate and miniMapIconData._isEffectOn == false then
    miniMapIconData._control:AddEffect("fUI_RoseWar_Map_Box_01A", true, 0, 0)
    audioPostEvent_SystemUi(35, 2)
    _AudioPostEvent_SystemUiForXBOX(35, 2)
    miniMapIconData._isEffectOn = true
  end
  miniMapIconData._childControl._rateProgressBar:SetProgressRate(adrenalinRate)
  miniMapIconData._childControl._rateProgressBar:ComputeProgressValue()
  miniMapIconData._adrenalinRate = adrenalinRate
end
function PaGlobal_ElfWarMiniMap:gimmickFierceBattleComputeProgressValue()
  for index = 0, self._miniMapGimmickFierceBattleIconPoolCount - 1 do
    local gimmickFierceBattleIconData = self._miniMapGimmickFierceBattleIconList[index]
    if gimmickFierceBattleIconData ~= nil then
      gimmickFierceBattleIconData._childControl._rateProgressBar:ComputeProgressValue()
    end
  end
end
function PaGlobal_ElfWarMiniMap:getAdrenalinRate(adrenalinPoint)
  local adrenalinRate = 0
  if adrenalinPoint > 0 then
    adrenalinRate = adrenalinPoint / 10
    adrenalinRate = math.floor(adrenalinRate) / 50
  end
  return adrenalinRate
end
