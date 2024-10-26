local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local ServantStable_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ServantStable")
local WareHouse_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WareHouse")
local Quest_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Quest")
local Transport_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Transport")
local transportAlert = UI.getChildControl(Panel_WorldMap, "Static_TransportAlert")
local ItemMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_ItemMarket")
local MarketPlace_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_MarketPlace")
local WorkerList_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerList")
local HelpMenu_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_HelpMovie")
local Exit_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_Exit")
local WorkerTrade_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WorkerTrade")
local StableMarket_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_StableMarket")
local NpcFind = UI.getChildControl(Panel_WorldMap, "BottomMenu_NpcFind")
local btn_inMyPosition = UI.getChildControl(Panel_WorldMap, "BottomMenu_InMyPosition")
local BarterFind = UI.getChildControl(Panel_WorldMap, "BottomMenu_BarterFind")
local WaypointPreset_Btn = UI.getChildControl(Panel_WorldMap, "BottomMenu_WaypointPreset")
local WaypointOption_Btn = UI.getChildControl(Panel_WorldMap, "Button_WayPointOption")
local NodeNaviCalc_Btn = UI.getChildControl(Panel_WorldMap, "Button_NodeCal")
local checkBtn_cameraSaveSlot = UI.getChildControl(Panel_WorldMap, "CheckButton_WorldMapCamera")
local btn_cameraSaveSlot_Template = UI.getChildControl(Panel_WorldMap, "Button_Camera_SaveSlot_Templete")
local btn_cameraSaveSlot = {}
local stc_cameraSaveSlotBG = UI.getChildControl(checkBtn_cameraSaveSlot, "Static_Camera_SaveSlot_BG")
local isWorkerTradeOpen = ToClient_IsContentsGroupOpen("209")
local base_carriageMoveCount = 5
local gab_carriageText = 35
local txt_NationSiegeCarriageCount = UI.getChildControl(Panel_WorldMap, "StaticText_RemainCarriage")
local NationSiegeCarriage_A = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_A")
local NationSiegeCarriage_B = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_B")
local NationSiegeCarriage_C = UI.getChildControl(Panel_WorldMap, "Button_NationSiegeCarriage_C")
local txt_pingTooltip = UI.getChildControl(Panel_WorldMap, "StaticText_KeyGuide")
local currentNodeKey
local isShowUIByObserver = true
local popupType = {
  stable = 0,
  wareHouse = 1,
  quest = 2,
  transport = 3,
  itemMarket = 4,
  workerList = 5,
  helpMovie = 6,
  workerTrade = 7,
  workerTradeCaravan = 8,
  stableMarket = 9,
  npcNavi = 10,
  marketPlace = 11,
  workerList_All = 12,
  servantMarket_All = 13,
  barterFind = 14,
  waypointPreset = 15,
  waypointOption = 16,
  nodeNavigation = 17,
  guildColorList = 18
}
local popupTypeCount = 18
local popupPanelList = {}
local _cameraSaveSlotCount = 10
Panel_WorldMap:SetShow(false, false)
local function worldMap_Init()
  Exit_Btn:SetSize(44, 44)
  HelpMenu_Btn:SetSize(44, 44)
  WorkerList_Btn:SetSize(44, 44)
  ItemMarket_Btn:SetSize(44, 44)
  MarketPlace_Btn:SetSize(44, 44)
  Transport_Btn:SetSize(44, 44)
  Quest_Btn:SetSize(44, 44)
  WareHouse_Btn:SetSize(44, 44)
  ServantStable_Btn:SetSize(44, 44)
  WorkerTrade_Btn:SetSize(44, 44)
  StableMarket_Btn:SetSize(44, 44)
  NpcFind:SetSize(44, 44)
  btn_inMyPosition:SetSize(44, 44)
  BarterFind:SetSize(44, 44)
  WaypointPreset_Btn:SetSize(44, 44)
  WaypointOption_Btn:SetSize(44, 44)
  NodeNaviCalc_Btn:SetSize(44, 44)
  transportAlert:SetShow(false)
  Exit_Btn:SetSpanSize(5, 5)
  txt_NationSiegeCarriageCount:SetShow(false)
  NationSiegeCarriage_A:SetShow(false)
  NationSiegeCarriage_B:SetShow(false)
  NationSiegeCarriage_C:SetShow(false)
  txt_pingTooltip:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_PING_TOOLTIP_BASE"))
  txt_pingTooltip:SetSize(txt_pingTooltip:GetTextSizeX() + 20, txt_pingTooltip:GetTextSizeY() + 20)
  checkBtn_cameraSaveSlot:SetCheck(false)
  checkBtn_cameraSaveSlot:addInputEvent("Mouse_On", "CheckBtn_CameraSaveSlotTooltip( true )")
  checkBtn_cameraSaveSlot:addInputEvent("Mouse_Out", "CheckBtn_CameraSaveSlotTooltip( false )")
  checkBtn_cameraSaveSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_CheckBtn_CameraSaveSlot()")
  stc_cameraSaveSlotBG:SetShow(false)
  for i = 0, _cameraSaveSlotCount - 1 do
    if btn_cameraSaveSlot[i] ~= nil then
      btn_cameraSaveSlot[i]:SetShow(false)
    end
  end
  NationSiegeCarriage_A:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(1)")
  NationSiegeCarriage_B:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(2)")
  NationSiegeCarriage_C:addInputEvent("Mouse_LUp", "HandleClick_NationSiegeCarriage(3)")
  NationSiegeCarriage_A:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(1, true)")
  NationSiegeCarriage_A:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(1, false)")
  NationSiegeCarriage_B:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(2, true)")
  NationSiegeCarriage_B:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(2, false)")
  NationSiegeCarriage_C:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(3, true)")
  NationSiegeCarriage_C:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(3, false)")
  if false == _ContentsGroup_TotalStableList then
    ServantStable_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ServantStable()")
  else
    ServantStable_Btn:addInputEvent("Mouse_LUp", "BtnEvent_TotalStable()")
  end
  WareHouse_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WareHouse()")
  Quest_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Quest()")
  Transport_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Transport()")
  ItemMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_ItemMarket()")
  MarketPlace_Btn:addInputEvent("Mouse_LUp", "BtnEvent_MarketPlace()")
  WorkerList_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerList()")
  HelpMenu_Btn:addInputEvent("Mouse_LUp", "BtnEvent_HelpMovie()")
  Exit_Btn:addInputEvent("Mouse_LUp", "BtnEvent_Exit()")
  StableMarket_Btn:addInputEvent("Mouse_LUp", "BtnEvent_StableMarket()")
  WorkerTrade_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WorkerTrade()")
  NpcFind:addInputEvent("Mouse_LUp", "BtnEvent_NpcNavi()")
  btn_inMyPosition:addInputEvent("Mouse_LUp", "BtnEvent_InMyPosition()")
  BarterFind:addInputEvent("Mouse_LUp", "BtnEvent_BarterFind()")
  WaypointPreset_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WaypointPreset()")
  WaypointOption_Btn:addInputEvent("Mouse_LUp", "BtnEvent_WaypointOption()")
  NodeNaviCalc_Btn:addInputEvent("Mouse_LUp", "BtnEvent_NodeNaviCalculation()")
  ServantStable_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 0 .. " )")
  ServantStable_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 0 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 1 .. " )")
  WareHouse_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 1 .. " )")
  Quest_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 2 .. " )")
  Quest_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 2 .. " )")
  Transport_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 3 .. " )")
  Transport_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 3 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 4 .. " )")
  ItemMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 4 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 5 .. " )")
  WorkerList_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 5 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 6 .. " )")
  HelpMenu_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 6 .. " )")
  Exit_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 7 .. " )")
  Exit_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 7 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 8 .. " )")
  WorkerTrade_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 8 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 9 .. " )")
  StableMarket_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 9 .. " )")
  NpcFind:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 10 .. " )")
  NpcFind:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 10 .. " )")
  btn_inMyPosition:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 12 .. " )")
  btn_inMyPosition:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 12 .. " )")
  MarketPlace_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 11 .. " )")
  MarketPlace_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 11 .. " )")
  BarterFind:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 13 .. " )")
  BarterFind:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 13 .. " )")
  WaypointPreset_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 14 .. " )")
  WaypointPreset_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 14 .. " )")
  WaypointOption_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 15 .. " )")
  WaypointOption_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 15 .. " )")
  NodeNaviCalc_Btn:addInputEvent("Mouse_On", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( true, " .. 16 .. " )")
  NodeNaviCalc_Btn:addInputEvent("Mouse_Out", "HandleOnOut_WorldmapGrand_MenuButtonTooltip( false, " .. 16 .. " )")
end
function GrandWorldMap_CheckPopup(openPanel, exceptionPopPanel)
  for idx = 0, popupTypeCount - 1 do
    if openPanel ~= idx and nil ~= popupPanelList[idx].panelname and popupPanelList[idx].panelname:GetShow() and (nil == exceptionPopPanel or popupPanelList[idx].panelname ~= exceptionPopPanel) then
      popupPanelList[idx].closeFunc()
    end
  end
  PaGlobal_TutorialManager:handleGrandWorldMap_CheckPopup(openPanel, popupPanelList[openPanel].panelname)
end
function BtnEvent_ServantStable()
  if not Panel_NodeStable:GetShow() then
    if nil ~= currentNodeKey then
      GrandWorldMap_CheckPopup(popupType.stable)
      StableOpen_FromWorldMap(currentNodeKey)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_WRONG_STABLE"))
      return
    end
  else
    StableClose_FromWorldMap()
  end
end
function BtnEvent_TotalStable()
  if false == _ContentsGroup_TotalStableList then
    return
  end
  if false == Panel_WorldMap_StableList:GetShow() then
    GrandWorldMap_CheckPopup(popupType.stable)
    if nil ~= PaGlobal_WorldMap_StableList_Open then
      WorldMapPopupManager:increaseLayer(true)
      WorldMapPopupManager:push(Panel_WorldMap_StableList, true)
      PaGlobal_WorldMap_StableList_Open()
    end
  else
    WorldMapPopupManager:pop()
  end
end
function BtnEvent_StableMarket()
  if nil ~= Panel_Dialog_ServantMarket_All then
    if true == Panel_Dialog_ServantMarket_All:GetShow() then
      PaGlobalFunc_ServantMarket_All_Close()
    else
      GrandWorldMap_CheckPopup(popupType.servantMarket_All)
      PaGlobalFunc_ServantMarket_All_Open()
    end
  end
end
function BtnEvent_WorkerTrade()
  if not ToClient_IsActiveWorkerTrade() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_WORKERTRADEALERT"))
    return
  end
  if Panel_WorkerTrade:GetShow() then
    WorkerTrade_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerTrade)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_WorkerTrade, true)
    FGlobal_WorkerTrade_Update()
  end
