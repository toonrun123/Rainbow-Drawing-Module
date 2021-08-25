--[[ 
===================================
OPEN SOURCE RAINBOW DRAWING.
toonrun123V2. || 8/24/2021.
===================================
]]

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Env = script.Parent:WaitForChild("env")
local sinModule = require(script:WaitForChild("SineWave"))
local Mouse:Mouse = game.Players.LocalPlayer:GetMouse()
local EnabledDrawing = false

local sin:sinModule.sinself = sinModule:new(0,2,0,50,0)

local info = TweenInfo.new(0.2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,0,false,0)

local t = 5

script.Parent.MouseButton1Down:Connect(function()
	EnabledDrawing = true
end)

script.Parent.MouseButton1Click:Connect(function()
	EnabledDrawing = false
end)

function Draw(Position2:Vector2,DoubleY:number,DefaultFix:boolean,TweenDraw:boolean,CustomColor:Color3)
	if rawequal(DefaultFix,nil) then
		DefaultFix = true
	end
	TweenDraw = TweenDraw or false
	DoubleY = DoubleY or 0
	local hue = ((Position2.X-script.Parent.AbsolutePosition.X)/script.Parent.AbsolutePosition.X/2) % t / t
	local color = Color3.fromHSV(hue,1, 1)
	local DrawFrame:Frame = Instance.new("Frame",Env)
	local UIcornor:UICorner = Instance.new("UICorner",DrawFrame)
	UIcornor.CornerRadius = UDim.new(0,665)
	DrawFrame.AnchorPoint = Vector2.new(0.5,0.5)
	if DefaultFix then
		DrawFrame.Position = UDim2.new(0,Position2.X-script.Parent.AbsolutePosition.X,0,Position2.Y+DoubleY)
	else 
		DrawFrame.Position = UDim2.new(0,Position2.X,0,Position2.Y+DoubleY)
	end
	DrawFrame.Size = UDim2.new(0,0,0,0)
	DrawFrame.Selectable = false
	if CustomColor then
		DrawFrame.BackgroundColor3 = CustomColor
	else 
		DrawFrame.BackgroundColor3 = color
	end
	if TweenDraw then
		TweenService:Create(DrawFrame,info,{Size = UDim2.new(0,31,0,31)}):Play()
	else 
		DrawFrame.Size = UDim2.new(0,31,0,31)
	end
end

function MiddleLine()
	local Middle = script.Parent.AbsoluteSize.Y/2
	for X = 1,script.Parent.AbsoluteSize.X do
		Draw(Vector3.new(X,Middle),0,false,false)
	end
end

function MakeSinWave(doublesin:number)
	script.Parent:WaitForChild("env"):ClearAllChildren()
	local Middle = script.Parent.AbsoluteSize.Y/2
	local UpHalfMiddle = Middle+doublesin
	local DownHalfMiddle = Middle-doublesin
	sinModule["b"] = doublesin
	for X = 1,script.Parent.AbsoluteSize.X do
		sinModule["x"] = X
		local Y = (sinModule:wave())*sinModule["b"]
		Draw(Vector3.new(X,Y),Middle,false,false)
	end
end

_G["TempDrawConnection"] = RunService.RenderStepped:Connect(function()
	if EnabledDrawing then
		Draw(Vector2.new(Mouse.X,Mouse.Y),nil,true,true)
	end
end)