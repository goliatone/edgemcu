local App = {}

print("Application module required")

function App.start()
    print("App: start")
    gpio.mode(0, gpio.OUTPUT)
    gpio.write(0, gpio.LOW)
end

function App.before_setup()
    print("App: before setup")
end

return App