end
function BtnEvent_NpcNavi()
  if Panel_NpcNavi_All:GetShow() then
    PaGlobal_NpcNavi_All_ShowToggle()
  else
    GrandWorldMap_CheckPopup(popupType.npcNavi)
    PaGlobal_NpcNavi_All_ShowToggle()
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_NpcNavi_All, true)
  end
end
function BtnEvent_InMyPosition()
  if btn_inMyPosition:GetShow() == false then
    return
  end
  ToClient_moveCameraSelfPlayerForWorldmap()
end
function BtnEvent_WareHouse()
  if Panel_Window_Warehouse:GetShow() then
    PaGlobal_Warehouse_All_Close()
  elseif nil ~= currentNodeKey then
    GrandWorldMap_CheckPopup(popupType.wareHouse, Panel_Window_Barter_Search)
    PaGlobal_Warehouse_All_OpenPanelFromWorldmap(currentNodeKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
  end
end
function BtnEvent_BarterFind()
  if nil == Panel_Window_Barter_Search then
    return
  end
  if true == Panel_Window_Barter_Search:GetShow() then
    PaGlobal_BarterInfoSearch:close()
  else
    GrandWorldMap_CheckPopup(popupType.barterFind, Panel_Window_Warehouse)
    if Panel_Window_TotalSearch ~= nil and PaGlobalFunc_TotalSearch_GetShow() == true then
      WorldMapPopupManager:popWantPanel(Panel_Window_TotalSearch)
    end
    if nil ~= Panel_Window_Delivery_All and true == Panel_Window_Delivery_All:GetShow() then
      WorldMapPopupManager:popWantPanel(Panel_Window_Delivery_All)
    end
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_Barter_Search, true)
    PaGlobal_BarterInfoSearch:open()
  end
