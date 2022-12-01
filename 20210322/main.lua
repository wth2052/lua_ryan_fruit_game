-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local hou_life = 20
local asteroidsTable = {}
local physics = require( "physics" )
physics.start()

local bg = display.newImageRect ( "bg.jpg", 360, 570 )
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local bomp_num = 0
local show_bomp = display.newText(bomp_num, 50, 20, native.systemFont, 40)
local show_life = display.newText(hou_life, 250, 20, native.systemFont, 40)

local hou = display.newImageRect("player.png", 100, 80)
hou.myName = "House"
physics.addBody(hou, "static")
hou.x = display.contentCenterX 
hou.y = display.contentHeight-10



local fort = display.newImageRect("ryanham.png", 100, 100)
fort.x = display.contentCenterX 
fort.y = display.contentHeight-90


local function dragfort ( event )
  local fort = event.target
  local phase = event.phase
  if ("began" == phase) then
    display.currentStage:setFocus(fort)
    fort.touchOffsetX = event.x - fort.x
  elseif("moved" == phase ) then
    fort.x = event.x - fort.touchOffsetX
  elseif("ended" == phase or "cancelled" == phase) then
    display.currentStage:setFocus( nil )
  end
  return true
  end
fort : addEventListener("touch", dragfort)

local function fire_missle()
  local newMis = display.newImageRect("a03.png", 50, 60)
physics.addBody( newMis, "dynamic", {isSensor=true})
newMis.isBullet = true
newMis.myName = "Missile"
newMis.x = fort.x
newMis.y = fort.y
-- newMis:toBack()

transition.to(newMis, {y=-40, time=500,
    onComplete = function() display.remove(newMis) end
    })

end
fort : addEventListener("tap", fire_missle)


local function createAsteroid()
--bomp_num = bomp_num + 1
    show_bomp.text = #asteroidsTable
  local newAsteroid = display.newImageRect( "a00.png",80,150)
  table.insert(asteroidsTable, newAsteroid)
physics.addBody( newAsteroid, "dynamic", {radius = 40, bounce=0.8})
newAsteroid.myName = "asteroid"

    
newAsteroid.x = math.random(0,300)
newAsteroid.y = 10
newAsteroid:setLinearVelocity(math.random(40,120), math.random(20,60))
newAsteroid:applyTorque(math.random(-6,6))

   -- local station = display.newImageRect ( "player.png", 100, 80 )
-- station.x = display.contentCenterX
-- station.y = display.contentHeight-25


end

local function onColision( event )
  if (event.phase == "began") then
    local obj1 = event.object1
    local obj2 = event.object2
    -- BOMB MISSILE
    if ((obj1.myName == "Missile" and obj2.myName == "asteroid") or
      (obj1.myName == "asteroid" and obj2.myName == "Missile"))
    then
      display.remove(obj1)
      display.remove(obj2)
      for i = #asteroidsTable, 1, -1 do
        if ( asteroidsTable[i] == obj1 or asteroidsTable[i] == obj2 ) then
          table.remove( asteroidsTable, i )
          break
        end
      end
    end
    local isHit = 0 
    local obj3
          if (obj1.myName == "Missile" and obj2.myName == "House") then
            display.remove(obj1)
            isHit = 1
          obj3 = obj1
          end
                if (obj1.myName == "House" and obj2.myName == "asteroid") then
            display.remove(obj2)
            isHit = 1
            obj3 = obj2
          end
          if (isHit == 1)then 
            hou_life = hou_life - 1
            show_life.text = hou_life
             for i = #asteroidsTable, 1, -1 do
        if ( asteroidsTable[i] == obj3 ) then
          table.remove( asteroidsTable, i )
          break
        end
      end
    end
  end
  local obj1 = event.object1
  local ojb2 = event.object2
end

Runtime:addEventListener("collision", onColision)

local function gameLoop()
  createAsteroid()
    for i = #asteroidsTable, 1, -1 do
        local thisAsteroid = asteroidsTable[i]
        if (thisAsteroid.x < -100 or
          thisAsteroid.x > display.contentWidth + 100 or
          thisAsteroid.y < -100 or
          thisAsteroid.x > display.contentHeight + 100)
        then
          display.remove(thisAsteroid)
          table.remove(asteroidsTable, i)
    end
end
end
gameLoopTimer = timer.performWithDelay( 2000, gameLoop, 0)


