gl.setup(1600, 900)
marginX = 30
marginY = 20

-- File import
local imager = require "imager"
-- FONTS
local arial = resource.load_font("Arial.ttf")
local black = resource.load_font("Arial_Black.ttf")
local impact = resource.load_font("Impact.ttf")
local typer = resource.load_font("silkscreen.ttf")

-- FILES
-- local file = resource.load_file(filename)
-- local background = resource.load_image("flag.jpg")
local grid_lines = resource.load_image("grid-lines.png")
local safety = resource.load_image("safety.png")
local bingo = resource.load_image("bingo2.png")
local ball = resource.load_image("ball.png")
local b_pink = resource.load_image("ball_pink.png")
local b_green = resource.load_image("ball_green.png")
local b_dot = resource.load_image("dot.png")
local grad_green = resource.load_image("grad_green.png")
local shadow = resource.create_colored_texture(0.0,0.0,0.0,1.0)
local white = resource.create_colored_texture(1.0,1.0,1.0,1.0)
local blue = resource.create_colored_texture(0.0,0.1,0.4,1.0)
local vid = resource.load_video{
  file = "space_fit.mp4";
  looped = true;}
--local num = resource.load_image("numbers.png")

local color = {
  ["r"] = 0,
  ["g"] = 0,
  ["b"] = 0,
  ["speed"] = 0.3, --Speed Multiplier
} --rolling color

