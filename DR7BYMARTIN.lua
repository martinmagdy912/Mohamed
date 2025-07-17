-- صنع خصيصاً لـ DR7 💀⚡

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Main Screen GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

-- Toggle Button (الصورة اللي على اليسار)
local toggleBtn = Instance.new("ImageButton", screenGui)
toggleBtn.Size = UDim2.new(0, 70, 0, 70)
toggleBtn.Position = UDim2.new(0, 10, 0.5, -35)
toggleBtn.Image = "https://cdn.discordapp.com/attachments/1391509472874332170/1395353760724943008/file_000000001e98620ab696dc8f818893f5.png?ex=687a23f4&is=6878d274&hm=d39e9b04d00ce846a6405bd4004ed84a7f957f46e8178cbb4ffbe42a73f3abbf&"
toggleBtn.BackgroundTransparency = 1

-- Main Frame (الواجهة اللي فيها التابات)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false
mainFrame.BorderSizePixel = 0

-- UI Corner
local corner = Instance.new("UICorner", mainFrame)
corner.CornerRadius = UDim.new(0, 16)

-- Tabs
local tabs = {
    {name = "القتال", scripts = {
        {"ESP", "https://rawscripts.net/raw/Universal-Script-ESP-10638"},
        {"Aimbot", "https://rawscripts.net/raw/Aimbot-Script-aimbot-11406"},
    }},
    {name = "السرقة", scripts = {
        {"Auto Farm", "https://raw.githubusercontent.com/martinmagdy912/RobloxScripts/main/robbery.lua"},
    }},
    {name = "بروكهافن", scripts = {
        {"تحكم في البيوت", "https://raw.githubusercontent.com/martinmagdy912/RobloxScripts/main/houses.lua"},
    }},
    {name = "أخر", scripts = {
        {"طيران", "https://raw.githubusercontent.com/martinmagdy912/RobloxScripts/main/fly.lua"},
        {"فلينق", "https://raw.githubusercontent.com/martinmagdy912/RobloxScripts/main/fling.lua"},
        {"وول هوب", "https://rawscripts.net/raw/Universal-Script-wallhop-42706"},
    }},
}

-- Create Tabs Buttons
local tabButtonsFrame = Instance.new("Frame", mainFrame)
tabButtonsFrame.Size = UDim2.new(0, 120, 1, 0)
tabButtonsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", tabButtonsFrame).CornerRadius = UDim.new(0, 8)

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0, 130, 0, 10)
contentFrame.Size = UDim2.new(1, -140, 1, -20)
contentFrame.BackgroundTransparency = 1

local function clearContent()
    for _, v in pairs(contentFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
end

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton", tabButtonsFrame)
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, (i - 1) * 45 + 10)
    btn.Text = tab.name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        clearContent()
        for j, scriptInfo in ipairs(tab.scripts) do
            local scriptBtn = Instance.new("TextButton", contentFrame)
            scriptBtn.Size = UDim2.new(1, -10, 0, 40)
            scriptBtn.Position = UDim2.new(0, 5, 0, (j - 1) * 45)
            scriptBtn.Text = scriptInfo[1]
            scriptBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            scriptBtn.TextColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", scriptBtn).CornerRadius = UDim.new(0, 6)

            scriptBtn.MouseButton1Click:Connect(function()
                loadstring(game:HttpGet(scriptInfo[2]))()
            end)
        end
    end)
end

-- Toggle visibility
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
