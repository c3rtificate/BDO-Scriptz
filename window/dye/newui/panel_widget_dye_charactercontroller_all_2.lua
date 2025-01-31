function InputMDown_Dye_SetCharacterRotate_Start(isLDown)
  local self = PaGlobal_Dye_CharacterController
  if isLDown then
    self._isLdown = true
  else
    self._isRdown = true
  end
  self._lMovePos = getMousePosX()
  self._yMovePos = getMousePosY()
end
function InputMUp_Dye_SetCharacterRotate_End(isLDown)
  local self = PaGlobal_Dye_CharacterController
  if nil == isLDown then
    self._isLdown = false
    self._isRdown = false
  elseif isLDown then
    self._isLdown = false
  else
    self._isRdown = false
  end
end
function InputScroll_Dye_SetCharacterZoom(isUp)
  local upValue = 35
  if true == isUp then
    upValue = -upValue
  end
  ToClient_RequestUpdateDyeVaryZoom(upValue)
end
function InputMLUp_Dye_RandomPose()
  local randValue = math.random(4, 9)
  if isGameTypeTaiwan() and 6 == randValue then
    randValue = 8
  end
  ToClient_setActionChart(randValue)
end
function InputMLUp_Dye_SetCharacterViewCamera()
  local self = PaGlobal_Dye_CharacterController
  ToClient_setCharacterViewCamera(self._ui_pc.chk_SeePlayer:IsCheck())
end
function PaGlobal_Dye_CharacterController_SetKeyGuideShow(isShow)
  local self = PaGlobal_Dye_CharacterController
  self._ui_console.stc_KeyGuideBG:SetShow(isShow)
  self._ui_console.txt_KeyGuideLSClick:SetShow(isShow)
  self._ui_console.txt_KeyGuideB:SetShow(isShow)
end
function InputMLUp_Dye_SetShowUI()
  if Panel_Widget_Dye_All:GetShow() then
    Panel_Widget_Dye_All:SetShow(false)
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_CloseWithItemDyeing()
    else
      Panel_Window_Inventory:SetShow(false)
    end
    if nil ~= Panel_Window_Palette_All and Panel_Window_Palette_All:GetShow() then
      PaGlobal_Palette_All_Close()
      PaGlobal_Dye_CharacterController._isPaletteShow = true
    end
    FGlobal_WebHelper_ForceClose()
  else
    Panel_Widget_Dye_All:SetShow(true)
    if true == _ContentsGroup_NewUI_Inventory_All then
      Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
      PaGlobalFunc_Inventory_All_OpenWithItemDyeing()
    else
      Panel_Window_Inventory:SetShow(true)
    end
    if true == PaGlobal_Dye_CharacterController._isPaletteShow then
      PaGlobal_Palette_All_Open()
      PaGlobal_Dye_CharacterController._isPaletteShow = false
    end
  end
end
function InputMLUp_Dye_WeatherBtnToggle()
  local self = PaGlobal_Dye_CharacterController
  local isShow = self._ui_pc.chk_Weather:IsCheck()
  for i = 1, self._weatherCount do
    self._btn_Weather[i]:SetShow(isShow)
  end
end
function InputMLUp_Dye_WeatherSetting(weatherType)
  local toIndex = 0
  if 1 == weatherType then
    toIndex = 0
  elseif 2 == weatherType then
    toIndex = 3
  elseif 3 == weatherType then
    toIndex = 7
  elseif 4 == weatherType then
    toIndex = 11
  elseif 5 == weatherType then
    toIndex = 15
  elseif 6 == weatherType then
    toIndex = 19
  end
  ToClient_RequestUpdateDyeSetCustomWeather(6, toIndex)
end
function InputMOver_Dye_SimpleTooltips(isShow, tipType)
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_POSE")
    control = PaGlobal_Dye_CharacterController._ui_pc.btn_Pose
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_EYESEE")
    control = PaGlobal_Dye_CharacterController._ui_pc.chk_SeePlayer
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SHOWUI")
    control = PaGlobal_Dye_CharacterController._ui_pc.chk_ShowUI
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_SETEQUIP_SUNICON")
    control = PaGlobal_Dye_CharacterController._ui_pc.chk_Weather
  end
  if isShow == true then
    TooltipSimple_Show(control, name, desc, false)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_Dye_CharacterRotate_PerFrameUpdate(deltaTime)
  local self = PaGlobal_Dye_CharacterController
  if false == self._isConsole then
    if false == self._isLdown and false == self._isRdown then
      return
    end
    local currPos = getMousePosX()
    local currPosY = getMousePosY()
    if currPos == self._lMovePos and currPosY == self._yMovePos then
      return
    end
    local radianAngle = (self._lMovePos - currPos) / (getOriginScreenSizeX() / 10)
    local cameraPitch = (currPosY - self._yMovePos) / (getOriginScreenSizeY() / 2)
    self._lMovePos = currPos
    self._yMovePos = currPosY
    if self._isLdown then
      ToClient_RequestUpdateDyeVaryCameraPosition(radianAngle * 30, cameraPitch * 90)
    end
    if self._isRdown then
      ToClient_RequestUpdateDyeVaryRotation(radianAngle * 0.8, -(cameraPitch * 2))
    end
  else
    local RSX = getPadRightStickMoveX()
    local RSY = getPadRightStickMoveY()
    if 0 ~= RSX or 0 ~= RSY then
      if true == self._padRSIsPressed then
        if false == self:isColorPaletteOpen() then
          ToClient_RequestUpdateDyeVaryZoom(RSY * deltaTime * -300)
        end
      elseif false == self:isColorPaletteOpen() then
        ToClient_RequestUpdateDyeVaryRotation(RSX * -0.8 * deltaTime, -(RSY * -2) * deltaTime)
      end
    end
  end
end
function PaGlobal_Dye_CharacterController_Open()
  PaGlobal_Dye_CharacterController:prepareOpen()
end
function PaGlobal_Dye_CharacterController_Close()
  PaGlobal_Dye_CharacterController:prepareClose()
end
function HandleEventLUp_Dye_CharacterController_InventoryButtonClicked()
  PaGlobal_Dye_CharacterController:InventoryButtonClicked()
end
function HandleEventLUp_Dye_CharacterController_InventoryToggle()
  if false == Panel_Window_Inventory_All:GetShow() then
    Inventory_SetFunctor(PaGlobal_Dye_All_InventoryFilter, PaGlobal_Dye_All_Interaction_FromInventory, nil, nil)
    PaGlobalFunc_Inventory_All_OpenWithItemDyeing()
  else
    PaGlobal_Dye_CharacterController._isPaletteShow = false
    PaGlobalFunc_Inventory_All_CloseWithItemDyeing()
  end
end
function HandleEventLUp_Dye_CharacterController_PaletteToggle()
  if false == PaGlobal_Dye_CharacterController._isPaletteShow then
    PaGlobal_Dye_CharacterController._isPaletteShow = true
    PaGlobal_Palette_All_Open()
  else
    PaGlobal_Dye_CharacterController._isPaletteShow = false
    PaGlobal_Palette_All_Close()
  end
end
function HandleEventRSDown_Dye_CharacterController_PressedRS()
  PaGlobal_Dye_CharacterController._padRSIsPressed = true
end
function HandleEventRSUp_Dye_CharacterController_ReleasedRS()
  PaGlobal_Dye_CharacterController._padRSIsPressed = false
end
