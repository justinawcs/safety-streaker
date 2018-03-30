gl.setup(1600, 900)
marginX = 30
marginY = 20

-- FONTS
local arial = resource.load_font("Arial.ttf")
local black = resource.load_font("Arial_Black.ttf")
local impact = resource.load_font("Impact.ttf")
local type = resource.load_font("silkscreen.ttf")
local shadow = resource.create_colored_texture(0,.02,0,1)

-- FILES
-- local file = resource.load_file(filename)
local background = resource.load_image("flag.jpg")
local usa = resource.load_video{
    file = "redance.mp4";
    looped = true;}

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
util.file_watch("percent.data", function(content)
      perr = trim(content)
  end)
--end

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

function banner(tall, daysSinceDecimal)
    start_bottom = HEIGHT - tall
    text_height = tall * 0.85
    text_padding = (tall * 0.15)
    start_y = start_bottom + text_padding
    split_lines = text_height / 2.3
    --shadow box
    shadow:draw(0, start_bottom, WIDTH, start_bottom+tall, .70)
    --days
    black:write(marginX+4, start_y+4, daysSince, text_height, .1, 1,.1, .70)
    black:write(marginX, start_y, daysSince, text_height,.8,.8,.8, 1)
    nextX = black:width(daysSince, text_height) + 20+ marginX
    daysVertical(nextX+3, start_bottom+3, black, tall, 0.85, .1, 1, .1, .70)
    daysVertical(nextX, start_bottom, black, tall, 0.85, 1, 1, 1, 1)
    nextX = black:width("_", text_height/4) + 30 + nextX
    --hours
    black:write(nextX+4, start_y+4, hoursSince, text_height, .1, 1,.1, .70)
    black:write(nextX, start_y, hoursSince, text_height,.8,.8,.8, 1)
    nextX = black:width(hoursSince, text_height) + 15 +nextX
    hoursVertical(nextX+3, start_bottom+3, black, tall, 0.85, .1, 1, .1, .70)
    hoursVertical(nextX, start_bottom, black, tall, 0.85, 1, 1, 1, 1)
    nextX = black:width("_", text_height/5) + 35 + nextX
    --since text
    dayStr = "Since Last Accident"
    arial:write(nextX, start_y, dayStr, text_height*.6,.8,.8,.8, 1)
    xx = align_right(black, streak.." Days", text_height*.6)
    nextX = arial:width(dayStr, text_height*.6) + 30 + nextX
    --start other side: days
    nextR = WIDTH - marginX
    rr = black:width("_", text_height/4)
    daysVertical(nextR-rr+3, start_bottom+3, black, tall, 0.85, .1, 1, .1, .70)
    daysVertical(nextR-rr, start_bottom, black, tall, 0.85, 1, 1, 1, 1)
    nextR = nextR - rr - black:width(streak, text_height) - 20
    --streak days
    black:write(nextR+4, start_y+4, streak, text_height, .1, 1,.1, .70)
    black:write(nextR, start_y, streak, text_height,.8,.8,.8, 1)
    rr = black:width(streak, text_height)
    --best record text
    bestStr = "Best Record"
    nextR = nextR - arial:width(bestStr, text_height*.6) - 20
    floor_y = HEIGHT - (text_height *.6)
    arial:write(nextR, floor_y, bestStr,text_height*.6,.8,.8,.8,1 )
end

function daysVertical(x_pos, y_pos, font, text_height, correction, rdV, grV, blV, alphaV)
    --vertical stack of days letters
    text_scaled = (text_height/4) / correction
    spacing = (text_height/4 * correction)
    font:write(x_pos, y_pos+(spacing*0)/correction, "D", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*1)/correction, "A", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*2)/correction, "Y", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*3)/correction, "S", text_scaled, rdV,grV,blV,alphaV)
end

function hoursVertical(x_pos, y_pos, font, text_height, correction, rdV, grV, blV, alphaV)
    --vertical stack of hourss letters
    text_scaled = text_height / (5 * correction)
    spacing = (text_height/5) * correction
    font:write(x_pos, y_pos+(spacing*0)/correction, "H", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*1)/correction, "O", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*2)/correction, "U", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*3)/correction, "R", text_scaled, rdV,grV,blV,alphaV)
    font:write(x_pos, y_pos+(spacing*4)/correction, "S", text_scaled, rdV,grV,blV,alphaV)

end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function node.render()
    --checkFiles()
    --gl.clear(.2, .37, 0, 1) -- set background sage green
    --background:draw(0, 0, WIDTH, HEIGHT, .6)
    usa:draw(0, 0, WIDTH, HEIGHT, .6)
    timeNow = math.floor(os.time())
    secondsSince = timeNow - injurySec
    daysSince = math.floor((timeNow - injurySec) / 86400 )
    hoursSince = math.floor(((timeNow - injurySec) % 86400) / 3600)
    -- type:write(0, 0, injuryFile.." "..timeSince, 20, 1, 1, 1, 1)
    -- font:write(XPOS, YPOS, "TEXT", SCALE, R,G,B,Alpha)
    black:write(64, 54, "ForEvergreen Friday", 130, 0,1,0,.4)
    black:write(60, 50, "ForEvergreen Friday", 130, .75,1,.75,1)
    arial:write(120, 160, "at The Rock", 80, .5,1,.5,1)
    --black:write(32, 252, daysSince.." Days, "..hoursSince.." Hours", 150, 1,0,0,1)
    --black:write(30, 250, daysSince.." Days, "..hoursSince.." Hours", 150, .3,0,0,1)
    --arial:write(600, 400, "without a lost time accident.", 80, .7,.7,.7,1)
    --arial:write(25, 500, "The best previous record was:", 80, .7,.7,.7,1)
    --black:write(618, 598, "123 DAYS", 180, 1,0,0,1)
    xx = align_right(black, perr.."%", 180)
    black:write(xx+4, 404, perr.."%", 180, 0,1,0,.6)
    black:write(xx, 400, perr.."%", 180, 0,.3,0,.5)
    --black:write(xx-4, 396, perr.."%", 180, .1,.5,.1,.3)
    x_align = align_center(impact, "CONGRATULATIONS! WE DID IT!", 60)
    impact:write(x_align+4, 724, "CONGRATULATIONS! WE DID IT!", 60, 0,0,0,.8)
    impact:write(x_align, 720, "CONGRATULATIONS! WE DID IT!", 60, 1,1,1,1)
    banner(120, daysSinceDecimal)
    --resource.render_child(""):draw(50, 200, 300, 400)

end
