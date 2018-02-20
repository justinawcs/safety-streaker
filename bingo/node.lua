gl.setup(1600, 900)
marginX = 30
marginY = 20

-- FONTS
local arial = resource.load_font("Arial.ttf")
local black = resource.load_font("Arial_Black.ttf")
local impact = resource.load_font("Impact.ttf")
local type = resource.load_font("silkscreen.ttf")

-- FILES
-- local file = resource.load_file(filename)
local background = resource.load_image("flag.jpg")
local safety = resource.load_image("safety.png")
local bingo = resource.load_image("bingo.png")
local ball = resource.load_image("ball.png")

--TODO What is purpore of this function?
function trim(s)
    return s:match "^%s*(.-)%s*$"
end

--function checkFiles()
--watch bestStreak.data file
util.file_watch("bestStreak.data", function(content)
      streak = trim(content)
  end)
--watch lastInjury.data file and calc timeSince
util.file_watch("lastInjury.data", function(content)
      injuryFile = trim(content)
      position = string.find(injuryFile, "\n")
      injurySec = injuryFile:sub(1, position - 1)
  end)
--end
--watch bingo.json
util.file_watch("bingo.json", function(content)
      bingo_json = content
  end)


function align_right(font, str, size)
    -- aligns text on right of screen with given marginX
    wide = font:width(str, size)
    return WIDTH - marginX - wide
end

function align_center(font, str, size)
    -- aligns text on the center of screen with given marginX
    wide = font:width(str, size)
    return ( WIDTH - wide ) / 2
end

--create vertical list of numbers from start, using fonts, sizing, spacing
function column(font, startNum, size, spacing)
    topMargin = 60
    high = font:height(startNum, size)
end

function grid()
    --IDEA this layout should be sliced from image program
    --position each element in a grid
end

function bingoNumber(xpos, ypos, num)
    --take in a letter or number and decorate
    black:write()
end



function testJson()
    local json = require('json')
    test = {
        one='first',two='second',three={2,3,5}
        --12, 34, 56
    }
    jsonTest = json.encode(test)
    --print('JSON encoded test is: ' .. jsonTest)
    -- Now JSON decode the json string
    result = json.decode(jsonTest)
    print ("The decoded table result:")
    table.foreach(result,print)
    print ("The decoded table result.three")
    table.foreach(result.three, print)
end

function readJson(key)
    local json = require('json')
    code = json.encode{1, 23, 34}
    local value = json.decode(code)
    local file = json.decode(resource.load_file("bingo.json"))
    return file[key]
end

function node.render()
    --checkFiles()
    --gl.clear(.2, .37, 0, 1) -- set background sage green
    background:draw(0, 0, WIDTH, HEIGHT, .25)
    timeNow = math.floor(os.time())
    secondsSince = timeNow - injurySec
    daysSince = math.floor((timeNow - injurySec) / 86400 )
    hoursSince = math.floor(((timeNow - injurySec) % 86400) / 3600)

    safeX, safeY = safety:size()
    safety:draw(720, 20, 720+(.85*safeX), 20+(.85*safeY), 1)
    bingX, bingY = bingo:size()
    bingo:draw(700, 160, 700+(.93*bingX), 160+(.80*bingY), 1)

    -- type:write(0, 0, injuryFile.." "..timeSince, 20, 1, 1, 1, 1)
    -- font:write(XPOS, YPOS, "TEXT", SCALE, R,G,B,Alpha)
    --black:write(24, 54, "SAFETY STARTS WITH YOU!", 100, 0,0,0,.4)
    --black:write(20, 50, "SAFETY STARTS WITH YOU!", 100, 1,1,1,1)
    --linex = align_center(arial, "This Property has enjoyed", 80)
    --arial:write(linex, 160, "This Property has enjoyed", 80, .7,.75,.7,1)
    --black:write(32, 252, daysSince.." Days, "..hoursSince.." Hours", 150, 1,0,0,1)
    --black:write(30, 250, daysSince.." Days, "..hoursSince.." Hours", 150, .3,0,0,1)
    --arial:write(600, 400, "without a lost time accident.", 80, .7,.75,.7,1)
    --arial:write(25, 500, "The best previous record was", 80, .7,.75,.7,1)
    arial:write(325, 500, "Coming Soon...",120, .7,.75,.7,1)
    --black:write(618, 598, "123 DAYS", 180, 1,0,0,1)
    --xx = align_right(black, streak.." days.", 180)
    --black:write(xx+4, 604, streak.." days.", 180, 1,0,0,1)
    --black:write(xx, 600, streak.." days.", 180, .3,0,0,.95)
    impact:write(320, 650, "0 "..readJson("date"), 48, 1,1,1,1)
    impact:write(320, 700, "1 "..readJson("date_int"), 48, 1,1,1,1)
    impact:write(320, 750, "2 "..readJson("game_count"), 48, 1,1,1,1)
    local pList = readJson("pickedList")
    local fakeList = {2, 3, 4, 12}
    impact:write(320, 800, "3 "..fakeList[1], 48, 1,1,1,1)

    --resource.render_child(""):draw(50, 200, 300, 400)
    --if(safety:state())


end
