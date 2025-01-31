Panel_RadarRealLine = {
  panel = nil,
  mapImage = {},
  mapValue = {},
  desertMapImage = {},
  desertMapValue = {},
  maxAlphaDesert = 0
}
local const = {imageSize = 256, size = 5}
local currentPosition = int3(0, 0, 0)
local currentRate = 0
local currentSelfPos = {x = 0, y = 0}
local currentAlpha = 1
local currentRadius = 0
local center = int2(0, 0)
local PIM = CppEnums.EProcessorInputMode
local floor = math.floor
function RadarMap_Init()
  Panel_RadarRealLine.panel = Panel_Radar
  local constImageSize = const.imageSize
  local constSize = const.size
  local reciprocalConstSize = 1 / constSize
  local loopCount = constSize * constSize - 1
  for index = 0, loopCount do
    Panel_RadarRealLine.mapImage[index] = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_minimap_Image_" .. index)
    Panel_RadarRealLine.mapImage[index]:SetShow(true)
    Panel_RadarRealLine.mapImage[index]:SetSize(constImageSize, constImageSize)
    Panel_RadarRealLine.mapImage[index]:SetIgnore(true)
    Panel_RadarRealLine.mapImage[index]:SetPosX(index % constSize * constImageSize)
    Panel_RadarRealLine.mapImage[index]:SetPosY(floor(index * reciprocalConstSize) * constImageSize)
    Panel_RadarRealLine.mapImage[index]:SetColor(Defines.Color.C_FFFFFFFF)
    Panel_RadarRealLine.mapImage[index]:SetDepth(2)
    Panel_RadarRealLine.mapValue[index] = int2(9999, 9999)
    Panel_RadarRealLine.panel:SetChildIndex(Panel_RadarRealLine.mapImage[index], index)
  end
  for index = 0, loopCount do
    Panel_RadarRealLine.desertMapImage[index] = UI.createControl(__ePAUIControl_Static, Panel_Radar, "Static_minimap_ImageDesert_" .. index)
    Panel_RadarRealLine.desertMapImage[index]:SetShow(false)
    Panel_RadarRealLine.desertMapImage[index]:SetSize(constImageSize, constImageSize)
    Panel_RadarRealLine.desertMapImage[index]:SetIgnore(true)
    Panel_RadarRealLine.desertMapImage[index]:SetPosX(index % constSize * constImageSize)
    Panel_RadarRealLine.desertMapImage[index]:SetPosY(floor(index * reciprocalConstSize) * constImageSize)
    Panel_RadarRealLine.desertMapImage[index]:SetColor(Defines.Color.C_FFFFFFFF)
    Panel_RadarRealLine.desertMapImage[index]:SetDepth(1)
    Panel_RadarRealLine.desertMapValue[index] = int2(9999, 9999)
    Panel_RadarRealLine.panel:SetChildIndex(Panel_RadarRealLine.desertMapImage[index], index + constSize * constSize)
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local regionInfoWrapper = selfPlayerWrapper:getRegionInfoWrapper()
  if nil == regionInfoWrapper then
    return
  end
  local desertMapImageContainer = Panel_RadarRealLine.desertMapImage
  if regionInfoWrapper:isDesert() and false == selfPlayerWrapper:isResistDesert() or regionInfoWrapper:isOcean() then
    Panel_RadarRealLine.maxAlphaDesert = 1
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(true)
      value:SetAlpha(1)
    end
  else
    Panel_RadarRealLine.maxAlphaDesert = 0
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(false)
      value:SetAlpha(0)
    end
  end
end
local function updatePanel()
  if getEnableSimpleUI() then
    local inputMode = getInputMode()
    local isUiMode = PIM.eProcessorInputMode_UiMode == inputMode or PIM.eProcessorInputMode_ChattingInputMode == inputMode
    local radarPosX = Panel_Radar:GetPosX()
    local radarPosY = Panel_Radar:GetPosY()
    local mousePosX = getMousePosX()
    local mousePosY = getMousePosY()
    local IsMouseOver = radarPosX < mousePosX and mousePosX < radarPosX + Panel_Radar:GetSizeX() and radarPosY < mousePosY and mousePosY < radarPosY + Panel_Radar:GetSizeY()
    isUiMode = isUiMode and IsMouseOver
  end
