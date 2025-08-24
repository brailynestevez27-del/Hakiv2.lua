local player = game.Players.LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local remote = rs:WaitForChild("Remotes"):WaitForChild("CommF_")

local npcName = "Master of Enhancement"
local esquivesNecesarios = 5000
local esquivesHechos = 0

local function hablarConNPC()
    remote:InvokeServer("StartDialogue", npcName, "1")
    task.wait(1)
    remote:InvokeServer("DialogueAnswer", npcName, "1")
end

local function pagarNPC()
    remote:InvokeServer("Buy", "KenV2")
end

local function hacerEsquives()
    while esquivesHechos < esquivesNecesarios do
        esquivesHechos += 1
        remote:InvokeServer("Ken", true) 
        task.wait(0.01)
    end
end

local function entregarMision()
    remote:InvokeServer("EndDialogue", npcName, "1")
end

local function autoHakiV2()
    if not player:FindFirstChild("KenV2") then
        hablarConNPC()
        pagarNPC()
        hacerEsquives()
        entregarMision()
    else
        print("✔️ Ya tienes Haki V2.")
    end
end

autoHakiV2()