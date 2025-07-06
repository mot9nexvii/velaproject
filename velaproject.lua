local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local InsertService = game:GetService("InsertService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VelaMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.Enabled = false -- по умолчанию скрыто

-- Основной фрейм, центрируем, зеркалим по горизонтали
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 420)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 0.65
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Зеркальное отражение по горизонтали
MainFrame.Rotation = 180
MainFrame.ScaleX = -1 -- Альтернативно можно использовать Scale в UIScale, но проще Rotation + ScaleX, но Roblox не поддерживает ScaleX напрямую
-- Вместо этого используем LayoutOrder + отражение дочерних элементов ниже

-- Добавим UICorner для скругления
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Добавим размытие (если хочешь, можно активировать)
--[[
local blur = Instance.new("BlurEffect")
blur.Size = 15
blur.Parent = game.Lighting
--]] 

-- Вспомогательная функция для зеркального отражения элементов
local function mirrorGuiElement(element)
    -- Меняем AnchorPoint и Position для зеркальности
    if element:IsA("GuiObject") then
        local ap = element.AnchorPoint
        local pos = element.Position
        element.AnchorPoint = Vector2.new(1 - ap.X, ap.Y)
        element.Position = UDim2.new(1 - pos.X.Scale, -pos.X.Offset, pos.Y.Scale, pos.Y.Offset)
    end
end

-- Заголовок (название меню)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Vela Menu 😎"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame
mirrorGuiElement(Title)

-- Кнопка загрузки аватара (по центру)
local LoadButton = Instance.new("TextButton")
LoadButton.Size = UDim2.new(0.7, 0, 0, 50)
LoadButton.Position = UDim2.new(0.15, 0, 0.3, 0)
LoadButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadButton.BackgroundTransparency = 0.4
LoadButton.Text = "Load Avatar"
LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadButton.TextScaled = true
LoadButton.Font = Enum.Font.GothamBold
LoadButton.Parent = MainFrame
local LoadButtonCorner = Instance.new("UICorner")
LoadButtonCorner.CornerRadius = UDim.new(0, 12)
LoadButtonCorner.Parent = LoadButton
mirrorGuiElement(LoadButton)

-- Кнопка настроек (иконка ⚙️) сверху справа (зеркально слева)
local SettingsToggle = Instance.new("TextButton")
SettingsToggle.Size = UDim2.new(0, 40, 0, 40)
SettingsToggle.Position = UDim2.new(0.02, 0, 0.02, 0)
SettingsToggle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
SettingsToggle.BackgroundTransparency = 0.7
SettingsToggle.Text = "⚙️"
SettingsToggle.TextScaled = true
SettingsToggle.Font = Enum.Font.GothamBold
SettingsToggle.Parent = MainFrame
local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0, 10)
SettingsCorner.Parent = SettingsToggle
mirrorGuiElement(SettingsToggle)

-- Настройки - отдельный фрейм
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(1, -20, 1, -70)
SettingsFrame.Position = UDim2.new(0, 10, 0, 60)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
SettingsFrame.BackgroundTransparency = 0.75
SettingsFrame.Visible = false
SettingsFrame.Parent = MainFrame
local SettingsCorner2 = Instance.new("UICorner")
SettingsCorner2.CornerRadius = UDim.new(0, 14)
SettingsCorner2.Parent = SettingsFrame
mirrorGuiElement(SettingsFrame)

-- Надпись "Settings"
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, 0, 0, 40)
SettingsTitle.Position = UDim2.new(0, 0, 0, 0)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
SettingsTitle.TextScaled = true
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.Parent = SettingsFrame
mirrorGuiElement(SettingsTitle)

-- Ползунок для FOV (от 60 до 120)
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, 0, 0, 30)
FOVLabel.Position = UDim2.new(0, 10, 0, 50)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "Camera FOV: 70"
FOVLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
FOVLabel.TextScaled = false
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = SettingsFrame
mirrorGuiElement(FOVLabel)

local FOVSlider = Instance.new("Frame")
FOVSlider.Size = UDim2.new(0.8, 0, 0, 20)
FOVSlider.Position = UDim2.new(0.1, 0, 0, 90)
FOVSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
FOVSlider.BackgroundTransparency = 0.6
FOVSlider.Parent = SettingsFrame
local FOVSliderCorner = Instance.new("UICorner")
FOVSliderCorner.CornerRadius = UDim.new(0, 10)
FOVSliderCorner.Parent = FOVSlider
mirrorGuiElement(FOVSlider)

