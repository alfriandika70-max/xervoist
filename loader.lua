--// Loader Xervoist
-- UI Hitam Merah + Fitur SuperSpeed, HighJump, Fly, GodMode

-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Warna dan posisi
ScreenGui.Name = "XervoistLoader"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 180, 0, 220)
Frame.Active = true
Frame.Draggable = true

UIListLayout.Parent = Frame
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi buat tombol
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = Frame
    btn.Text = name
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.MouseButton1Click:Connect(callback)
end

-- Ambil player
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character:WaitForChild("Humanoid")

-- Fitur SuperSpeed
createButton("SuperSpeed", function()
    if Humanoid.WalkSpeed == 16 then
        Humanoid.WalkSpeed = 100
    else
        Humanoid.WalkSpeed = 16
    end
end)

-- Fitur HighJump
createButton("HighJump", function()
    Humanoid.JumpPower = 150
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end)

-- Fitur Fly sederhana
local flying = false
createButton("Fly", function()
    flying = not flying
    local HRP = Player.Character:WaitForChild("HumanoidRootPart")
    local bp = Instance.new("BodyPosition", HRP)
    local bg = Instance.new("BodyGyro", HRP)
    bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            bp.Position = bp.Position + (HRP.CFrame.LookVector * 2)
        else
            bp:Destroy()
            bg:Destroy()
        end
    end)
end)

-- Fitur GodMode
createButton("GodMode", function()
    Humanoid.Health = math.huge
    Humanoid.MaxHealth = math.huge
end)

print("✅ Xervoist Loader berhasil dijalankan")
