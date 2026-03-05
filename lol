-- ╔══════════════════════════════════════════════╗
-- ║          INFERNO HUB - example.lua           ║
-- ║    Ejemplo completo de uso de la librería    ║
-- ╚══════════════════════════════════════════════╝

-- ══════════════════════════════════════
-- 1. CARGAR LA LIBRERÍA
-- ══════════════════════════════════════
local InfernoHub = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/LuycyJuycy/La-librarya-LOL/refs/heads/main/WTF"
))()

-- ══════════════════════════════════════
-- 2. (OPCIONAL) SISTEMA DE KEY
--    Descomenta y configura si necesitas key system
-- ══════════════════════════════════════
--[[
local keyPassed = InfernoHub:CreateKeyScreen({
    Title    = "Mi Script",
    Subtitle = "Introduce tu clave para continuar",
    Discord  = "discord.gg/miservidor",
    HowToGetKey = "https://linkvertise.com/mikey",
    SaveKey  = true,          -- guarda la key en archivo
    KeyFileName = "MiScript_Key",
    AccentColor = Color3.fromRGB(138, 43, 226),

    -- Servicio de validación (elige uno):
    -- PlatoBoost:
    Service = InfernoHub.Services.platoboost.New("TU_SERVICE_ID", "TU_SECRET"),

    -- Panda Development:
    -- Service = InfernoHub.Services.pandadevelopment.New("TU_SERVICE_ID"),

    -- Luarmor:
    -- Service = InfernoHub.Services.luarmor.New("TU_SCRIPT_ID", "discord.gg/miservidor"),

    -- Junkie:
    -- Service = InfernoHub.Services.junkie.New("service", "identifier", "Mixed"),
})

if not keyPassed then return end  -- detiene el script si la key es inválida
]]

-- ══════════════════════════════════════
-- 3. CREAR LA VENTANA PRINCIPAL
--    Key requerida para que la UI funcione.
--    Copia la key real desde el source de la librería.
-- ══════════════════════════════════════
local KEY = "kF9Q2R7A6vM4JdPZ" .. "yXb0mC5nL8sHqE1T" ..
            "3wUoGrIYxKWSVtBe" .. "N4yD6J0E5T2PZbC"  ..
            "qA7HMWLXv1rVFtQm" .. "GUYw3xIOeB9sK8R"  ..
            "A2D7M_P5E4RZ0C2"  .. "W1L8F3H6TBYDVGJ"  ..
            "NKISUOQX9AR7MP5"

local Window = InfernoHub:CreateWindow({
    Title       = "Mi Script",         -- Título del hub
    Description = "v1.0 | By Ti",      -- Subtítulo / versión
    ["Tab Width"] = 120,               -- Ancho del panel de tabs
    SizeUi      = UDim2.fromOffset(580, 340), -- Tamaño total de la UI
    Discord     = "discord.gg/miservidor",
    Config      = "MiScript",          -- Nombre del archivo de config
    Key         = KEY,
})

-- ══════════════════════════════════════
-- 4. (OPCIONAL) PANTALLA DE CARGA
-- ══════════════════════════════════════
local Loader = Window:ShowLoadingScreen({
    Title       = "Mi Script",
    Subtitle    = "Cargando módulos",
    Duration    = 3,
    AccentColor = Color3.fromRGB(138, 43, 226),
    -- Logo     = "rbxassetid://XXXXXXXX",  -- pon tu image id
})

-- Puedes actualizar el estado mientras cargas:
task.wait(1)
Loader:SetStatus("Iniciando exploits...")
task.wait(1)
Loader:SetStatus("Conectando servicios...")
task.wait(0.8)
Loader:Complete()   -- cierra la pantalla de carga

-- ══════════════════════════════════════
-- 5. CREAR TABS
-- ══════════════════════════════════════
local TabPrincipal = Window:CreateTab({ Title = "Principal",  Icon = "rbxassetid://10734950309" })
local TabCombate   = Window:CreateTab({ Title = "Combate",    Icon = "rbxassetid://6031091004"  })
local TabVisual    = Window:CreateTab({ Title = "Visual",     Icon = "rbxassetid://6031154871"  })
local TabMisc      = Window:CreateTab({ Title = "Misc",       Icon = "rbxassetid://6022668888"  })

