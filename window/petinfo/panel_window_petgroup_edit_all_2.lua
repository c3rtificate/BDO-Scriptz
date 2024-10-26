function PaGlobalFunc_PetGroupEdit_Open()
  PaGlobal_PetGroupEdit:prepareOpen()
end
function PaGlobalFunc_PetGroupEdit_Close()
  PaGlobal_PetGroupEdit:prepareClose()
end
function PaGlobalFunc_PetGroupEdit_GetShow()
  if Panel_Window_GroupEdit_All == nil then
    return false
  end
  return (Panel_Window_GroupEdit_All:GetShow())
end
function PaGlobalFunc_PetGroupEdit_ClickGroup(index)
  PaGlobal_PetGroupEdit:clickGroup(index)
end
function PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(isLeft)
  if isLeft == true then
    PaGlobal_PetGroupEdit._indexForConsole = PaGlobal_PetGroupEdit._indexForConsole - 1
  elseif isLeft == false then
    PaGlobal_PetGroupEdit._indexForConsole = PaGlobal_PetGroupEdit._indexForConsole + 1
  end
  if PaGlobal_PetGroupEdit._indexForConsole < 0 then
    PaGlobal_PetGroupEdit._indexForConsole = 4
  elseif PaGlobal_PetGroupEdit._indexForConsole > 4 then
    PaGlobal_PetGroupEdit._indexForConsole = 0
  end
  PaGlobal_PetGroupEdit:clickGroup(PaGlobal_PetGroupEdit._indexForConsole)
end
