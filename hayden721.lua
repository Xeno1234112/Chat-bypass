-- Remove existing GUI
for _, gui in pairs(game.CoreGui:GetChildren()) do
	if gui.Name == "SigmaHub" then gui:Destroy() end
end

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SigmaHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local function makeRounded(obj, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = obj
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 280)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = ScreenGui
makeRounded(mainFrame, 12)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.Parent = mainFrame
makeRounded(topBar, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -180, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "👑 Sigma Hub"
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Size = UDim2.new(0, 100, 1, 0)
usernameLabel.Position = UDim2.new(1, -170, 0, 0)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = LocalPlayer.Name
usernameLabel.TextSize = 14
usernameLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
usernameLabel.Font = Enum.Font.Gotham
usernameLabel.TextXAlignment = Enum.TextXAlignment.Right
usernameLabel.Parent = topBar

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -60, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.Text = "➖"
minBtn.TextSize = 16
minBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = topBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "❌"
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

local tabFrame = Instance.new("ScrollingFrame")
tabFrame.Size = UDim2.new(0, 100, 1, -30)
tabFrame.Position = UDim2.new(0, 0, 0, 30)
tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
tabFrame.ScrollBarThickness = 4
tabFrame.Parent = mainFrame
makeRounded(tabFrame, 10)

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 5)
uiListLayout.Parent = tabFrame
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -100, 1, -30)
contentFrame.Position = UDim2.new(0, 100, 0, 30)
contentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
contentFrame.Parent = mainFrame
makeRounded(contentFrame, 10)

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 150, 0, 20)
versionLabel.Position = UDim2.new(0, 5, 1, -20)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "Version: v0.01 Beta"
versionLabel.TextSize = 13
versionLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = mainFrame

local shouldRejoinVC = false

task.spawn(function()
	while true do
		task.wait(1)
		if shouldRejoinVC then
			shouldRejoinVC = false
			local success, result = pcall(function()
				game:GetService("VoiceChatService"):JoinVoice()
			end)
			if success then
				print("✅ Attempted to rejoin VC.")
			else
				warn("❌ Failed to rejoin VC:", result)
			end
		end
	end
end)


-- Tabs
local tabInfo = {
	{"🏠", "Home"},
	{"🧍", "Player"},
	{"🎨", "Visual"},
	{"🎙️", "VoiceChat"},
	{"⚙️", "Settings"},
	{"📜", "Credits"},
}

local tabButtons = {}

for _, tab in ipairs(tabInfo) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -10, 0, 40)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.Text = tab[1]
	button.Font = Enum.Font.Gotham
	button.TextSize = 20
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Name = tab[2] .. "Tab"
	button.Parent = tabFrame
	makeRounded(button, 6)
	tabButtons[tab[2]] = button
end

-- Welcome Screen
local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Name = "WelcomeFrame"
WelcomeFrame.Size = UDim2.new(1, 0, 1, 0)
WelcomeFrame.BackgroundTransparency = 1
WelcomeFrame.Parent = contentFrame

local welcomeLabel = Instance.new("TextLabel")
welcomeLabel.Size = UDim2.new(1, 0, 0, 50)
welcomeLabel.Position = UDim2.new(0, 0, 0.4, 0)
welcomeLabel.BackgroundTransparency = 1
welcomeLabel.Text = "Welcome to Sigma Hub"
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextSize = 20
welcomeLabel.TextXAlignment = Enum.TextXAlignment.Center
welcomeLabel.Parent = WelcomeFrame

-- Create a frame template function
local function createTabFrame(name, labelText)
	local frame = Instance.new("Frame")
	frame.Name = name .. "Frame"
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.Visible = false
	frame.Parent = contentFrame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 30)
	label.Position = UDim2.new(0, 10, 0, 10)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame

	return frame
end

-- Home Tab
-- 🏠 Home Tab (Scrollable)
local HomeFrame = Instance.new("ScrollingFrame")
HomeFrame.Name = "HomeFrame"
HomeFrame.Size = UDim2.new(1, 0, 1, 0)
HomeFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
HomeFrame.ScrollBarThickness = 4
HomeFrame.BackgroundTransparency = 1
HomeFrame.Visible = false
HomeFrame.Parent = contentFrame
makeRounded(HomeFrame, 10)