-- ══════════════════════════════════════
-- 6. TAB PRINCIPAL
-- ══════════════════════════════════════

-- Párrafo informativo
TabPrincipal:AddParagraph({
    Title   = "Bienvenido",
    Content = "Este es un ejemplo completo de INFERNO HUB. Explora cada tab para ver los elementos disponibles.",
})

-- Separador visual
TabPrincipal:AddSeperator()

-- Toggle simple
TabPrincipal:AddToggle({
    Title   = "Anti AFK",
    Default = false,
    Callback = function(value)
        if value then
            -- InfernoHub.Custom:EnableAntiAFK()  -- función integrada
            print("[Anti AFK] Activado")
        else
            print("[Anti AFK] Desactivado")
        end
    end,
})

-- Sección con elementos agrupados
local SeccionMovimiento = TabPrincipal:AddSection({ Title = "Movimiento" })

SeccionMovimiento:AddSlider({
    Title    = "Velocidad",
    Min      = 16,
    Max      = 500,
    Default  = 16,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end,
})

SeccionMovimiento:AddSlider({
    Title    = "Altura de salto",
    Min      = 7,
    Max      = 200,
    Default  = 7,
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpHeight = value
        end
    end,
})

SeccionMovimiento:AddToggle({
    Title    = "Noclip",
    Default  = false,
    Callback = function(value)
        -- Implementación básica de noclip
        local player = game.Players.LocalPlayer
        if value then
            game:GetService("RunService").Stepped:Connect(function()
                if player.Character then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
        print("[Noclip]", value and "ON" or "OFF")
    end,
})

-- ══════════════════════════════════════
-- 7. TAB COMBATE
-- ══════════════════════════════════════

TabCombate:AddParagraph({
    Title   = "Combate",
    Content = "Ajusta los parámetros de combate aquí.",
})

local SeccionAim = TabCombate:AddSection({ Title = "Aim Assist" })

SeccionAim:AddToggle({
    Title    = "Aimbot",
    Default  = false,
    Callback = function(value)
        print("[Aimbot]", value)
    end,
})

SeccionAim:AddDropdown({
    Title   = "Hitbox objetivo",
    Options = { "Head", "Torso", "HumanoidRootPart" },
    Default = "Head",
    Callback = function(selected)
        print("[Hitbox]", selected)
    end,
})

SeccionAim:AddSlider({
    Title    = "FOV",
    Min      = 10,
    Max      = 360,
    Default  = 100,
    Callback = function(value)
        print("[FOV]", value)
    end,
})

local SeccionOtros = TabCombate:AddSection({ Title = "Otros" })

SeccionOtros:AddToggle({
    Title    = "Silent Aim",
    Default  = false,
    Callback = function(value)
        print("[Silent Aim]", value)
    end,
})

SeccionOtros:AddToggle({
    Title    = "Infinite Jump",
    Default  = false,
    Callback = function(value)
        if value then
            game:GetService("UserInputService").JumpRequest:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end
        print("[Infinite Jump]", value)
    end,
})

-- Botón de acción
TabCombate:AddButton({
    Title    = "Teleport a jugador más cercano",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local closest, dist = nil, math.huge
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (p.Character.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then closest, dist = p, d end
            end
        end
        if closest then
            lp.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            Window:ShowToast({ Title = "Teleport", Description = "Teleportado a " .. closest.Name, Duration = 2 })
        end
    end,
})

-- ══════════════════════════════════════
-- 8. TAB VISUAL
-- ══════════════════════════════════════

TabVisual:AddParagraph({
    Title   = "Visual / ESP",
    Content = "Configuración de elementos visuales del juego.",
})

local SeccionEsp = TabVisual:AddSection({ Title = "ESP" })

SeccionEsp:AddToggle({
    Title    = "Player ESP",
    Default  = false,
    Callback = function(value)
        print("[ESP]", value)
    end,
})

SeccionEsp:AddToggle({
    Title    = "Mostrar nombre",
    Default  = true,
    Callback = function(value) print("[Nombres]", value) end,
})

SeccionEsp:AddToggle({
    Title    = "Mostrar distancia",
    Default  = false,
    Callback = function(value) print("[Distancia ESP]", value) end,
})

local SeccionUI = TabVisual:AddSection({ Title = "UI" })

-- Dropdown multi-select
SeccionUI:AddDropdown({
    Title    = "Tema de color",
    Options  = { "Púrpura", "Rojo", "Azul", "Verde", "Naranja" },
    Default  = "Púrpura",
    Callback = function(selected)
        local colores = {
            ["Púrpura"] = Color3.fromRGB(138, 43, 226),
            ["Rojo"]    = Color3.fromRGB(220, 50, 50),
            ["Azul"]    = Color3.fromRGB(50, 120, 220),
            ["Verde"]   = Color3.fromRGB(50, 200, 100),
            ["Naranja"] = Color3.fromRGB(230, 130, 30),
        }
        if colores[selected] then
            -- Actualiza el color de acento de toda la UI
            -- InfernoHub.Custom:UpdateAllAccentColors(colores[selected])
            print("[Tema]", selected)
        end
    end,
})

-- Input de texto
TabVisual:AddInput({
    Title       = "Texto personalizado en ESP",
    Placeholder = "Escribe aquí...",
    Callback    = function(text)
        print("[ESP Texto]", text)
    end,
})

-- ══════════════════════════════════════
-- 9. TAB MISC
-- ══════════════════════════════════════

TabMisc:AddParagraph({
    Title   = "Misceláneos",
    Content = "Herramientas varias y utilidades.",
})

-- Botones de notificación de ejemplo
TabMisc:AddButton({
    Title    = "Enviar notificación",
    Callback = function()
        InfernoHub:SetNotification({
            "Mi Script",        -- Título
            "Aviso",            -- Subtítulo (acento)
            "Esto es una notificación de prueba desde INFERNO HUB.", -- Contenido
            nil,
            0.5,                -- Tiempo animación
            4,                  -- Duración en pantalla
        })
    end,
})

TabMisc:AddButton({
    Title    = "Mostrar Toast",
    Callback = function()
        Window:ShowToast({
            Title       = "Toast de prueba",
            Description = "Mensaje breve en esquina",
            Duration    = 3,
            Color       = Color3.fromRGB(138, 43, 226),
            -- Logo     = "rbxassetid://XXXXXXX",
        })
    end,
})

TabMisc:AddButton({
    Title    = "Abrir diálogo de confirmación",
    Callback = function()
        Window:ShowDialog({
            Title       = "¿Estás seguro?",
            Description = "Esta acción no se puede deshacer.",
            AccentColor = Color3.fromRGB(220, 50, 50),
            Buttons     = {
                {
                    Text     = "Confirmar",
                    Callback = function()
                        print("[Diálogo] Confirmado")
                    end,
                },
                {
                    Text     = "Cancelar",
                    Callback = function()
                        print("[Diálogo] Cancelado")
                    end,
                },
            },
        })
    end,
})

TabMisc:AddSeperator()

local SeccionConfig = TabMisc:AddSection({ Title = "Configuración" })

SeccionConfig:AddButton({
    Title    = "Guardar config",
    Callback = function()
        local ok = InfernoHub.Custom:SaveConfig()
        Window:ShowToast({
            Title       = ok and "Config guardada" or "Error al guardar",
            Description = ok and "Ajustes guardados correctamente." or "No se pudo guardar.",
            Duration    = 2,
        })
    end,
})

SeccionConfig:AddButton({
    Title    = "Cargar config",
    Callback = function()
        local ok = InfernoHub.Custom:LoadConfig()
        print("[Config]", ok and "Cargada" or "No se pudo cargar")
    end,
})

-- Línea divisoria
TabMisc:AddLine()

TabMisc:AddParagraph({
    Title   = "Créditos",
    Content = "Librería: INFERNO HUB\nScript by: Ti\n\n¡Gracias por usar este script!",
})

-- ══════════════════════════════════════
-- 10. NOTIFICACIÓN DE INICIO
-- ══════════════════════════════════════
task.wait(0.5)
InfernoHub:SetNotification({
    "Mi Script",
    "¡Listo!",
    "El script se cargó correctamente. Disfrútalo.",
    nil,
    0.5,
    4,
})

print("[INFERNO HUB] example.lua cargado correctamente ✔")
