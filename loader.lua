--// Xervoist Loader UI dengan Toggle + Minimize
-- Warna Hitam Merah

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeButton = Instance.new("TextButton")

ScreenGui.Name = "XervoistLoader"
ScreenGui.Parent = game:GetService("CoreGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
Frame.BorderSizePixel = 2
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 220, 0, 280)
Frame.Active = true
Frame.Draggable = true

UIListLayout.Parent = Frame
UIListLayout.Padding = UDim.new(0, 8)

-- Tombol minimize
MinimizeButton.Parent = Frame
MinimizeButton.Text = "-"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -30, 0, 5)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20

local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        for _, v in ipairs(Frame:GetChildren()) do
            if v ~= MinimizeButton and not v:IsA("UIListLayout") then
                v.Visible = false
            end
        end
        Frame.Size = UDim2.new(0, 60, 0, 40)
        MinimizeButton.Text = "+"
    else
        for _, v in ipairs(Frame:GetChildren()) do
            if v ~= MinimizeButton and not v:IsA("UIListLayout") then
                v.Visible = true
            end
        end
        Frame.Size = UDim2.new(0, 220, 0, 280)
        MinimizeButton.Text = "-"
    end
end)

-- Fungsi toggle
local function createToggle(name, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 40)
    holder.BackgroundTransparency = 1
    holder.Parent = Frame

    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.Parent = holder

    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 50, 0, 22)
    toggle.Position = UDim2.new(0.7, 0, 0.25, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.BorderSizePixel = 0
    toggle.Parent = holder

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 1, 0, 1)
    circle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    circle.BorderSizePixel = 0
    circle.Parent = toggle
    circle.ZIndex = 2
    circle.AnchorPoint = Vector2.new(0, 0)

    local on = false
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            on = not on
            if on then
                toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                circle:TweenPosition(UDim2.new(1, -21, 0, 1), "Out", "Sine", 0.2, true)
            else
                toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                circle:TweenPosition(UDim2.new(0, 1, 0, 1), "Out", "Sine", 0.2, true)
            end
            callback(on)
        end
    end)
end

-- Ambil player
local Player = game.Players.LocalPlayer
local Humanoid = Player.Character:WaitForChild("Humanoid")

-- Toggle SuperSpeed
createToggle("SuperSpeed", function(state)
    Humanoid.WalkSpeed = state and 100 or 16
end)

-- Toggle HighJump
createToggle("HighJump", function(state)
    Humanoid.JumpPower = state and 150 or 50
end)

-- Toggle Fly
local flying = false
local conn
createToggle("Fly", function(state)
    local HRP = Player.Character:WaitForChild("HumanoidRootPart")
    if state then
        flying = true
        local bp = Instance.new("BodyPosition", HRP)
        local bg = Instance.new("BodyGyro", HRP)
        bp.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            if flying then
                bp.Position = bp.Position + (HRP.CFrame.LookVector * 2)
            end
        end)
    else
        flying = false
        if conn then conn:Disconnect() end
        for _, v in pairs(HRP:GetChildren()) do
            if v:IsA("BodyPosition") or v:IsA("BodyGyro") then
                v:Destroy()
            end
        end
    end
end)

-- Toggle GodMode
createToggle("GodMode", function(state)
    Humanoid.MaxHealth = state and math.huge or 100
    Humanoid.Health = state and math.huge or 100
end)

print("✅ Xervoist Loader UI + Toggle + Minimize berhasil dijalankan")