local homeLayout = Instance.new("UIListLayout")
homeLayout.Padding = UDim.new(0, 8)
homeLayout.SortOrder = Enum.SortOrder.LayoutOrder
homeLayout.Parent = HomeFrame

local homePadding = Instance.new("UIPadding")
homePadding.PaddingTop = UDim.new(0, 10)
homePadding.PaddingLeft = UDim.new(0, 20)
homePadding.Parent = HomeFrame

-- Infinite Yield Button
local infYieldBtn = Instance.new("TextButton")
infYieldBtn.Size = UDim2.new(0, 180, 0, 35)
infYieldBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
infYieldBtn.Text = "Launch Infinite Yield"
infYieldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infYieldBtn.Font = Enum.Font.Gotham
infYieldBtn.TextSize = 14
infYieldBtn.LayoutOrder = 1
infYieldBtn.Parent = HomeFrame
makeRounded(infYieldBtn, 6)

infYieldBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)


-- Coming Soon Label
local comingSoonLabel = Instance.new("TextLabel")
comingSoonLabel.Size = UDim2.new(1, -40, 0, 30)
comingSoonLabel.BackgroundTransparency = 1
comingSoonLabel.Text = "Reanimations coming in the future."
comingSoonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
comingSoonLabel.Font = Enum.Font.Gotham
comingSoonLabel.TextSize = 14
comingSoonLabel.TextXAlignment = Enum.TextXAlignment.Left
comingSoonLabel.LayoutOrder = 2
comingSoonLabel.Parent = HomeFrame

-- 🧍 Player Tab (Scrollable & Styled)
local PlayerFrame = Instance.new("ScrollingFrame")
PlayerFrame.Name = "PlayerFrame"
PlayerFrame.Size = UDim2.new(1, 0, 1, 0)
PlayerFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
PlayerFrame.ScrollBarThickness = 4
PlayerFrame.BackgroundTransparency = 1
PlayerFrame.Visible = false
PlayerFrame.Parent = contentFrame
makeRounded(PlayerFrame, 10)

local playerLayout = Instance.new("UIListLayout")
playerLayout.Padding = UDim.new(0, 5)
playerLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerLayout.Parent = PlayerFrame

local playerPadding = Instance.new("UIPadding")
playerPadding.PaddingTop = UDim.new(0, 10)
playerPadding.PaddingLeft = UDim.new(0, 20)
playerPadding.Parent = PlayerFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Player Tab"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.LayoutOrder = 0
title.Parent = PlayerFrame

-- Helper: Spacer
local function addSpacer(order)
	local spacer = Instance.new("Frame")
	spacer.Size = UDim2.new(0, 0, 0, 5)
	spacer.BackgroundTransparency = 1
	spacer.LayoutOrder = order
	spacer.Parent = PlayerFrame
end

-- WalkSpeed
local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0, 200, 0, 20)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "WalkSpeed (Max 500):"
walkSpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextSize = 14
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.LayoutOrder = 1
walkSpeedLabel.Parent = PlayerFrame

local walkSpeedBox = Instance.new("TextBox")
walkSpeedBox.Size = UDim2.new(0, 200, 0, 30)
walkSpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
walkSpeedBox.Text = "16"
walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedBox.Font = Enum.Font.Gotham
walkSpeedBox.TextSize = 14
walkSpeedBox.ClearTextOnFocus = false
walkSpeedBox.PlaceholderText = "Enter speed"
walkSpeedBox.TextXAlignment = Enum.TextXAlignment.Center
walkSpeedBox.LayoutOrder = 2
walkSpeedBox.Parent = PlayerFrame
makeRounded(walkSpeedBox, 6)

addSpacer(3)

walkSpeedBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local num = tonumber(walkSpeedBox.Text)
		if num and num >= 0 and num <= 500 then
			local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.WalkSpeed = num
			end
		else
			walkSpeedBox.Text = "16"
		end
	end
