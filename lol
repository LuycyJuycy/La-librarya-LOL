local Library = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/LuycyJuycy/La-librarya-LOL/refs/heads/main/WTF"
))()

local Window = INFERNO_HUB:CreateWindow({
    Title       = "MyScript Hub",
    Description = "v1.0 | Universal",
    TabWidth    = 130,
    SizeUi      = UDim2.fromOffset(580, 340),
    Discord     = "discord.gg/myscript",
    Config      = "MyScriptConfig",
    Key         = "kF9Q2R7A6vM4JdPZyXb0mC5nL8sHqE1T3wUoGrIYxKWSVtBeN4yD6J0E5T2PZbCqA7HMWLXv1rVFtQmGUYw3xIOeB9sK8RA2D7M_P5E4RZ0C2W1L8F3H6TBYDVGJNKISUOQX9AR7MP5",
})

local CombatTab   = Window:CreateTab({ Name = "Combat",   Icon = "rbxassetid://7733715400" })
local MovementTab = Window:CreateTab({ Name = "Movement", Icon = "rbxassetid://7734053495" })
local VisualTab   = Window:CreateTab({ Name = "Visual",   Icon = "rbxassetid://7733960981" })
local MiscTab     = Window:CreateTab({ Name = "Misc",     Icon = "rbxassetid://7734061158" })

-- COMBAT

local AimbotSection = CombatTab:AddSection("Aimbot", true)

local aimbotEnabled = false
local aimbotFOV = 150
local aimbotSmooth = 0.15

AimbotSection:AddToggle({
    Title      = "Enable Aimbot",
    Content    = "Automatically aim at the nearest player",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
        aimbotEnabled = state
    end,
})

AimbotSection:AddSlider({
    Title      = "FOV Radius",
    Content    = "Field of view circle size (pixels)",
    Min        = 10,
    Max        = 500,
    Default    = 150,
    Suffix     = "px",
    SaveConfig = true,
    Callback   = function(value)
        aimbotFOV = value
    end,
})

AimbotSection:AddSlider({
    Title      = "Smoothness",
    Content    = "Higher = slower, more human-like movement",
    Min        = 1,
    Max        = 100,
    Default    = 15,
    Suffix     = "%",
    SaveConfig = true,
    Callback   = function(value)
        aimbotSmooth = value / 100
    end,
})

AimbotSection:AddDropdown({
    Title      = "Aim Part",
    Content    = "Which body part to aim at",
    Multi      = false,
    Options    = { "Head", "HumanoidRootPart", "Torso", "LeftArm", "RightArm" },
    Default    = { "Head" },
    SaveConfig = true,
    Callback   = function(selected)
    end,
})

AimbotSection:AddDropdown({
    Title      = "Prediction Parts",
    Content    = "Parts used for velocity prediction",
    Multi      = true,
    Options    = { "Head", "Torso", "HumanoidRootPart" },
    Default    = { "Head", "Torso" },
    SaveConfig = true,
    Callback   = function(selected)
    end,
})

local SilentSection = CombatTab:AddSection("Silent Aim", false)

