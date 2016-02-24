local App = {}

print("Application module required")

local function doif(filename)
    local exists = file.open(filename)
    file.close(filename)
    if exists then dofile(filename) end
end

function App.start()
    print("App: start")
    doif("app_start.lua")
end

function App.before_setup()
    print("App: before setup")
    doif("app_before_setup.lua")
end



return App
