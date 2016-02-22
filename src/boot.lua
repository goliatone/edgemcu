-- Create a global variable holding our app
app = dofile("app.lua")
if app.before_setup then
    app.before_setup()
end

-- Create a global variable holding config
config = dofile("config.lua")

dofile("setup.lua").run(function()
    print("Setup complete")
    app.start()
end)
