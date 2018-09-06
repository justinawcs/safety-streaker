gl.setup(1024, 1024)

local arial = resource.load_font("Arial.ttf")

local message = "_"

util.data_mapper{
    ["msg"] = function(given)
        message = given
    end;
}

function node.render()
    arial:write(120, 120, ">> "..message, 40, .7, .7, .7, 1)
end
