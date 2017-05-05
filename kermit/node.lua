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
    file = "flail.mp4";
    looped = true;}

function trim(s)
    return s:match "^%s*(.-)%s*$"
end

--function checkFiles()
--watch bestStreak file
util.file_watch("bestStreak", function(content)
      bestStreak = trim(content)
  end)
--watch lastInjury file and calc timeSince
util.file_watch("lastInjury", function(content)
      injuryFile = trim(content)
      position = string.find(injuryFile, "\n")
      injurySec = injuryFile:sub(1, position - 1)
  end)
util.file_watch("percent", function(content)
      perr = trim(content)
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
    black:write(xx, 400, perr.."%", 180, 0,.3,0,.95)
    impact:write(224, 804, "CONGRATULATIONS! WE DID IT!", 100, 0,0,0,.6)
    impact:write(220, 800, "CONGRATULATIONS! WE DID IT!", 100, 1,1,1,1)

    --resource.render_child(""):draw(50, 200, 300, 400)

end
