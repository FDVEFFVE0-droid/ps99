-- =============================================
--   PS99 - INTERFACE STYLE GANJAHUB
--   Ouverture/Fermeture avec F
-- =============================================

local player = game.Players.LocalPlayer
local root = player.Character:WaitForChild("HumanoidRootPart")

-- Auto Collect (toujours actif)
spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local things = workspace:FindFirstChild("__THINGS")
            if things then
                for _, v in pairs(things.Orbs:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then v.CFrame = root.CFrame end
                end
                for _, v in pairs(things.Lootbags:GetChildren()) do
                    if v:IsA("Part") or v:IsA("MeshPart") then v.CFrame = root.CFrame end
                end
            end
        end)
    end
end)

-- ====================== GUI ======================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 580)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -290)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Titre
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,70)
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 80)
Title.Text = "PS99 • CUSTOM"
Title.TextColor3 = Color3.fromRGB(180, 100, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Fermer le menu avec la touche F
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Fonction Toggle
local function CreateToggle(parent, text)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -30, 0, 55)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleFrame.Parent = parent
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "   " .. text
    Label.TextColor3 = Color3.new(1,1,1)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 110, 0, 40)
    Button.Position = UDim2.new(0.75, 0, 0.15, 0)
    Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ToggleFrame
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        Button.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        Button.Text = enabled and "ON" or "OFF"
    end)
end

-- Catégories comme GanjaHub
local Tabs = Instance.new("Folder", MainFrame)

CreateToggle(MainFrame, "Auto Collect Orbs")
CreateToggle(MainFrame, "Auto Tap")
CreateToggle(MainFrame, "Fly")
CreateToggle(MainFrame, "Noclip")
CreateToggle(MainFrame, "Speed Boost")
CreateToggle(MainFrame, "Auto Rebirth")
CreateToggle(MainFrame, "Auto Hatch")
CreateToggle(MainFrame, "Godmode")
CreateToggle(MainFrame, "Anti-AFK")

print("✅ Interface style GanjaHub chargée - Appuie sur F pour ouvrir/fermer")
