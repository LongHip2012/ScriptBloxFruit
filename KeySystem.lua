local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AEMDxLongHip/ScriptBloxFruit/main/KeySystemGui.lua')))()')))() --This Will Load The Script Code
local Player = game.Players.LocalPlayer --This Will Reveal The Player Name
  local Window = OrionLib:MakeWindow({
		Name = "Key System",
		HidePremium = false,
		SaveConfig = true,
		ConfigFolder = "OrionTest",
        IntroText = "Loading Script..."       
}) --This Will Load The Script Hub

function MakeScriptHub()
         loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/GhostHub'))() --Put The Script That Will Load If The Key Is Correct Here
end

OrionLib:MakeNotification({
	Name = "Logged In!",
	Content = "You need key "..Player.Name..".",
	Image = "rbxassetid://4483345998",
	Time = 5
}) --Notification

getgenv().Key = "Genshin_W82bspw0zn6eiav" --Put The Correct Key Here
getgenv().Key = "Admin_Long08092012" --Put The Correct Key Here
getgenv().Key = "Admin2_Aether08092012" --Put The Correct Key Here
getgenv().KeyInput = "string" --Require For The Key To Work

local Tab = Window:MakeTab({
	Name = "Key System",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
}) --Making A Tab

Tab:AddTextbox({
	Name = "Input Key Here",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		getgenv().KeyInput = Value
	end	  
}) --You Will Enter The Key Here

Tab:AddButton({
    Name = "Check Key",
    Callback = function()
        if getgenv().KeyInput == getgenv().Key then
            OrionLib:MakeNotification({
                Name = "Checking Key",
                Content = "Checking The Key You Entered",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            wait(2)
            OrionLib:MakeNotification({
                Name = "Correct Key!",
                Content = "The key you entered is Correct.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            wait(1)
            OrionLib:Destroy()
            wait(.3)
            MakeScriptHub()
        else
           OrionLib:MakeNotification({
                Name = "Checking Key",
                Content = "Checking The Key You Entered",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            wait(2)
            OrionLib:MakeNotification({
                Name = "Incorrect Key!",
                Content = "The key you entered is incorrect.",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
    end
}) --This Will Check The Key You Entered

Tab:AddButton({
	Name = "Copy Key",
	Callback = function()
      		setclipboard("https://sites.google.com/view/genshinkeysystem") --This Will Copy The Link Of The Key
  	end    
}) 
    
OrionLib:Init() --Require If The Script Is Done


Video: https://youtu.be/6Vb7M5YMWck?si=hrxzqilspfBDe1ja
            