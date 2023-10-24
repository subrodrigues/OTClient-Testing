HOTKEY = 'Ctrl+W'

jumpinBtnWindow = nil
clickMeButton = nil
animationEvent = nil

function init()					
  g_keyboard.bindKeyDown(HOTKEY, toggle)

  jumpinBtnWindow = g_ui.displayUI('jumpinbtn')
  
  clickMeButton = jumpinBtnWindow:getChildById('clickMeButton')
  
  -- onClick handler, resets the btn position on click
  clickMeButton.onClick = function()
    resetJumpinBtnPosition()
  end

  -- Setup the initial btn position and start the btn animation
  resetJumpinBtnPosition()
  startButtonAnimation()
end

function terminate()
  g_keyboard.unbindKeyDown(HOTKEY)
  jumpinBtnWindow:destroy()
  clickMeButton:destroy()
end

--[[ 
  Method that toggles the Window visibility.
  
  On visible: resets the button position and start the animation.
  On invisible: removes the animation event.
--]]
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
  clickMeButton:raise() -- push the button to the front
  
  animationEvent = scheduleEvent(startButtonAnimation, 200)
end

function changeButtonPos()
  clickMeButton:setX(clickMeButton:getX() - 25) -- moves the button to the left
  
  -- If horizontal position reaches window border, reset
  if clickMeButton:getX() <= jumpinBtnWindow:getX() then
    resetJumpinBtnPosition()
  end

end

--[[
  Method that resets the button position.
  
  The horizontal position is the parent (main window) far right X value minus half the button width.
  The vertical position is the parent top Y value plus a random value within the window border.
--]]
function resetJumpinBtnPosition()
  clickMeButton:setX(jumpinBtnWindow:getX() + jumpinBtnWindow:getWidth() - clickMeButton:getWidth() - 25)
  clickMeButton:setY(jumpinBtnWindow:getY() + clickMeButton:getHeight() + math.random(10, 425))
end