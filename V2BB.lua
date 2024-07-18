

print('Thanks for using our new Script')
setfpscap(165)

local Stats = game:GetService('Stats')
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Nurysium_Util = loadstring(game:HttpGet('https://raw.githubusercontent.com/flezzpe/Nurysium/main/nurysium_helper.lua'))()

local local_player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local nurysium_Data = nil
local hit_Sound = nil

local closest_Entity = nil
local parry_remote = nil

getgenv().aura_Enabled = false
getgenv().hit_sound_Enabled = false
getgenv().hit_effect_Enabled = false
getgenv().night_mode_Enabled = false
getgenv().trail_Enabled = false
getgenv().self_effect_Enabled = false

local Services = {
    game:GetService('AdService'),
    game:GetService('SocialService')
}

-- Shop Fractions

function SwordCrateManual()
game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalSwordCrate)
end

function ExplosionCrateManual()
game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalExplosionCrate)
end

function SwordCrateAuto()
while _G.AutoSword do
game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalSwordCrate)
wait(1)
end
end

function ExplosionCrateAuto()
while _G.AutoBoom do
game:GetService("ReplicatedStorage").Remote.RemoteFunction:InvokeServer("PromptPurchaseCrate", workspace.Spawn.Crates.NormalExplosionCrate)
wait(1)
end
end

-- Ui Library

local  Library = loadstring(game:HttpGet("https://pastebin.com/raw/vff1bQ9F"))()
local Window = Library.CreateLib("Genshin Hub's Return", "DarkTheme")

local Tab = Window:NewTab("Combat")
local Tab2 = Window:NewTab("Shop")
local Tab3 = Window:NewTab("World/Misc")
local Combat = Tab:NewSection("Combat")
local Shop = Tab2:NewSection("Shop")
local World = Tab3:NewSection("World")

function initializate(dataFolder_name: string)
    local nurysium_Data = Instance.new('Folder', game:GetService('CoreGui'))
    nurysium_Data.Name = dataFolder_name

    hit_Sound = Instance.new('Sound', nurysium_Data)
    hit_Sound.SoundId = 'rbxassetid://8632670510'
    hit_Sound.Volume = 5
end

local function get_closest_entity(Object: Part)
    task.spawn(function()
        local closest
        local max_distance = math.huge

        for index, entity in workspace.Alive:GetChildren() do
            if entity.Name ~= Players.LocalPlayer.Name then
                local distance = (Object.Position - entity.HumanoidRootPart.Position).Magnitude

                if distance < max_distance then
                    closest_Entity = entity
                    max_distance = distance
                end

            end
        end

        return closest_Entity
    end)
end

--// Thanks Aries for this.
function resolve_parry_Remote()
    for _, value in Services do
        local temp_remote = value:FindFirstChildOfClass('RemoteEvent')

        if not temp_remote then
            continue
        end

        if not temp_remote.Name:find('\n') then
            continue
        end

        parry_remote = temp_remote
    end
end

local aura_table = {
    canParry = true,
    is_Spamming = false,

    parry_Range = 0,
    spam_Range = 0,  
    hit_Count = 0,

    hit_Time = tick(),
    ball_Warping = tick(),
    is_ball_Warping = false
}

ReplicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
    if getgenv().hit_sound_Enabled then
        hit_Sound:Play()
    end

    if getgenv().hit_effect_Enabled then
        local hit_effect = game:GetObjects("rbxassetid://17407244385")[1]

        hit_effect.Parent = Nurysium_Util.getBall()
        hit_effect:Emit(3)

        task.delay(5, function()
            hit_effect:Destroy()
        end)

    end
end)

ReplicatedStorage.Remotes.ParrySuccessAll.OnClientEvent:Connect(function()
    aura_table.hit_Count += 1

    task.delay(0.15, function()
        aura_table.hit_Count -= 1
    end)
end)

