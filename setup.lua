local Setup = {}

local function check_wifi_ip()
    if wifi.sta.getip() then
        tmr.stop(1)
        print("WiFi ready: "..wifi.sta.getip())
        --TODO: Do we want to make this a callback?
        app.start()
    end
end


local function connect_wifi(ssid)
    wifi.sta.config(ssid, config.SSID[ssid])
    wifi.sta.connect()
    config.SSID = nil
    tmr.alarm(1, 1000, 1, check_wifi_ip)
end

--[[
Get the list of visible networks, and
check which one matches our list of available
SSIDs in config object
]]
local function scan_networks(networks)
    for k, v in pairs(networks) do
        if config.SSID and config.SSID[k] then
            connect_wifi(k)
        end
    end
end

function Setup.run()
    -- We have a config object, then run station
    if config ~= nil then Setup.run_station() end
    -- No config object, let's try to run WiFi cofiguration
    Setup.admin_panel()
end

function Setup.run_station()
    wifi.setmode(wifi.STATION)
    wifi.sta.getap(scan_networks)
end

function Setup.admin_panel()
    --Here we would use the AP MODE AND all that bubble.
    -- it should provide a server to whicn we can connect and
    --modify through a form a config file. Then we compile the
    -- file so that its picked up by Config on boot sequence.
end

return Setup
