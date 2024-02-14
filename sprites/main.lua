-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

name = "moveleft"
local img = love.graphics.newImage(name..".png")
local data = love.image.newImageData(name..".png")
 size = 3

function love.load()
    love.graphics.setBackgroundColor(0,0,1,1)
    
    width = 8 -- size width caracter    data:getWidth()
    height = 10 -- size height caracter   data:getHeight()
    nbLine = data:getHeight()/10
    nbRows = data:getWidth()/8
    --print(data:getHeight())
    --print(data:getWidth())
    results = {}
    for n=1,data:getHeight()/10 do
        for i=1,data:getWidth()/8 do
      --      print(n,i)
            local grid = getCaracter(n-1,i-1)
            local result = encodeByte(grid)
            table.insert(results,result)
        end
    end

    print("nombre de caractere : "..tostring(#results))
    print("nb ligne : "..tostring(nbLine))
    print("nb colonne : "..tostring(nbRows))
    -- one caracter

    --grid = getCaracter()
    --result = encodeByte(grid)
    local dataSprite = {}
    for n=1,#results do
        dataSprite[n] = convertToByte(results[n])
    end
    interlaceData(dataSprite)
    writeFile(name..".bin",dataSprite)
  --  love.event.quit()
end
function interlaceData(pData)
    print"interlace"
    local result = {}
    for n=1,#pData do
        for l=1 ,#pData[n] do
            local v=pData[n][l]
        end
    end
    
    return result
end

function encodeByte(pTable)
-- encode
    local result = {}
    for l=1,height do
        result[l] = {}
        for c=1,width do 
            local v = pTable[l][width-c+1]
            table.insert(result[l],v)
        end
    end
    return result
end


function getCaracter(pL,pC)
    local grid = {}
    for l=0,height-1 do
        grid[l+1] = {}
        for c=0,width-1 do 
            local r,g,b,a= data:getPixel(c+pC*8,l+pL*10)
            local pixel = 0
            if (r+g+b)> 1 then
                pixel = 1
            else
                pixel = 0
            end
            table.insert(grid[l+1],pixel)
            --print(s)
        end
    end
    return grid
end

function love.draw()
    x=200
    y=100
   
    love.graphics.draw(img)
    
    local index = 1   
    local x,y = 100,100
    for n=1,data:getHeight()/10 do
        for i=1,data:getWidth()/8 do
            drawCaracter(results[index],x+i*8*size,y+n*10*size)
            index = index + 1
        end
    end

    
--    drawCaracter(result)



end
function drawCaracter(pTable,x,y)
  for l=1,height do
        for c=1,width do 
          --  local pixel=grid[l][c]
            local pixel=pTable[l][width-c+1]
            if pixel==1 then
                love.graphics.setColor(1,1,1,1)
                love.graphics.rectangle("fill",x+(c)*size,y+l*size,size,size)
            else
                love.graphics.setColor(0,0,0,1)
                love.graphics.rectangle("fill",x+(c)*size,y+l*size,size,size)
           end
            
        end
    end
end


function convertToByte(pTable)
    resultText = ""
    local r={}
    for l=1,#pTable do
        local v=0
        for c=1,#pTable[l] do 
            local n=math.pow(2,(8-c))*pTable[l][c]
            v=v+n
        
        end
        resultText = resultText..(string.format("%x", v))..","  --%X pour hexa  %B
        table.insert(r,v)
    end
    print(resultText)
    return r
end
function writeFile(pName,pData)
   local file = io.open(pName,"wb")
    file:write(string.char(nbLine))
    file:write(string.char(nbRows))

    for n=1,#pData do
        for l=1 ,#pData[n] do
            local v=pData[n][l]
            file:write(string.char(v))
        end
    end
   file:close() 
end