end
function FromClient_EnterToInstanceField_UpdateMiniMap()
  currentSelfPos.x = 9999
  currentSelfPos.y = 9999
  local constSize = const.size
  local loopCount = constSize * constSize - 1
  for index = 0, loopCount do
    Panel_RadarRealLine.mapValue[index] = int2(9999, 9999)
  end
end
local prevMaxAlpha
local function updateMapImage(position, deltaTime)
  if position.x == currentPosition.x and position.z == currentPosition.z and currentRate == RadarMap_GetDistanceToPixelRate() and currentSelfPos.x == RadarMap_GetSelfPosInRadar().x and currentSelfPos.y == RadarMap_GetSelfPosInRadar().y and Panel_RadarRealLine.maxAlphaDesert == prevMaxAlpha then
    return
  end
  prevMaxAlpha = Panel_RadarRealLine.maxAlphaDesert
  local regionInfoWrapper = getSelfPlayer():getRegionInfoWrapper()
  local isResistDesert = getSelfPlayer():isResistDesert()
  local isDesert = regionInfoWrapper:isDesert()
  local isOcean = regionInfoWrapper:isOcean()
  local desertMapImageContainer = Panel_RadarRealLine.desertMapImage
  if isDesert and false == isResistDesert or isOcean then
    Panel_RadarRealLine.maxAlphaDesert = Panel_RadarRealLine.maxAlphaDesert + deltaTime / 2
    if Panel_RadarRealLine.maxAlphaDesert > 1 then
      Panel_RadarRealLine.maxAlphaDesert = 1
    end
    local calcAlpha = Panel_RadarRealLine.maxAlphaDesert * currentAlpha
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(true)
      value:SetAlpha(calcAlpha)
    end
  elseif Panel_RadarRealLine.maxAlphaDesert > 0 then
    Panel_RadarRealLine.maxAlphaDesert = Panel_RadarRealLine.maxAlphaDesert - deltaTime / 2
    if Panel_RadarRealLine.maxAlphaDesert < 0 then
      Panel_RadarRealLine.maxAlphaDesert = 0
    end
    local calcAlpha = Panel_RadarRealLine.maxAlphaDesert * currentAlpha
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(true)
      value:SetAlpha(calcAlpha)
    end
  else
    for key, value in pairs(desertMapImageContainer) do
      value:SetShow(false)
      value:SetAlpha(0)
    end
  end
  currentSelfPos = {
    x = RadarMap_GetSelfPosInRadar().x,
    y = RadarMap_GetSelfPosInRadar().y
  }
  currentRate = RadarMap_GetDistanceToPixelRate()
  const.imageSize = floor(currentRate * 256)
  local constImageSize = const.imageSize
  local constSize = const.size
  local halfConstSize = floor(constSize / 2)
  local reciprocalConstSize = 1 / constSize
  currentPosition = position
  local currentSector = convertPosToSector(currentPosition)
  local inSectorPos = convertPosToInSectorPos(currentPosition)
  local startX = floor(-(inSectorPos.x * 0.01 * currentRate) * 2 - constImageSize * 2 + currentSelfPos.x)
  local startY = floor(inSectorPos.z * 0.01 * currentRate * 2 - constImageSize * 3 + currentSelfPos.y)
  local calcAlpha = (1 - Panel_RadarRealLine.maxAlphaDesert) * currentAlpha
  local radarPath = ToClient_getRadarPath() .. "Rader_"
  local loopCount = constSize * constSize - 1
  for index = 0, loopCount do
    local indexModConstSize = index % constSize
    local floorIndexDivConstSize = floor(index * reciprocalConstSize)
    local xSector = currentSector.x - halfConstSize + indexModConstSize
    local zSector = currentSector.z + halfConstSize - floorIndexDivConstSize
    local mapImage = Panel_RadarRealLine.mapImage[index]
    local mapValue = Panel_RadarRealLine.mapValue[index]
    if mapValue.x ~= xSector or mapValue.y ~= zSector then
      mapValue.x = xSector
      mapValue.y = zSector
      mapImage:ChangeTextureInfoNameForRadarBackground(radarPath .. xSector .. "_" .. zSector .. ".dds")
    end
    mapImage:SetPosX(startX + indexModConstSize * constImageSize)
    mapImage:SetPosY(startY + floorIndexDivConstSize * constImageSize)
    mapImage:SetSize(constImageSize, constImageSize)
    mapImage:SetAlpha(calcAlpha)
    mapImage:SetShow(true)
    local xValue = (currentSector.x + index) % constSize
    local zValue = constSize - (currentSector.z - floorIndexDivConstSize) % constSize - 1
    local currentCenterX = currentPosition.x + 12800 * (indexModConstSize - 2)
    local currentCenterZ = currentPosition.z + 12800 * (2 - floorIndexDivConstSize)
    local radix = center.x - currentCenterX
    local radiz = center.y - currentCenterZ
    if radix * radix + radiz * radiz < currentRadius * currentRadius then
      mapImage:SetMonoTone(false)
    elseif 0 ~= currentRadius then
      mapImage:SetMonoTone(true)
    end
    local desertMapImage = Panel_RadarRealLine.desertMapImage[index]
    local desertMapValue = Panel_RadarRealLine.desertMapValue[index]
    if desertMapValue.x ~= xValue or desertMapValue.y ~= zValue or Panel_RadarRealLine.maxAlphaDesert > 0 and Panel_RadarRealLine.maxAlphaDesert < 1 then
      desertMapValue.x = xValue
      desertMapValue.y = zValue
      if isDesert and not isResistDesert then
        desertMapImage:ChangeTextureInfoNameForRadarBackground("New_UI_Common_forLua/Widget/Rader/Rader_Desert_" .. xValue .. "_" .. zValue .. ".dds")
      elseif isOcean then
        desertMapImage:ChangeTextureInfoNameForRadarBackground("New_UI_Common_forLua/Widget/Rader/Rader_Ocean_" .. xValue .. "_" .. zValue .. ".dds")
      end
    end
    desertMapImage:SetPosX(startX + indexModConstSize * constImageSize)
    desertMapImage:SetPosY(startY + floorIndexDivConstSize * constImageSize)
    desertMapImage:SetSize(constImageSize, constImageSize)
  end
