-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')
love.graphics.setDefaultFilter("nearest")




local door = love.graphics.newImage("door.png")
local perso = love.graphics.newImage("perso.png")
local piege = love.graphics.newImage("piege.png")
local decor1 = love.graphics.newImage("decor1.png")
local decor2 = love.graphics.newImage("decor2.png")
local bonus = love.graphics.newImage("bonus.png")
local torche = love.graphics.newImage("torche.png")
local ghostleft = love.graphics.newImage("ghostleft.png")
local ghostright = love.graphics.newImage("ghostright.png")
local ghostup = love.graphics.newImage("ghostup.png")
local ghostdown = love.graphics.newImage("ghostdown.png")
local cadenas = love.graphics.newImage("cadenas.png")
local key = love.graphics.newImage("key.png")
local moveup = love.graphics.newImage("moveup.png")
local moveright = love.graphics.newImage("moveright.png")
local movedown = love.graphics.newImage("movedown.png")
local moveleft = love.graphics.newImage("moveleft.png")

lstButton = {perso,door,piege,decor1,decor2,bonus,torche,ghostleft,ghostright,ghostup,ghostdown,
             key,cadenas,moveup,moveright,movedown,moveleft  }

name = "spriteSheet"
local img = love.graphics.newImage(name..".png")
width = img:getWidth()/8
height = img:getHeight()/10
print(width,height)
quad = {}
indexKey = 1 
buttons = {}
sprites = {}
imgSprites = {}
currentLevel = 0
indexSprite = 0
mapSprite = {}

local statusGrid = true
local rowsLevel = 12
local lineLevel = 6 
 local size = 2
  local maxColonne = 15
  local offsetDrawTile = 450
  local sizeSprite = 3
 local level = {}
 
 local red = {1,0,0,0.7}
--                {
--                    0,0,0,0,0,0,0,0,0,0,
--                    0,0,0,0,0,0,0,0,0,0,
--                    0,0,0,0,0,0,0,0,0,0,
--                    0,0,0,0,0,0,0,0,0,0,
--                    0,0,0,0,0,0,0,0,0,0,
--                    0,0,0,0,0,0,0,0,0,0,
----                    0,0,0,0,0,0,0,0,0,0,
----                    14,12,12,18,18,15,0,0,0,0,
----                    17,10,21,0,0,26,0,0,0,0,
----                    0,0,0,0,0,19,0,0,0,0,
----                    0,0,0,14,5,1,1,15,0,0,
----                    0,0,0,17,10,10,10,16,0,0
--                }
--                }
 grids = {
    
     }
