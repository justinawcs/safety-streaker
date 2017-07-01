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
local usa = resource.load_video{
    file = "usa.mp4";
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
--end

function align_right(font, str, size)
    -- aligns text on right of screen with given marginX
    wide = font:width(str, size)
    return WIDTH - marginX - wide
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
    black:write(24, 54, "SAFETY STARTS WITH YOU!", 100, 0,0,0,.4)
    black:write(20, 50, "SAFETY STARTS WITH YOU!", 100, 1,1,1,1)
    arial:write(25, 160, "The Marriott Evergreen Family has enjoyed", 80, .7,.7,.7,1)
    black:write(32, 252, daysSince.." Days, "..hoursSince.." Hours", 150, 1,0,0,1)
    black:write(30, 250, daysSince.." Days, "..hoursSince.." Hours", 150, .3,0,0,1)
    arial:write(600, 400, "without a lost time accident.", 80, .7,.7,.7,1)
    arial:write(25, 500, "The best previous record was:", 80, .7,.7,.7,1)
    --black:write(618, 598, "123 DAYS", 180, 1,0,0,1)
    xx = align_right(black, streak.." days", 180)
    black:write(xx+4, 604, streak.." Days", 180, 1,0,0,.6)
    black:write(xx, 600, streak.." Days", 180, .3,0,0,.95)
    impact:write(324, 804, "STAY SAFE. THINK SAFETY!", 100, 0,0,0,.6)
    impact:write(320, 800, "STAY SAFE. THINK SAFETY!", 100, 1,1,1,1)

    --resource.render_child(""):draw(50, 200, 300, 400)

end
