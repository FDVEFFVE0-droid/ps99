-- =================================================================
--   PET SIMULATOR 99 - AUTOMATION & QUEST ENGINE (V2.2 CORRIGÉ)
--   Interface Style GanjaHub / REDz | Touche F pour Ouvrir/Fermer
-- =================================================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Table des états globales pour les fonctionnalités (Toggles)
local States = {
    AutoCollect = false,
    AutoTap = false,
    ItemTracker = false,
    AutoClaimGifts = false,
    AutoVending = false,
    AutoPotions = false
}

-- Helper fonction sécurisée pour récupérer le HumanoidRootPart du joueur
local function getRootPart()
    local char = player.Character
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

-- Helper fonction pour trouver le dossier Network sans bloquer le script
local function getNetwork()
    return ReplicatedStorage:FindFirstChild("Network")
end

-- =================================================================
--   1. INTERFACE GRAPHIQUE (CHARGEMENT PRIORITAIRE ET IMMÉDIAT)
-- =================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PS99_GanjaHub_Edition"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Fenêtre Principale
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 520)
MainFrame.Position = UDim2.new(0.5, -220, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Ligne d'effet néon supérieure (Border Glow)
local PremiumStroke = Instance.new("UIStroke")
PremiumStroke.Color = Color3.fromRGB(130, 90, 255)
PremiumStroke.Thickness = 1.8
PremiumStroke.Parent = MainFrame

-- Bannière du Titre
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(26, 26, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PS99 AUTOMATION HUB [BETA]"
Title.TextColor3 = Color3.fromRGB(150, 120, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Système de Drag (Déplacement de la fenêtre fluide)
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Conteneur Défilant (ScrollingFrame)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -85)
Container.Position = UDim2.new(0, 10, 0, 75)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(130, 90, 255)
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout", Container)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)

-- Fonction Génératrice de Toggles
local function CreateToggle(text, stateKey, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -6, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Container

    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 8)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 235)
    Label.TextSize = 13
    Label.Font = Enum.Font.GothamMedium
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 85, 0, 30)
    Button.Position = UDim2.new(1, -100, 0.5, -15)
    Button.BackgroundColor3 = Color3.fromRGB(44, 44, 58)
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(160, 160, 170)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 11
    Button.Parent = ToggleFrame

    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

    Button.MouseButton1Click:Connect(function()
        States[stateKey] = not States[stateKey]
        if States[stateKey] then
            Button.BackgroundColor3 = Color3.fromRGB(130, 90, 255)
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Text = "ON"
        else
            Button.BackgroundColor3 = Color3.fromRGB(44, 44, 58)
            Button.TextColor3 = Color3.fromRGB(160, 160, 170)
            Button.Text = "OFF"
        end
        if callback then callback(States[stateKey]) end
    end)
end

-- Instanciation des Boutons
CreateToggle("Auto Collect (Orbes & Sacs)", "AutoCollect")
CreateToggle("Auto Clicker Rapide (Breakables)", "AutoTap")
CreateToggle("Tracker d'Objets Quêtes (Glow Bleu)", "ItemTracker", function(val) pcall(UpdateTrackers) end)
CreateToggle("Auto Claim (Cadeaux Horaires & Ranks)", "AutoClaimGifts")
CreateToggle("Sniper Distributeurs (Vending Machines)", "AutoVending")
CreateToggle("Auto Potions (Maintien des Buffs T1)", "AutoPotions")

-- Encart informatif de bas de page
local InfoPanel = Instance.new("Frame")
InfoPanel.Size = UDim2.new(1, -6, 0, 65)
InfoPanel.BackgroundColor3 = Color3.fromRGB(22, 28, 45)
InfoPanel.BorderSizePixel = 0
InfoPanel.Parent = Container
Instance.new("UICorner", InfoPanel).CornerRadius = UDim.new(0, 8)

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -20, 1, -10)
InfoLabel.Position = UDim2.new(0, 10, 0, 5)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "⚙️ Ce hub est optimisé pour les quêtes et le farm discret. Aucun risque de kick lié à des mouvements anormaux (Fly/Speed)."
InfoLabel.TextColor3 = Color3.fromRGB(160, 190, 255)
InfoLabel.TextSize = 11
InfoLabel.TextWrapped = true
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextYAlignment = Enum.TextYAlignment.Center
InfoLabel.Parent = InfoPanel


