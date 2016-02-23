## NodeMCU Application Framework and Project Scaffold

EdgeMCU is an application framework and project scaffold for NodeMCU projects.

### Files:
* [init.lua](#initlua)
* [boot.lua](#bootlua)
* [app.lua](#applua)
* [setup.lua](#setuplua)
* [config.lua](#configlua)

#### init.lua
This file is kept intentionally simple. It will call `boot.lua` after a delay of 2 seconds.

When a NodeMCU board starts it will look for a file named `ini.lua` and execute it. The way NodeMCU handles panic errors is to reboot the board, and then it will call the `ini.lua`. If this file causes an error early on before you can send a `file.remove('init.lua')` then you can potentially brick your board.

#### boot.lua
The boot module wires together the application by requiring the `app` and the `config` modules. It creates two global references to each module.
Then it will load the `setup` module and call it's `run` function. When the setup is complete, it will call the `App.start` function.

#### app.lua

The app module is where you should include your application's logic.

It exposes two functions, `App.start` and `App.before_setup` that in turn will call `dofile` on `app_before_setup.lua` and `app_start.lua` if they exists.

This way, your application specific code can go in this two files and will get executed by simply creating them.

#### setup.lua
The setup module's is mainly responsible to configure WiFi. It does so by listing all visible networks and then it will try to match a networks name with the value in `Config.SSID`.

We can define a function `Setup.onConnection` which would be called once the connection is active and the board has been assigned an `IP`.

#### config.lua
This module exposes a table object that you can reference through your project to access configuration values.

This is the only file of the framework which you have to edit per application- unless you want to modify default behavior of other files.

It's required by `boo.lua` and referenced by `setup.lua`. During the setup process we access the `SSID` table which holds credentials for multiple networks in the form:

```lua
Config.SSID['my_network_ssid'] = 'my_network_password'
```

If you don't modify `setup.lua` then `Config.SSID` is required.

The config module is intended to store any useful information, you can access a reference to `Config` in the global namespace.

For instance, if you are using a service to send measurements you can store the services `host` and `port` properties:

```lua
-- config.lua
Config.HOST = "192.168.1.4"
Config.PORT = 8080
```

Then you when you need to connect to your service:
```lua
conn:connect(Config.PORT, Config.HOST)
```

### Application flow:
* init.lua:
    - Waits `BOOT_DELAY` and calls `boot.lua`
* boot.lua:
    - Require `app.lua`
    - Call `App.before_setup` if defined
    - Require `config.lua`
    - Require `setup.lua` and calls `Setup.run`
        - On `Setup.run` callback we call `App.start`


### Conventions
Should we make global variables uppercase?
* app, App, or APP
* config, Config, or CONFIG

TODO:
- `setup.lua`: implement WiFi connect timeout watchdog
- `setup.lua`: Do we want to add WiFi setup HTML admin page?