local SliderKnob = Instance.new("Frame")
SliderKnob.Size = UDim2.new(0, 20, 1, 0)
SliderKnob.Position = UDim2.new(0.25, 0, 0, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SliderKnob.Parent = FOVSlider
local SliderKnobCorner = Instance.new("UICorner")
SliderKnobCorner.CornerRadius = UDim.new(0, 10)
SliderKnobCorner.Parent = SliderKnob
mirrorGuiElement(SliderKnob)

local dragging = false

SliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

SliderKnob.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local sliderAbsPos = FOVSlider.AbsolutePosition.X
        local sliderAbsSize = FOVSlider.AbsoluteSize.X
        local mouseX = input.Position.X
        local relativeX = math.clamp(mouseX - sliderAbsPos, 0, sliderAbsSize)
        local scale = relativeX / sliderAbsSize
        SliderKnob.Position = UDim2.new(scale, 0, 0, 0)
        local newFOV = math.floor(60 + scale * 60)
        FOVLabel.Text = "Camera FOV: "..newFOV
        workspace.CurrentCamera.FieldOfView = newFOV
    end
end)

-- Функция для анимации появления меню
local function tweenMenu(show)
    ScreenGui.Enabled = true
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if show then
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 50)
        MainFrame.BackgroundTransparency = 1
        local tweenPos = TweenService:Create(MainFrame, tweenInfo, {Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 0.65})
        tweenPos:Play()
        tweenPos.Completed:Wait()
    else
        local tweenPos = TweenService:Create(MainFrame, tweenInfo, {Position = UDim2.new(0.5, 0, 0.5, 50), BackgroundTransparency = 1})
        tweenPos:Play()
        tweenPos.Completed:Wait()
        ScreenGui.Enabled = false
    end
end

local menuVisible = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        menuVisible = not menuVisible
        tweenMenu(menuVisible)
    end
end)

-- Переключение между главной страницей и настройками
local onSettings = false

SettingsToggle.MouseButton1Click:Connect(function()
    onSettings = not onSettings
    SettingsFrame.Visible = onSettings
    LoadButton.Visible = not onSettings
end)

-- Аксессуары и одежда, которые подгружаем
local accessories = {
    {id = 1337018321, type = Enum.AccessoryType.Hat}, -- Cute cat ears in black (Hat)
    {id = 1303253197, type = "Shirt"}, -- Classic Shirt
    {id = 915925344, type = "Pants"}, -- Pants
    {id = 187421656, type = Enum.AccessoryType.Hair}, -- Black spiky messy boy hair (Hair)
    {id = 102659157, type = Enum.AccessoryType.Hair}, -- Black unkept emo vkei Anime Hairstyle (Hair)
    {id = 111007665, type = Enum.AccessoryType.Hair}, -- Emo anime boy hair messy black (Hair)
    {id = 11720215, type = Enum.AccessoryType.Face}, -- Cute sleepy face (Face)
}

-- Функция для очистки текущего персонажа от аксессуаров и одежды
local function clearCharacter()
    local character = LocalPlayer.Character
    if not character then return end
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then
            item:Destroy()
        end
    end
end

-- Функция для подгрузки аксессуаров и одежды
local function loadAvatar()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    clearCharacter()

    for _, item in pairs(accessories) do
        if item.type == "Shirt" then
            local shirt = Instance.new("Shirt")
            shirt.ShirtTemplate = "rbxassetid://"..item.id
            shirt.Parent = character
        elseif item.type == "Pants" then
            local pants = Instance.new("Pants")
            pants.PantsTemplate = "rbxassetid://"..item.id
            pants.Parent = character
        else
            -- аксессуары через InsertService
            local success, accessory = pcall(function()
                return InsertService:LoadAsset(item.id)
            end)
            if success and accessory then
                local acc = accessory:GetChildren()[1]
                if acc and acc:IsA("Accessory") then
                    acc.Parent = character
                end
            end
        end
    end

    StarterGui:SetCore("SendNotification", {
        Title = "Vela",
        Text = "Аватар успешно загружен!",
        Duration = 3
    })
end

LoadButton.MouseButton1Click:Connect(loadAvatar)