end
function BtnEvent_WaypointPreset()
  if nil == Panel_Worldmap_WaypointPreset then
    return
  end
  if false == Panel_Worldmap_WaypointPreset:GetShow() then
    GrandWorldMap_CheckPopup(popupType.waypointPreset)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_WaypointPreset, true)
    Panel_Worldmap_WaypointPreset:SetPosX(WaypointPreset_Btn:GetPosX())
    Panel_Worldmap_WaypointPreset:SetPosY(WaypointPreset_Btn:GetPosY() - Panel_Worldmap_WaypointPreset:GetSizeY())
    PaGlobal_Worldmap_Grand_WaypointPreset_Open()
  else
    PaGlobal_Worldmap_Grand_WaypointPreset_Close()
  end
end
function BtnEvent_WaypointOption()
  if nil == Panel_Worldmap_WaypointOption then
    return
  end
  if false == Panel_Worldmap_WaypointOption:GetShow() then
    GrandWorldMap_CheckPopup(popupType.waypointOption)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_WaypointOption, true)
    Panel_Worldmap_WaypointOption:SetPosX(WaypointOption_Btn:GetPosX())
    Panel_Worldmap_WaypointOption:SetPosY(WaypointOption_Btn:GetPosY() - Panel_Worldmap_WaypointOption:GetSizeY())
    PaGlobal_Worldmap_Grand_WaypointOption_Open()
  else
    PaGlobal_Worldmap_Grand_WaypointOption_Close()
  end
end
function Global_getNodeNavigationPopUpType()
  return popupType.nodeNavigation
end
function Global_getGuildColorListPopUpType()
  return popupType.guildColorList
