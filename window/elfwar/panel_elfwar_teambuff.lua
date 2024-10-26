PaGlobal_ElfWarTeamBuff = {
  _ui = {_stc_bg = nil, _stc_buffTemplate = nil},
  _buffDataList = nil,
  _buffUiPool = nil,
  _buffUiExpandCount = 5,
  _currentBuffUiCount = 0,
  _currentBuffCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamBuff_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamBuff_2.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_TeamBuff_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarTeamBuffInit")
function FromClient_ElfWarTeamBuffInit()
  PaGlobal_ElfWarTeamBuff:initialize()
end