-- =================================================================
--   2. LOGIQUE ET BOUCLES DE FARM (SÉCURISÉES PAR PCALL)
-- =================================================================

-- 1. Auto Collect Orbs & Lootbags
task.spawn(function()
    while true do
        task.wait(0.3)
        local root = getRootPart()
        if States.AutoCollect and root then
            pcall(function()
                local things = Workspace:FindFirstChild("__THINGS")
                if things then
                    if things:FindFirstChild("Orbs") then
                        for _, v in pairs(things.Orbs:GetChildren()) do
                            if v:IsA("BasePart") then v.CFrame = root.CFrame end
                        end
                    end
                    if things:FindFirstChild("Lootbags") then
                        for _, v in pairs(things.Lootbags:GetChildren()) do
                            if v:IsA("BasePart") then v.CFrame = root.CFrame end
                        end
                    end
                end
            end)
        end
    end
end)

-- 2. Auto Clicker intelligent
task.spawn(function()
    while true do
        task.wait(0.1)
        local root = getRootPart()
        local net = getNetwork()
        if States.AutoTap and root and net then
            pcall(function()
                local breakables = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("Breakables")
                if breakables then
                    local closest = nil
                    local minDist = math.huge
                    for _, v in pairs(breakables:GetChildren()) do
                        if v:IsA("Model") and v:PrimaryPart then
                            local dist = (v.PrimaryPart.Position - root.Position).Magnitude
                            if dist < minDist then
                                minDist = dist
                                closest = v
                            end
                        end
                    end
                    if closest and net:FindFirstChild("Tap") then
                        net.Tap:FireServer(closest.Name)
                    end
                end
            end)
        end
    end
end)

-- 3. Tracker Visuel d'Objets Cachés
function UpdateTrackers()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Model") and (v.Name:lower():find("shiny") or v.Name:lower():find("chest") or v.Name:lower():find("gift") or v.Name:lower():find("lucky")) then
            if States.ItemTracker then
                if not v:FindFirstChild("Highlight") then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = Color3.fromRGB(0, 170, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.FillTransparency = 0.4
                    hl.Parent = v
                end
            else
                if v:FindFirstChild("Highlight") then v.Highlight:Destroy() end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(4)
        if States.ItemTracker then pcall(UpdateTrackers) end
    end
end)

-- 4. Auto Claim Récompenses
task.spawn(function()
    while true do
        task.wait(15)
        local net = getNetwork()
        if States.AutoClaimGifts and net then
            pcall(function()
                if net:FindFirstChild("FreeGifts_Claim") then
                    for i = 1, 12 do
                        net.FreeGifts_Claim:InvokeServer(i)
                    end
                end
                if net:FindFirstChild("Ranks_ClaimReward") then
                    for i = 1, 5 do
                        net.Ranks_ClaimReward:InvokeServer(i)
                    end
                end
            end)
        end
    end
end)

-- 5. Sniper Automatique de Distributeurs
local vendingMachines = {"Potion Vending Machine", "Enchant Vending Machine", "Fruit Vending Machine"}
task.spawn(function()
    while true do
        local net = getNetwork()
        if States.AutoVending and net then
            pcall(function()
                if net:FindFirstChild("VendingMachine_Purchase") then
                    for _, machine in pairs(vendingMachines) do
                        net.VendingMachine_Purchase:InvokeServer(machine, 1)
                    end
                end
            end)
            task.wait(60)
        else
            task.wait(2)
        end
    end
end)

-- 6. Auto-Consommation des Potions
local basePotions = {"Coins Potion I", "Damage Potion I", "Lucky Potion I", "Treasure Hunter Potion I"}
task.spawn(function()
    while true do
        task.wait(10)
        local net = getNetwork()
        if States.AutoPotions and net then
            pcall(function()
                if net:FindFirstChild("Potions_Activate") then
                    for _, potion in pairs(basePotions) do
                        net.Potions_Activate:FireServer(potion)
                    end
                end
            end)
        end
    end
end)

-- Ouverture/Fermeture globale du menu avec F
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.F then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("✅ [GanjaHub] Version 2.2 chargée ! Interface fluide disponible.")
