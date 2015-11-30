-- Create a global variable holding our app
app = dofile("app.lua")


config = dofile("config.lua")

dofile("setup.lua").run()