end)

-- JumpPower
local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0, 200, 0, 20)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Text = "JumpPower:"
jumpPowerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerLabel.Font = Enum.Font.Gotham
jumpPowerLabel.TextSize = 14
jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpPowerLabel.LayoutOrder = 4
jumpPowerLabel.Parent = PlayerFrame

local jumpPowerBox = Instance.new("TextBox")
jumpPowerBox.Size = UDim2.new(0, 200, 0, 30)
jumpPowerBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
jumpPowerBox.Text = "50"
jumpPowerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerBox.Font = Enum.Font.Gotham
jumpPowerBox.TextSize = 14
jumpPowerBox.ClearTextOnFocus = false
jumpPowerBox.PlaceholderText = "Enter jump"
jumpPowerBox.LayoutOrder = 5
jumpPowerBox.Parent = PlayerFrame
makeRounded(jumpPowerBox, 6)

addSpacer(6)

local function setJumpPower(amount)
	amount = tonumber(amount)
	if amount and amount >= 1 and amount <= 500 then
		local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = amount
		end
	end
end

jumpPowerBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		setJumpPower(jumpPowerBox.Text)
	end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid")
	wait(0.2)
	setJumpPower(jumpPowerBox.Text)
end)

-- Gravity
local gravityLabel = Instance.new("TextLabel")
gravityLabel.Size = UDim2.new(0, 200, 0, 20)
gravityLabel.BackgroundTransparency = 1
gravityLabel.Text = "Gravity (0–10000):"
gravityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gravityLabel.Font = Enum.Font.Gotham
gravityLabel.TextSize = 14
gravityLabel.TextXAlignment = Enum.TextXAlignment.Left
gravityLabel.LayoutOrder = 7
gravityLabel.Parent = PlayerFrame

local gravityBox = Instance.new("TextBox")
gravityBox.Size = UDim2.new(0, 200, 0, 30)
gravityBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
gravityBox.Text = tostring(workspace.Gravity)
gravityBox.TextColor3 = Color3.fromRGB(255, 255, 255)
gravityBox.Font = Enum.Font.Gotham
gravityBox.TextSize = 14
gravityBox.ClearTextOnFocus = false
gravityBox.PlaceholderText = "Enter gravity"
gravityBox.LayoutOrder = 8
gravityBox.Parent = PlayerFrame
makeRounded(gravityBox, 6)

addSpacer(9)

local function setGravity(amount)
	amount = tonumber(amount)
	if amount and amount >= 0 and amount <= 10000 then
		workspace.Gravity = amount
	end
end

gravityBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		setGravity(gravityBox.Text)
	end
end)

-- Teleport to Display Name
local tpLabel = Instance.new("TextLabel")
tpLabel.Size = UDim2.new(0, 200, 0, 20)
tpLabel.BackgroundTransparency = 1
tpLabel.Text = "Teleport to Display Name:"
tpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
tpLabel.Font = Enum.Font.Gotham
tpLabel.TextSize = 14
tpLabel.TextXAlignment = Enum.TextXAlignment.Left
tpLabel.LayoutOrder = 10
tpLabel.Parent = PlayerFrame

local tpBox = Instance.new("TextBox")
tpBox.Size = UDim2.new(0, 200, 0, 30)
tpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpBox.Text = ""
tpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBox.Font = Enum.Font.Gotham
tpBox.TextSize = 14
tpBox.ClearTextOnFocus = false
tpBox.PlaceholderText = "Type a display name..."
tpBox.LayoutOrder = 11
tpBox.Parent = PlayerFrame
makeRounded(tpBox, 6)

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0, 200, 0, 30)
tpButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
tpButton.Text = "🚀 Teleport to Player"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Font = Enum.Font.Gotham
tpButton.TextSize = 14
tpButton.LayoutOrder = 12
tpButton.Parent = PlayerFrame
makeRounded(tpButton, 6)

