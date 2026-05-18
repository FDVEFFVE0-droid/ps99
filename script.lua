-- =============================================
--   PET SIMULATOR 99 - MENU FUTURISTE NEON
--   Version Optimisée pour Delta Executor
-- =============================================

print("🚀 Menu Futuriste PS99 chargé")

game.StarterGui:SetCore("SendNotification", {
    Title = "PS99 Cyber Cheat",
    Text = "Menu Neon activé avec succès !",
    Duration = 5
})

local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")

-- Auto Collect Orbs + Lootbags
spawn(function()
    while task.wait(0.2) do
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

local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.Parent = player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 430, 0, 590)
Main.Position = UDim2.new(0.5, -215, 0.5, -295)
Main.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
Main.Parent = sg

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(0, 255, 200)
stroke.Thickness = 3

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,90)
Title.BackgroundColor3 = Color3.fromRGB(0, 25, 45)
Title.Text = "NEON•PS99"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 18)

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,0,0,30)
sub.Position = UDim2.new(0,0,0,65)
sub.BackgroundTransparency = 1
sub.Text = "2026 • CYBER EDITION"
sub.TextColor3 = Color3.fromRGB(120, 255, 220)
sub.TextScaled = true
sub.Font = Enum.Font.Gotham
sub.Parent = Main

-- Scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-30,1,-150)
scroll.Position = UDim2.new(0,15,0,120)
scroll.BackgroundTransparency = 1
scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200)
scroll.Parent = Main

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 18)

local function NewToggle(name)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,0,70)
    f.BackgroundColor3 = Color3.fromRGB(15,15,30)
    f.Parent = scroll
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
    
    local s = Instance.new("UIStroke", f)
    s.Color = Color3.fromRGB(0, 200, 255)
    s.Thickness = 1.8
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "   "..name
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 18
    lbl.Parent = f
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,130,0,48)
    btn.Position = UDim2.new(0.68,0,0.15,0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Parent = f
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    
    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        btn.BackgroundColor3 = on and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
        btn.Text = on and "ON" or "OFF"
    end)
end

NewToggle("Auto Collect Orbs")
NewToggle("Auto Tap")
NewToggle("Fly")
NewToggle("Noclip")
NewToggle("Speed Boost")
NewToggle("Auto Rebirth")
NewToggle("Auto Hatch")
NewToggle("Anti AFK")

scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 100)

print("✅ Menu Futuriste chargé avec succès")
