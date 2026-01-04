Main.lua
-- English Hub | Safe GUI | Fully Working
if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Settings
local Version = getgenv().Version or "V1"
local Team = getgenv().Team or "Marines"

-- Team selection (safe)
pcall(function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", Team)
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "EnglishHub"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.Text = "English Hub | "..Version
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(45,45,45)
title.Parent = frame

-- Auto Beli Toggle
local autoBeli = false
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,300,0,40)
btn.Position = UDim2.new(0,25,0,100)
btn.Text = "Auto Collect Beli: OFF"
btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
btn.TextColor3 = Color3.new(1,1,1)
btn.Parent = frame

btn.MouseButton1Click:Connect(function()
    autoBeli = not autoBeli
    btn.Text = "Auto Collect Beli: "..(autoBeli and "ON" or "OFF")
end)

-- Safe Auto Beli loop
RunService.RenderStepped:Connect(function()
    if autoBeli and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        for _,v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") and v.Name == "BeliDrop" then
                v.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)