end
function BtnEvent_NodeNaviCalculation()
  if nil == Panel_Worldmap_NodeCal then
    return
  end
  if false == Panel_Worldmap_NodeCal:GetShow() then
    GrandWorldMap_CheckPopup(popupType.nodeNavigation)
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_NodeCal, true)
    Panel_Worldmap_NodeCal:SetPosX(getScreenSizeX() - Panel_Worldmap_NodeCal:GetSizeX() - 10)
    Panel_Worldmap_NodeCal:SetPosY(getScreenSizeY() / 2 - Panel_Worldmap_NodeCal:GetSizeY() / 2)
    PaGlobal_Worldmap_Grand_NodeNavigation_Open()
  else
    PaGlobal_Worldmap_Grand_NodeNavigation_Close()
  end
end
function BtnEvent_Quest()
  if Panel_CheckedQuest:GetShow() then
    FGlobal_QuestWidget_Close()
  else
    GrandWorldMap_CheckPopup(popupType.quest)
    FGlobal_QuestWidget_Open()
  end
end
function BtnEvent_Transport()
  if Panel_Window_Delivery_InformationView:GetShow() then
    DeliveryInformationView_Close()
  else
    GrandWorldMap_CheckPopup(popupType.transport)
    DeliveryInformationView_Open()
  end
end
function BtnEvent_ItemMarket()
  if Panel_Window_ItemMarket:IsShow() then
    FGolbal_ItemMarketNew_Close()
  else
    GrandWorldMap_CheckPopup(popupType.itemMarket)
    FGlobal_ItemMarket_Open_ForWorldMap(1)
  end
end
function BtnEvent_MarketPlace()
  if false == _ContentsGroup_RenewUI_ItemMarketPlace then
    return
  end
  if true == PaGlobalFunc_MarketPlace_GetShow() then
    PaGlobalFunc_MarketPlace_Close()
  else
    GrandWorldMap_CheckPopup(popupType.marketPlace)
    if _ContentsOption_CH_CreditPoint == true then
      PaGlobalFunc_MarketPlace_CheckCreditPoint(eCreditPointCheckOpenType.openFromWorldMap)
    else
      PaGlobalFunc_MarketPlace_OpenForWorldMap(1)
    end
  end
end
function BtnEvent_WorkerList()
  if nil ~= Panel_Window_WorkerManager_All and true == Panel_Window_WorkerManager_All:GetShow() then
    PaGlobalFunc_WorkerManager_All_Close()
  else
    GrandWorldMap_CheckPopup(popupType.workerList_All)
    if nil ~= currentNodeKey then
      PaGlobalFunc_WorkerManager_All_UpdateNode(ToClient_convertWaypointKeyToPlantKey(currentNodeKey))
    else
      PaGlobalFunc_WorkerManager_All_OpenWorldMap()
    end
  end
end
function BtnEvent_HelpMovie()
  PaGlobal_MovieGuide_Web:Open()
end
function BtnEvent_Exit()
  FGlobal_CloseWorldmapForLuaKeyHandling()
end
function HandleClick_NationSiegeCarriage(point)
  local remainCount = base_carriageMoveCount
  local isMove = false
  if remainCount < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_ZERO"))
  end
end
function HandleOnOut_WorldmapGrand_NationSiegeCarriage_Tooltip(point, isShow)
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_TITLE")
  if 1 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_A")
    control = NationSiegeCarriage_A
  elseif 2 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_B")
    control = NationSiegeCarriage_B
  elseif 3 == point then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GRAND_NATIONSIEGECARRIAGE_TOOLTIP_POINT_C")
    control = NationSiegeCarriage_C
  end
  if true == isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function checkIsHasCastle()
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildWrapper then
    return false
  end
  local myGuildNo = myGuildWrapper:getGuildNo_s64()
  local calpheonWrapper = ToClient_getNationSiegeTeamWrapper(2)
  if nil ~= calpheonWrapper then
    local calpheonGuildCount = calpheonWrapper:getGuildCount()
    for ii = 1, calpheonGuildCount do
      local guildNo = calpheonWrapper:getGuildNoRawByIndex(ii - 1)
      if true == calpheonWrapper:isKingByIndex(ii - 1) and myGuildNo == guildNo then
        return true
      end
    end
  end
  local valenciaWrapper = ToClient_getNationSiegeTeamWrapper(4)
  if nil ~= valenciaWrapper then
    local valenciaGuildCount = valenciaWrapper:getGuildCount()
    for ii = 1, valenciaGuildCount do
      local guildNo = valenciaWrapper:getGuildNoRawByIndex(ii - 1)
      if true == valenciaWrapper:isKingByIndex(ii - 1) and myGuildNo == guildNo then
        return true
      end
    end
  end
  return false
