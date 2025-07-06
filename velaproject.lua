local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- Настройки аксессуаров и одежды (ID с твоих ссылок)
local SkinItems = {
    Accessories = { -- все волосы и аксессуары
        133701832157051, -- Cute cat ears in black (Face Accessory)
        18742165661,     -- Black spiky messy boy hair (Accessory)
        102659157896264, -- Black unkept emo vkei Anime Hairstyle (Accessory)
        111007665254899, -- Emo anime boy hair messy black (Accessory)
        11720215989,     -- Cute Sleepy Face (Face Accessory)
    },
    Shirts = {
        130325319784092, -- Classic Shirt "66"
    },
    Pants = {
        91592534471170,  -- Classic Pants "66"
    }
}

-- Уведомление
local function notify(msg)
    local notification = Instance.new("TextLabel")
    notification.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.Text = msg
    notification.Size = UDim2.new(0, 250, 0, 30)
    notification.Position = UDim2.new(1, -260, 1, -40)
    notification.AnchorPoint = Vector2.new(0, 0)
    notification.Parent = PlayerGui
    notification.TextScaled = true
    notification.BackgroundTransparency = 0.4
    notification.ZIndex = 10
    notification.Font = Enum.Font.GothamBold

    delay(3, function()
        notification:Destroy()
    end)
end

-- Удаление старых аксессуаров/одежды нашего скина перед загрузкой нового
local function clearSkin(character)
    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Accessory") then
            item:Destroy()
        elseif item:IsA("Shirt") or item:IsA("Pants") then
            item:Destroy()
        end
    end
end

-- Загрузка одного аксессуара или одежды по ID
local function loadItem(id, character)
    local success, model = pcall(function()
        return InsertService:LoadAsset(id)
    end)
    if success and model then
        local obj = model:GetChildren()[1]
        if obj then
            if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") then
                obj.Parent = character
                return true
            end
        end
    end
    return false
end

-- Загрузка скина (все айтемы)
local function loadSkin()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    clearSkin(character)

    -- Загрузка аксессуаров
    for _, accId in ipairs(SkinItems.Accessories) do
        loadItem(accId, character)
    end
    -- Загрузка одежды
    for _, shirtId in ipairs(SkinItems.Shirts) do
        loadItem(shirtId, character)
    end
    for _, pantsId in ipairs(SkinItems.Pants) do
        loadItem(pantsId, character)
    end
    notify("Скин успешно загружен!")
end

-- Создаём главное меню
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VelaMenu"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0,0)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Text = "Vela Menu"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Parent = MainFrame

-- Кнопка переключения на настройки
local SettingsButton = Instance.new("TextButton")
SettingsButton.Text = "⚙ Настройки"
SettingsButton.Font = Enum.Font.Gotham
SettingsButton.TextSize = 20
SettingsButton.TextColor3 = Color3.new(1,1,1)
SettingsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SettingsButton.Size = UDim2.new(0, 120, 0, 35)
SettingsButton.Position = UDim2.new(1, -130, 0, 45)
SettingsButton.AnchorPoint = Vector2.new(1, 0)
SettingsButton.Parent = MainFrame
SettingsButton.AutoButtonColor = true

local ButtonUICorner1 = Instance.new("UICorner")
ButtonUICorner1.Parent = SettingsButton
ButtonUICorner1.CornerRadius = UDim.new(0, 8)

-- Кнопка загрузки скина
local LoadSkinButton = Instance.new("TextButton")
LoadSkinButton.Text = "Загрузить скин"
LoadSkinButton.Font = Enum.Font.GothamBold
LoadSkinButton.TextSize = 22
LoadSkinButton.TextColor3 = Color3.new(1,1,1)
LoadSkinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
LoadSkinButton.Size = UDim2.new(0, 200, 0, 50)
LoadSkinButton.Position = UDim2.new(0.5, -100, 0, 90)
LoadSkinButton.Parent = MainFrame
LoadSkinButton.AutoButtonColor = true

local ButtonUICorner2 = Instance.new("UICorner")
ButtonUICorner2.Parent = LoadSkinButton
ButtonUICorner2.CornerRadius = UDim.new(0, 12)