end
function RadarBackground_updatePerFrame(deltaTime)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  updatePanel()
  updateMapImage(selfPlayer:get():getPosition(), deltaTime)
end
function FGlobal_Panel_RadarRealLine_Show(isShow)
  Panel_RadarRealLine.panel:SetShow(isShow)
end
function RadarBackground_Show()
  Panel_RadarRealLine.panel:SetShow(true)
end
function RadarBackground_Hide()
  Panel_RadarRealLine.panel:SetShow(false)
end
function RadarBackground_SetRotateMode(isRotateMode)
  local loopCount = const.size * const.size - 1
  for index = 0, loopCount do
    Panel_RadarRealLine.mapImage[index]:SetParentRotCalc(isRotateMode)
  end
end
function RadarMapBG_SetAlphaValue(alpha)
  local isShowFront = true
  if 1 <= Panel_RadarRealLine.maxAlphaDesert then
    isShowFront = false
  end
  currentAlpha = alpha
  local loopCount = const.size * const.size - 1
  for index = 0, loopCount do
    Panel_RadarRealLine.mapImage[index]:SetAlpha((1 - Panel_RadarRealLine.maxAlphaDesert) * currentAlpha)
    Panel_RadarRealLine.mapImage[index]:SetShow(isShowFront)
  end
end
function RadarMapBG_EnableSimpleUI_Force_Over()
  RadarMapBG_EnableSimpleUI(true)
end
function RadarMapBG_EnableSimpleUI_Force_Out()
  RadarMapBG_EnableSimpleUI(false)
end
registerEvent("EventSimpleUIEnable", "RadarMapBG_EnableSimpleUI_Force_Over")
registerEvent("EventSimpleUIDisable", "RadarMapBG_EnableSimpleUI_Force_Out")
registerEvent("FromClient_EnterToInstanceField_UpdateMiniMap", "FromClient_EnterToInstanceField_UpdateMiniMap")
function RadarMapBG_EnableSimpleUI(isEnable)
  cacheSimpleUI_ShowButton = true
end