-- scoreboard vars
header = {"B", "I", "N", "G", "O"}
tbl = {}
tbl.width = (.35 * WIDTH)
tbl.height = HEIGHT -(2 * marginY)
tbl.eachX = (tbl.width / 5)
tbl.eachY = (tbl.height / 16)
tbl.slimMargin = 10
i = 1
while(i<=75)
do
  --Columns
  for col=0, 4, 1
  do
    col_xpos = tbl.slimMargin + (col * tbl.eachX)
    tbl[header[col+1]] = {
      ["id"] = header[col+1],
      ["xpos"] = col_xpos,
      ["ypos"] = marginY,
      ["xspacing"] = (tbl.eachX - black:width(header[col+1], tbl.eachY) ) / 2,
      ["alpha"] = 0.06,
    }
    --Rows
    for row=1, 15, 1
    do
      row_ypos = marginY + (row * tbl.eachY)
      tbl[i] = {
        ["id"] = i,
        ["xpos"] = col_xpos,
        ["ypos"] = row_ypos,
        --["xwide"] = nil,
        --["yhigh"] = nil,
        ["xspacing"] = (tbl.eachX - black:width(i, tbl.eachY)) / 2,
        ["alpha"] = 0.06,
        -- TODO BUG called bingo numbers will not be fully dehightlighted until
        -- the visual is restarted, lacking a way to reset table to defaults
        -- black:write(tbl[i]["xpos"+tbl[i]["spacing"],
        --    tbl[i]["ypos"], i, tbl.eachY, 1,1,1,tbl[i][alpha])
      }
      i = i + 1
    end
  end
end

function draw_table()
  for i, v in ipairs(picked) do
    tbl[v]["alpha"] = 1.0
    black:write(tbl[v]["xpos"]+tbl[v]["xspacing"]+5, tbl[v]["ypos"]+2, v,
        tbl.eachY, color.r, color.g, color.b, .75)
    --outline(black, 1.5, tbl[v]["xpos"]+tbl[v]["xspacing"], tbl[v]["ypos"],
    --       v, tbl.eachY,.1,.1,1,.5)
  end
  for i=1, 5, 1  do
    outline(black,3, tbl[header[i]]["xpos"]+tbl[header[i]]["xspacing"],
     tbl[header[i]]["ypos"], tbl[header[i]]["id"], tbl.eachY,
     color.r, color.g, color.b,.75)
    black:write(tbl[header[i]]["xpos"]+tbl[header[i]]["xspacing"],
        tbl[header[i]]["ypos"], tbl[header[i]]["id"], tbl.eachY, 1,1,1, 1.0)
  end
  for i=1, 75, 1  do
    black:write(tbl[i]["xpos"]+tbl[i]["xspacing"], tbl[i]["ypos"], i,
        tbl.eachY, 1,1,1, tbl[i]["alpha"] )
    --black:write(0, 20, tbl[i]["alpha"], 20, 1,1,1,1)
  end
end

-- ball vars
areadict = {
  ['sized'] = 650 * .70, --IMG_Size * Scale
  ['scale'] = .75,
  ['x'] = 570,
  ['y'] = 305,
}
areadict['x_'] = (areadict.sized) + areadict.x
areadict['y_'] = (areadict.sized) + areadict.y
areadict['centerX'] = (areadict.sized / 2) + areadict.x
areadict['centerY'] = (areadict.sized / 2) + areadict.y
areadict['headerY_'] = areadict.y + 56
--ball split into two
green = {
  ['sized'] = 650 * .50,
  ['scale'] = .50,
  ['x'] = areadict.x,
  ['y'] = areadict.centerY - 55,
}
green['x_'] = (green.sized) + green.x
green['y_'] = (green.sized) + green.y
green['centerX'] = (green.sized / 2) + green.x
green['centerY'] = (green.sized / 2) + green.y
card = { --recycled from second ball that was pink
  --['sized'] = areadict.x_ - green.x_,
  --[scale'] = .50,
  ['x'] = green.x+15,
  ['y'] = green.y_-45,
}
card['x_'] = green.x_-15
card['y_'] = HEIGHT-105
card['sizedX'] = card.x_ - card.x
card['sizedY'] = card.y_ - card.y
card['centerX'] = (card.x_ - card.x) /2
card['centerY'] = (card.y_ - card.y) /2

--TODO What is purpore of this function?
function trim(s)
    return s:match "^%s*(.-)%s*$"
end

--function checkFiles()
--watch bestStreak.data file
-- util.file_watch("bestStreak.data", function(content)
--       streak = trim(content)
--   end)
-- --watch lastInjury.data file and calc timeSince
-- util.file_watch("lastInjury.data", function(content)
--       injuryFile = trim(content)
--       position = string.find(injuryFile, "\n")
--       injurySec = injuryFile:sub(1, position - 1)
--   end)
--end

-- LOAD JSON DATA
util.json_watch("config.json", function(settings)
    --cfg = settings
    streak = settings["best_streak"]
    injurySec = settings["last_injury"]["unix_time"]
  end)

--watch bingo.json
util.json_watch("bingo.json", function(settings)
      --bingo_json = settings
      picked = settings["pickedList"]
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

function outline(font, offset, xpos, ypos, text, font_size,
      red, grn, blu, alpha)
    --draws in all four corners of outline
    font:write(xpos - offset, ypos - offset, text, font_size,
        red, grn, blu, alpha)
    font:write(xpos + offset, ypos - offset, text, font_size,
        red, grn, blu, alpha)
    font:write(xpos - offset, ypos + offset, text, font_size,
        red, grn, blu, alpha)
    font:write(xpos + offset, ypos + offset, text, font_size,
        red, grn, blu, alpha)
end

function textVertical(text, x_pos, y_pos, font, text_height, correction,
      rdV, grV, blV, alphaV)
    count = text:len()
    text_scaled = (text_height / count) / correction
    spacing = (text_height / count  * correction)
    max_width = font:width("W", text_scaled)
    for i=0, count-1, 1
    do
      letter = text:sub(i+1, i+1)
      hspace = align_center_cell(font, letter, text_scaled, max_width)
      font:write(x_pos+hspace, y_pos+(spacing * i )/correction, letter, text_scaled, rdV,grV,blV,alphaV)
    end
end

function gradient(xpos, ypos, x_pos, y_pos, r1,g1,b1,a1, r2,g2,b2,a2 )
    --resource.create_colored_texture(1.0,0.0,0.0,1.0):draw(0,0,100,100,0.95)
    function mix(color1, color2, ratio)
        -- Mix two color parts
        return ( (color1*(1-ratio)) + (color2*ratio) )
    end
    lines = y_pos - ypos
    frac = 1.0 / lines
    for i=0,lines, 1 do
        resource.create_colored_texture(
          mix(r1,r2,i*frac),
          mix(g1,g2,i*frac),
          mix(b1,b2,i*frac),
          mix(a1,a2,i*frac) ):draw(xpos, ypos+i, x_pos, ypos+i+1, 1.0)
    end
end

function scorecard(xpos, ypos, x_pos, y_pos)
    --
    header = {'B', 'I', 'N', 'G', 'O'}
    spaces1 = {1,2,3,4,5}
    spaces2 = {6,7,8,9,10}
    spaces3 = {11,12,13,14,15}
    spaces4 = {16,17,18,19,20}
    spaces5 = {21,22,23,24,25}

    areaX = x_pos - xpos
    areaY = y_pos - ypos
    eachX = areaX / 5
    eachY = areaY / 6
    slimMarginX = 2
    -- back color
    white:draw(xpos, ypos+eachY, x_pos+1, y_pos+1, 0.6)
    -- vertical lines
    shadow:draw(xpos+eachX*1, ypos+eachY, xpos+1+eachX*1, y_pos+1, 0.6)
    shadow:draw(xpos+eachX*2, ypos+eachY, xpos+1+eachX*2, y_pos+1, 0.6)
    shadow:draw(xpos+eachX*3, ypos+eachY, xpos+1+eachX*3, y_pos+1, 0.6)
    shadow:draw(xpos+eachX*4, ypos+eachY, xpos+1+eachX*4, y_pos+1, 0.6)
    --white:draw(xpos+eachX*5, ypos, xpos+1+eachX*5, y_pos+eachY+1, 0.6)
    -- horizontal lines
    shadow:draw(xpos, ypos+eachY, x_pos, ypos+1+eachY, 0.6)
    shadow:draw(xpos, ypos+eachY*2, x_pos, ypos+1+eachY*2, 0.6)
    shadow:draw(xpos, ypos+eachY*3, x_pos, ypos+1+eachY*3, 0.6)
    shadow:draw(xpos, ypos+eachY*4, x_pos, ypos+1+eachY*4, 0.6)
    shadow:draw(xpos, ypos+eachY*5, x_pos, ypos+1+eachY*5, 0.6)
    function row(start_x, start_y, each_x, each_y, array)
        --len = table.getn(array)
        for i,v in ipairs(array) do
            row_cell(start_x, start_y, each_x, each_y, v)
            start_x = start_x + each_x
        end
    end

    function row_cell(c_xpos, c_ypos, c_xwide, c_yhigh, num)
        --take in a letter or number and decorate
        --needs center align, colors, dim,
        --font:write(XPOS, YPOS, "TEXT", SCALE, R,G,B,Alpha)
        --called = readJson("pickedList")
        patt = {1,2,3,4,5,10,11,12,13,14,15,18,24}
        patta = {1,2,3,4,5}
        patts = {patt, patta}
        header = {'B', 'I', 'N', 'G', 'O'}

        if membership(header, num) then
          spacing = align_center_cell(black, num, c_yhigh, c_xwide)
          outline(black, 2, c_xpos+spacing, c_ypos, num, c_yhigh,
              1.0, 1.0, 1.0, 0.8)
          black:write(c_xpos+spacing, c_ypos, num, c_yhigh, 0.0,0.0,0.4,1.0)
        elseif membership(patt, num) then
          num = "+"
          spacing = align_center_cell(black, num, c_yhigh, c_xwide)
          black:write(c_xpos+spacing, c_ypos, num, c_yhigh+5, 0.0,0.0,0.0,.9)
          -- b_green:draw(green.x, green.y, green.x_, green.y_, 1.00)
          dot = {
            ['sized'] = 49 * .60,
            ['x'] = c_xpos,
            ['y'] = c_ypos,
          }
          dot['x_'] = dot.x + dot.sized
          dot['y_'] = dot.y + dot.sized
          dot['xpad'] = (c_xwide - dot.sized) / 2
          dot['ypad'] = (c_yhigh - dot.sized) / 2
          b_dot:draw(dot.x+dot.xpad, dot.y+dot.ypad,
              dot.x_+dot.xpad, dot.y_+dot.ypad, 1.00)
        end
    end
    row(xpos, ypos, eachX, eachY, header)
    row(xpos, ypos+(1*eachY), eachX, eachY, spaces1)
    row(xpos, ypos+(2*eachY), eachX, eachY, spaces2)
    row(xpos, ypos+(3*eachY), eachX, eachY, spaces3)
    row(xpos, ypos+(4*eachY), eachX, eachY, spaces4)
    row(xpos, ypos+(5*eachY), eachX, eachY, spaces5)

    -- grid_col(xpos, ypos, eachX, eachY, b_)
    -- grid_col(xpos+1*(eachX), ypos, eachX, eachY, i_)
    -- grid_col(xpos+2*(eachX), ypos, eachX, eachY, n_)
    -- grid_col(xpos+3*(eachX), ypos, eachX, eachY, g_)
    -- grid_col(xpos+4*(eachX), ypos, eachX, eachY, o_)
end

function all_grid() --DEPRECATED
    --position each element in a grid
    grid_areaX = (.35 * WIDTH)
    grid_areaY = HEIGHT - (2 * marginY)
    --return "Width, Height", areaX, areaY
    eachX = (grid_areaX / 5)
    eachY = (grid_areaY / 16)
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
    white:draw(marginX, marginY-2, areaX-8, marginY+eachY-3, 0.04)
    --shadow:draw(green.centerX, green.y+3, WIDTH-marginX, card.y_-2, .60)
    slimMarginX = 10
    grid_col(slimMarginX, marginY, eachX, eachY, b_)
    grid_col(slimMarginX+1*(eachX), marginY, eachX, eachY, i_)
    grid_col(slimMarginX+2*(eachX), marginY, eachX, eachY, n_)
    grid_col(slimMarginX+3*(eachX), marginY, eachX, eachY, g_)
    grid_col(slimMarginX+4*(eachX), marginY, eachX, eachY, o_)
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
    --called = readJson("pickedList")
    called = picked
    spacing = align_center_cell(black, num, yhigh, xwide)
    if membership(header, num) then
        outline(black,3, xpos+spacing, ypos, num, yhigh, .1,.1,1,.5)
        black:write(xpos+spacing, ypos, num, yhigh, 1,1,1,1)
    elseif membership(called, tonumber(num)) then
      outline(black,1.5, xpos+spacing, ypos, num, yhigh, .1,1,.1,.5)
      black:write(xpos+spacing, ypos, num, yhigh, 1,1,1,1)
    else
        black:write(xpos+spacing, ypos, num, yhigh, 1,1,1,.06)
    end
end

-- function testJson()
--     local json = require('json')
--     test = {
--         one='first',two='second',three={2,3,5}
--         --12, 34, 56
--     }
--     jsonTest = json.encode(test)
--     --print('JSON encoded test is: ' .. jsonTest)
--     -- Now JSON decode the json string
--     result = json.decode(jsonTest)
--     print ("The decoded table result:")
--     table.foreach(result,print)
--     print ("The decoded table result.three")
--     table.foreach(result.three, print)
-- end
--
-- function readJson(key)
--     local json = require('json')
--     --code = json.encode{1, 23, 34}
--     --local value = json.decode(code)
--     file = json.decode(resource.load_file("bingo.json"))
--     return file[key]
-- end

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

function formatBingo(number)
    if number == nil then
        return "N/A"
    elseif (1 <= number and number <= 15) then
        return "B-" .. tostring(number)
    elseif (16 <= number and number <= 30) then
        return "I-" .. tostring(number)
    elseif (31 <= number and number <= 45) then
        return "N-" .. tostring(number)
    elseif (46 <= number and number <= 60) then
        return "G-" .. tostring(number)
    elseif (61 <= number and number <= 75) then
        return "O-" .. tostring(number)
    else
        return "N/A"
    end
end

function last_number()
    --returns last item in list
    list = picked
    formated = formatBingo(list[#list])
    return formated
end

function node.render()
    -- color roll
    color.r = math.sin(sys.now()*color.speed +0)
    color.g = math.sin(sys.now()*color.speed +2 *math.pi/3)
    color.b = math.sin(sys.now()*color.speed +4 *math.pi/3)
    --checkFiles()
    --gl.clear(.2, .37, 0, 1) -- set background sage green
    vid:draw(0, 0, WIDTH, HEIGHT, 0.95)
    --draw ball
    shadow:draw(green.centerX, areadict.y, WIDTH-marginX+5, card.y_-2, .50)
    --white:draw(green.centerX, green.y_-4, WIDTH-marginX, green.y_-2, .10)
    --title shadow
    grad_green:draw(green.centerX, areadict.y, WIDTH-marginX+5,
        areadict.headerY_, 1.00)
    --gradient(green.centerX, green.y+2, WIDTH-marginX, green.y+50,
    --    0.2,1.0,0.0,1.0, 0.1,0.4,0.0,0.5 )
    --line separator
    --white:draw(green.centerX, card.y+4, WIDTH-marginX, card.y+2, .80)
    --ball:draw(areadict.x, areadict.y, areadict.x_, areadict.y_, 1.00)
    --b_pink:draw(card.x, card.y, card.x_, card.y_, 1.00)
    b_green:draw(green.x, green.y, green.x_, green.y_, 1.00)
    --draw last called number
    ali_last = align_center_cell(black, "Last", 70, green.sized)
    --black:write(areadict.x+ ali_last, areadict.y + 85, "Last", 90,
    --    .05, .05, .05, .5)
    black:write(green.x+ ali_last, green.y+35, "Last", 70, .15, .15, .15, .86)
    ali_number = align_center_cell(black, "Number", 70, green.sized)
    black:write(green.x+ ali_number, green.y + 100, "Number", 70,
        .15, .15, .15, .86)

    ali_num = align_center_cell(arial, last_number(), 120, green.sized)
    outline(arial, 2, green.x + ali_num - 2, green.centerY + 00, last_number(),
        120, 0, .7, 0, 0.6)
    arial:write(green.x + ali_num - 2, green.centerY + 00, last_number(),
        120, .8,.85,.8,1)

    --winning
--    blue:draw(card.x+0, card.y, card.x_-0, card.y_, 1.0)
--    textVertical("WINNING",card.x+3, card.y+33, black, card.sizedY-33,
--        .90, 1.0, 1.0, 1.0, 0.7)
--    textVertical("PATTERN",card.x_-32, card.y+33, black, card.sizedY-33,
--        .90, 1.0, 1.0, 1.0, 0.7)
    --pattern block
    -- TODO add code to pull numbers from config
    --scorecard(card.x+39, card.y+3, card.x_-34, card.y_+0)
    --guide grid lines
    --grid_lines:draw(0, 0, WIDTH, HEIGHT, .5)

    timeNow = math.floor(os.time())
    secondsSince = timeNow - injurySec
    daysSince = math.floor((timeNow - injurySec) / 86400 )
    hoursSince = math.floor(((timeNow - injurySec) % 86400) / 3600)
    streakDays = math.floor( streak / 86400 )

    --Add percentage width fixed from right side to size
    safeX, safeY = safety:size()
    --image:draw(xpos, ypos, xpos_end, ypos_end, alphaV)
    safety:draw(600, marginY-21, 600+(.94*safeX), 20+(.80*safeY), 1)
    bingX, bingY = bingo:size()
    bingo:draw(590, 140, 590+(1.03*bingX), 140+(.75*bingY), 1)
    --num:draw(40, 40, (40+489), (40+712), .3)
    --all_grid()
    draw_table()
    -- type:write(0, 0, injuryFile.." "..timeSince, 20, 1, 1, 1, 1)
    -- font:write(XPOS, YPOS, "TEXT", SCALE, R,G,B,Alpha)
    --black:write(24, 54, "SAFETY STARTS WITH YOU!", 100, 0,0,0,.4)
    --black:write(20, 50, "SAFETY STARTS WITH YOU!", 100, 1,1,1,1)
    --linex = align_center(arial, "This Property has enjoyed", 80)
    --gradient(xpos, ypos, x_pos, y_pos, r1,g1,b1,a1, r2,g2,b2,a2 )
    location = "The Atlanta Marriott Evergreen Family"
    arial:write(green.centerX +18, areadict.y+4, location, 48, 0.9,1.0,0.9,1)
    since_text1 = "Together we have enjoyed:"
    since_text2 = "without a lost time accident."
    arial:write(green.centerX+10, areadict.headerY_+20, since_text1, 44,
        .70,.70,.70,1)
    --black:write(32, 252, daysSince.." Days, "..hoursSince.." Hours", 150,
    --    1,0,0,1)
    --black:write(30, 250, daysSince.." Days, "..hoursSince.." Hours", 150,
    --      .3,0,0,1)
    --arial:write(600, 400, "without a lost time accident.", 80, .7,.75,.7,1)
    --arial:write(green.x_+0, areadict.y+70,
    --    "Time since last lost time accident:", 40,.7,.7,.7,1)
    --arial:write(750, 500, "Coming Soon...",120, .7,.75,.7,1)
    running = daysSince.." Days, "..hoursSince.." Hours"
    pushR = align_right(black, running, 70)
    --outline(black, 2, xpos, ypos, text, font_size, red, grn, blu, alpha)
    black:write(pushR-2, areadict.headerY_+74+4, running, 70, 0.9,0.10,0.10,.75)
    black:write(pushR-4, areadict.headerY_+74, running, 70, 0.85,0.85,0.85,1)
    -- since line 2
    ali_since = align_right(arial, since_text2, 44)
    arial:write(ali_since, areadict.headerY_+94 + 66, since_text2, 44,
        .70,.70,.70,1)

    bestLine = "Our best previous record was:"
    arial:write(green.x_+10, areadict.centerY+95, bestLine, 48, .7,.7,.7,1)
    --black:write(618, 598, "123 DAYS", 180, 1,0,0,1)
    xx = align_right(black, streakDays.." Days", 80)
    --black:write(xx+4, 604, streakDays.." days", 180, 1,0,0,1)
    black:write(xx-1, areadict.centerY+162, streakDays.." Days", 80,
        .9,.10,.10,0.75)
    black:write(xx-5, areadict.centerY+160, streakDays.." Days", 80,
        .85,.85,.85,1.0)

    --Prizes section
    -- TODO add function to rotate prizes from list given by config
    --arial:write(card.x_ +20, green.y_, "Prizes:", 40, .7,.7,.7,1)
    --prize = "#1  ".."$350"
    --midx = align_center_cell(black, prize, 60, WIDTH-marginX - card.x_)
    --outline(black, 1.5, card.x_+ midx, green.y_ + 50, prize, 60,
    --    0.619,0.518,0.141,1)
    --black:write(card.x_+ midx, green.y_ + 50, prize, 60, 1,1,1,1)


    --impact:write(320, 650, "0 "..readJson("date"), 48, 1,1,1,1)
    --impact:write(320, 700, "1 "..readJson("date_int"), 48, 1,1,1,1)
    --impact:write(320, 750, "2 "..readJson("game_count"), 48, 1,1,1,1)
    --outline(impact, 3, 585, HEIGHT-95, "PLAY IT SAFE. PLAY TO WIN!", 97,
    --    0.0, 0.0, 0.0, 1.0)
    impact:write(585+5, HEIGHT-95+3, "PLAY IT SAFE. PLAY TO WIN!", 97,
        0.0, 0.0, 0.0, 0.8)
    impact:write(585, HEIGHT-95, "PLAY IT SAFE. PLAY TO WIN!", 97,
        0.8, 0.8, 0.8, 1.0)
    --local pList = readJson("pickedList")
    --local fakeList = {2, 3, 4, 12}
    --impact:write(320, 800, "3 "..listToString(fakeList), 48, 1,1,1,1)
    --test_member = tostring(membership(fakeList, 11))
    --arial:write(320, 850, "4 "..test_member, 78, 1,1,1,1)
    --resource.render_child(""):draw(50, 200, 300, 400)
    --if(safety:state())
    --STATUS LINE
    --arial:write(0, 0, listToString(picked), 20, color.r,
    --    color.g, color.b, 0.8)
    --resource.create_colored_texture(1.0,0.0,0.0,1.0)
    --    :draw(0, 0, 100, 100, 0.95)
    --gradient(0, ypos, x_pos, y_pos, r1,g1,b1,a1, r2,g2,b2,a2 )
end
