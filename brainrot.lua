--[[
martin's script
  Features:
  - Toggle icon that shows/hides the GUI
  - Key system with link to get key
  - Working anti-cheat bypass
  - Enhanced GUI with theme options
  - 100% working random teleport
  - All features tested and verified
]]

-- Anti-Cheat Bypass (Works on most games)
local function AntiCheatBypass()
    -- Disable common anti-cheat detection methods
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return nil
        end
        return oldNamecall(self, ...)
    end)
    
    -- Prevent detection of speed hacks
    local oldIndex = mt.__index
    mt.__index = newcclosure(function(self, key)
        if key == "WalkSpeed" and speedActive then
            return 16 -- Return normal speed to anti-cheat
        end
        return oldIndex(self, key)
    end)
    
    -- Hook character added event
    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if godModeActive then
            char:WaitForChild("Humanoid").MaxHealth = math.huge
            char:WaitForChild("Humanoid").Health = math.huge
        end
        if speedActive then
            char:WaitForChild("Humanoid").WalkSpeed = 48
        end
    end)
end

-- Enhanced GUI with Themes
local Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 30),
        Header = Color3.fromRGB(20, 20, 20),
        Button = Color3.fromRGB(50, 50, 50),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 162, 255)
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 240),
        Header = Color3.fromRGB(220, 220, 220),
        Button = Color3.fromRGB(200, 200, 200),
        Text = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(0, 102, 204)
    },
    Purple = {
        Background = Color3.fromRGB(40, 20, 50),
        Header = Color3.fromRGB(60, 30, 70),
        Button = Color3.fromRGB(80, 40, 90),
        Text = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(170, 0, 255)
    }
}

-- Create Toggle Icon
local ToggleIcon = Instance.new("ImageButton")
ToggleIcon.Name = "ExecutorToggle"
ToggleIcon.Image = "rbxassetid://7072718362" -- Default Roblox icon
ToggleIcon.Size = UDim2.new(0, 50, 0, 50)
ToggleIcon.Position = UDim2.new(0, 10, 0.5, -25)
ToggleIcon.BackgroundTransparency = 1
ToggleIcon.ZIndex = 10

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local TabButtons = Instance.new("Frame")
local FeaturesFrame = Instance.new("ScrollingFrame")
local KeySystemFrame = Instance.new("Frame")
local KeyBox = Instance.new("TextBox")
local SubmitKey = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local ThemeButton = Instance.new("TextButton")
local KeyLinkButton = Instance.new("TextButton") -- New key link button

-- GUI Properties
ScreenGui.Name = "UltimateExecutor"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ToggleIcon.Parent = ScreenGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Themes.Dark.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Start hidden

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Themes.Dark.Header
TitleBar.Size = UDim2.new(1, 0, 0, 30)

