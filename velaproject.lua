local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- IDs аксессуаров и одежды
local AvatarAssets = {
    Accessories = {
        1337018321,    -- Cute cat ears in black (сократил id для примера, подставь полные)
        1874216566,    -- Black spiky messy boy hair
        1026591578,    -- Black unkept emo vkei Anime Hairstyle
        1110076652,    -- Emo anime boy hair messy black
        1172021598,    -- Cute Sleepy Face
    },
    ShirtId = 1303253197, -- Classic Shirt
    PantsId = 9159253447, -- Classic Pants
}

-- Текущая тема меню: "Light" или "Dark"
local CurrentTheme = "Light"

-- Создаем ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VelaGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

-- Основной фрейм меню
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Vela Menu"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 28
TitleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.Parent = MainFrame

-- Кнопка переключения страниц (Настройки/Главная)
local ToggleSettingsBtn = Instance.new("TextButton")
ToggleSettingsBtn.Size = UDim2.new(0, 120, 0, 40)
ToggleSettingsBtn.Position = UDim2.new(1, -130, 0, 10)
ToggleSettingsBtn.AnchorPoint = Vector2.new(1, 0)
ToggleSettingsBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleSettingsBtn.Font = Enum.Font.Gotham
ToggleSettingsBtn.TextSize = 18
ToggleSettingsBtn.Text = "Настройки"
ToggleSettingsBtn.Name = "ToggleSettingsBtn"
ToggleSettingsBtn.Parent = MainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = ToggleSettingsBtn

-- Страницы
local Pages = {}

-- Главная страница
local MainPage = Instance.new("Frame")
MainPage.Size = UDim2.new(1, 0, 1, -50)
MainPage.Position = UDim2.new(0, 0, 0, 50)
MainPage.BackgroundTransparency = 1
MainPage.Parent = MainFrame

-- Кнопка загрузки аватара
local LoadAvatarBtn = Instance.new("TextButton")
LoadAvatarBtn.Size = UDim2.new(0.8, 0, 0, 50)
LoadAvatarBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
LoadAvatarBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
LoadAvatarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadAvatarBtn.Font = Enum.Font.GothamBold
LoadAvatarBtn.TextSize = 20
LoadAvatarBtn.Text = "Загрузить аватар"
LoadAvatarBtn.Parent = MainPage

local loadBtnCorner = Instance.new("UICorner")
loadBtnCorner.CornerRadius = UDim.new(0, 12)
loadBtnCorner.Parent = LoadAvatarBtn

-- Страница Настроек
local SettingsPage = Instance.new("Frame")
SettingsPage.Size = UDim2.new(1, 0, 1, -50)
SettingsPage.Position = UDim2.new(0, 0, 0, 50)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false
SettingsPage.Parent = MainFrame

-- FoV Текст
local FoVLabel = Instance.new("TextLabel")
FoVLabel.Size = UDim2.new(0.6, 0, 0, 30)
FoVLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
FoVLabel.BackgroundTransparency = 1
FoVLabel.Font = Enum.Font.Gotham
FoVLabel.TextSize = 18
FoVLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
FoVLabel.Text = "Камера FoV:"
FoVLabel.TextXAlignment = Enum.TextXAlignment.Left
FoVLabel.Parent = SettingsPage

-- FoV Slider Frame
local FoVSliderFrame = Instance.new("Frame")
FoVSliderFrame.Size = UDim2.new(0.8, 0, 0, 40)
FoVSliderFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
FoVSliderFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
FoVSliderFrame.BorderSizePixel = 0
FoVSliderFrame.Parent = SettingsPage

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 12)
sliderCorner.Parent = FoVSliderFrame

-- Slider draggable part
local FoVSlider = Instance.new("Frame")
FoVSlider.Size = UDim2.new(0, 50, 1, 0)
FoVSlider.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
FoVSlider.BorderSizePixel = 0
FoVSlider.Position = UDim2.new(0, 0, 0, 0)
FoVSlider.Parent = FoVSliderFrame

local sliderHandle = Instance.new("UICorner")
sliderHandle.CornerRadius = UDim.new(0, 12)
sliderHandle.Parent = FoVSlider

-- FoV Value Label
local FoVValueLabel = Instance.new("TextLabel")
FoVValueLabel.Size = UDim2.new(0.15, 0, 0, 30)
FoVValueLabel.Position = UDim2.new(0.85, 0, 0.1, 0)
FoVValueLabel.BackgroundTransparency = 1
FoVValueLabel.Font = Enum.Font.GothamBold
FoVValueLabel.TextSize = 18
FoVValueLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
FoVValueLabel.Text = tostring(math.floor(Camera.FieldOfView))
FoVValueLabel.Parent = SettingsPage

-- Тема меню текст
local ThemeLabel = Instance.new("TextLabel")
ThemeLabel.Size = UDim2.new(0.6, 0, 0, 30)
ThemeLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
ThemeLabel.BackgroundTransparency = 1
ThemeLabel.Font = Enum.Font.Gotham
ThemeLabel.TextSize = 18
ThemeLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
ThemeLabel.Text = "Тема меню:"
ThemeLabel.TextXAlignment = Enum.TextXAlignment.Left
ThemeLabel.Parent = SettingsPage

