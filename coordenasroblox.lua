
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local BtnToggleEsquives = Instance.new("TextButton")
local BtnCoords = Instance.new("TextButton")
local BtnAutoFarm = Instance.new("TextButton")
local LabelInfo = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Size = UDim2.new(0, 260, 0, 200)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Parent = ScreenGui

BtnToggleEsquives.Size = UDim2.new(0, 230, 0, 40)
BtnToggleEsquives.Position = UDim2.new(0, 15, 0, 10)
BtnToggleEsquives.Text = "Auto Esquives: OFF"
BtnToggleEsquives.Parent = Frame

BtnCoords.Size = UDim2.new(0, 230, 0, 40)
BtnCoords.Position = UDim2.new(0, 15, 0, 60)
BtnCoords.Text = "Mostrar Coordenadas"
BtnCoords.Parent = Frame

BtnAutoFarm.Size = UDim2.new(0, 230, 0, 40)
BtnAutoFarm.Position = UDim2.new(0, 15, 0, 110)
BtnAutoFarm.Text = "AutoFarm Nivel: OFF"
BtnAutoFarm.Parent = Frame

LabelInfo.Size = UDim2.new(0, 230, 0, 30)
LabelInfo.Position = UDim2.new(0, 15, 0, 160)
LabelInfo.Text = "Info: ---"
LabelInfo.TextColor3 = Color3.fromRGB(255,255,255)
LabelInfo.BackgroundTransparency = 1
LabelInfo.Parent = Frame

-- Variables
local autofarmActivo = false
local esquivesHechos = 0
local esquivesNecesarios = 5000
local autoFarmNivel = false

-- Función pagar NPC (Ken Haki V2)
local function pagarNPC()
    local remote = game.ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("BuyKenV2")
    if remote then
        remote:InvokeServer("Buy", "Ken Haki V2")
        LabelInfo.Text = "Info: Pagado al NPC"
    else
        LabelInfo.Text = "Info: Remote no encontrado"
    end
end

-- Autofarm esquives
spawn(function()
    while task.wait(0.1) do
        if autofarmActivo and esquivesHechos < esquivesNecesarios then
            esquivesHechos = esquivesHechos + 1
            LabelInfo.Text = "Info: Esquives " .. esquivesHechos .. "/" .. esquivesNecesarios
        elseif esquivesHechos >= esquivesNecesarios and autofarmActivo then
            LabelInfo.Text = "Info: Esquives completados"
            pagarNPC()
            autofarmActivo = false
            BtnToggleEsquives.Text = "Auto Esquives: OFF"
        end
    end
end)

-- Mostrar coordenadas
local function mostrarCoords()
    local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    LabelInfo.Text = "Coords: " .. math.floor(pos.X) .. ", " .. math.floor(pos.Y) .. ", " .. math.floor(pos.Z)
end

-- Autofarm de nivel (ejemplo simple)
spawn(function()
    while task.wait(0.3) do
        if autoFarmNivel then
            local player = game.Players.LocalPlayer
            local char = player.Character
            local humanoid = char:FindFirstChildOfClass("Humanoid")

            -- Detectar enemigos en la carpeta de Mobs
            local enemigos = workspace:FindFirstChild("Enemies")
            if enemigos then
                for _, mob in pairs(enemigos:GetChildren()) do
                    if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildOfClass("Humanoid").Health > 0 then
                        -- Teleport al enemigo
                        char.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        -- Atacar
                        humanoid:MoveTo(mob.HumanoidRootPart.Position)
                        LabelInfo.Text = "Matando: " .. mob.Name
                        break
                    end
                end
            else
                LabelInfo.Text = "No se encontró carpeta Enemies"
            end
        end
    end
end)

-- Conexiones de botones
BtnToggleEsquives.MouseButton1Click:Connect(function()
    autofarmActivo = not autofarmActivo
    if autofarmActivo then
        BtnToggleEsquives.Text = "Auto Esquives: ON"
        LabelInfo.Text = "Info: Autofarm activado"
    else
        BtnToggleEsquives.Text = "Auto Esquives: OFF"
        LabelInfo.Text = "Info: Autofarm detenido"
    end
end)

BtnCoords.MouseButton1Click:Connect(function()
    mostrarCoords()
end)

BtnAutoFarm.MouseButton1Click:Connect(function()
    autoFarmNivel = not autoFarmNivel
    if autoFarmNivel then
        BtnAutoFarm.Text = "AutoFarm Nivel: ON"
        LabelInfo.Text = "Info: Autofarm nivel activado"
    else
        BtnAutoFarm.Text = "AutoFarm Nivel: OFF"
        LabelInfo.Text = "Info: Autofarm nivel detenido"
    end
end)    else
        print("✔️ Ya tienes Haki V2.")
    end
end

autoHakiV2()
