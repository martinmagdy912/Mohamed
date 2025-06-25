-- Anti-Cheat Safe TP GUI with Draggable Frame and Title
-- Made by Martin 💥

--====== Anti-Kick Bypass ======
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then
        warn("Blocked kick 🚫")
        return nil
    end
    return old(self, ...)
end)
local lp = game.Players.LocalPlayer
local oldKick = lp.Kick
hookfunction(oldKick, function(...) return nil end)

--====== Player Setup ======
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--====== GUI Setup ======
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 130)
frame.Position = UDim2.new(0.01, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true -- ✅ يخلّيها قابلة للسحب

--====== Title ======
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Made by Martin"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18

--====== Steal Button ======
local stealBtn = Instance.new("TextButton", frame)
stealBtn.Size = UDim2.new(1, -10, 0, 40)
stealBtn.Position = UDim2.new(0, 5, 0, 35)
stealBtn.Text = "Steal"
stealBtn.TextColor3 = Color3.new(1, 1, 1)
stealBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
stealBtn.Font = Enum.Font.SourceSans
stealBtn.TextSize = 18

--====== TP Button ======
local tpBtn = Instance.new("TextButton", frame)
tpBtn.Size = UDim2.new(1, -10, 0, 40)
tpBtn.Position = UDim2.new(0, 5, 0, 85)
tpBtn.Text = "TP"
tpBtn.TextColor3 = Color3.new(1, 1, 1)
tpBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
tpBtn.Font = Enum.Font.SourceSans
tpBtn.TextSize = 18

--====== Teleport Logic ======
task.wait(2)
local spawnPosition = hrp.Position
local stealPosition = Vector3.new(1000, 10, 1000)

local TweenService = game:GetService("TweenService")
local function safeTP(pos)
    local goal = {CFrame = CFrame.new(pos)}
    local info = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
    local tw = TweenService:Create(hrp, info, goal)
    tw:Play()
end

-- زر السرقة
stealBtn.MouseButton1Click:Connect(function()
    safeTP(stealPosition)
end)

-- زر العودة للقاعدة
tpBtn.MouseButton1Click:Connect(function()
    safeTP(spawnPosition)
end)
