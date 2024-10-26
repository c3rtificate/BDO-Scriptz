PaGlobal_ImperialSupplyMSG = {
  _ui = {},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _Slot1 = nil,
  _Slot2 = nil,
  _Slot3 = nil,
  _initialize = false,
  _event = _ContentsGroup_HorseImperialEvent
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ImperialSupplyMSG")
function FromClient_ImperialSupplyMSG()
  PaGlobal_ImperialSupplyMSG:initialize()
end
