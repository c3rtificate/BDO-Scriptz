function PaGlobal_ElfWarTeamBuff:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_bg = UI.getChildControl(Panel_ElfWar_TeamBuff, "Static_BuffList_BG")
  self._ui._stc_buffTemplate = UI.getChildControl(Panel_ElfWar_TeamBuff, "Static_BuffIcon_Template")
  self:makeBuffIconList()
  self._initialize = true
end
function PaGlobal_ElfWarTeamBuff:prepareOpen()
  if Panel_ElfWar_TeamBuff == nil then
    return
  end
  self:open()
end
function PaGlobal_ElfWarTeamBuff:open()
  if Panel_ElfWar_TeamBuff == nil then
    return
  end
  Panel_ElfWar_TeamBuff:SetShow(true)
  self:makeBuffDataList()
  self:updateBuffIcon()
end
function PaGlobal_ElfWarTeamBuff:prepareClose()
  if Panel_ElfWar_TeamBuff == nil then
    return
  end
  self:close()
end
function PaGlobal_ElfWarTeamBuff:close()
  if Panel_ElfWar_TeamBuff == nil then
    return
  end
  Panel_ElfWar_TeamBuff:SetShow(false)
end
