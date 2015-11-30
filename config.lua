local Config = {}

-- Default values
Config.SSID = {}
Config.SSID["SSID1"] = "password1"
Config.SSID["SSID2"] = "password2"

Config.HOST = "192.168.1.4"
Config.PORT = 8080


c = file.list()
if c["config.lc"] then
    -- TODO: Table merge: http://goo.gl/O5b84h
    Config = dofile("config.lc")
end




return Config
