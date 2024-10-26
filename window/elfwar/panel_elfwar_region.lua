PaGlobal_ElfWarRegion = {
  _ui = {
    _stc_regionName = UI.getChildControl(Panel_ElfWar_Region, "RegionText"),
    _stc_regionPlace = UI.getChildControl(Panel_ElfWar_Region, "StaticText_Regiontext"),
    _stc_line_L = UI.getChildControl(Panel_ElfWar_Region, "Static_L_Line"),
    _stc_line_R = UI.getChildControl(Panel_ElfWar_Region, "Static_R_Line")
  },
  _deltaTime = 0,
  _showTime = 5,
  _initialize = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Region_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_Region_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FromClient_ElfWarRegionInit")
function FromClient_FromClient_ElfWarRegionInit()
  PaGlobal_ElfWarRegion:initialize()
end