-- Страница настроек (скрыта по умолчанию)
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(1, 0, 1, 0)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
SettingsFrame.Visible = false
SettingsFrame.Parent = MainFrame
SettingsFrame.ClipsDescendants = true
SettingsFrame.AnchorPoint = Vector2.new(0,0)

local SettingsUICorner = Instance.new("UICorner")
SettingsUICorner.CornerRadius = UDim.new(0, 12)
SettingsUICorner.Parent = SettingsFrame

-- Заголовок настроек
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Text = "Настройки"
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextSize = 24
SettingsTitle.TextColor3 = Color3.new(1,1,1)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Size = UDim2.new(1, 0, 0, 40)
SettingsTitle.Position = UDim2.new(0, 0, 0, 0)
SettingsTitle.Parent = SettingsFrame

-- Кнопка возврата в главное меню
local BackButton = Instance.new("TextButton")
BackButton.Text = "← Назад"
BackButton.Font = Enum.Font.Gotham
BackButton.TextSize = 18
BackButton.TextColor3 = Color3.new(1,1,1)
BackButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BackButton.Size = UDim2.new(0, 100, 0, 30)
BackButton.Position = UDim2.new(0, 10, 0, 45)
BackButton.Parent = SettingsFrame
BackButton.AutoButtonColor = true

local BackButtonCorner = Instance.new("UICorner")
BackButtonCorner.CornerRadius = UDim.new(0, 8)
BackButtonCorner.Parent = BackButton

-- FOV label
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Text = "Поле зрения камеры (FOV): 70"
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextSize = 18
FOVLabel.TextColor3 = Color3.new(1,1,1)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Position = UDim2.new(0, 10, 0, 90)
FOVLabel.Size = UDim2.new(1, -20, 0, 25)
FOVLabel.Parent = SettingsFrame

-- FOV slider
local FOVSlider = Instance.new("Slider")
FOVSlider.Min = 60
FOVSlider.Max = 120
FOVSlider.Value = Camera.FieldOfView
FOVSlider.Size = UDim2.new(0.8, 0, 0, 30)
FOVSlider.Position = UDim2.new(0.1, 0, 0, 120)
FOVSlider.Parent = SettingsFrame

-- Т.к. Roblox стандартный слайдер не имеет, заменяем на TextBox + кнопки (импровизация)

local FOVInput = Instance.new("TextBox")
FOVInput.Size = UDim2.new(0.3, 0, 0, 30)
FOVInput.Position = UDim2.new(0.6, 0, 0, 120)
FOVInput.Text = tostring(Camera.FieldOfView)
FOVInput.ClearTextOnFocus = false
FOVInput.Font = Enum.Font.Gotham
FOVInput.TextSize = 18
FOVInput.TextColor3 = Color3.new(0, 0, 0)
FOVInput.BackgroundColor3 = Color3.new(1,1,1)
FOVInput.Parent = SettingsFrame

-- Обработчик изменения FOV через TextBox
FOVInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(FOVInput.Text)
        if val and val >= 60 and val <= 120 then
            Camera.FieldOfView = val
            FOVLabel.Text = "Поле зрения камеры (FOV): "..val
            notify("FOV установлен на "..val)
        else
            notify("Ошибка: введите число от 60 до 120")
            FOVInput.Text = tostring(Camera.FieldOfView)
        end
    end
end)

-- Показать/скрыть меню по нажатию K
local menuVisible = false
local UserInputService = game:GetService("UserInputService")

local function toggleMenu()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        toggleMenu()
    end
end)

-- Кнопки переключения между страницами меню
SettingsButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    SettingsFrame.Visible = true
    LoadSkinButton.Visible = false
    SettingsButton.Visible = false
end)

BackButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = false
    LoadSkinButton.Visible = true
    SettingsButton.Visible = true
end)

-- Загрузка скина при нажатии кнопки
LoadSkinButton.MouseButton1Click:Connect(function()
    loadSkin()
end)

notify("Vela скрипт загружен! Нажмите K для меню")
