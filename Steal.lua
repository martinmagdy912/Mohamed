-- 👑 MARTIN BRAINROT GUI 👑

-- 🛡️ Anti-Kick & Console Clean
local plr = game.Players.LocalPlayer
hookfunction(plr.Kick, function() return nil end)
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    if getnamecallmethod() == "Kick" then return nil end
    return old(self, ...)
end)
getgenv().print = function() end
getgenv().warn = function() end

-- 🧠 SERVICES
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("StealRemote")

-- 🎬 Intro Animation
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.ResetOnSpawn = false
local intro = Instance.new("TextLabel", gui)
intro.Size = UDim2.new(0, 400, 0, 100)
intro.Position = UDim2.new(0.5, -200, 0.4, 0)
intro.BackgroundTransparency = 1
intro.Text = "MADE BY MARTIN"
intro.TextColor3 = Color3.fromRGB(255, 255, 255)
intro.TextScaled = true
intro.Font = Enum.Font.GothamBold

local tweenIn = TweenService:Create(intro, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 0})
local tweenOut = TweenService:Create(intro, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 1})
intro.TextTransparency = 1
tweenIn:Play()
tweenIn.Completed:Wait()
wait(1)
tweenOut:Play()
tweenOut.Completed:Wait()
intro:Destroy()

-- 🔲 GUI Creation
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 120)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Made by Martin 😎"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local stealBtn = Instance.new("TextButton", frame)
stealBtn.Size = UDim2.new(1, -20, 0, 60)
stealBtn.Position = UDim2.new(0, 10, 0, 40)
stealBtn.Text = "STEAL BRAINROT"
stealBtn.TextColor3 = Color3.new(1, 1, 1)
stealBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
stealBtn.Font = Enum.Font.GothamBlack
stealBtn.TextScaled = true

-- 📍 Save Spawn Location
local hrp = plr.Character and plr.Character:WaitForChild("HumanoidRootPart")
local startPos = hrp and hrp.Position or Vector3.new(0, 5, 0)

-- ➤ Teleport Smooth + Fire Remote
local function smartSteal()
	if not hrp then return end
	local goal = CFrame.new(startPos + Vector3.new(0, 3, -5))
	local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Quad), {CFrame = goal})
	tween:Play()
	tween.Completed:Wait()
	remote:FireServer("Odin Din Din Dun")
end

-- 🔘 Button Action
stealBtn.MouseButton1Click:Connect(smartSteal)
