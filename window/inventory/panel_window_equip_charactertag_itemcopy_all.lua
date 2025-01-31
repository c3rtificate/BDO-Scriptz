PaGlobal_Equip_CharacterTag_ItemCopy = {
  _ui = {
    _stc_title = nil,
    _stc_title = nil,
    _btn_close = nil,
    _txt_titleIcon = nil,
    _btn_openDescBox = nil,
    _stc_tapBg = nil,
    _stc_tapLine = nil,
    _stc_selectLine = nil,
    _btn_copyAllTap = nil,
    _btn_changeCopy = nil,
    _btn_exitCopy = nil,
    _stc_itemCopyBg = nil,
    _stc_costBox = nil,
    _txt_itemCost = nil,
    _stc_needItemIcon = nil,
    _btn_copyConfirm = nil,
    _txt_toCharacterName = nil,
    _stc_equipSlotGroup = nil,
    _stc_mainCirce = nil,
    _txt_notice = nil,
    _txt_slotEnchantValue = nil,
    _stc_itemCopyDecoBG = nil,
    _stc_itemCopyEffect = nil,
    _btn_selectAwakenWeaponForShy = nil,
    _stc_addCopyBg = nil,
    _btn_addConfirm = nil,
    _stc_addCostBox = nil,
    _stc_addCostIcon = nil,
    _txt_addCost = nil,
    _stc_addCostIcon2 = nil,
    _txt_addCost2 = nil,
    _txt_addToCharacter = nil,
    _stc_addItemBg = nil,
    _txt_addItemName = nil,
    _stc_addItemEffect = nil,
    _stc_exitCopyBg = nil,
    _btn_exitConfirm = nil,
    _txt_exitToCharacter = nil,
    _stc_exitItemBg = nil,
    _txt_exitItemName = nil,
    _stc_exitItemEffect = nil,
    _stc_keyguideBg = nil,
    _txt_keyguideX = nil,
    _txt_keyguideB = nil,
    _txt_keyguideA = nil,
    _txt_keyguideY = nil,
    _txt_keyguideLTX = nil,
    _txt_keyguideLB = nil,
    _txt_keyguideRB = nil
  },
  _equipSlot = {},
  _equipSlotBG = {},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createDuplicatedForDuel = true
  },
  _equipSlotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createCash = true,
    createBlack = true,
    createEnchant = true,
    createDuplicatedForDuel = true
  },
  _slotNoId = {
    [0] = "Static_Slot_RightHand",
    [1] = "Static_Slot_LeftHand",
    [2] = "Static_Slot_Gather",
    [3] = "Static_Slot_Chest",
    [4] = "Static_Slot_Glove",
    [5] = "Static_Slot_Boots",
    [6] = "Static_Slot_Helm",
    [7] = "Static_Slot_Necklace",
    [8] = "Static_Slot_Ring1",
    [9] = "Static_Slot_Ring2",
    [10] = "Static_Slot_Earing1",
    [11] = "Static_Slot_Earing2",
    [12] = "Static_Slot_Belt",
    [27] = "Static_Slot_AlchemyStone",
    [29] = "Static_Slot_AwakenWeapon",
    [32] = "Static_Slot_Relics_1",
    [33] = "Static_Slot_Relics_2"
  },
  _slotNoIdToString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_GATHERTOOLS"),
    [3] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [4] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [5] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [6] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [7] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [8] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [9] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [10] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [11] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [12] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [27] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [29] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [32] = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_EQUIP_RELIC"),
    [33] = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_EQUIP_RELIC")
  },
  LOCAL_DEFINE = {NODUEL = -1},
  _EquipNoMin = __eEquipSlotNoRightHand,
  _EquipNoMax = __eEquipSlotNoCount,
  _UnUsedEquipNo_01 = 100,
  _UnUsedEquipNo_02 = 101,
  _needItemCount = 0,
  _needItemSlotNo = __eTInventorySlotNoUndefined,
  _toCharacterName = "",
  _equipSlotBG = {},
  _equipSlot = {},
  _awakenWeaponContentsOpen = false,
  _lastShowDescState = false,
  _selfClassType = nil,
  eTabIndex = {
    ALL_COPY = 0,
    ADD_COPY = 1,
    RELEASE_COPY = 2,
    TAP_COUNT = 3
  },
  _currentTap = 0,
  _changeCopySlot = nil,
  _releaseCopySlot = nil,
  _selectSlotNo = __eTInventorySlotNoUndefined,
  _addCopyNeedItemSlotNo = __eTInventorySlotNoUndefined,
  _addCopyNeedItemCount = toInt64(0, 0),
  _addCopyNeedItemSlotNo2 = __eTInventorySlotNoUndefined,
  _addCopyNeedItemCount2 = toInt64(0, 0),
  _baseAddCopyNeedItemIconSpanSizeY = 0,
  _hasCopyOriginItem = false,
  _curEffectTime = 0,
  _maxEffectTime = 3,
  _isEffectStart = false,
  _copyEffectType = 0,
  _checkFirstNeedItem = false,
  _isConsole = false,
  _initailize = false
}
function FromClient_CharacterTagItemCopyInit()
  local self = PaGlobal_Equip_CharacterTag_ItemCopy
  self:init()
end
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Equip_CharacterTag_ItemCopy_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Equip_CharacterTag_ItemCopy_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterTagItemCopyInit")
