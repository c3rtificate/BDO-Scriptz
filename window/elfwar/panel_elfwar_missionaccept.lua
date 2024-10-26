PaGlobal_ElfWarMissionAccept = {
  _ui = {
    _txt_missionName = UI.getChildControl(Panel_ElfWar_MissionAccept, "StaticText_Mission")
  },
  _timeAcc = 0,
  _showTime = 6,
  _initialize = false
}
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_MissionAccept_1.lua")
runLua("UI_Data/Script/Window/ElfWar/Panel_ElfWar_MissionAccept_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FromClient_ElfWarMissionAcceptInit")
function FromClient_FromClient_ElfWarMissionAcceptInit()
  PaGlobal_ElfWarMissionAccept:initialize()
end