SilentSection:AddToggle({
    Title      = "Enable Silent Aim",
    Content    = "Redirects bullets to nearest enemy without moving camera",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

SilentSection:AddSlider({
    Title      = "Hit Chance",
    Content    = "Percentage chance per shot to redirect",
    Min        = 1,
    Max        = 100,
    Default    = 100,
    Suffix     = "%",
    SaveConfig = true,
    Callback   = function(value)
    end,
})

local AntiAimSection = CombatTab:AddSection("Anti-Aim", false)

AntiAimSection:AddToggle({
    Title    = "Spin Bot",
    Content  = "Rapidly rotates your character",
    Default  = false,
    Callback = function(state)
    end,
})

AntiAimSection:AddSlider({
    Title    = "Spin Speed",
    Min      = 1,
    Max      = 60,
    Default  = 30,
    Suffix   = " spd",
    Callback = function(value)
    end,
})

-- MOVEMENT

local SpeedSection = MovementTab:AddSection("Speed", true)

local speedEnabled = false
local walkSpeed = 16

SpeedSection:AddToggle({
    Title      = "Speed Hack",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
        speedEnabled = state
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = state and walkSpeed or 16
        end
    end,
})

SpeedSection:AddSlider({
    Title      = "Walk Speed",
    Min        = 16,
    Max        = 500,
    Default    = 100,
    Suffix     = " studs/s",
    SaveConfig = true,
    Callback   = function(value)
        walkSpeed = value
        if speedEnabled then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = value
            end
        end
    end,
})

local JumpSection = MovementTab:AddSection("Jump", true)

JumpSection:AddToggle({
    Title      = "Infinite Jump",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

JumpSection:AddSlider({
    Title      = "Jump Power",
    Min        = 50,
    Max        = 500,
    Default    = 50,
    Suffix     = " pwr",
    SaveConfig = true,
    Callback   = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end,
})

local TeleportSection = MovementTab:AddSection("Teleport", false)

TeleportSection:AddInput({
    Title       = "Teleport to Player",
    Content     = "Type a player's name and press Enter",
    PlaceHolder = "Username...",
    SaveConfig  = false,
    Callback    = function(text)
        local target = game.Players:FindFirstChild(text)
        if target and target.Character then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                INFERNO_HUB:SetNotification({
                    Title       = "Teleported",
                    Description = "Movement",
                    Content     = "Teleported to " .. text,
                    Time        = 0.5,
                    Delay       = 2,
                })
            end
        else
            INFERNO_HUB:SetNotification({
                Title       = "Error",
                Description = "Movement",
                Content     = "Player not found: " .. text,
                Time        = 0.5,
                Delay       = 2,
            })
        end
    end,
})

TeleportSection:AddButton({
    Title    = "Teleport to Spawn",
    Content  = "Moves you back to spawn point",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
        if char and spawn and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
        end
        INFERNO_HUB:SetNotification({
            Title       = "Teleported",
            Description = "Movement",
            Content     = "Returned to spawn",
            Time        = 0.5,
            Delay       = 2,
        })
    end,
})

-- VISUAL

local ESPSection = VisualTab:AddSection("ESP", true)

ESPSection:AddToggle({
    Title      = "Player ESP",
    Content    = "Draw boxes/names over players",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

ESPSection:AddToggle({
    Title      = "Show Health Bars",
    Default    = true,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

ESPSection:AddToggle({
    Title      = "Show Names",
    Default    = true,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

ESPSection:AddSlider({
    Title      = "ESP Max Distance",
    Content    = "Only show ESP for players within this range",
    Min        = 50,
    Max        = 5000,
    Default    = 1000,
    Suffix     = " studs",
    SaveConfig = true,
    Callback   = function(value)
    end,
})

local ChamsSection = VisualTab:AddSection("Chams", false)

ChamsSection:AddToggle({
    Title      = "Enable Chams",
    Content    = "See players through walls",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
    end,
})

ChamsSection:AddDropdown({
    Title      = "Chams Style",
    Multi      = false,
    Options    = { "Flat", "Neon", "Glass", "Default" },
    Default    = { "Neon" },
    SaveConfig = true,
    Callback   = function(selected)
    end,
})

-- MISC

local ScriptSection = MiscTab:AddSection("Script Info", true)

ScriptSection:AddParagraph({
    Title   = "About",
    Content = "MyScript Hub v1.0\nDeveloped by YourName\nDiscord: discord.gg/myscript",
})

ScriptSection:AddParagraph({
    Title   = "Keybinds",
    Content = "Right Shift: Toggle UI visibility\nDelete: Unload script",
})

local UtilitySection = MiscTab:AddSection("Utilities", true)

UtilitySection:AddToggle({
    Title      = "Anti-AFK",
    Content    = "Prevents automatic disconnection",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
        if state then
            game:GetService("VirtualUser"):ActivateMouse(Vector2.new())
        end
    end,
})

UtilitySection:AddToggle({
    Title    = "NoClip",
    Content  = "Walk through walls",
    Default  = false,
    Callback = function(state)
    end,
})

UtilitySection:AddToggle({
    Title      = "Full Bright",
    Content    = "Maximizes game lighting",
    Default    = false,
    SaveConfig = true,
    Callback   = function(state)
        local lighting = game:GetService("Lighting")
        if state then
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = false
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
        else
            lighting.Brightness = 1
            lighting.ClockTime = 14
            lighting.FogEnd = 100000
            lighting.GlobalShadows = true
            lighting.Ambient = Color3.fromRGB(127, 127, 127)
        end
    end,
})

local ServerSection = MiscTab:AddSection("Server", false)

ServerSection:AddButton({
    Title    = "Rejoin Server",
    Content  = "Leaves and rejoins the current server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

ServerSection:AddButton({
    Title    = "New Server",
    Content  = "Hops to a different server instance",
    Callback = function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local ok, servers = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
            return HttpService:JSONDecode(game:HttpGet(url))
        end)
        if ok and servers and servers.data then
            for _, server in ipairs(servers.data) do
                if server.id ~= game.JobId and server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(placeId, server.id, game.Players.LocalPlayer)
                    return
                end
            end
        end
        INFERNO_HUB:SetNotification({
            Title       = "Server Hop",
            Description = "Misc",
            Content     = "No available servers found",
            Time        = 0.5,
            Delay       = 3,
        })
    end,
})

ServerSection:AddInput({
    Title       = "Execute Script",
    Content     = "Type Lua code and press Enter to run it",
    PlaceHolder = "print('Hello World')",
    SaveConfig  = false,
    Callback    = function(code)
        local fn, err = loadstring(code)
        if fn then
            local ok, runErr = pcall(fn)
            INFERNO_HUB:SetNotification({
                Title       = ok and "Executed" or "Error",
                Description = "Misc",
                Content     = ok and "Script ran successfully" or tostring(runErr),
                Time        = 0.5,
                Delay       = 3,
            })
        else
            INFERNO_HUB:SetNotification({
                Title       = "Syntax Error",
                Description = "Misc",
                Content     = tostring(err),
                Time        = 0.5,
                Delay       = 3,
            })
        end
    end,
})

task.delay(1, function()
    INFERNO_HUB:SetNotification({
        Title       = "Welcome!",
        Description = "MyScript Hub",
        Content     = "Loaded successfully. Enjoy!",
        Time        = 0.5,
        Delay       = 4,
    })
end)