tpButton.MouseButton1Click:Connect(function()
	local inputName = tpBox.Text:lower()
	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.DisplayName:lower() == inputName and plr ~= LocalPlayer then
			local targetChar = plr.Character
			local myChar = LocalPlayer.Character

			if targetChar and targetChar:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
				myChar:MoveTo(targetChar.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
				print("✅ Teleported to " .. plr.DisplayName)
			else
				warn("❌ Could not find player or their character.")
			end
			break
		end
	end
end)



-- 🎨 Visual Tab (Scrollable + Ordered Buttons)
local VisualFrame = Instance.new("ScrollingFrame")
VisualFrame.Name = "VisualFrame"
VisualFrame.Size = UDim2.new(1, 0, 1, 0)
VisualFrame.CanvasSize = UDim2.new(0, 0, 0, 200) -- Expand as needed
VisualFrame.ScrollBarThickness = 4
VisualFrame.BackgroundTransparency = 1
VisualFrame.Visible = false
VisualFrame.Parent = contentFrame
makeRounded(VisualFrame, 10)

-- Layout for vertical stacking
local visualLayout = Instance.new("UIListLayout")
visualLayout.Padding = UDim.new(0, 6)
visualLayout.SortOrder = Enum.SortOrder.LayoutOrder
visualLayout.Parent = VisualFrame

-- Optional padding
local visualPadding = Instance.new("UIPadding")
visualPadding.PaddingTop = UDim.new(0, 10)
visualPadding.PaddingLeft = UDim.new(0, 20)
visualPadding.Parent = VisualFrame

-- 💀 Spin and Die Button (softer fling)
local spinDieBtn = Instance.new("TextButton")
spinDieBtn.Size = UDim2.new(0, 200, 0, 30)
spinDieBtn.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
spinDieBtn.Text = "💀 Spin & Explode"
spinDieBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spinDieBtn.Font = Enum.Font.Gotham
spinDieBtn.TextSize = 14
spinDieBtn.LayoutOrder = 1
spinDieBtn.Parent = VisualFrame
makeRounded(spinDieBtn, 6)

spinDieBtn.MouseButton1Click:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- Soft fling
	hrp.Velocity = Vector3.new(10, 20, 10)

	-- Spin effect
	local spin = Instance.new("BodyAngularVelocity")
	spin.AngularVelocity = Vector3.new(0, 100, 0)
	spin.MaxTorque = Vector3.new(1, 1, 1) * 100000
	spin.P = 1000
	spin.Parent = hrp

	-- Ragdoll-like stumble
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end

	-- Kill after 2 seconds
	task.delay(2, function()
		spin:Destroy()
		if humanoid then
			humanoid.Health = 0
		end
	end)
end)

-- 📍 Target Name Input
local missileInput = Instance.new("TextBox")
missileInput.Size = UDim2.new(0, 200, 0, 30)
missileInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
missileInput.Text = ""
missileInput.PlaceholderText = "Display Name..."
missileInput.TextColor3 = Color3.fromRGB(255, 255, 255)
missileInput.Font = Enum.Font.Gotham
missileInput.TextSize = 14
missileInput.LayoutOrder = 5
missileInput.ClearTextOnFocus = false
missileInput.Parent = VisualFrame
makeRounded(missileInput, 6)

-- 🚀 Missile Button
local missileLaunchBtn = Instance.new("TextButton")
missileLaunchBtn.Size = UDim2.new(0, 200, 0, 30)
missileLaunchBtn.BackgroundColor3 = Color3.fromRGB(20, 100, 200)
missileLaunchBtn.Text = "🚀 Missile Launch"
missileLaunchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
missileLaunchBtn.Font = Enum.Font.Gotham
missileLaunchBtn.TextSize = 14
missileLaunchBtn.LayoutOrder = 6
missileLaunchBtn.Parent = VisualFrame
makeRounded(missileLaunchBtn, 6)