workspace:WaitForChild("Balls").ChildRemoved:Connect(function(child)
    aura_table.hit_Count = 0
    aura_table.is_ball_Warping = false
    aura_table.is_Spamming = false
end)

Combat:NewToggle("Auto Parry", "", function(toggled)
    resolve_parry_Remote()
    getgenv().aura_Enabled = toggled
end)

Combat:NewToggle("Minecraft Hit FX", "ToggleInfo", function(toggled)
    getgenv().hit_sound_Enabled = toggled
end)

Combat:NewToggle("Hit Effect", "ToggleInfo", function(toggled)
    getgenv().hit_effect_Enabled = toggled
end)

Shop:NewButton("SwordCrate", "ButtonInfo", function()

SwordCrateManual()
    print("Clicked")
end)

Shop:NewButton("ExplosionCrate", "ButtonInfo", function()

ExplosionCrateManual()
    print("Clicked")
end)

World:NewToggle("Night Mode", "ToggleInfo", function(toggled)
    getgenv().night_mode_Enabled = toggled
end)

World:NewToggle("Trail", "ToggleInfo", function(toggled)
    getgenv().trail_Enabled = toggled
end)

World:NewToggle("Destroy Particles", "ToggleInfo", function(toggled)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/Destroy%20Particle%20Emitters",true))()
end)

World:NewToggle("AntiLag", "ToggleInfo", function(toggled)
-- Made by RIP#6666
_G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
    ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
    ["No Explosions"] = true, -- Makes Explosion's invisible
    ["No Clothes"] = true, -- Removes Clothing from the game
    ["Low Water Graphics"] = true, -- Removes Water Quality
    ["No Shadows"] = true, -- Remove Shadows
    ["Low Rendering"] = true, -- Lower Rendering
    ["Low Quality Parts"] = true -- Lower quality parts
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
end)

World:NewToggle("Aiming Mechanism", "ToggleInfo", function(toggled)   loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/M%3ABlade%20Ball%20Mechanism",true))()
end)

World:NewToggle("Antiafk", "ToggleInfo", function(toggled)    loadstring(game:HttpGet(('https://raw.githubusercontent.com/Proxylol/OtherScripts/main/AntiAfk.lua'),true))()
end)

--// trail

task.defer(function()
    game:GetService("RunService").Heartbeat:Connect(function()

        if not local_player.Character then
            return
        end

        if getgenv().trail_Enabled then
            local trail = game:GetObjects("rbxassetid://17483658369")[1]

            trail.Name = 'nurysium_fx'

            if local_player.Character.PrimaryPart:FindFirstChild('nurysium_fx') then
                return
            end

            local Attachment0 = Instance.new("Attachment", local_player.Character.PrimaryPart)
            local Attachment1 = Instance.new("Attachment", local_player.Character.PrimaryPart)

            Attachment0.Position = Vector3.new(0, -2.411, 0)
            Attachment1.Position = Vector3.new(0, 2.504, 0)

            trail.Parent = local_player.Character.PrimaryPart
            trail.Attachment0 = Attachment0
            trail.Attachment1 = Attachment1
        else

            if local_player.Character.PrimaryPart:FindFirstChild('nurysium_fx') then
                local_player.Character.PrimaryPart['nurysium_fx']:Destroy()
            end
        end

    end)
end)

--// night-mode

task.defer(function()
    while task.wait(1) do
        if getgenv().night_mode_Enabled then
            game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(3), {ClockTime = 3.9}):Play()
        else
            game:GetService("TweenService"):Create(game:GetService("Lighting"), TweenInfo.new(3), {ClockTime = 13.5}):Play()
        end
    end
end)

--// aura

