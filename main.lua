-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local movieclip = require("movieclip")
local physics = require( "physics" )

local asteroidsTable = {}
local asteroidsTable2 = {}
physics.start()
local bg = display.newImageRect ( "bg.jpg", 360, 570 )
bg.x = display.contentCenterX
bg.y = display.contentCenterY
local jumpCount = 100
local score =  0
local show_score = display.newText(score, 65, 50, native.systemFont, 40)
local scorestring = display.newText("Score",65,10, native.systemFont, 40)
local life = 1
local show_life = display.newText(life, 280, 50, native.systemFont, 40)
local show_lifestring = display.newText("Life", 280, 10, native.systemFont, 40)

local jump_times = display.newText(jumpCount, 180, 50, native.systemFonr,40)
local jump_timesstring = display.newText("Jump", 180, 10, native.systemFonr,40)

local wall1 = display.newRect(2, 200, 1, 640) --왼쪽
local wall2 = display.newRect(0, 505, 650, 1) --아래쪽
local wall3 = display.newRect(319, 280, 1, 640) --오른쪽
local wall4 = display.newRect(110, 360, 420, 1) --위쪽(캐릭터)
local wall5 = display.newRect(110, -43, 420, 1) --위쪽

local wallCollisionFilter = {categoryBits = 1, maskBits = 6}

physics.addBody(wall1, 'static', {filter = wallCollisionFilter})
physics.addBody(wall2, 'static', {filter = wallCollisionFilter})
physics.addBody(wall3, 'static', {filter = wallCollisionFilter})
physics.addBody(wall4, 'static', {filter = wallCollisionFilter})
physics.addBody(wall5, 'static', {filter = wallCollisionFilter})

local function onMouseEvent( event )
    -- Print the mouse cursor's current position to the log.
    -- 마우스 좌표읽기
    --local message = "Position = (" .. math.floor(event.x) .. ")"
      --.. math.floor(event.y) .. ")"
        transition.to(myAnimm, {x=event.x})


   
  
 --   local location = display.newText(message, 100,50, native.systemFont, 30)
    
end             
-- Add the mouse event listener.
Runtime:addEventListener( "mouse", onMouseEvent )



 --   local location = display.newText(message, 100,50, native.systemFont, 30)
    
                              
-- Add the mouse event listener.


local function createAsteroid()
 
  local indx = math.random(1,3)
	local picname = "a00.png";
	if indx ==2 then picname = "a01.png" end
	if indx ==3 then picname = "a02.png" end
	 local newAsteroid = display.newImageRect( picname,80,80)
  --local newAsteroid = display.newImageRect( picname ,40,40)
 
 
    newAsteroid.myName = "Heart"
  table.insert(asteroidsTable, newAsteroid)
physics.addBody( newAsteroid, "dynamic", {radius = 30, bounce=0.6})
newAsteroid.x = math.random(0,200)
newAsteroid.y = 10
newAsteroid:setLinearVelocity(math.random(40,120), math.random(30,45))
newAsteroid:applyTorque(math.random(-6,6))


end

local function createAsteroid2()
  local newAsteroid2 = display.newImageRect( "bomb.png",70,50)
    newAsteroid2.myName = "Bomb"
  table.insert(asteroidsTable2, newAsteroid2)
physics.addBody( newAsteroid2, "dynamic", {radius = 30, bounce=0.6})
newAsteroid2.x = math.random(0,250)
newAsteroid2.y = 15
newAsteroid2:setLinearVelocity(math.random(30,80), math.random(30,45))
newAsteroid2:applyTorque(math.random(-6,6))


end



   local AnimCollisionFilter = { categoryBits = 2, maskBits = 3 }


-- 무한 루프 1-8
local function myAnim() myAnimm = movieclip.newAnim{ "player01.png", "player02.png", "player03.png", "player04.png", "player05.png", "player06.png", "player07.png" };
    myAnimm.myName = "Ryan"
    myAnimm.x = display.contentCenterX
    myAnimm.y = display.contentHeight-25
    physics.addBody(myAnimm, "dynamic", {filter = AnimCollisionFilter, radius = 50, friction = 0.5})
    myAnimm:play{ startFrame=1, endFrame=8, loop=0, time=50, remove=true}
    end