missileLaunchBtn.MouseButton1Click:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not root or not humanoid then return end

	local inputName = missileInput.Text:lower()
	local target = nil

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.DisplayName:lower() == inputName then
			target = plr
			break
		end
	end

	if not target or not target.Character or not target.Character:FindFirstChild("Head") then
		warn("Target not found")
		return
	end

	-- Spin in place for 2 seconds
	local spin = Instance.new("BodyAngularVelocity")
	spin.AngularVelocity = Vector3.new(0, 20, 0)
	spin.MaxTorque = Vector3.new(0, math.huge, 0)
	spin.P = 1000
	spin.Parent = root

	task.wait(2)
	spin:Destroy()

	-- Lift upward
	local lift = Instance.new("BodyVelocity")
	lift.Velocity = Vector3.new(0, 55, 0)
	lift.MaxForce = Vector3.new(0, math.huge, 0)
	lift.P = 10000
	lift.Parent = root
	task.wait(1.25)
	lift:Destroy()

	-- Pause mid-air
	local pause = Instance.new("BodyPosition")
	pause.Position = root.Position
	pause.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	pause.P = 30000
	pause.Parent = root

	task.wait(0.5)

	-- Ragdoll and rotate to face head-first toward target
	if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Physics) end
	local direction = (target.Character.Head.Position - root.Position).Unit
	local look = CFrame.lookAt(root.Position, root.Position + direction) * CFrame.Angles(math.rad(90), 0, 0)
	root.CFrame = look

	task.wait(0.3)
	pause:Destroy()

	-- Dynamic homing
	local homing = true
	local followLoop

	followLoop = game:GetService("RunService").Heartbeat:Connect(function()
		if not homing or not target.Character or not target.Character:FindFirstChild("Head") then
			followLoop:Disconnect()
			return
		end

		local toTarget = (target.Character.Head.Position - root.Position)
		local distance = toTarget.Magnitude

		-- If close enough to target, stop and free
		if distance <= 5 then
			homing = false
			followLoop:Disconnect()
			root.Velocity = Vector3.zero
			if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
			return
		end

		root.Velocity = toTarget.Unit * 300
	end)
end)


-- 🎙️ Voice Chat Controls (with fixes & scrollable)
local VoiceChatFrame = Instance.new("ScrollingFrame")
VoiceChatFrame.Name = "VoiceChatFrame"
VoiceChatFrame.Size = UDim2.new(1, 0, 1, 0)
VoiceChatFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
VoiceChatFrame.ScrollBarThickness = 4
VoiceChatFrame.BackgroundTransparency = 1
VoiceChatFrame.Visible = false
VoiceChatFrame.Parent = contentFrame
makeRounded(VoiceChatFrame, 10)

local vcLayout = Instance.new("UIListLayout")
vcLayout.Padding = UDim.new(0, 8)
vcLayout.SortOrder = Enum.SortOrder.LayoutOrder
vcLayout.Parent = VoiceChatFrame

local vcPadding = Instance.new("UIPadding")
vcPadding.PaddingTop = UDim.new(0, 10)
vcPadding.PaddingLeft = UDim.new(0, 20)
vcPadding.Parent = VoiceChatFrame

-- Title Label
local vcTitle = Instance.new("TextLabel")
vcTitle.Size = UDim2.new(1, -20, 0, 30)
vcTitle.BackgroundTransparency = 1
vcTitle.Text = "Voice Chat Tab"
vcTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
vcTitle.Font = Enum.Font.GothamBold
vcTitle.TextSize = 16
vcTitle.TextXAlignment = Enum.TextXAlignment.Left
vcTitle.LayoutOrder = 0
vcTitle.Parent = VoiceChatFrame

-- 🔓 Rejoin VC Button (Raw, No Wrappers)
local unbanVCBtn = Instance.new("TextButton")
unbanVCBtn.Size = UDim2.new(0, 200, 0, 35)
unbanVCBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
unbanVCBtn.Text = "🔓 Rejoin Voice Chat"
unbanVCBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unbanVCBtn.Font = Enum.Font.Gotham
unbanVCBtn.TextSize = 14
unbanVCBtn.LayoutOrder = 1
unbanVCBtn.Parent = VoiceChatFrame
makeRounded(unbanVCBtn, 6)

unbanVCBtn.MouseButton1Click:Connect(function()
	shouldRejoinVC = true
end)