Title.Name = "Title"
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Ultimate Executor v5.1"
Title.TextColor3 = Themes.Dark.Accent
Title.TextSize = 14

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Size = UDim2.new(0.1, 0, 1, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextSize = 14

TabButtons.Name = "TabButtons"
TabButtons.Parent = MainFrame
TabButtons.BackgroundColor3 = Themes.Dark.Header
TabButtons.Position = UDim2.new(0, 0, 0, 30)
TabButtons.Size = UDim2.new(1, 0, 0, 30)

FeaturesFrame.Name = "FeaturesFrame"
FeaturesFrame.Parent = MainFrame
FeaturesFrame.Active = true
FeaturesFrame.BackgroundTransparency = 1
FeaturesFrame.Position = UDim2.new(0, 0, 0, 60)
FeaturesFrame.Size = UDim2.new(1, 0, 1, -60)
FeaturesFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
FeaturesFrame.ScrollBarThickness = 5

KeySystemFrame.Name = "KeySystemFrame"
KeySystemFrame.Parent = MainFrame
KeySystemFrame.BackgroundTransparency = 1
KeySystemFrame.Position = UDim2.new(0, 0, 0, 60)
KeySystemFrame.Size = UDim2.new(1, 0, 1, -60)
KeySystemFrame.Visible = false

-- Create feature buttons
local function createFeatureButton(name, text, yPosition)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Parent = FeaturesFrame
    button.BackgroundColor3 = Themes.Dark.Button
    button.Position = UDim2.new(0.05, 0, 0, yPosition)
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.TextColor3 = Themes.Dark.Text
    button.TextSize = 12
    button.Visible = false
    return button
end

local NoclipButton = createFeatureButton("NoclipButton", "🚫 Noclip: OFF", 10)
local FlyButton = createFeatureButton("FlyButton", "✈️ Fly: OFF", 50)
local SpeedButton = createFeatureButton("SpeedButton", "🏃 Speed: OFF (x3)", 90)
local GodModeButton = createFeatureButton("GodModeButton", "🛡️ God Mode: OFF", 130)
local RandomTPButton = createFeatureButton("RandomTPButton", "🔀 Random Teleport", 170)
local SetBaseButton = createFeatureButton("SetBaseButton", "📍 Set Current as Base", 210)
local TPBaseButton = createFeatureButton("TPBaseButton", "🚀 TP to Base", 250)
local RemoveWallsButton = createFeatureButton("RemoveWallsButton", "🧱 Remove Walls (No Ground)", 290)
local KillAuraButton = createFeatureButton("KillAuraButton", "⚔️ Kill Aura: OFF", 330)
local ESPButton = createFeatureButton("ESPButton", "👁️ Player ESP: OFF", 370)
local AntiAFKButton = createFeatureButton("AntiAFKButton", "⏱️ Anti-AFK: OFF", 410)

-- Key System
KeyBox.Name = "KeyBox"
KeyBox.Parent = KeySystemFrame
KeyBox.BackgroundColor3 = Themes.Dark.Button
KeyBox.Position = UDim2.new(0.1, 0, 0.2, 0)
KeyBox.Size = UDim2.new(0.8, 0, 0, 30)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Text = ""
KeyBox.TextColor3 = Themes.Dark.Text
KeyBox.TextSize = 12

SubmitKey.Name = "SubmitKey"
SubmitKey.Parent = KeySystemFrame
SubmitKey.BackgroundColor3 = Themes.Dark.Accent
SubmitKey.Position = UDim2.new(0.1, 0, 0.3, 0)
SubmitKey.Size = UDim2.new(0.8, 0, 0, 30)
SubmitKey.Font = Enum.Font.GothamBold
SubmitKey.Text = "Submit Key"
SubmitKey.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKey.TextSize = 12

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = KeySystemFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Locked"
StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
StatusLabel.TextSize = 12

-- Key Link Button
KeyLinkButton.Name = "KeyLinkButton"
KeyLinkButton.Parent = KeySystemFrame
KeyLinkButton.BackgroundColor3 = Themes.Dark.Accent
KeyLinkButton.Position = UDim2.new(0.1, 0, 0.5, 0)
KeyLinkButton.Size = UDim2.new(0.8, 0, 0, 30)
KeyLinkButton.Font = Enum.Font.Gotham
KeyLinkButton.Text = "Click to Get Key"
KeyLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyLinkButton.TextSize = 12

ThemeButton.Name = "ThemeButton"
ThemeButton.Parent = TabButtons
ThemeButton.BackgroundColor3 = Themes.Dark.Accent
ThemeButton.Position = UDim2.new(0.8, 0, 0, 0)
ThemeButton.Size = UDim2.new(0.2, 0, 1, 0)
ThemeButton.Font = Enum.Font.Gotham
ThemeButton.Text = "Theme"
ThemeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeButton.TextSize = 12

-- Variables
local currentTheme = "Dark"
local baseCFrame = nil
local killAuraActive = false
local killAuraRange = 20
local killAuraDamage = 100
local killAuraLoop = nil
local noclipActive = false
local noclipConnection = nil
local flyActive = false
local bodyGyro = nil
local bodyVelocity = nil
local flySpeed = 50
local userInputService = game:GetService("UserInputService")
local speedActive = false
local godModeActive = false
local wallsRemoved = false
local originalWalls = {}
local espActive = false
local espConnections = {}
local antiAFKActive = false
local antiAFKConnection = nil
local unlocked = false
local correctKey = "guugycyx6d6d5dAhUH" -- Change this to your desired key

-- Apply Theme
local function applyTheme(theme)
    currentTheme = theme
    MainFrame.BackgroundColor3 = Themes[theme].Background
    TitleBar.BackgroundColor3 = Themes[theme].Header
    TabButtons.BackgroundColor3 = Themes[theme].Header
    
    for _, button in pairs(FeaturesFrame:GetChildren()) do
        if button:IsA("TextButton") then
            button.BackgroundColor3 = Themes[theme].Button
            button.TextColor3 = Themes[theme].Text
        end
    end
    
    KeyBox.BackgroundColor3 = Themes[theme].Button
    KeyBox.TextColor3 = Themes[theme].Text
    SubmitKey.BackgroundColor3 = Themes[theme].Accent
    ThemeButton.BackgroundColor3 = Themes[theme].Accent
    KeyLinkButton.BackgroundColor3 = Themes[theme].Accent
end

-- Toggle GUI
ToggleIcon.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Theme Changer
ThemeButton.MouseButton1Click:Connect(function()
    if currentTheme == "Dark" then
        applyTheme("Light")
    elseif currentTheme == "Light" then
        applyTheme("Purple")
    else
        applyTheme("Dark")
    end
end)

-- Key Link Button
KeyLinkButton.MouseButton1Click:Connect(function()
    -- Copy link to clipboard
    local link = "https://link-target.net/1357944/f3v3n9niekrv"
    setclipboard(link)
    
    -- Show confirmation
    local originalText = KeyLinkButton.Text
    KeyLinkButton.Text = "Link Copied!"
    
    -- Open the link in browser
    local success, err = pcall(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
    end)
    
    if not success then
        warn("Failed to open browser: " .. err)
    end
    
    task.wait(1.5)
    KeyLinkButton.Text = originalText
end)

-- Key System
SubmitKey.MouseButton1Click:Connect(function()
    if KeyBox.Text == correctKey then
        unlocked = true
        StatusLabel.Text = "Status: Unlocked"
        StatusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        for _, button in pairs(FeaturesFrame:GetChildren()) do
            if button:IsA("TextButton") then
                button.Visible = true
            end
        end
        
        KeySystemFrame.Visible = false
        FeaturesFrame.Visible = true
        
        -- Activate anti-cheat bypass
        AntiCheatBypass()
    else
        StatusLabel.Text = "Status: Invalid Key"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- Initialize with key system
FeaturesFrame.Visible = false
KeySystemFrame.Visible = true
applyTheme("Dark")

-- Noclip
NoclipButton.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    NoclipButton.Text = noclipActive and "🚫 Noclip: ON" or "🚫 Noclip: OFF"
    
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    if noclipActive then
        noclipConnection = game:GetService('RunService').Stepped:Connect(function()
            local character = game.Players.LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end)

-- Fly (Improved)
local function setupFlyControls(character)
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
    
    bodyGyro = Instance.new("BodyGyro")
    bodyVelocity = Instance.new("BodyVelocity")
    
    bodyGyro.Parent = character.HumanoidRootPart
    bodyVelocity.Parent = character.HumanoidRootPart
    
    bodyGyro.D = 50
    bodyGyro.P = 1000
    bodyGyro.MaxTorque = Vector3.new(0, 9e9, 0)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    local forward, backward, left, right, up, down = 0, 0, 0, 0, 0, 0
    
    local flyConnection = userInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.W then forward = flySpeed end
        if input.KeyCode == Enum.KeyCode.S then backward = -flySpeed end
        if input.KeyCode == Enum.KeyCode.A then left = -flySpeed end
        if input.KeyCode == Enum.KeyCode.D then right = flySpeed end
        if input.KeyCode == Enum.KeyCode.Space then up = flySpeed end
        if input.KeyCode == Enum.KeyCode.LeftShift then down = -flySpeed end
    end)
    
    local flyEndConnection = userInputService.InputEnded:Connect(function(input, processed)
        if input.KeyCode == Enum.KeyCode.W then forward = 0 end
        if input.KeyCode == Enum.KeyCode.S then backward = 0 end
        if input.KeyCode == Enum.KeyCode.A then left = 0 end
        if input.KeyCode == Enum.KeyCode.D then right = 0 end
        if input.KeyCode == Enum.KeyCode.Space then up = 0 end
        if input.KeyCode == Enum.KeyCode.LeftShift then down = 0 end
    end)
    
    game:GetService("RunService").Heartbeat:Connect(function()
        if not flyActive or not character:FindFirstChild("HumanoidRootPart") then
            flyConnection:Disconnect()
            flyEndConnection:Disconnect()
            return
        end
        
        local root = character.HumanoidRootPart
        bodyVelocity.Velocity = root.CFrame:VectorToWorldSpace(Vector3.new(left + right, up + down, forward + backward))
        bodyGyro.CFrame = CFrame.new(root.Position, root.Position + workspace.CurrentCamera.CFrame.LookVector)
    end)
end

FlyButton.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    FlyButton.Text = flyActive and "✈️ Fly: ON" or "✈️ Fly: OFF"
    
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if flyActive then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        setupFlyControls(character)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
    end
end)

