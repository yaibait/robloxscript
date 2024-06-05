getgenv().Key = "" 
getgenv().EquipMacroTroop = true
getgenv().ImportMacro = "https://cdn.discordapp.com/attachments/1243117652084260894/1246359369377906730/dwad.txt?ex=6660b75d&is=665f65dd&hm=4d75ce9174d528d800af83be032d0b1b8b865e7a2c27c240d03d3e3eeb748077&"
getgenv().Config = {
    ["SelectChapter"] = "Chapter1",
    ["AutoReplay"] = true,
    ["WH_MatchComplete"] = true,
    ["AutoSkip"] = true,
    ["SelectWorld"] = "Windmill Village",
    ["TPLobbyIfPlayer"] = true,
    ["AutoJoinWorld"] = true,
    ["IgnoreMacroTiming"] = true,
    ["SelectMacro"] = "dwad",
    ["AutoRejoin"] = true,
    ["PlayMacro"] = true,
    ["WebhookURL"] = "",
    ["AutoSave"] = true,
    ["BoostFPS"] = true,
    ["AutoLeave"] = true
}
loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