end
local function makePopupPanelList()
  popupPanelList = {
    [popupType.stable] = {panelname = Panel_NodeStable, closeFunc = StableClose_FromWorldMap},
    [popupType.wareHouse] = {panelname = Panel_Window_Warehouse, closeFunc = Warehouse_Close},
    [popupType.quest] = {panelname = Panel_CheckedQuest, closeFunc = FGlobal_QuestWidget_Close},
    [popupType.transport] = {panelname = Panel_Window_Delivery_InformationView, closeFunc = DeliveryInformationView_Close},
    [popupType.itemMarket] = {panelname = Panel_Window_ItemMarket, closeFunc = FGolbal_ItemMarketNew_Close},
    [popupType.workerList] = {panelname = Panel_WorkerManager, closeFunc = HandleClicked_WorkerManager_Close},
    [popupType.helpMovie] = {panelname = Panel_WorldMap_MovieGuide, closeFunc = Panel_Worldmap_MovieGuide_Close},
    [popupType.workerTrade] = {panelname = Panel_WorkerTrade, closeFunc = WorkerTrade_Close},
    [popupType.workerTradeCaravan] = {panelname = Panel_WorkerTrade_Caravan, closeFunc = FGlobal_WorkerTradeCaravan_Hide},
    [popupType.stableMarket] = {panelname = Panel_Window_StableMarket, closeFunc = StableMarket_Close},
    [popupType.npcNavi] = {panelname = Panel_NpcNavi, closeFunc = NpcNavi_ShowToggle},
    [popupType.marketPlace] = {panelname = Panel_Window_MarketPlace_Main, closeFunc = PaGlobalFunc_MarketPlace_Close},
    [popupType.workerList_All] = {panelname = Panel_Window_WorkerManager_All, closeFunc = PaGlobalFunc_WorkerManager_All_Close},
    [popupType.servantMarket_All] = {panelname = Panel_Dialog_ServantMarket_All, closeFunc = PaGlobalFunc_ServantMarket_All_Close},
    [popupType.barterFind] = {panelname = Panel_Window_Barter_Search, closeFunc = PaGlobal_BarterInfoSearch_Close},
    [popupType.waypointPreset] = {panelname = Panel_Worldmap_WaypointPreset, closeFunc = PaGlobal_Worldmap_Grand_WaypointPreset_Close},
    [popupType.waypointOption] = {panelname = Panel_Worldmap_WaypointOption, closeFunc = PaGlobal_Worldmap_Grand_WaypointOption_Close},
    [popupType.nodeNavigation] = {panelname = Panel_Worldmap_NodeCal, closeFunc = PaGlobal_Worldmap_Grand_NodeNavigation_Close},
    [popupType.guildColorList] = {panelname = Worldmap_Grand_Guildwar_ColorList, closeFunc = PaGlobal_Worldmap_Grand_GuildColorList_Close}
  }
  popupPanelList[popupType.wareHouse].closeFunc = PaGlobal_Warehouse_All_Close
  popupPanelList[popupType.workerList].closeFunc = PaGlobalFunc_WorkerManager_All_Close
  popupPanelList[popupType.npcNavi] = {panelname = Panel_NpcNavi_All, closeFunc = PaGlobal_NpcNavi_All_ShowToggle}
  if true == _ContentsGroup_TotalStableList then
    popupPanelList[popupType.stable] = {panelname = Panel_WorldMap_StableList, closeFunc = PaGlobal_WorldMap_StableList_Close}
  end
end
function FGlobal_WorldMapOpenForMenu()
  local btnList = {
    [1] = {btn = Exit_Btn, show = true},
    [2] = {
      btn = HelpMenu_Btn,
      show = false == _ContentsOption_CH_GameType and not isGameTypeGT()
    },
    [3] = {btn = WorkerList_Btn, show = true},
    [4] = {btn = MarketPlace_Btn, show = _ContentsGroup_RenewUI_ItemMarketPlace},
    [5] = {btn = Transport_Btn, show = true},
    [6] = {btn = Quest_Btn, show = true},
    [7] = {btn = WareHouse_Btn, show = true},
    [8] = {btn = ServantStable_Btn, show = true},
    [9] = {btn = StableMarket_Btn, show = true},
    [10] = {btn = NpcFind, show = true},
    [11] = {btn = btn_inMyPosition, show = true},
    [12] = {btn = WaypointPreset_Btn, show = true},
    [13] = {
      btn = ItemMarket_Btn,
      show = not _ContentsGroup_RenewUI_ItemMarketPlace_Only
    },
    [14] = {btn = BarterFind, show = _ContentsGroup_Barter},
    [15] = {btn = WaypointOption_Btn, show = _ContentsGroup_AutomaticGuildeSmooth},
    [16] = {btn = WorkerTrade_Btn, show = isWorkerTradeOpen},
    [17] = {btn = NodeNaviCalc_Btn, show = _ContentsGroup_WorldMapNodeNavigation},
    [18] = {btn = checkBtn_cameraSaveSlot, show = true}
  }
  for key, value in pairs(btnList) do
    if value ~= nil and value.btn ~= nil and value.show ~= nil then
      value.btn:SetShow(value.show)
    end
  end
  PaGlobalFunc_WorldmapGrand_ComputeBottomButtonPos()
  makePopupPanelList()
  Panel_WorldMap:SetShow(true, false)
  Panel_Worldmap_MovieGuide_Init()
  if false == isShowUIByObserver then
    isShowUIByObserver = true
    PaGlobalFunc_WorldmapGrand_ToggleButtonByObserver()
  end
