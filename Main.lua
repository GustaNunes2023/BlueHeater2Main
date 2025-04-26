-- Blue Heater 2 - Script Autofarm GUI Neon Roxo
-- Feito para GustaNunes2023
-- Proteções AntiKick / AntiAFK Ativas

-- AntiAFK
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- UI Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "Blue Heater 2 | GustaNunes2023", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "BlueHeater2",
    IntroEnabled = false,
})

-- Variáveis
local selectedMob = nil
local worlds = {
    ["Mundo 1"] = {
        "Skeleton King", "Dreadestwood", "Infernal Wolf", "Giant Slime", "Goblin King",
        "Buff Bee", "Territorial Lysandra", "Giant Golem", "Nun", "Malignant Malcolm",
        "Weeping Wyatt", "Metal Slime", "Sweellia", "Executioner", "Gluttonous Daemon",
        "Nightstalker", "White Werewolf", "Armored Skeleton Warrior", "Cryan Ryan",
        "Daemon Shaman", "Dreadwood", "Fluffim", "Goblin", "Greater Daemon",
        "Hauntling", "Lesser Daemon", "Lysposa", "Malignroot", "Pyunnit", "Red Wolf",
        "Slime", "Skeleton Gunner", "Skeleton Mage", "Skeleton Warrior", "Treant",
        "Undead Guard", "Werewolf", "Wolf"
    },
    ["Mundo 2"] = {
        "Spectral Dragon", "Space Moth", "Frankenstein's Monster", "Mothlem Queen",
        "The Tormentor", "Werewolf King", "Tsuu", "Super Turtle", "Thunder Golem",
        "Alpha Sheep", "Arctic Wolf", "Cephalopod Cultist", "Crysalithe", "Fluffrost",
        "Frozen Guardian", "Goatman", "Mothlem", "Nekomata", "Penguin", "Snowbear",
        "Snhost", "Snowfield Pyunnit", "Vampire", "Water Sprite", "Yeti",
        "Frostwood Treant", "Zombie"
    }
}

local function getWorld()
    if workspace:FindFirstChild("World1") then
        return "Mundo 1"
    elseif workspace:FindFirstChild("World2") then
        return "Mundo 2"
    else
        return "Mundo 1" -- fallback
    end
end

-- Farm Functions
function farmMob(mobName)
    while selectedMob == mobName and task.wait() do
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name == mobName then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame * CFrame.new(0,0,-5)
                if v:FindFirstChildOfClass("Humanoid") then
                    v:FindFirstChildOfClass("Humanoid"):TakeDamage(10)
                end
            end
        end
    end
end

-- Auto Collect Easter Eggs
function collectEasterEggs()
    while true do
        task.wait(5)
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("egg") and v:IsA("Part") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
            end
        end
    end
end

-- Tabs
local FarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

FarmTab:AddParagraph("Selecionar Mob", "Escolha qual mob deseja farmar:")

for _, mob in ipairs(worlds[getWorld()]) do
    FarmTab:AddButton({
        Name = mob,
        Callback = function()
            selectedMob = mob
            OrionLib:MakeNotification({
                Name = "Autofarm",
                Content = "Farmando: "..mob,
                Time = 5
            })
            farmMob(mob)
        end
    })
end

FarmTab:AddButton({
    Name = "Parar Autofarm",
    Callback = function()
        selectedMob = nil
        OrionLib:MakeNotification({
            Name = "Autofarm",
            Content = "Farm Parado",
            Time = 5
        })
    end
})

local OtherTab = Window:MakeTab({
    Name = "Extras",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

OtherTab:AddButton({
    Name = "Farmar Ovos de Páscoa",
    Callback = function()
        collectEasterEggs()
    end
})

-- GUI Minimizar
OrionLib:Init()