-- 🔴 Disconnect VC Button
local disconnectVCBtn = Instance.new("TextButton")
disconnectVCBtn.Size = UDim2.new(0, 200, 0, 35)
disconnectVCBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
disconnectVCBtn.Text = "🔴 Disconnect from Voice Chat"
disconnectVCBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
disconnectVCBtn.Font = Enum.Font.Gotham
disconnectVCBtn.TextSize = 14
disconnectVCBtn.LayoutOrder = 2
disconnectVCBtn.Parent = VoiceChatFrame
makeRounded(disconnectVCBtn, 6)

disconnectVCBtn.MouseButton1Click:Connect(function()
	local success, result = pcall(function()
		game:GetService("VoiceChatService"):Leave()
	end)
	if success then
		print("✅ Disconnected from VC.")
	else
		warn("❌ Failed to disconnect from VC:", result)
	end
end)


-- 🎥 Camera Spy
local cam = workspace.CurrentCamera
local originalCamCF = cam.CFrame
local spyCamActive = false
local spyConnection = nil

-- Static Overlay (fallback with noise texture)
local staticOverlay = Instance.new("Frame")
staticOverlay.Name = "StaticOverlay"
staticOverlay.Size = UDim2.new(1, 0, 1, 0)
staticOverlay.Position = UDim2.new(0, 0, 0, 0)
staticOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
staticOverlay.BackgroundTransparency = 0.2
staticOverlay.Visible = false
staticOverlay.ZIndex = 9999
staticOverlay.Parent = game:GetService("CoreGui")

-- Add fallback static noise pattern
local noise = Instance.new("ImageLabel")
noise.Size = UDim2.new(1, 0, 1, 0)
noise.Position = UDim2.new(0, 0, 0, 0)
noise.BackgroundTransparency = 1
noise.ImageTransparency = 0
noise.Image = "rbxassetid://15988137208" -- Fallback noise texture
noise.ZIndex = 9999
noise.Parent = staticOverlay

-- Toggle Static Button
local toggleStaticBtn = Instance.new("TextButton")
toggleStaticBtn.Size = UDim2.new(0, 200, 0, 30)
toggleStaticBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleStaticBtn.Text = "📺 Toggle Static Overlay"
toggleStaticBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleStaticBtn.Font = Enum.Font.Gotham
toggleStaticBtn.TextSize = 14
toggleStaticBtn.LayoutOrder = 7
toggleStaticBtn.Parent = VoiceChatFrame
makeRounded(toggleStaticBtn, 6)

toggleStaticBtn.MouseButton1Click:Connect(function()
	staticOverlay.Visible = not staticOverlay.Visible
	print("🔁 Static overlay toggled to", staticOverlay.Visible)
end)

local camSpyNameLabel = Instance.new("TextLabel")
camSpyNameLabel.Size = UDim2.new(0, 200, 0, 20)
camSpyNameLabel.BackgroundTransparency = 1
camSpyNameLabel.Text = "Camera Spy Display Name:"
camSpyNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
camSpyNameLabel.Font = Enum.Font.Gotham
camSpyNameLabel.TextSize = 14
camSpyNameLabel.TextXAlignment = Enum.TextXAlignment.Left
camSpyNameLabel.LayoutOrder = 3
camSpyNameLabel.Parent = VoiceChatFrame

local camSpyBox = Instance.new("TextBox")
camSpyBox.Size = UDim2.new(0, 200, 0, 30)
camSpyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
camSpyBox.Text = ""
camSpyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
camSpyBox.Font = Enum.Font.Gotham
camSpyBox.TextSize = 14
camSpyBox.ClearTextOnFocus = false
camSpyBox.PlaceholderText = "Type their display name..."
camSpyBox.LayoutOrder = 4
camSpyBox.Parent = VoiceChatFrame
makeRounded(camSpyBox, 6)

local startSpyCamBtn = Instance.new("TextButton")
startSpyCamBtn.Size = UDim2.new(0, 200, 0, 30)
startSpyCamBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
startSpyCamBtn.Text = "🎥 Start Camera Spy"
startSpyCamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startSpyCamBtn.Font = Enum.Font.Gotham
startSpyCamBtn.TextSize = 14
startSpyCamBtn.LayoutOrder = 5
startSpyCamBtn.Parent = VoiceChatFrame
makeRounded(startSpyCamBtn, 6)