end
function HandleOnOut_WorldmapGrand_MenuButtonTooltip(isShow, buttonType)
  if isShow then
    local control
    local name = ""
    local desc
    if 0 == buttonType then
      control = ServantStable_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_STABLE")
    elseif 1 == buttonType then
      control = WareHouse_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_WAREHOUSE")
    elseif 2 == buttonType then
      control = Quest_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST")
    elseif 3 == buttonType then
      control = Transport_Btn
      name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_DELIVERY")
    elseif 4 == buttonType then
      control = ItemMarket_Btn
      name = PAGetString(Defines.StringSheet_GAME, "GAME_ITEM_MARKET_NAME")
    elseif 5 == buttonType then
      control = WorkerList_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_WORKERTITLE")
    elseif 6 == buttonType then
      control = HelpMenu_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_HELPMOVIE")
    elseif 7 == buttonType then
      control = Exit_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "UICONTROL_BTN_GAMEEXIT")
    elseif 8 == buttonType then
      control = WorkerTrade_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_HELPWORKERTRADE")
    elseif 9 == buttonType then
      control = StableMarket_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_FUNCTION_BTN_MARKET")
    elseif 10 == buttonType then
      control = NpcFind
      name = PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_NOTDRAGABLE")
    elseif 11 == buttonType then
      control = MarketPlace_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_TITLE")
    elseif 12 == buttonType then
      control = btn_inMyPosition
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_INMYPOSITION")
      desc = PAGetString(Defines.StringSheet_GAME, "PANEL_WORLDMAP_INMYPOSITION_DESC")
    elseif 13 == buttonType then
      control = BarterFind
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEA_BARTER_SERACH")
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHERE_ISLAND_BARTER_LIST_SERACH")
    elseif 14 == buttonType then
      control = WaypointPreset_Btn
      name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_MENUBUTTONTOOLTIP_WAYPOINTPRESET")
    elseif 15 == buttonType then
      control = WaypointOption_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_WAYPOINTOPTION_TITLE")
    elseif 16 == buttonType then
      control = NodeNaviCalc_Btn
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_NODECAL_TITLE")
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FGlobal_WorldmapGrand_Bottom_MenuSet(waypointKey)
  if waypointKey ~= nil then
    currentNodeKey = waypointKey
    local isStableOpen = false
    local isWareHouseOpen = false
    local regionInfoWrapper = ToClient_getRegionInfoWrapperByWaypoint(waypointKey)
    if regionInfoWrapper ~= nil then
      isStableOpen = regionInfoWrapper:get():hasStableNpc()
      isWareHouseOpen = regionInfoWrapper:get():hasWareHouseNpc()
    end
    ServantStable_Btn:SetShow(isStableOpen)
    WareHouse_Btn:SetShow(isWareHouseOpen)
    WorkerTrade_Btn:SetShow(false)
    btn_inMyPosition:SetShow(false)
  else
    currentNodeKey = nil
    ServantStable_Btn:SetShow(false)
    WareHouse_Btn:SetShow(false)
    WorkerTrade_Btn:SetShow(isWorkerTradeOpen)
    btn_inMyPosition:SetShow(true)
  end
  if _ContentsGroup_TotalStableList == true then
    ServantStable_Btn:SetShow(true)
  end
  PaGlobalFunc_WorldmapGrand_ComputeBottomButtonPos()
