HOTKEY = 'Ctrl+W'

jumpinBtnWindow = nil
clickMeButton = nil
animationEvent = nil

function init()					
  g_keyboard.bindKeyDown(HOTKEY, toggle)

  jumpinBtnWindow = g_ui.displayUI('jumpinbtn')
  clickMeButton = jumpinBtnWindow:getChildById('clickMeButton')
  clickMeButton.onClick = function()
    resetJumpinBtnPosition()
  end
	
  resetJumpinBtnPosition()
  startButtonAnimation()
end

function terminate()
  g_keyboard.unbindKeyDown(HOTKEY)
  jumpinBtnWindow:destroy()
  clickMeButton:destroy()
end

function toggle()
  jumpinBtnWindow:setVisible(not jumpinBtnWindow:isVisible())
  
  if(jumpinBtnWindow:isVisible()) then
    resetJumpinBtnPosition()

    startButtonAnimation()
  else
    if animationEvent then
      removeEvent(animationEvent)
      animationEvent = nil
	end
  end
end

function startButtonAnimation()
  changeButtonPos()
  clickMeButton:raise()
  
  animationEvent = scheduleEvent(startButtonAnimation, 200)
end

function changeButtonPos()
  clickMeButton:setX(clickMeButton:getX() - 25)
  
  if clickMeButton:getX() <= jumpinBtnWindow:getX() then
    resetJumpinBtnPosition()
  end

end

function resetJumpinBtnPosition()
  clickMeButton:setX(jumpinBtnWindow:getX() + jumpinBtnWindow:getWidth() - clickMeButton:getWidth() - 25)
  clickMeButton:setY(jumpinBtnWindow:getY() + clickMeButton:getHeight() + math.random(10, 425))
end