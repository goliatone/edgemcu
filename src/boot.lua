-- If the device panics and resets at any time,
-- errors will be written to the serial interface at 115200 bps.
uart.setup(0, 115200, 8, 0, 1, 1)

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