grids ={ 
        {
            {1,7,7,1},
            {8,0,0,8},
            {8,0,0,8},
            {1,7,7,1}
        },
        {
            {11,7,7,10},
            {8,0,0,8},
            {8,0,0,8},
            {1,7,7,1}
        },
        {
            {1,7,7,4},
            {8,0,0,8},
            {8,0,0,8},
            {1,7,7,6}
        },
        {
            {1,7,7,1},
            {8,0,0,8},
            {8,0,0,8},
            {11,7,7,10}
        },
        {
            {4,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,1}
        },
        -------
        {
            {2,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,1}
        },
        {
            {1,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,5}
        },
        {
            {1,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {9,7,7,5}
        },
        {
            {2,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {9,7,7,1}
        },
        ----------
        {
            {1,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,6}
        },
        {
            {11,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,1}
        },       
        {
            {4,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,1}
        },
        {
            {1,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,10}
        },
        -----------
        {
            {2,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,1}
        },
        {
            {4,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,10}
        },
        {
            {1,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,5}
        },
        {
            {11,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {9,7,7,6}
        },
        ------------
        {
            {4,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,6}
        },
        {
            {11,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,10}
        },
        ----------------
        {
            {4,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,6}
        },
        
        {
            {1,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,5}
        },
                ---------------------- A Faire 

        {
            {1,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,6}
        },
        {
            {4,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,6}
        },        
        {
            {4,7,7,4},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,1}
        },    
--------------------
        {
            {11,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,10}
        },
        {
            {1,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,10}
        }, 
        {
            {11,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,10}
        },
        {
            {11,7,7,10},
            {8,0,0,8},  
            {8,0,0,8},
            {11,7,7,1}
        },
    ----------
            {
            {4,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,5}
        },
 {
            {1,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {6,7,7,5}
        },
 {
            {1,7,7,1},
            {8,0,0,8},  
            {8,0,0,8},
            {9,7,7,6}
        },
        {
            {1,7,7,3},
            {8,0,0,8},  
            {8,0,0,8},
            {1,7,7,10}
        },
    }


function love.load()
     love.window.setMode( 1024, 768)
     table.insert(mapSprite,newMapSprite())

     --loadTiles()
     newLevels()
     loadLevels()
     --mapSprite=newMapSprite()
--     mapSprite[2] = 1
   
     indexKey = 1 or #grids 
     love.graphics.setBackgroundColor(1,1,1,1)
     local i=1
     for l=1,height do
          for c=1,width do
               quad[i] = love.graphics.newQuad( (c-1)*8, (l-1)*10, 8, 10, img)
               i = i + 1
            
          end
     end
     local panel = { x = 600, y = 0}
    
     newButton(panel.x,panel.y,100,40,"SAVE TILES",saveTiles,nil,nil,red)
     newButton(panel.x,panel.y+40,100,40,"LOAD TILES",loadTiles)
     newButton(panel.x+100,panel.y,100,40,"SAVE LEVELS",saveLevels,nil,nil,red)
     newButton(panel.x+100,panel.y+40,100,40,"LOAD LEVELS",loadLevels)
     newButton(panel.x,panel.y+80,100,40,"NEW LEVELS",newLevels)
     newButton(panel.x+100,panel.y+80,100,40,"ERASE LEVELS",eraseLevels)
     newButton(panel.x,panel.y+120,100,40,"SHOW GRID",updateGrid)

    
     newButton(panel.x+250,panel.y,50,40,"DOWN",downLevels)
     newButton(panel.x+350,panel.y,50,40,"UP",upLevels)
     windowCurrentLevel=newButton(panel.x+300,panel.y,50,40,"1",downLevels)
     
     -- perso et door
--     table.insert(sprites,newButton(panel.x+200,panel.y+100,16*sizeSprite,20*sizeSprite,"",actionSprite,perso,1))
--     table.insert(sprites,newButton(panel.x+200+16*sizeSprite+2,panel.y+100,16*sizeSprite,20*sizeSprite,"",actionSprite,door,2))
--     table.insert(sprites,newButton(panel.x+200+32*sizeSprite+2,panel.y+100,16*sizeSprite,20*sizeSprite,"",actionSprite,piege,3))
--     table.insert(imgSprites,perso)
--     table.insert(imgSprites,door)
--     table.insert(imgSprites,piege)
     
     local indexButton = 1
     
     for l=1,math.floor(#lstButton/4)+1 do 
          for c=1,4 do
          if indexButton<=#lstButton then 
          local b = lstButton[indexButton]
          table.insert(sprites,newButton(panel.x+200+16*sizeSprite*(c-1)+2,panel.y+100+20*sizeSprite*(l-1),16*sizeSprite,20*sizeSprite,"",actionSprite,b,indexButton))
          table.insert(imgSprites,b)
          indexButton = indexButton + 1
          end
          end
     end

end
function actionSprite(self)
     print(self.index)
     indexSprite = 0
     for k, sprite in pairs(sprites) do
          if sprite.index == self.index then
               sprite.isHover = not sprite.isHover
          else 
               sprite.isHover = false
          end
          if sprite.isHover then 
               indexSprite=self.index
          end
          
     end
end
function getPositionSprite(n,pCurrentLevel)
     for i = 1, rowsLevel do
      for j = 1, lineLevel do
        local v=mapSprite[pCurrentLevel][(j-1)*rowsLevel + i]
        if v==n then
             print(i,j)
          return {i,j}
        end
        
      end
    end
end

function newMapSprite()
         local t = {}
    for i = 1, rowsLevel do
      for j = 1, lineLevel do
        t[(j-1)*rowsLevel + i] = 0
      end
    end
    return t
end

function newLevels()
    local t = {}
    for i = 1, rowsLevel do
      for j = 1, lineLevel do
        t[(j-1)*rowsLevel + i] = 0
      end
    end
    table.insert(level,currentLevel+1,t)
    table.insert(mapSprite,currentLevel+1,newMapSprite())
    currentLevel = currentLevel+1
end

function eraseLevels()
    if currentLevel==1 and #level==1 then return end

    table.remove(level,currentLevel)
    table.remove(mapSprite,currentLevel)
    
    if currentLevel-1==#level then currentLevel=#level end
end

function downLevels()
    currentLevel = currentLevel - 1
    if currentLevel<=0 then currentLevel=1 end
    print("down Level")
end

function upLevels()
    currentLevel = currentLevel + 1
    if currentLevel>#level then currentLevel=#level end

    print("up level")
end

function saveTiles()
    pName = "tiles.bin"
    local file = io.open(pName,"wb")

    file:write(string.char(#grids)) -- le fichier commence par le nombre de tiles
    file:write(string.char(4*4)) -- taille des tiles

    for l=1 , #grids do
        for line=1,4 do
            for c=1,4 do
                local value = string.char(grids[l][line][c]) 
                file:write(value)
            end
        end
    end
    
   file:close() 
end
function loadTiles()
   local file = assert(io.open("tiles.bin","rb"))
   local block = 1 --blocks of 1 byte
   local nbTiles =  string.byte(file:read(block))
   local sizeTiles = string.byte(file:read(block))
   
   grids = {}
   
   for l=1,nbTiles do
       grids[l]={}
       for line = 1,4 do
            grids[l][line]={}

           for c=1,4 do
            local value = string.byte(file:read(block))
            grids[l][line][c] = value
           end
        end
    end
   
   file:close()
end
function saveLevels()
    pName = "level.bin"
   local file = io.open(pName,"wb")

      file:write(string.char(#level)) -- le fichier commence par le nombre de level
      file:write(string.char(#level[1])) -- puis par la taille d'un level
     for l=1,#level do     
          local pos = getPositionSprite(1,l)
          -- perso
      
          file:write(string.char(pos[1])) 
          file:write(string.char(pos[2])) 
      
      -- door
          pos = getPositionSprite(2,l)
      
          file:write(string.char(pos[1])) 
          file:write(string.char(pos[2])) 
      
          for c=1,#level[l] do
               local value = string.char(level[l][c]) 
               file:write(value)
          end
          for c=1,#mapSprite[l] do
               local value = string.char(mapSprite[l][c]) 
               file:write(value)
          end
     end
   file:close() 
end
function updateGrid()
     statusGrid = not statusGrid
end

function loadLevels()

   local file = assert(io.open("level.bin","rb"))
   local block = 1 --blocks of 1 byte
   local nbLevel =  string.byte(file:read(block))
   local sizeLevel = string.byte(file:read(block))
   mapSprite={}
   level = {}
   
     for l=1,nbLevel do
   
          --perso
          local x = string.byte(file:read(block))
          local y = string.byte(file:read(block))
        
        --  mapSprite[l][(y-1)*rowsLevel + x] = 1
        -- door
          x = string.byte(file:read(block))
          y = string.byte(file:read(block))
          --mapSprite[l][(y-1)*rowsLevel + x] = 2
   
   
   
          level[l]={}
          for n=1,sizeLevel do
               local value = string.byte(file:read(block))
               level[l][n] = value
          end
          
          mapSprite[l]={}
          for n=1,sizeLevel do
               local value = string.byte(file:read(block))
               mapSprite[l][n] = value
          end
    
    end
   
   file:close()
end
function newButton(pX,pY,pW,pH,name,calback,img,index,color)
     local button = {}
     button.index = index
     button.x = pX
     button.y = pY
     button.w = pW
     button.h = pH
     button.img = img 
     button.name = name 
     button.calback = calback
     button.isHover = false
     button.backGroundColor = {1,0,1,1}
     button.colorIsHover = {1,0,1,0.6}
     button.colorIsNotHover = {1,1,1,1}
     if color ~= nil then 
          button.color = color
     else 
          button.color = nil --{1,1,1,1}
     end
     function button:update(pX,pY)
          if  (pX>self.x 
               and pX<(self.x+self.w)
               and pY>self.y 
               and pY<(self.y+self.h)) or self.isHover then
               self.backGroundColor = self.colorIsHover
          else
               self.backGroundColor = self.colorIsNotHover
               
          end
     end
     
     function button:action(pX,pY)
          if self.calback == nil then return end
          if  pX>self.x 
               and pX<(self.x+self.w)
               and pY>self.y 
               and pY<(self.y+self.h) then
            
               self.calback(self)
          end
            
     end
    
     function button:draw()
          love.graphics.setColor(self.backGroundColor)
          love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
          love.graphics.setColor(0,0,1,1)
            
          if self.img == nil then
               if self.color~= nil then 
                    love.graphics.setColor(self.color)
                    love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
               end
               love.graphics.setColor(0,0,1,1)
               love.graphics.rectangle("line",self.x,self.y,self.w,self.h)
               love.graphics.printf(self.name,self.x,self.y+self.h/3,self.w,"center")
               love.graphics.setColor(1,1,1,1)
          else
               love.graphics.setColor(1,1,1,1)

               local w = self.img:getWidth()
               local h = self.img:getHeight()
               local zoom = 0.8
               love.graphics.draw(self.img,self.x+self.w/2,self.y+self.h/2,0,sizeSprite*zoom,sizeSprite*zoom,w/2,h/2)
          end
          
     end
     table.insert(buttons,button)

     return button
    
end


function love.update()
    windowCurrentLevel.name = tostring(currentLevel).."/"..tostring(#level)
     for k, button in pairs(buttons) do
        local x,y = love.mouse.getPosition()
        button:update(x,y)
    end
end

function drawTiles()
  
    
    -- Draw tile
    
    local index = 1
    for l=1,math.floor(#grids/(maxColonne))+1 do
        for c=1,maxColonne do
            local sizeTile = size*8*4+2
            local x =sizeTile*(c-1)
            local y = offsetDrawTile + (l-1)*size*10*4+ (l-1)*2
            if index<=#grids then 
            drawGrid(grids[index],x,y)
        end
        
        -- Draw case
        
        local w=  size*8*4
        local h = size*10*4
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle("line",x,y,w,h)
        love.graphics.setColor(1,1,1,1)
        
        love.graphics.setColor(0,0,0,1)
        love.graphics.print(index,x+size*8*4/3,y+size*10*4/3)
        love.graphics.setColor(1,1,1,1)
        
        index = index + 1
        end
        
    end
   
   
   
   
end

function drawGrid(grid,x,y,v)
    if grids[1]== nil then return end
   -- local size = 3
    for l=1,4 do
        for c=1,4 do
            local v = grid[l][c]
            if v>0 then
                love.graphics.draw(img,quad[v],x+(c-1)*8*size,y+(l-1)*10*size,0,size,size)
            end
        end
    end
    if v~= nil then
     if statusGrid then 

        love.graphics.setColor(1,0,0,1)
        love.graphics.print(v,x+20,y+20)
        love.graphics.setColor(1,1,1,1)
     end
    end
end
function drawLevelEdit()
   
     for l=1,lineLevel do
        for c=1,rowsLevel do
            local n = (l-1)*rowsLevel+c
            local v = mapSprite[currentLevel][n]
            if v>0 then
             love.graphics.draw(imgSprites[v],8*3*size*(c-1)+8*size,10*3*size*(l-1)+10*size,0,size,size)
            end
        end
    end
    
    for l=1,lineLevel do
        for c=1,rowsLevel do
            local n = (l-1)*rowsLevel+c
            local v = level[currentLevel][n]
            if v>0 then
                --love.graphics.draw(img,quad[v],c*8*size,l*10*size,0,size,size)
                drawGrid(grids[v],8*3*size*(c-1),10*3*size*(l-1),v)
            end
        end
    end
    for l=1,lineLevel do
        for c=1,rowsLevel do
               if statusGrid then 
                love.graphics.setColor(1,0,0,1)
                love.graphics.rectangle("line",8*3*size*(c-1),10*3*size*(l-1),size*8*3,size*10*3)
                love.graphics.setColor(1,1,1,1)
               end
        end
    end
end

function love.draw()
     drawLevelEdit()
     local x = 600
     local y = 150
     drawGrid(grids[indexKey],x,y)
     love.graphics.setColor(0,0,0,1)
     love.graphics.print(indexKey,x+size*8*4/3,y+size*10*4/3)
     love.graphics.print(tostring(indexSprite),500,400)
     love.graphics.setColor(1,1,1,1)

   
   --love.graphics.draw(img)
  --  local size = 3
--    for i=1,#quad do
--        love.graphics.draw(img,quad[i],100,size*12*i,0,size,size)
--    end
     drawTiles()
     love.graphics.setColor(1,0,0,0.5)
     local x1 = (size*8*4+2)*(maxColonne)
     local y1 = size*10*4*math.floor(1+#grids/maxColonne)+math.floor(#grids/maxColonne)*2
 --  love.graphics.rectangle("fill",0,350,x1,y1)
     love.graphics.setColor(1,1,1,1)
   
     for k, button in pairs(buttons) do
          button:draw()
     end
end

function love.mousepressed( x, y, button)
    for k, s in pairs(buttons) do
        s:action(x,y,button)
    end
-- Zone selection Tiles
    local x1 = (size*8*4+2)*(maxColonne)
    local y1 = size*10*4*math.floor(1+#grids/maxColonne)+math.floor(#grids/maxColonne)*2
    --print(x,y,x1,y1)
    if x>0 and y>offsetDrawTile and x<x1 and y<(y1+offsetDrawTile) then
        local w=  size*8*4+2
        local h = size*10*4
        local c = math.floor(x/w)
        local l = math.floor((y-offsetDrawTile)/(h+2))
        local n = l*(maxColonne)+c+1
        if n<=#grids then
            print(n)
            indexKey = n
        end
    end


--       love.graphics.rectangle("line",8*3*size*(c-1),10*3*size*(l-1),size*8*3,size*10*3)
    if x>0 and y>0 and x<(size*8*3*rowsLevel) and y<(size*10*3*lineLevel)then
        local c = math.floor(x/(size*8*3))+1
        local l = math.floor(y/(size*10*3))+1
        if indexSprite>=1 and indexSprite<=2  or indexSprite==13  then 
          -- sprite unique
          for i=1,#mapSprite[currentLevel] do
               local v= mapSprite[currentLevel][i]
               if v==indexSprite then 
                    mapSprite[currentLevel][i]=0
               end
               
          end
          mapSprite[currentLevel][(l-1)*rowsLevel+c] = indexSprite
        
        elseif  indexSprite>=3 and indexSprite~=13 then
              
               if button == 1 then 
                    mapSprite[currentLevel][(l-1)*rowsLevel+c] = indexSprite
               elseif button ==2 then 
                    mapSprite[currentLevel][(l-1)*rowsLevel+c] = 0
             end
              
   
        else
               if button == 1 then 
                 level[currentLevel][(l-1)*rowsLevel+c] = indexKey
             elseif button ==2 then 
                 level[currentLevel][(l-1)*rowsLevel+c] = 0
             end
          end
    end
    
    
    
end

function love.keypressed(key)
        if key=="return" then 
            print("Level")
            local text ="byte "
            for i=1,#level do 
                local v=level[i]
                if i%10==0 then
                text = text..tostring(v)
                    print(text)
                    text = "byte "
                else
                    text = text..tostring(v)..","
                end
                
            end
            
            
        else 
        
--        indexKey = indexKey + 1 
--        if indexKey > #grids then indexKey=1 end
--        print(indexKey)
       end
end
