function PaGlobal_ElfWarScoreBoardWidget:initialize()
  if self._initialize == true then
    return
  end
  self._ui._txt_kill = UI.getChildControl(Panel_ElfWar_ScoreBoardWidget, "StaticText_Kill")
  self._ui._txt_death = UI.getChildControl(Panel_ElfWar_ScoreBoardWidget, "StaticText_Death")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ElfWarScoreBoardWidget:registEventHandler()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  Panel_ElfWar_ScoreBoardWidget:addInputEvent("Mouse_LDown", "HandleEventLDown_ElfWarScoreBoardWidget_ToggleScoreBoard()")
  Panel_ElfWar_ScoreBoardWidget:addInputEvent("Mouse_LUp", "HandleEventLUp_ElfWarScoreBoardWidget_ToggleScoreBoard()")
  registerEvent("FromClient_UpdateElfWarPersonalScoreBoard", "FromClient_ElfWarScoreBoardWidget_UpdateScore")
  registerEvent("onScreenResize", "FromClient_ElfWarScoreBoardWidget_OnScreenResize")
end
function PaGlobal_ElfWarScoreBoardWidget:validate()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_kill:isValidate()
  self._ui._txt_death:isValidate()
end
function PaGlobal_ElfWarScoreBoardWidget:onScreenResize()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  if Panel_Radar ~= nil then
    local radarPosY = Panel_Radar:GetPosY()
    local radarSizeY = Panel_Radar:GetSizeY()
    Panel_ElfWar_ScoreBoardWidget:SetPosX(getScreenSizeX() - Panel_ElfWar_ScoreBoardWidget:GetSizeX() - 10)
    Panel_ElfWar_ScoreBoardWidget:SetPosY(radarPosY + radarSizeY + 10)
  end
  self._tempPanelPosX = nil
  self._tempPanelPosY = nil
end
function PaGlobal_ElfWarScoreBoardWidget:prepareOpen()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  self:initialize()
  self:updateKill(0)
  self:updateDeath(0)
  self:updateScoreFromClient()
  self:onScreenResize()
  self:open()
end
function PaGlobal_ElfWarScoreBoardWidget:open()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  Panel_ElfWar_ScoreBoardWidget:SetShow(true)
end
function PaGlobal_ElfWarScoreBoardWidget:prepareClose()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  self:close()
end
function PaGlobal_ElfWarScoreBoardWidget:close()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  Panel_ElfWar_ScoreBoardWidget:SetShow(false)
end
function PaGlobal_ElfWarScoreBoardWidget:updateScoreFromClient()
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  local elfWarSelfMemberData = ToClient_GetElfWarMemberDataWrapperBySelfPlayer()
  if elfWarSelfMemberData == nil then
    return
  end
  self:updateKill(elfWarSelfMemberData:getElfWarPersonalScore(__eElfWarPersonalRecordType_Kill))
  self:updateDeath(elfWarSelfMemberData:getElfWarPersonalScore(__eElfWarPersonalRecordType_Death))
end
function PaGlobal_ElfWarScoreBoardWidget:updateKill(kill)
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_kill:SetText(tostring(kill))
end
function PaGlobal_ElfWarScoreBoardWidget:updateDeath(death)
  if Panel_ElfWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_death:SetText(tostring(death))
end
