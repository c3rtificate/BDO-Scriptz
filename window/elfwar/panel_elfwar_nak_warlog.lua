PaGlobal_ElfWar_NakWarLog = {
  _ui = {
    static_PositiveBox = nil,
    static_NegativeBox = nil,
    static_NeutralBox = nil
  },
  _readyLogList = {},
  _showingLogList = {},
  _logInfoList = {},
  _showingTime = 12,
  _hideTime = 1,
  _maxShowCount = 7,
  _initialize = false
}
NakWarLog_BoxType = {
  positive = 0,
  negative = 1,
  neutral = 2,
  count = 3
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Nak_WarLog_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Nak_WarLog_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarNakWarLogInit")
function FromClient_ElfWarNakWarLogInit()
  PaGlobal_ElfWar_NakWarLog:initialize()
end
