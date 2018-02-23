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
local grid_lines = resource.load_image("grid-lines.png")
local safety = resource.load_image("safety.png")
local bingo = resource.load_image("bingo.png")
local ball = resource.load_image("ball.png")
local num = resource.load_image("numbers.png")

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

function align_center_cell(font, str, size, cell_width)
    --aligns text on center of the cell given
    wide = font:width(str, size)
    return (cell_width - wide ) / 2
end

function outline(font,offset, xpos, ypos, text, font_size, red, grn, blu, alpha)
    --draws in all four corners of outline
    font:draw(xpos-offset, ypos-offset, text, font_size, red, grn, blu, alpha)
    font:draw(xpos+offset, ypos-offset, text, font_size, red, grn, blu, alpha)
    font:draw(xpos-offset, ypos+offset, text, font_size, red, grn, blu, alpha)
    font:draw(xpos+offset, ypos+offset, text, font_size, red, grn, blu, alpha)
end
function grid()
    --IDEA this layout should be sliced from image program
    --position each element in a grid
    areaX = (.36 * WIDTH) --40%
    areaY = HEIGHT - (2 * marginY)
    --return "Width, Height", areaX, areaY
    eachX = (areaX / 5)
    eachY = (areaY / 16)
    --print("X-space", math.floor(eachX) )
    --print("Y-space", math.floor(eachY) )

    b_ = {'B',  1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15}
    i_ = {'I', 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30}
    n_ = {'N', 31,32,33,34,35,36,37,38,39,40,41,42,43,44,45}
    g_ = {'G', 46,47,48,49,50,51,52,53,54,55,56,57,58,59,60}
    o_ = {'O', 61,62,63,64,65,66,67,68,69,70,71,72,73,74,75}
    --print(listToString(b_))
    --print(listToString(i_))
    --print(listToString(n_))
    --print(listToString(g_))
    --print(listToString(o_))
    --t = {{b_, i_, n_, g_, o_}}
    grid_col(marginX, marginY, eachX, eachY, b_)
    grid_col(marginX+1*(eachX), marginY, eachX, eachY, i_)
    grid_col(marginX+2*(eachX), marginY, eachX, eachY, n_)
    grid_col(marginX+3*(eachX), marginY, eachX, eachY, g_)
    grid_col(marginX+4*(eachX), marginY, eachX, eachY, o_)
end

function grid_col(start_x, start_y, each_x, each_y, array)
    len = table.getn(array)
    for i,v in ipairs(array) do
        grid_cell(start_x, start_y, each_x, each_y, v)
        start_y = start_y + each_y
        --print(v)
        --string_rep = string_rep.." "..v
        --grid_cell(start_x, start_y, each_x, each_y, v)
    end
end

function grid_cell(xpos, ypos, xwide, yhigh, num)
    --take in a letter or number and decorate
    --needs center align, colors, dim,
    --font:write(XPOS, YPOS, "TEXT", SCALE, R,G,B,Alpha)
    header = {'B', 'I', 'N', 'G', 'O'}
    called = readJson("pickedList")
    spacing = align_center_cell(black, num, yhigh, xwide)
    if membership(header, num) or membership(called, tonumber(num)) then
        black:write(xpos+spacing, ypos, num, yhigh, 1,1,1,1)
    else
        black:write(xpos+spacing, ypos, num, yhigh, 1,1,1,.20)
    end
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

function listToString(list)
    string_rep = ""
    for i,v in ipairs(list) do
        --print(v)
        string_rep = string_rep.." "..v
    end
    return string_rep
end

function membership(list, item)
    for i, v in ipairs(list) do
        if item == v then
            looking = false
            return true
        end
    end
    return false
end

function node.render()
    --checkFiles()
    --gl.clear(.2, .37, 0, 1) -- set background sage green
    background:draw(0, 0, WIDTH, HEIGHT, .25)
    --grid_lines:draw(0, 0, WIDTH, HEIGHT, .5)
    timeNow = math.floor(os.time())
    secondsSince = timeNow - injurySec
    daysSince = math.floor((timeNow - injurySec) / 86400 )
    hoursSince = math.floor(((timeNow - injurySec) % 86400) / 3600)

    --Add percentage width fixed from right side to size
    safeX, safeY = safety:size()
    safety:draw(720, 20, 720+(.85*safeX), 20+(.85*safeY), 1)
    bingX, bingY = bingo:size()
    bingo:draw(700, 160, 700+(.93*bingX), 160+(.80*bingY), 1)

    --num:draw(40, 40, (40+489), (40+712), .3)

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
    arial:write(750, 500, "Coming Soon...",120, .7,.75,.7,1)
    --black:write(618, 598, "123 DAYS", 180, 1,0,0,1)
    --xx = align_right(black, streak.." days.", 180)
    --black:write(xx+4, 604, streak.." days.", 180, 1,0,0,1)
    --black:write(xx, 600, streak.." days.", 180, .3,0,0,.95)

    --impact:write(320, 650, "0 "..readJson("date"), 48, 1,1,1,1)
    --impact:write(320, 700, "1 "..readJson("date_int"), 48, 1,1,1,1)
    --impact:write(320, 750, "2 "..readJson("game_count"), 48, 1,1,1,1)
    --local pList = readJson("pickedList")
    --local fakeList = {2, 3, 4, 12}
    --impact:write(320, 800, "3 "..listToString(fakeList), 48, 1,1,1,1)
    --test_member = tostring(membership(fakeList, 11))
    --impact:write(320, 850, "4 "..test_member, 48, 1,1,1,1)
    --resource.render_child(""):draw(50, 200, 300, 400)
    --if(safety:state())
    grid()
end