myAnim()

--local function onTouch(event)
 --   if(event.phase == "ended") then
  --      
      --  end
    
--end

local function onCollision( event )

    local obj1 = event.object1
    local obj2 = event.object2
	local heart = newAsteroid
--	function  myAnim2() myAnimm2 = movieclip.newAnim{ "nukebomb-0000.jpg","nukebomb-0001.jpg","nukebomb-0002.jpg","nukebomb-0003.jpg","nukebomb-0004.jpg","nukebomb-0005.jpg","nukebomb-0006.jpg","nukebomb-0007.jpg",
--"nukebomb-0008.jpg","nukebomb-0009.jpg","nukebomb-0010.jpg","nukebomb-0011.jpg","nukebomb-0012.jpg",
--"nukebomb-0013.jpg","nukebomb-0014.jpg","nukebomb-0015.jpg","nukebomb-0016.jpg","nukebomb-0017.jpg",
-- "nukebomb-0018.jpg","nukebomb-0019.jpg","nukebomb-00020.jpg","nukebomb-0021.jpg"	};
	--end
	
    if  (obj1.y > obj2.y) and ((obj1.myName == "Ryan" and obj2.myName == "Heart") or
      (obj1.myName == "Heart" and obj2.myName == "Ryan")) 
    then
      display.remove(obj2)
		score = score + 1
		show_score.text = score
		--print("하트와 라이언이 충돌했습니다.")
		elseif  (obj1.y > obj2.y) and ((obj1.myName == "Ryan" and obj2.myName == "Bomb") or
      (obj1.myName == "Bomb" and obj2.myName == "Ryan")) 
		then
		--print("폭탄과 라이언이 충돌했습니다.")
		display.remove(obj2)
	--	myAnimm2:play{ startFrame=1, endFrame=21, loop=1, time=50, remove=true}
		score = score - 10
		show_score.text = score
		life = life - 1
		show_life.text = life
    end
	if (score < -1) then score = 0 
	show_score.text = score end
	-- 점수가 -1일때 스코어는 0으로 회귀한다.
	
    
  if (life <= 0)then
   local GAME = display.newText("GAME",160,150, native.systemFont, 70)  
     local OVER = display.newText("OVER",160,230, native.systemFont, 70) 
	local record = display.newText("Your Score:",160,280, native.systemFont, 40)
	local recordtext = score
	local recorddisplay = display.newText(recordtext, 160, 330, native.systemFont, 40)
	local replay = display.newText("Retry? Please Press Any Key", 160, 380, native.systemFont, 23)
    display.remove(event.object1)
    display.remove(event.object2)
    physics.removeBody(event.object1) 
	
 end
 end
 
 
 --local function gameRestart()
 --if (life <= 0) then
 --display.remove(GAME)
 --display.remove(OVER)
 --display.remove(record)
 --display.remove(replay) 
 --myAnim()
 --end
 --end
--Runtime:addEventListener("touch", gameRestart)


Runtime:addEventListener("collision", onCollision)



--Runtime:addEventListener("touch", onTouch)

local function gameLoop()
  createAsteroid()
end

local function gameLoopBomb()
createAsteroid2()
end

gameLoopTimer = timer.performWithDelay( 2000, gameLoop, 0)
gameLoopTimer = timer.performWithDelay( 5000, gameLoopBomb, 0)


local function onJumpEvent( event )

if(event.phase == "began") then
        myAnimm:setLinearVelocity(0, -100)
		jumpCount = jumpCount - 1
		jump_times.text = jumpCount
		if (jumpCount < 0 ) then
		myAnimm:setLinearVelocity(0, 0)
		local jumpNotice = display.newText("You can't Jump!", 160, 100, native.systemFont, 40)

end

end
	if (jumpCount < 0) then 
	jumpCount = 0 
	jump_times.text = jumpCount end
end



--gameJumpTimer = timer.performWithDelay( 10000, onJumpEvent, 0 )


Runtime:addEventListener("touch", onJumpEvent) 