-- Тема переключатель
local ThemeToggleBtn = Instance.new("TextButton")
ThemeToggleBtn.Size = UDim2.new(0.4, 0, 0, 40)
ThemeToggleBtn.Position = UDim2.new(0.55, 0, 0.48, 0)
ThemeToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ThemeToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeToggleBtn.Font = Enum.Font.GothamBold
ThemeToggleBtn.TextSize = 18
ThemeToggleBtn.Text = "Светлая"
ThemeToggleBtn.Parent = SettingsPage

local themeBtnCorner = Instance.new("UICorner")
themeBtnCorner.CornerRadius = UDim.new(0, 12)
themeBtnCorner.Parent = ThemeToggleBtn

-- Служебные переменные для слайдера
local dragging = false
local dragStartX = 0
local sliderStartPos = 0

-- Функция обновления темы меню
local function UpdateTheme(theme)
    CurrentTheme = theme
    if theme == "Light" then
        MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
        TitleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
        FoVLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
        FoVValueLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
        ThemeLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
        ThemeToggleBtn.Text = "Светлая"
        ThemeToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        ToggleSettingsBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        ToggleSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadAvatarBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        LoadAvatarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        FoVLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        FoVValueLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        ThemeLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        ThemeToggleBtn.Text = "Тёмная"
        ThemeToggleBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        ToggleSettingsBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        ToggleSettingsBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
        LoadAvatarBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        LoadAvatarBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end

-- Установка начальной темы
UpdateTheme(CurrentTheme)

-- Обработчик переключения темы
ThemeToggleBtn.MouseButton1Click:Connect(function()
    if CurrentTheme == "Light" then
        UpdateTheme("Dark")
    else
        UpdateTheme("Light")
    end
end)

-- Обработчик переключения страниц
local showingSettings = false
ToggleSettingsBtn.MouseButton1Click:Connect(function()
    showingSettings = not showingSettings
    if showingSettings then
        MainPage.Visible = false
        SettingsPage.Visible = true
        ToggleSettingsBtn.Text = "Главная"
    else
        MainPage.Visible = true
        SettingsPage.Visible = false
        ToggleSettingsBtn.Text = "Настройки"
    end
end)

-- Функция плавного появления меню
local function ShowMenu()
    ScreenGui.Enabled = true
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -160, 0.5, -200)})
    tween:Play()
end

-- Функция плавного скрытия меню
local function HideMenu()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -160, 0.5, -250)})
    tween:Play()
    tween.Completed:Wait()
    ScreenGui.Enabled = false
end

ScreenGui.Enabled = false

-- Переключение меню по нажатию K
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        if ScreenGui.Enabled then
            HideMenu()
        else
            ShowMenu()
        end
    end
end)

-- Обработчики для слайдера FoV
FoVSliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartX = input.Position.X
        sliderStartPos = FoVSlider.Size.X.Offset
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position.X - dragStartX
        local newPos = math.clamp(sliderStartPos + delta, 0, FoVSliderFrame.AbsoluteSize.X)
        FoVSlider.Size = UDim2.new(0, newPos, 1, 0)
        local ratio = newPos / FoVSliderFrame.AbsoluteSize.X
        local newFoV = math.floor(60 + ratio * (120 - 60))
        Camera.FieldOfView = newFoV
        FoVValueLabel.Text = tostring(newFoV)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Функция загрузки аватара
local function LoadAvatar()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        warn("Humanoid не найден.")
        return
    end
    
    -- Удаляем старые аксессуары
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then
            item:Destroy()
        end
    end
    
    -- Добавляем аксессуары по ID
    for _, assetId in pairs(AvatarAssets.Accessories) do
        local success, asset = pcall(function()
            return game:GetService("InsertService"):LoadAsset(assetId)
        end)
        if success and asset then
            local acc = asset:FindFirstChildWhichIsA("Accessory")
            if acc then
                acc.Parent = character
            end
            asset:Destroy()
        else
            warn("Не удалось загрузить аксессуар: "..tostring(assetId))
        end
    end
    
    -- Добавляем одежду
    local shirt = Instance.new("Shirt")
    shirt.ShirtTemplate = "rbxassetid://"..tostring(AvatarAssets.ShirtId)
    shirt.Parent = character

    local pants = Instance.new("Pants")
    pants.PantsTemplate = "rbxassetid://"..tostring(AvatarAssets.PantsId)
    pants.Parent = character
    
    -- Обновление Humanoid Description
    local success, description = pcall(function()
        return Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
    end)
    if success and description then
        -- Можно здесь добавить кастомизацию если нужно
    end
end

LoadAvatarBtn.MouseButton1Click:Connect(function()
    LoadAvatar()
    -- Отправляем сообщение в чат (ServerMessage)
    local msg = Instance.new("Message", workspace)
    msg.Text = "[Vela] Аватар успешно загружен!"
    delay(3, function()
        msg:Destroy()
    end)
end)

-- Уведомление о загрузке скрипта сразу при запуске
local msg = Instance.new("Message", workspace)
msg.Text = "[Vela] Скрипт успешно загружен! Нажмите 'K' для открытия меню."
delay(4, function()
    msg:Destroy()
end)
