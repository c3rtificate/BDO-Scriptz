function PaGlobalFunc_AtoraxionInfo_Open()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  PaGlobal_Atoraxion_RegionInfo:prepareOpen()
end
function PaGlobalFunc_AtoraxionInfo_Close()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  PaGlobal_Atoraxion_RegionInfo:prepareClose()
end
function PaGlobalFunc_AtoraxionInfo_GetPosY()
  if Panel_Window_AtoraxionInfo == nil then
    return 0
  end
  return panel:GetPosY()
end
function PaGlobalFunc_AtoraxionInfo_GetSizeY()
  if Panel_Window_AtoraxionInfo == nil then
    return 0
  end
  return panel:GetSizeY()
end
function PaGlobalFunc_Atoraxion_RegionInfo_Open(regionData)
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  if nil == regionData then
    return
  end
  PaGlobal_Atoraxion_RegionInfo:setData(regionData)
  PaGlobalFunc_AtoraxionInfo_Open()
end