local stopSpyCamBtn = Instance.new("TextButton")
stopSpyCamBtn.Size = UDim2.new(0, 200, 0, 30)
stopSpyCamBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
stopSpyCamBtn.Text = "🔁 Return to Self"
stopSpyCamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopSpyCamBtn.Font = Enum.Font.Gotham
stopSpyCamBtn.TextSize = 14
stopSpyCamBtn.LayoutOrder = 6
stopSpyCamBtn.Parent = VoiceChatFrame
makeRounded(stopSpyCamBtn, 6)

startSpyCamBtn.MouseButton1Click:Connect(function()
	local displayName = camSpyBox.Text:lower()
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= LocalPlayer and player.DisplayName:lower() == displayName then
			local char = player.Character
			local head = char and char:FindFirstChild("Head")
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if head and root then
				originalCamCF = cam.CFrame
				spyCamActive = true

				cam.CameraType = Enum.CameraType.Scriptable
				cam.FieldOfView = 95

				if spyConnection then spyConnection:Disconnect() end
				spyConnection = game:GetService("RunService").RenderStepped:Connect(function()
					if player.Character and head and root then
						local lookVec = (head.CFrame.LookVector + root.CFrame.LookVector).Unit
						local camPos = head.Position - lookVec * 5 + Vector3.new(0, 2.5, 0)
						local bob = math.sin(tick() * 3) * 0.15
						camPos = camPos + Vector3.new(0, bob, 0)
						local focus = head.Position + lookVec * 10
						cam.CFrame = CFrame.new(camPos, focus)
					end
				end)

				print("🎥 Camera spy started on", player.DisplayName)
				break
			end
		end
	end
end)

stopSpyCamBtn.MouseButton1Click:Connect(function()
	if spyCamActive then
		spyCamActive = false
		if spyConnection then
			spyConnection:Disconnect()
			spyConnection = nil
		end
		cam.CameraType = Enum.CameraType.Custom
		cam.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
		print("🔁 Returned camera to self")
	end
end)


-- settings
local SettingsFrame = createTabFrame("Settings", "Settings Tab")
mainFrame.ClipsDescendants = true
contentFrame.ClipsDescendants = true

local dexButton = Instance.new("TextButton")
dexButton.Size = UDim2.new(0, 200, 0, 35)
dexButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
dexButton.Text = "🧠 Open World Explorer"
dexButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dexButton.Font = Enum.Font.Gotham
dexButton.TextSize = 14
dexButton.LayoutOrder = 10
dexButton.Parent = VisualFrame
makeRounded(dexButton, 6)

dexButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"))()
end)

local CreditsFrame = createTabFrame("Credits", "Credits Tab")
mainFrame.ClipsDescendants = true
contentFrame.ClipsDescendants = true


-- Add credit labels
local creditsText = Instance.new("TextLabel")
creditsText.Size = UDim2.new(1, -40, 0, 30)
creditsText.Position = UDim2.new(0, 20, 0, 50)
creditsText.BackgroundTransparency = 1
creditsText.Text = "Made by Hayden"
creditsText.TextColor3 = Color3.fromRGB(200, 200, 200)
creditsText.Font = Enum.Font.Gotham
creditsText.TextSize = 14
creditsText.TextXAlignment = Enum.TextXAlignment.Left
creditsText.Parent = CreditsFrame

local creditsNote = Instance.new("TextLabel")
creditsNote.Size = UDim2.new(1, -40, 0, 30)
creditsNote.Position = UDim2.new(0, 20, 0, 80)
creditsNote.BackgroundTransparency = 1
creditsNote.Text = "💬 Type '!admin' in chat to unlock the admin panel."
creditsNote.TextColor3 = Color3.fromRGB(200, 200, 200)
creditsNote.Font = Enum.Font.Gotham
creditsNote.TextSize = 14
creditsNote.TextXAlignment = Enum.TextXAlignment.Left
creditsNote.Parent = CreditsFrame

