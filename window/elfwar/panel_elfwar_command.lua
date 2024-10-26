PaGlobal_ElfWarCommand = {
  _ui = {
    _btn_template = UI.getChildControl(Panel_ElfWar_Command, "Button_Template")
  },
  _lastPosXY_gameScene = nil,
  _openWorldPosition = float3(0, 0, 0),
  _openByMiniMap = false,
  _commandButtonList = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Command_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Command_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ElfWarCommandInit")
function FromClient_ElfWarCommandInit()
  PaGlobal_ElfWarCommand:initialize()
end