end
function worldmapGrand_Base_OnScreenResize()
  local offsetX = getScreenSizeX()
  local offsetY = getScreenSizeY()
  local remainCount = base_carriageMoveCount
  Panel_WorldMap:SetSize(offsetX, offsetY)
  ServantStable_Btn:ComputePos()
  WareHouse_Btn:ComputePos()
  Quest_Btn:ComputePos()
  Transport_Btn:ComputePos()
  ItemMarket_Btn:ComputePos()
  MarketPlace_Btn:ComputePos()
  WorkerList_Btn:ComputePos()
  HelpMenu_Btn:ComputePos()
  Exit_Btn:ComputePos()
  WorkerTrade_Btn:ComputePos()
  StableMarket_Btn:ComputePos()
  NpcFind:ComputePos()
  btn_inMyPosition:ComputePos()
  transportAlert:ComputePos()
  BarterFind:ComputePos()
  WaypointPreset_Btn:ComputePos()
  WaypointOption_Btn:ComputePos()
  NodeNaviCalc_Btn:ComputePos()
  checkBtn_cameraSaveSlot:ComputePos()
  NationSiegeCarriage_A:ComputePos()
  NationSiegeCarriage_B:ComputePos()
  NationSiegeCarriage_C:ComputePos()
  txt_NationSiegeCarriageCount:ComputePos()
  NationSiegeCarriage_A:SetPosX(offsetX - 200 + NationSiegeCarriage_A:GetSizeX() * 1 + 5)
  NationSiegeCarriage_B:SetPosX(NationSiegeCarriage_A:GetPosX() + NationSiegeCarriage_A:GetSizeX() + 5)
  NationSiegeCarriage_C:SetPosX(NationSiegeCarriage_B:GetPosX() + NationSiegeCarriage_B:GetSizeX() + 5)
  txt_NationSiegeCarriageCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NATIONSIEGE_CARRIAGE_COUNT_TEXT_SET", "remainCount", remainCount))
  txt_NationSiegeCarriageCount:SetPosX(NationSiegeCarriage_A:GetPosX() - txt_NationSiegeCarriageCount:GetTextSizeX() - gab_carriageText)
end
function FromClient_isCompletedTransport(isComplete)
  if nil == isComplete then
    return
  end
end
function PaGlobalFunc_Panel_WorldMap_Open()
  if PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction ~= nil and PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction() == true or PaGlobalFunc_BossReward_IsOpen ~= nil and PaGlobalFunc_BossReward_IsOpen() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NOTOPEN_INGACTION"))
    return
  end
  worldMap_Init()
end
function PaGlobalFunc_WorldmapGrand_ToggleButtonByObserver()
  if nil == Panel_WorldMap then
    return
  end
  isShowUIByObserver = not isShowUIByObserver
  local btnList = {
    Exit_Btn,
    HelpMenu_Btn,
    WorkerList_Btn,
    MarketPlace_Btn,
    Transport_Btn,
    Quest_Btn,
    WareHouse_Btn,
    ServantStable_Btn,
    StableMarket_Btn,
    NpcFind,
    btn_inMyPosition,
    WaypointPreset_Btn,
    ItemMarket_Btn,
    BarterFind,
    WaypointOption_Btn,
    WorkerTrade_Btn,
    NodeNaviCalc_Btn,
    checkBtn_cameraSaveSlot
  }
  for index = 1, #btnList do
    btnList[index]:SetShow(isShowUIByObserver)
  end
  if nil ~= Panel_Chat0 then
    Panel_Chat0:SetShow(isShowUIByObserver)
  end
  if nil ~= Panel_Chat1 then
    Panel_Chat1:SetShow(isShowUIByObserver)
  end
  if nil ~= Panel_Chat2 then
    Panel_Chat2:SetShow(isShowUIByObserver)
  end
  if nil ~= Panel_Chat3 then
    Panel_Chat3:SetShow(isShowUIByObserver)
  end
  if nil ~= Panel_Chat4 then
    Panel_Chat4:SetShow(isShowUIByObserver)
  end
end
function PaGlobalFunc_WorldmapGrand_ComputeBottomButtonPos()
  local btnList = {
    [1] = Exit_Btn,
    [2] = HelpMenu_Btn,
    [3] = WorkerList_Btn,
    [4] = MarketPlace_Btn,
    [5] = Transport_Btn,
    [6] = Quest_Btn,
    [7] = WareHouse_Btn,
    [8] = ServantStable_Btn,
    [9] = StableMarket_Btn,
    [10] = NpcFind,
    [11] = btn_inMyPosition,
    [12] = WaypointPreset_Btn,
    [13] = ItemMarket_Btn,
    [14] = BarterFind,
    [15] = WaypointOption_Btn,
    [16] = WorkerTrade_Btn,
    [17] = NodeNaviCalc_Btn,
    [18] = checkBtn_cameraSaveSlot
  }
  local spanX = Exit_Btn:GetSpanSize().x
  local spanY = Exit_Btn:GetSpanSize().y
  local addValue = 3
  for i = 1, #btnList do
    local btn = btnList[i]
    if btn ~= nil and btn:GetShow() == true then
      btn:SetSpanSize(spanX, spanY)
      btn:ComputePos()
      spanX = btn:GetSizeX() + btn:GetSpanSize().x + addValue
    end
  end
end
function PaGlobalFunc_WorldMapReightBottomUIListOnOff(onOff)
  local btnList = {
    [1] = Exit_Btn,
    [2] = HelpMenu_Btn,
    [3] = WorkerList_Btn,
    [4] = MarketPlace_Btn,
    [5] = Transport_Btn,
    [6] = Quest_Btn,
    [7] = WareHouse_Btn,
    [8] = ServantStable_Btn,
    [9] = StableMarket_Btn,
    [10] = NpcFind,
    [11] = btn_inMyPosition,
    [12] = WaypointPreset_Btn,
    [13] = ItemMarket_Btn,
    [14] = BarterFind,
    [15] = WaypointOption_Btn,
    [16] = WorkerTrade_Btn,
    [17] = NodeNaviCalc_Btn,
    [18] = checkBtn_cameraSaveSlot
  }
  for index = 1, #btnList do
    if btnList[index] ~= nil then
      btnList[index]:SetShow(onOff)
    end
  end