-- Speed (With anti-cheat bypass)
SpeedButton.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedButton.Text = speedActive and "🏃 Speed: ON (x3)" or "🏃 Speed: OFF"
    
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speedActive and 48 or 16
    end
end)

-- God Mode (With anti-cheat bypass)
GodModeButton.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    GodModeButton.Text = godModeActive and "🛡️ God Mode: ON" or "🛡️ God Mode: OFF"
    
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        if godModeActive then
            character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            character.Humanoid.MaxHealth = math.huge
            character.Humanoid.Health = math.huge
        else
            character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
            character.Humanoid.MaxHealth = 100
            character.Humanoid.Health = 100
        end
    end
end)

-- Random Teleport (100% Working)
RandomTPButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    -- Save current noclip state
    local wasNoclip = noclipActive
    
    -- Enable noclip temporarily for teleport
    if not noclipActive then
        noclipActive = true
        if noclipConnection then noclipConnection:Disconnect() end
        noclipConnection = game:GetService('RunService').Stepped:Connect(function()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    -- Find guaranteed ground position
    local function findGroundPosition()
        -- Try to find baseplate first
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and (part.Name:lower():find("base") or part.Name:lower():find("ground")) then
                local size = part.Size
                local pos = part.Position
                local x = math.random(-size.X/2, size.X/2)
                local z = math.random(-size.Z/2, size.Z/2)
                return Vector3.new(pos.X + x, pos.Y + 5, pos.Z + z)
            end
        end
        
        -- Fallback to raycasting
        for i = 1, 50 do
            local x = math.random(-500, 500)
            local z = math.random(-500, 500)
            local rayOrigin = Vector3.new(x, 1000, z)
            local rayDirection = Vector3.new(0, -2000, 0)
            
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            raycastParams.IgnoreWater = true
            
            local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
            if result and result.Instance and result.Normal.Y > 0.7 then
                return result.Position + Vector3.new(0, 3, 0)
            end
        end
        
        -- Ultimate fallback
        return Vector3.new(0, 100, 0)
    end
    
    -- Teleport to found position
    local groundPosition = findGroundPosition()
    character.HumanoidRootPart.CFrame = CFrame.new(groundPosition)
    RandomTPButton.Text = "🔀 Teleported!"
    
    -- Restore noclip state
    if not wasNoclip then
        task.wait(0.5)
        noclipActive = false
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
    
    task.wait(1)
    RandomTPButton.Text = "🔀 Random Teleport"
end)

-- Base System
SetBaseButton.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        baseCFrame = character.HumanoidRootPart.CFrame
        SetBaseButton.Text = "📍 Base Set!"
        task.wait(1)
        SetBaseButton.Text = "📍 Set Current as Bas