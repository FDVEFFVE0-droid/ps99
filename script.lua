-- =============================================
--   PET SIMULATOR 99 - CRIMSON EDITION
--   Style Dark Red Cyber (comme Stresser)
-- =============================================

print("🔴 CRIMSON PS99 CHEAT LOADED")

game.StarterGui:SetCore("SendNotification", {
    Title = "CRIMSON PS99",
    Text = "Dark Red Protocol Activé",
    Duration = 5
})

local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")

-- ==================== AUTO FARM ====================
spawn(function()
    while task.wait(0.18) do
        pcall(function()
            local things = workspace:FindFirstChild("__THINGS")
            if things then
                for _, v in pairs(things.Orbs:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.CFrame = root.CFrame
                    end
                end
                for _, v in pairs(things.Lootbags:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then
                        v.CFrame = root.CFrame
                    end
                end
            end
        end)
    end
end)

-- ====================== GUI CRIMSON ======================
local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 480, 0, 650)  -- Plus gros
Main.Position = UDim2.new(0.5, -240, 0.5, -325)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
Main.Parent = sg

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(200, 0, 0)
Stroke.Thickness = 4
Stroke.Parent = Main

-- Titre Style Stresser
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,90)
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Title.Text = "CRIMSON PS99"
Title.TextColor3 = Color3.fromRGB(255, 40, 40)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1,0,0,30)
Subtitle.Position = UDim2.new(0,0,0,65)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "DARK RED PROTOCOL v2026"
Subtitle.TextColor3 = Color3.fromRGB(180, 0, 0)
Subtitle.TextScaled = true
Subtitle.Font = Enum.Font.GothamBold
Subtitle.Parent = Main

-- Scrolling
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -40, 1, -150)
Scroll.Position = UDim2.new(0, 20, 0, 120)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 8
Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 18)
Layout.Parent = Scroll

local function CrimsonToggle(name)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1,0,0,75)
    Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    Frame.Parent = Scroll
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)
    
    local s = Instance.new("UIStroke", Frame)
    s.Color = Color3.fromRGB(150, 0, 0)
    s.Thickness = 2
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65,0,1,0)
    Label.BackgroundTransparency = 1
    Label.Text = "   " .. name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 20
    Label.Parent = Frame
    
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 140, 0, 50)
    Btn.Position = UDim2.new(0.68,0,0.15,0)
    Btn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    Btn.Text = "OFF"
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 18
    Btn.Parent = Frame
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    
    local enabled = false
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
        Btn.Text = enabled and "ON" or "OFF"
    end)
end

-- Toggles
CrimsonToggle("Auto Collect Orbs")
CrimsonToggle("Auto Tap")
CrimsonToggle("Fly")
CrimsonToggle("Noclip")
CrimsonToggle("Speed Boost")
CrimsonToggle("Auto Rebirth")
CrimsonToggle("Auto Hatch")
CrimsonToggle("Anti-AFK")
CrimsonToggle("Godmode")

Scroll.CanvasSize = UDim2.new(0,0,0, Layout.AbsoluteContentSize.Y + 100)

print("🔴 Interface Crimson chargée - Essaye maintenant")
