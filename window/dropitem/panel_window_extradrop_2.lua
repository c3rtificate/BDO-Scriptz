function PaGlobal_ExtraDrop_ShowAni()
  if PaGlobal_ExtraDrop == nil then
    return
  end
end
function PaGlobal_ExtraDrop_HideAni()
  if PaGlobal_ExtraDrop == nil then
    return
  end
end
function PaGlobal_ExtraDrop_Open()
  if PaGlobal_ExtraDrop == nil then
    return
  end
  PaGlobal_ExtraDrop:prepareOpen()
end
function PaGlobal_ExtraDrop_Close()
  if PaGlobal_ExtraDrop == nil then
    return
  end
  PaGlobal_ExtraDrop:prepareClose()
end
function PaGlobal_ExtraDrop_Toggle()
  local self = PaGlobal_ExtraDrop
  if self == nil then
    return
  end
  local isShow = Panel_Window_ExtraDrop:GetShow()
  if isShow == true then
    PaGlobal_ExtraDrop:prepareClose()
  else
    PaGlobal_ExtraDrop:prepareOpen()
  end
end
function PaGlobal_ExtraDrop_ExtraDropUpdateSwitch()
  local self = PaGlobal_ExtraDrop
  if self == nil then
    return
  end
  if Panel_Window_ExtraDrop == nil then
    return
  end
  if Panel_Window_ExtraDrop:GetShow() == false then
    return
  end
  self:update()
end
function PaGlobal_ExtraDrop_ExtraDropUpdatePoint()
  local self = PaGlobal_ExtraDrop
  if self == nil then
    return
  end
  if Panel_Window_ExtraDrop == nil then
    return
  end
  if Panel_Window_ExtraDrop:GetShow() == false then
    return
  end
  self:update()
end
