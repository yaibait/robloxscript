if not game:IsLoaded() then
    game.Loaded:Wait()
end
-- game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")
--rconsoleprint(test)
-- game:GetService("Players").LocalPlayer.PlayerGui.Main.Inventory.Visible = true
wait(60)
repeat
	userData = {}
	inven = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
	abiliti = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
	--inventoryFruits = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryFruits")
    ---
	local bounty = 0
	if game.Players.LocalPlayer:FindFirstChild("leaderstats") then 
		local leaderstats = game.Players.LocalPlayer.leaderstats
		local bountyHonor = leaderstats:FindFirstChild("Bounty/Honor")
	
		if bountyHonor then
			-- The "Bounty/Honor1" attribute exists
			bounty = bountyHonor.Value
		else
			-- The "Bounty/Honor1" attribute is nil or doesn't exist
			-- Handle this scenario accordingly
			print("Bounty/Honor1 is nil or doesn't exist")
		end
	end
    currentMelee = {}
	local equipped = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if equipped then
		print(equipped.Name)
		table.insert(currentMelee,equipped.Name)
	end
    for k,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
		print(v.Name)
        table.insert(currentMelee,v.Name)
    end
    ---
	beli = game:GetService("Players")["LocalPlayer"].Data.Beli.Value
	fragments = game:GetService("Players")["LocalPlayer"].Data.Fragments.Value
	level = game:GetService("Players")["LocalPlayer"].Data.Level.Value
	name = game:GetService("Players")["LocalPlayer"].Name
	userData["Inventory"] = inven
	userData["Beli"] = beli
	userData["Fragments"] = fragments
	userData["Level"] = level
	userData["Ability"] = abiliti
	userData["Account"] = name
    userData["Backpack"] = currentMelee
	userData["Bounty"] = bounty
	local response = request(
		{
			--http://mmocms.bi/api/updateAccoutInfo
			Url = "https://robloxpanel.vietblox.com/api/updateAccoutInfo",  -- This website helps debug HTTP requests
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"  -- When sending JSON, set this!
			},
			Body = game:GetService("HttpService"):JSONEncode(userData)
		}
	)
	wait(60)
until false
