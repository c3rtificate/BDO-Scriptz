PaGlobal_Window_CharacterStat_All = {
  _ui = {
    _stc_TitleArea = nil,
    _btn_Close = nil,
    _combo_Stat = nil,
    _btn_Reload = nil,
    _stc_ServerBG = nil,
    _stc_ClientBG = nil
  },
  _STATT_TYPE = {
    _offence = 1,
    _defence = 2,
    _hit = 3,
    _specialAttack = 4,
    _resistance = 5,
    _speed = 6
  },
  _currentStatType = 1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterStatInit")
function FromClient_CharacterStatInit()
  PaGlobal_Window_CharacterStat_All:initialize()
end
function PaGlobal_Window_CharacterStat_All:initialize()
  if self._isInitialize == true then
    return
  end
  self._ui._stc_TitleArea = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_TitleArea, "Button_Close")
  self._ui._combo_Stat = UI.getChildControl(Panel_Window_CharacterStat_All, "Combobox_Stat")
  self._ui._btn_Reload = UI.getChildControl(Panel_Window_CharacterStat_All, "Button_Reload")
  self._ui._stc_ServerBG = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_ServerBg")
  self._ui._stc_ClientBG = UI.getChildControl(Panel_Window_CharacterStat_All, "Static_ClientBg")
  self:registerEventHandler()
  self:validate()
  self._isInitialize = true
end
function PaGlobal_Window_CharacterStat_All:registerEventHandler()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_Window_CharacterStat_All_Close()")
  self._ui._btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_ReloadStat()")
end
function PaGlobal_Window_CharacterStat_All:prepareOpen()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  if self:update() == false then
    return
  end
  self:open()
end
function PaGlobal_Window_CharacterStat_All:open()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  Panel_Window_CharacterStat_All:SetShow(true)
end
function PaGlobal_Window_CharacterStat_All:prepareClose()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self:close()
end
function PaGlobal_Window_CharacterStat_All:close()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  Panel_Window_CharacterStat_All:SetShow(false)
end
function PaGlobal_Window_CharacterStat_All:validate()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self._ui._stc_TitleArea:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._combo_Stat:isValidate()
  self._ui._btn_Reload:isValidate()
  self._ui._stc_ServerBG:isValidate()
  self._ui._stc_ClientBG:isValidate()
end
function PaGlobal_Window_CharacterStat_All:validate()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  self._ui._stc_TitleArea:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._combo_Stat:isValidate()
  self._ui._btn_Reload:isValidate()
  self._ui._stc_ServerBG:isValidate()
  self._ui._stc_ClientBG:isValidate()
end
function PaGlobal_Window_CharacterStat_All:update()
  if Panel_Window_CharacterStat_All == nil then
    return false
  end
  local characterStatInfo = ToClient_getCharacterStatInfoDebug()
  if characterStatInfo == nil then
    return false
  end
  return true
end
function HandleEventLUp_ReloadStat()
end
function PaGlobal_Window_CharacterStat_All_Open()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareOpen()
end
function PaGlobal_Window_CharacterStat_All_Close()
  if Panel_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareClose()
end
function FromClient_ResponseShowPlayerStat()
  if PaGlobal_Window_CharacterStat_All == nil then
    return
  end
  PaGlobal_Window_CharacterStat_All:prepareOpen()
end
