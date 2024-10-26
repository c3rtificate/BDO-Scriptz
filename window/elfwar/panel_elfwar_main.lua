PaGlobal_ElfWarMain = {
  _prevUIMode = nil,
  _renderMode = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarMainInit")
function FromClient_ElfWarMainInit()
  PaGlobal_ElfWarMain:initialize()
end
function PaGlobal_ElfWarMain:initialize()
  if self._initialize == true then
    return
  end
  self._prevUIMode = Defines.UIMode.eUIMode_Default
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_ElfWar
  }, false)
  self._renderMode:setClosefunctor(nil, PaGlobalFunc_ElfWarMain_Close)
  registerEvent("FromClient_ChangeElfWarState", "FromClient_ElfWarMain_ChangeElfWarState")
  registerEvent("FromClient_UnsetElfWarObserveMode", "FromClient_ElfWarMain_UnsetElfWarObserveMode")
  self._initialize = true
end
function PaGlobal_ElfWarMain:open()
  if Panel_ElfWar_Main == nil then
    return
  end
  self._renderMode:set()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_ElfWar)
  Panel_ElfWar_Main:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_ElfWar_Main:ComputePosAllChild()
  Panel_ElfWar_Main:SetShow(true)
  PaGlobalFunc_ElfWarMiniMap_Open()
  if PaGlobalFunc_ElfWarMiniMap_IsShow() == false then
    self:close()
  end
end
function PaGlobal_ElfWarMain:close()
  if Panel_ElfWar_Main == nil then
    return
  end
  ToClient_HideElfWarMain()
  PaGlobal_ElfWarMain._renderMode:reset()
  SetUIMode(PaGlobal_ElfWarMain._prevUIMode)
  PaGlobal_ElfWarMain._prevUIMode = Defines.UIMode.eUIMode_Default
  Panel_ElfWar_Main:SetShow(false)
  PaGlobalFunc_ElfWarMiniMap_Close()
end
function PaGlobalFunc_ElfWarMain_Open()
  if Panel_ElfWar_Main == nil then
    return
  end
  if ToClient_IsElfWarServer() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionOnlyRoseWarServer"))
    return
  end
  if ToClient_ShowElfWarMain() == false then
    return
  end
  PaGlobal_ElfWarMain:open()
end
function PaGlobalFunc_ElfWarMain_Close()
  if Panel_ElfWar_Main == nil then
    return
  end
  if 0 < ToClient_GetElfWarSelectIconListCount() then
    ToClient_ClearElfWarSelectIconList()
    return
  end
  if PaGlobalFunc_ElfWarCommand_IsShow() == true then
    PaGlobalFunc_ElfWarCommand_Close()
    return
  end
  PaGlobal_ElfWarMain:close()
end
function FromClient_ElfWarMain_ChangeElfWarState(state)
  if Panel_ElfWar_Main == nil or state == nil then
    return
  end
  if state == __eElfWar_Stop then
    ToClient_ClearElfWarSelectIconList()
    PaGlobalFunc_ElfWarCommand_Close()
    if Panel_ElfWar_Main:GetShow() == true then
      PaGlobal_ElfWarMain:close()
    end
  end
end
function FromClient_ElfWarMain_UnsetElfWarObserveMode()
  if Panel_ElfWar_Main == nil then
    return
  end
  if Panel_ElfWar_Main:GetShow() == true then
    PaGlobal_ElfWarMain:close()
  end
end
function IsSelfPlayerElfWarGrade_Commander()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_Commander
end
function IsSelfPlayerElfWarGrade_SubCommander()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_SubCommander
end
function IsSelfPlayerElfWarGrade_GuildPartyLeader()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_GuildPartyLeader
end
function IsSelfPlayerElfWarGrade_GuildMember()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_GuildMember
end
function IsSelfPlayerElfWarGrade_MercenaryPartyLeader()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_MercenaryPartyLeader
end
function IsSelfPlayerElfWarGrade_Mercenary()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getElfWarGradeType() == __eElfWarPlayerGradeType_Mercenary
end
function IsMouseInElfWarPanel(panel)
  if panel == nil then
    return false
  end
  if panel:GetShow() == false then
    return false
  end
  local panelPosX = panel:GetPosX()
  local panelPosY = panel:GetPosY()
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local lt = float2(panelPosX, panelPosY)
  local rb = float2(panelPosX + panelSizeX, panelPosY + panelSizeY)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if mousePosX >= lt.x and mousePosX <= rb.x and mousePosY >= lt.y and mousePosY <= rb.y then
    return true
  end
  return false
end