-- Tab switching
for tabName, button in pairs(tabButtons) do
	button.MouseButton1Click:Connect(function()
		for _, child in ipairs(contentFrame:GetChildren()) do
			if child:IsA("Frame") or child:IsA("ScrollingFrame") then -- ✅ hides both
				child.Visible = false
			end
		end
		local welcome = contentFrame:FindFirstChild("WelcomeFrame")
		if welcome then
			welcome.Visible = false
		end
		local tabFrame = contentFrame:FindFirstChild(tabName .. "Frame")
		if tabFrame then
			tabFrame.Visible = true
		end
	end)
end


-- 🔐 Admin Panel (hidden unless !admin is typed)
local AdminFrame = Instance.new("Frame")
AdminFrame.Name = "AdminFrame"
AdminFrame.Size = UDim2.new(1, 0, 1, 0)
AdminFrame.BackgroundTransparency = 0
AdminFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
AdminFrame.Visible = false
AdminFrame.Parent = contentFrame
makeRounded(AdminFrame, 10)

local adminTitle = Instance.new("TextLabel")
adminTitle.Size = UDim2.new(1, 0, 0, 40)
adminTitle.Position = UDim2.new(0, 0, 0, 0)
adminTitle.BackgroundTransparency = 1
adminTitle.Text = "🔧 Admin Panel"
adminTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
adminTitle.Font = Enum.Font.GothamBold
adminTitle.TextSize = 18
adminTitle.Parent = AdminFrame

local adminMsg = Instance.new("TextLabel")
adminMsg.Size = UDim2.new(1, -40, 0, 30)
adminMsg.Position = UDim2.new(0, 20, 0, 50)
adminMsg.BackgroundTransparency = 1
adminMsg.Text = "Admin tools will go here soon..."
adminMsg.TextColor3 = Color3.fromRGB(200, 200, 200)
adminMsg.Font = Enum.Font.Gotham
adminMsg.TextSize = 14
adminMsg.TextXAlignment = Enum.TextXAlignment.Left
adminMsg.Parent = AdminFrame

-- 💬 Listen for !admin in chat
LocalPlayer.Chatted:Connect(function(msg)
	if msg:lower() == "!admin" then
		for _, frame in ipairs(contentFrame:GetChildren()) do
			if frame:IsA("Frame") then
				frame.Visible = false
			end
		end
		local welcome = contentFrame:FindFirstChild("WelcomeFrame")
		if welcome then
			welcome.Visible = false
		end
		AdminFrame.Visible = true
	end
end)

-- 🔘 Minimize button functionality
local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	for _, child in pairs(mainFrame:GetChildren()) do
		if child ~= topBar then
			child.Visible = not isMinimized
		end
	end
end)

-- ❌ Close button functionality
closeBtn.MouseButton1Click:Connect(function()
	ScreenGui.Enabled = false
end)

-- 🎹 Toggle GUI with "K" key
local guiToggled = true
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.K then
		guiToggled = not guiToggled
		ScreenGui.Enabled = guiToggled
	end
end)

-- Resize corner handle
local resizeCorner = Instance.new("TextButton")
resizeCorner.Size = UDim2.new(0, 15, 0, 15)
resizeCorner.Position = UDim2.new(1, -15, 1, -15)
resizeCorner.BackgroundColor3 = Color3.fromRGB(100,100,100)
resizeCorner.BorderSizePixel = 0
resizeCorner.Text = ""
resizeCorner.Parent = mainFrame

local resizing = false
local lastMousePos
local lastFrameSize

resizeCorner.MouseButton1Down:Connect(function()
	resizing = true
	lastMousePos = UIS:GetMouseLocation()
	lastFrameSize = mainFrame.Size
end)

UIS.InputChanged:Connect(function(input)
	if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = UIS:GetMouseLocation() - lastMousePos
		mainFrame.Size = UDim2.new(
			0, math.max(300, lastFrameSize.X.Offset + delta.X),
			0, math.max(150, lastFrameSize.Y.Offset + delta.Y)
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		resizing = false
	end
end)
