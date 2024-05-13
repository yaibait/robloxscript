-- // Globals
local ReS = game:GetService("ReplicatedStorage")
local RuS = game:GetService("RunService")
local TeS = game:GetService("TeleportService")
local Http = game:GetService("HttpService")
local Plyrs = game:GetService("Players")
-- // Locals
local Plyr ; local Lib
repeat RuS.Heartbeat:Wait()
    Plyr = Plyrs.LocalPlayer
    Lib = require(ReS.Library)
until (Plyr and Lib) ~= nil

local Active ; local Entrance
repeat RuS.Heartbeat:Wait()
    Active = workspace.__THINGS.__INSTANCE_CONTAINER.Active
    Entrance = workspace.__THINGS.Instances.Backrooms.Teleports.Enter
until (Active and Entrance) ~= nil and Entrance.BrickColor == BrickColor.new("Sand blue metallic")

local Hrp = Plyr.Character.HumanoidRootPart ; Hrp.CFrame = Entrance.CFrame ; local Spawn
repeat RuS.Heartbeat:Wait()
    pcall(function() Spawn = Active.Backrooms.GeneratedBackrooms.SpawnRoom end)
until Spawn ~= nil

local Exec = tick() ; local Rooms = {} ; local Counter = 0 ; local Claimed = 0
for _,room in workspace.__THINGS.__INSTANCE_CONTAINER.Active.Backrooms.GeneratedBackrooms:GetChildren() do
    local Reward = room:FindFirstChild("RandomReward")
    local UID = room:GetAttribute("RoomUID")
    if Reward and (Reward.Animated.Top.Transparency and Reward.Animated.Bottom.Transparency) ~= 1 then
        Counter = Counter + 1
        if not Rooms[UID] then
            Rooms[UID] = room
        end
    end
end

workspace.__THINGS.__INSTANCE_CONTAINER.Active.Backrooms.GeneratedBackrooms.ChildAdded:Connect(function(room)
    local Reward = room:FindFirstChild("RandomReward")
    local UID = room:GetAttribute("RoomUID")
    if Reward and (Reward.Animated.Top.Transparency and Reward.Animated.Bottom.Transparency) ~= 1 then
        if not Rooms[UID] then
            Rooms[UID] = room
        end
    end
end)

print("Initially Found x"..tostring(Counter), "RandomRewards")

while next(Rooms) do task.wait()
    for _,room in Rooms do
        local Reward = room:FindFirstChild("RandomReward")
        local UID = room:GetAttribute("RoomUID")
        if Reward and (Reward.Animated.Top.Transparency and Reward.Animated.Bottom.Transparency) ~= 1 then
            local start = tick()
            repeat task.wait(.3)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = room.RandomReward.Main.CFrame
                local Success,Reason = Lib.Network.Invoke("Instancing_InvokeCustomFromClient", "Backrooms", "AbstractRoom_InvokeServer", room:GetAttribute("RoomUID"), "ClaimRandomReward", Reward)
            until Success or not Success and Reason ~= "You are claiming this too fast!"
            Claimed = Claimed + 1
            print("Claimed "..tostring(Claimed).."x Rewards in "..tostring(tick() - start).."s, in serv for "..tostring(tick() - Exec).."s")
            Rooms[UID] = nil
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end)
        end
    end
end
