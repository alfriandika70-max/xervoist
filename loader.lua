-- Xervoist Hub - Baseplate Test
-- UI: Hitam + Merah, bisa dipindah & minimize

-- Load OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()

-- Window
local Window = OrionLib:MakeWindow({
    Name = "Xervoist Hub | Baseplate Test",
    HidePremium = false,
    SaveConfig = false,
    IntroText = "Xervoist Hub Loaded",
    ConfigFolder = "XervoistHub"
})

-- Tab Utama
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998", -- Ikon default Orion
    PremiumOnly = false
})

-- Super Speed
Tab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 300,
    Default = 16,
    Color = Color3.fromRGB(255,0,0), -- Merah
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Value
        end
    end
})

-- Jump Higher
Tab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Color = Color3.fromRGB(255,0,0),
    Increment = 1,
    ValueName = "Jump",
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.JumpPower = Value
        end
    end
})

-- God Mode
Tab:AddButton({
    Name = "God Mode (Respawn Immortal)",
    Callback = function()
        local plr = game.Players.LocalPlayer
        plr.Character.Humanoid.Health = math.huge
        plr.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            plr.Character.Humanoid.Health = math.huge
        end)
        OrionLib:MakeNotification({
            Name = "Xervoist Hub",
            Content = "God Mode Aktif!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

-- Fly Mode
local flying = false
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local hum = plr.Character:FindFirstChildOfClass("Humanoid")

Tab:AddToggle({
    Name = "Fly Mode",
    Default = false,
    Callback = function(Value)
        flying = Value
        if flying then
            OrionLib:MakeNotification({
                Name = "Xervoist Hub",
                Content = "Fly Mode Aktif (WASD untuk gerak, SPACE/Turun SHIFT)",
                Time = 3
            })
            local hrp = plr.Character:WaitForChild("HumanoidRootPart")
            RS.RenderStepped:Connect(function()
                if flying and hrp then
                    local cam = workspace.CurrentCamera
                    local move = Vector3.new()
                    if UIS:IsKeyDown(Enum.KeyCode.W) then
                        move = move + cam.CFrame.LookVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then
                        move = move - cam.CFrame.LookVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then
                        move = move - cam.CFrame.RightVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then
                        move = move + cam.CFrame.RightVector
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then
                        move = move + Vector3.new(0,1,0)
                    end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                        move = move - Vector3.new(0,1,0)
                    end
                    hrp.Velocity = move * 100
                end
            end)
        end
    end
})

-- Inisialisasi Orion
OrionLib:Init()
