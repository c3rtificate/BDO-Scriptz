PaGlobal_ExtraDrop = {
  _ui = {
    stc_TitleArea = nil,
    txt_Title = nil,
    btn_Close = nil,
    list2_ExtraDropList = nil,
    txt_Desc = nil,
    stc_consoleBtnGroup = nil,
    stc_console_A = nil,
    stc_console_B = nil,
    stc_console_Y = nil
  },
  _extraDropData = {
    [__eExtraDropType_Hystria] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_Aakman] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_PilaKu] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_Sulfur] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_Tungrad] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_CityOfTheDead] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eeExtraDropType_OlunsValley] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_SycraiaUpper] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_Padix] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_AshForest] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eExtraDropType_CryptOfRestingThoughts] = {
      string = "",
      currentPoint = 0,
      switch = false
    }
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/DropItem/Panel_Window_ExtraDrop_1.lua")
runLua("UI_Data/Script/Window/DropItem/Panel_Window_ExtraDrop_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ExtraDrop_Init")
function FromClient_ExtraDrop_Init()
  PaGlobal_ExtraDrop:initialize()
end
