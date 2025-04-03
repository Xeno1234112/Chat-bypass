-- Remove existing GUI
for _, gui in pairs(game.CoreGui:GetChildren()) do
	if gui.Name == "SigmaHub" then gui:Destroy() end
end

-- Sigma Hub v0.01 Beta
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "SigmaHub"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 300)
mainFrame.Position = UDim2.new(0.5,-250,0.5,-150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.Active = true
mainFrame.Draggable = true

-- Top Bar
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1,0,0,30)
topBar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.6,0,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "👑 Sigma Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left

local usernameLabel = Instance.new("TextLabel", topBar)
usernameLabel.Size = UDim2.new(0.3,0,1,0)
usernameLabel.Position = UDim2.new(0.65,0,0,0)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = LocalPlayer.Name
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextSize = 14
usernameLabel.TextColor3 = Color3.fromRGB(150,150,150)
usernameLabel.TextXAlignment = Enum.TextXAlignment.Right

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-30,0,0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "❌"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(200,50,50)
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Tabs Frame
local tabFrame = Instance.new("Frame", mainFrame)
tabFrame.Size = UDim2.new(0,100,1,-30)
tabFrame.Position = UDim2.new(0,0,0,30)
tabFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
local uiListLayout = Instance.new("UIListLayout", tabFrame)

-- Content Frame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1,-100,1,-30)
contentFrame.Position = UDim2.new(0,100,0,30)
contentFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)

-- Version label
local versionLabel = Instance.new("TextLabel", mainFrame)
versionLabel.Size = UDim2.new(0,150,0,20)
versionLabel.Position = UDim2.new(0,5,1,-20)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "Version: v0.01 Beta"
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextSize = 13
versionLabel.TextColor3 = Color3.fromRGB(120,120,120)

-- Local Tab
local localTab = Instance.new("TextButton", tabFrame)
localTab.Size = UDim2.new(1,0,0,30)
localTab.BackgroundColor3 = Color3.fromRGB(35,35,35)
localTab.Font = Enum.Font.Gotham
localTab.Text = "Local"
localTab.TextSize = 14
localTab.TextColor3 = Color3.fromRGB(255,255,255)

-- Ride Player Button
local rideBtn = Instance.new("TextButton", contentFrame)
rideBtn.Size = UDim2.new(0,140,0,30)
rideBtn.Position = UDim2.new(0,10,0,10)
rideBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
rideBtn.Font = Enum.Font.Gotham
rideBtn.Text = "🚗 Ride Player"
rideBtn.TextSize = 13
rideBtn.TextColor3 = Color3.fromRGB(255,255,255)
rideBtn.Visible = false

localTab.MouseButton1Click:Connect(function()
	rideBtn.Visible = true
end)

rideBtn.MouseButton1Click:Connect(function()
	local dropdown = Instance.new("ScrollingFrame", contentFrame)
	dropdown.Size = UDim2.new(0,160,0,150)
	dropdown.Position = UDim2.new(0,10,0,50)
	dropdown.BackgroundColor3 = Color3.fromRGB(25,25,25)
	dropdown.ScrollBarThickness = 6
	dropdown.CanvasSize = UDim2.new(0,0,0,#Players:GetPlayers()*30)
	local layout = Instance.new("UIListLayout", dropdown)

	for _,p in pairs(Players:GetPlayers()) do
		local btn = Instance.new("TextButton", dropdown)
		btn.Size = UDim2.new(1,-5,0,25)
		btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
		btn.Font = Enum.Font.Gotham
		btn.Text = p.DisplayName.." ("..p.Name..")"
		btn.TextColor3 = Color3.fromRGB(255,255,255)

		btn.MouseButton1Click:Connect(function()
			dropdown:Destroy()
			local char = p.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				local seat = Instance.new("Seat",workspace)
				seat.Anchored=false seat.CanCollide=false seat.Transparency=0.8
				seat.Size=Vector3.new(2,0.4,2)
				seat.CFrame=char.HumanoidRootPart.CFrame*CFrame.new(0,1.5,0)

				local weld=Instance.new("WeldConstraint",seat)
				weld.Part0=seat
				weld.Part1=char.HumanoidRootPart

				wait(0.1)
				LocalPlayer.Character.HumanoidRootPart.CFrame=seat.CFrame+Vector3.new(0,1,0)
				wait(0.1)
				LocalPlayer.Character.Humanoid.Sit=true
				seat:Sit(LocalPlayer.Character.Humanoid)

				seat.CanCollide=true
				local conn
				conn=LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
					if not LocalPlayer.Character.Humanoid.Sit then seat:Destroy() conn:Disconnect() end
				end)
			end
		end)
	end
end)

-- Toggle GUI visibility with "K"
UIS.InputBegan:Connect(function(key,gpe)
	if key.KeyCode == Enum.KeyCode.K and not gpe then
		mainFrame.Visible = not mainFrame.Visible
	end
end)
