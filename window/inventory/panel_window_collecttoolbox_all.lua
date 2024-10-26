PaGlobal_CollectToolBox_All = {
  _ui = {
    _btn_close = nil,
    _slot_ax = nil,
    _slot_injector = nil,
    _slot_homi = nil,
    _slot_meat = nil,
    _slot_leather = nil,
    _slot_pick = nil,
    _slotInfoTemplate = nil,
    _stc_keyGuideBG = nil,
    _stc_keyGuide_A = nil,
    _stc_keyGuide_B = nil,
    _stc_keyGuide_X = nil
  },
  _collectTypeList = {
    __eCollectToolType_Axe,
    __eCollectToolType_Syringe,
    __eCollectToolType_ButcheryKnife,
    __eCollectToolType_Pickax,
    __eCollectToolType_Hoe,
    __eCollectToolType_SkinKnife
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _defaultPanel = {},
  _activatePanel = {},
  _slots = {},
  _isConsole = false,
  _initialize = false,
  _popToolBagItem = false,
  _popToolBagItemIdx = 0
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_CollectToolBox_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_CollectToolBox_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CollectToolBoxInit")
function FromClient_CollectToolBoxInit()
  PaGlobal_CollectToolBox_All:initialize()
end