end
function CreateBtn_CameraSaveSlots()
  if btn_cameraSaveSlot[0] ~= nil then
    return
  end
  local initPosY = checkBtn_cameraSaveSlot:GetSpanSize().y
  for i = 0, _cameraSaveSlotCount - 1 do
    btn_cameraSaveSlot[i] = UI.cloneControl(btn_cameraSaveSlot_Template, Panel_WorldMap, "Button_Camera_SaveSlot_" .. i)
    btn_cameraSaveSlot[i]:SetSpanSize(checkBtn_cameraSaveSlot:GetSpanSize().x, initPosY)
    btn_cameraSaveSlot[i]:addInputEvent("Mouse_LUp", "HandleEventLUp_Btn_CameraSaveSlot(" .. i .. ")")
    btn_cameraSaveSlot[i]:addInputEvent("Mouse_On", "Btn_CameraSaveSlotTooltip( true, " .. i .. ")")
    btn_cameraSaveSlot[i]:addInputEvent("Mouse_Out", "Btn_CameraSaveSlotTooltip( false, " .. i .. ")")
    btn_cameraSaveSlot[i]:SetText(i)
    btn_cameraSaveSlot[i]:ComputePos()
    btn_cameraSaveSlot[i]:SetShow(false)
  end
end
function CheckBtn_CameraSaveSlotTooltip(isShow)
  if isShow then
    local btn = checkBtn_cameraSaveSlot
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_CAMERASAVE_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_CAMERASAVE_DESC")
    TooltipSimple_Show(btn, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function Btn_CameraSaveSlotTooltip(isShow, index)
  if ToClient_IsSetWorldMapQuickScreenPosition(index) == false then
    return
  end
  if isShow then
    local btn = btn_cameraSaveSlot[index]
    local name = ToClient_GetWorldMapQuickScreenPositionRegionName(index)
    TooltipSimple_Show(btn, name, "")
  else
    TooltipSimple_Hide()
  end
end
function UpdateBtn_WorldMapCameraSaveSlotMonoTone(index)
  if ToClient_IsSetWorldMapQuickScreenPosition(index) == true then
    btn_cameraSaveSlot[index]:SetMonoTone(false)
  else
    btn_cameraSaveSlot[index]:SetMonoTone(true)
  end
end
function HandleEventLUp_CheckBtn_CameraSaveSlot()
  if stc_cameraSaveSlotBG:GetShow() == true then
    stc_cameraSaveSlotBG:SetShow(false)
    local initPosY = checkBtn_cameraSaveSlot:GetPosY()
    for i = 0, _cameraSaveSlotCount - 1 do
      local btn = btn_cameraSaveSlot[i]
      local ani = btn:addMoveAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      ani:SetStartPosition(checkBtn_cameraSaveSlot:GetPosX() + 6, btn:GetPosY())
      ani:SetEndPosition(checkBtn_cameraSaveSlot:GetPosX() + 6, initPosY)
      ani:SetDisableWhileAni(true)
      ani:SetHideAtEnd(true)
    end
  else
    stc_cameraSaveSlotBG:SetShow(true)
    local sizeY = checkBtn_cameraSaveSlot:GetSizeY()
    local startY = checkBtn_cameraSaveSlot:GetPosY() + 12
    local offsetY = sizeY - 10
    local posIndex = 0
    for i = 0, _cameraSaveSlotCount - 1 do
      local btn = btn_cameraSaveSlot[i]
      btn:SetShow(true)
      UpdateBtn_WorldMapCameraSaveSlotMonoTone(i)
      if i == 0 then
        posIndex = _cameraSaveSlotCount + 1
      else
        posIndex = i + 1
      end
      local ani = btn:addMoveAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
      ani:SetStartPosition(checkBtn_cameraSaveSlot:GetPosX() + 6, btn:GetPosY())
      ani:SetEndPosition(checkBtn_cameraSaveSlot:GetPosX() + 6, startY - offsetY * posIndex)
    end
  end
end
function HandleEventLUp_Btn_CameraSaveSlot(index)
  if ToClient_IsSetWorldMapQuickScreenPosition(index) then
    ToClient_MoveCameraToWorldMapQuickScreenPosition(index)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_CAMERASAVE_EMPTY"))
  end
end
worldMap_Init()
registerEvent("onScreenResize", "worldmapGrand_Base_OnScreenResize")
registerEvent("FromClient_isCompletedTransport", "FromClient_isCompletedTransport")