task.spawn(function()
    RunService.PreRender:Connect(function()
        if not getgenv().aura_Enabled then
            return
        end

        if closest_Entity then
            if workspace.Alive:FindFirstChild(closest_Entity.Name) and workspace.Alive:FindFirstChild(closest_Entity.Name).Humanoid.Health > 0 then
                if aura_table.is_Spamming then
                    if local_player:DistanceFromCharacter(closest_Entity.HumanoidRootPart.Position) <= aura_table.spam_Range then   

                        parry_remote:FireServer(
                            0.5,
                            CFrame.new(camera.CFrame.Position, Vector3.zero),
                            {[closest_Entity.Name] = closest_Entity.HumanoidRootPart.Position},
                            {closest_Entity.HumanoidRootPart.Position.X, closest_Entity.HumanoidRootPart.Position.Y},
                            false
                        )

                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if not getgenv().aura_Enabled then
            return
        end

        local ping = Stats.Network.ServerStatsItem['Data Ping']:GetValue() / 10
        local self = Nurysium_Util.getBall()

        if not self then
            return
        end

        self:GetAttributeChangedSignal('target'):Once(function()
            aura_table.canParry = true
        end)

        if self:GetAttribute('target') ~= local_player.Name or not aura_table.canParry then
            return
        end

        get_closest_entity(local_player.Character.PrimaryPart)

        local player_Position = local_player.Character.PrimaryPart.Position

        local ball_Position = self.Position
        local ball_Velocity = self.AssemblyLinearVelocity

        if self:FindFirstChild('zoomies') then
            ball_Velocity = self.zoomies.VectorVelocity
        end

        local ball_Direction = (local_player.Character.PrimaryPart.Position - ball_Position).Unit
        local ball_Distance = local_player:DistanceFromCharacter(ball_Position)
        local ball_Dot = ball_Direction:Dot(ball_Velocity.Unit)
        local ball_Speed = ball_Velocity.Magnitude
        local ball_speed_Limited = math.min(ball_Speed / 1000, 0.1)

        local ball_predicted_Distance = (ball_Distance - ping / 15.5) - (ball_Speed / 3.5)

        local target_Position = closest_Entity.HumanoidRootPart.Position
        local target_Distance = local_player:DistanceFromCharacter(target_Position)
        local target_distance_Limited = math.min(target_Distance / 10000, 0.1)
        local target_Direction = (local_player.Character.PrimaryPart.Position - closest_Entity.HumanoidRootPart.Position).Unit
        local target_Velocity = closest_Entity.HumanoidRootPart.AssemblyLinearVelocity
        local target_isMoving = target_Velocity.Magnitude > 0
        local target_Dot = target_isMoving and math.max(target_Direction:Dot(target_Velocity.Unit), 0)

        aura_table.spam_Range = math.max(ping / 10, 15) + ball_Speed / 7
        aura_table.parry_Range = math.max(math.max(ping, 4) + ball_Speed / 3.5, 9.5)
        aura_table.is_Spamming = aura_table.hit_Count > 1 or ball_Distance < 13.5

        if ball_Dot < -0.2 then
            aura_table.ball_Warping = tick()
        end

        task.spawn(function()
            if (tick() - aura_table.ball_Warping) >= 0.15 + target_distance_Limited - ball_speed_Limited or ball_Distance <= 10 then
                aura_table.is_ball_Warping = false

                return
            end

            aura_table.is_ball_Warping = true
        end)

        if ball_Distance <= aura_table.parry_Range and not aura_table.is_Spamming and not aura_table.is_ball_Warping then
            parry_remote:FireServer(
                0.5,
                CFrame.new(camera.CFrame.Position, Vector3.new(math.random(0, 100), math.random(0, 1000), math.random(100, 1000))),
                {[closest_Entity.Name] = target_Position},
                {target_Position.X, target_Position.Y},
                false
            )

            aura_table.canParry = false
            aura_table.hit_Time = tick()
            aura_table.hit_Count += 1

            task.delay(0.15, function()
                aura_table.hit_Count -= 1
            end)
        end

        task.spawn(function()
            repeat
                RunService.Heartbeat:Wait()
            until (tick() - aura_table.hit_Time) >= 1
                aura_table.canParry = true
        end)
    end)
end)


initializate('nurysium_temp')
