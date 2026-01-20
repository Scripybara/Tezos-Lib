--[[
    ╔══════════════════════════════════════════════════════════════╗
    ║                    LUXURA UI LIBRARY v2.0                    ║
    ║              Modern • Beautiful • Responsive                  ║
    ║                  Created for Roblox Executors                 ║
    ╚══════════════════════════════════════════════════════════════╝
]]

local LuxuraLib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- ═══════════════════════════════════════════════════════════════
-- THEME CONFIGURATION
-- ═══════════════════════════════════════════════════════════════

local Themes = {
    Dark = {
        Primary = Color3.fromRGB(15, 15, 25),
        Secondary = Color3.fromRGB(22, 22, 35),
        Tertiary = Color3.fromRGB(30, 30, 45),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentDark = Color3.fromRGB(71, 82, 196),
        AccentLight = Color3.fromRGB(114, 137, 218),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(185, 185, 195),
        TextDarker = Color3.fromRGB(130, 130, 145),
        Success = Color3.fromRGB(67, 181, 129),
        Warning = Color3.fromRGB(250, 166, 26),
        Error = Color3.fromRGB(240, 71, 71),
        Border = Color3.fromRGB(45, 45, 65),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(88, 101, 242),
    },
    Purple = {
        Primary = Color3.fromRGB(18, 12, 28),
        Secondary = Color3.fromRGB(28, 18, 42),
        Tertiary = Color3.fromRGB(38, 25, 55),
        Accent = Color3.fromRGB(147, 51, 234),
        AccentDark = Color3.fromRGB(124, 58, 237),
        AccentLight = Color3.fromRGB(168, 85, 247),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 180, 220),
        TextDarker = Color3.fromRGB(150, 130, 170),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(239, 68, 68),
        Border = Color3.fromRGB(55, 35, 75),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(147, 51, 234),
    },
    Ocean = {
        Primary = Color3.fromRGB(10, 20, 30),
        Secondary = Color3.fromRGB(15, 30, 45),
        Tertiary = Color3.fromRGB(20, 40, 60),
        Accent = Color3.fromRGB(6, 182, 212),
        AccentDark = Color3.fromRGB(8, 145, 178),
        AccentLight = Color3.fromRGB(34, 211, 238),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 210, 220),
        TextDarker = Color3.fromRGB(130, 160, 175),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(244, 63, 94),
        Border = Color3.fromRGB(30, 55, 75),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(6, 182, 212),
    },
    Rose = {
        Primary = Color3.fromRGB(25, 15, 20),
        Secondary = Color3.fromRGB(38, 22, 30),
        Tertiary = Color3.fromRGB(50, 28, 40),
        Accent = Color3.fromRGB(244, 63, 94),
        AccentDark = Color3.fromRGB(225, 29, 72),
        AccentLight = Color3.fromRGB(251, 113, 133),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(220, 190, 200),
        TextDarker = Color3.fromRGB(170, 140, 155),
        Success = Color3.fromRGB(74, 222, 128),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(248, 113, 113),
        Border = Color3.fromRGB(65, 35, 48),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(244, 63, 94),
    },
    Emerald = {
        Primary = Color3.fromRGB(12, 22, 18),
        Secondary = Color3.fromRGB(18, 32, 26),
        Tertiary = Color3.fromRGB(24, 42, 35),
        Accent = Color3.fromRGB(16, 185, 129),
        AccentDark = Color3.fromRGB(5, 150, 105),
        AccentLight = Color3.fromRGB(52, 211, 153),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 220, 200),
        TextDarker = Color3.fromRGB(130, 170, 150),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(251, 191, 36),
        Error = Color3.fromRGB(248, 113, 113),
        Border = Color3.fromRGB(35, 60, 48),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(16, 185, 129),
    },
}

local CurrentTheme = Themes.Dark
local ScreenGui

-- ═══════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function Create(class, properties)
    local instance = Instance.new(class)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            instance[prop] = value
        end
    end
    if properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

local function Tween(instance, properties, duration, style, direction)
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function AddCorner(parent, radius)
    return Create("UICorner", {
        CornerRadius = UDim.new(0, radius or 8),
        Parent = parent
    })
end

local function AddStroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color or CurrentTheme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        Parent = parent
    })
end

local function AddPadding(parent, padding)
    return Create("UIPadding", {
        PaddingTop = UDim.new(0, padding),
        PaddingBottom = UDim.new(0, padding),
        PaddingLeft = UDim.new(0, padding),
        PaddingRight = UDim.new(0, padding),
        Parent = parent
    })
end

local function AddGradient(parent, colors, rotation)
    return Create("UIGradient", {
        Color = ColorSequence.new(colors),
        Rotation = rotation or 90,
        Parent = parent
    })
end

local function AddShadow(parent, size, transparency)
    local shadow = Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 4),
        Size = UDim2.new(1, size or 30, 1, size or 30),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = CurrentTheme.Shadow,
        ImageTransparency = transparency or 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450),
        Parent = parent
    })
    return shadow
end

local function Ripple(button)
    local ripple = Create("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        ZIndex = button.ZIndex + 1,
        Parent = button
    })
    AddCorner(ripple, 1000)
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    Tween(ripple, {Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1}, 0.5)
    
    task.delay(0.5, function()
        ripple:Destroy()
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════════

local NotificationHolder

local function CreateNotificationHolder()
    NotificationHolder = Create("Frame", {
        Name = "NotificationHolder",
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 320, 1, -40),
        Parent = ScreenGui
    })
    
    Create("UIListLayout", {
        Padding = UDim.new(0, 10),
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Parent = NotificationHolder
    })
end

function LuxuraLib:Notify(config)
    config = config or {}
    local title = config.Title or "Notification"
    local description = config.Description or ""
    local duration = config.Duration or 5
    local type_ = config.Type or "Info"
    
    local typeColors = {
        Info = CurrentTheme.Accent,
        Success = CurrentTheme.Success,
        Warning = CurrentTheme.Warning,
        Error = CurrentTheme.Error
    }
    
    local typeIcons = {
        Info = "rbxassetid://7733960981",
        Success = "rbxassetid://7733715400",
        Warning = "rbxassetid://7734053495",
        Error = "rbxassetid://7733792936"
    }
    
    local notification = Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = CurrentTheme.Secondary,
        Size = UDim2.new(1, 0, 0, 80),
        Position = UDim2.new(1, 100, 0, 0),
        ClipsDescendants = true,
        Parent = NotificationHolder
    })
    AddCorner(notification, 12)
    AddStroke(notification, CurrentTheme.Border, 1, 0.5)
    AddShadow(notification, 40, 0.6)
    
    -- Accent bar
    local accentBar = Create("Frame", {
        Name = "AccentBar",
        BackgroundColor3 = typeColors[type_],
        Size = UDim2.new(0, 4, 1, 0),
        Parent = notification
    })
    Create("UICorner", {
        CornerRadius = UDim.new(0, 2),
        Parent = accentBar
    })
    
    -- Glow effect
    local glow = Create("ImageLabel", {
        Name = "Glow",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -20, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 80, 0, 80),
        Image = "rbxassetid://5028857084",
        ImageColor3 = typeColors[type_],
        ImageTransparency = 0.7,
        Parent = notification
    })
    
    -- Icon
    local iconHolder = Create("Frame", {
        Name = "IconHolder",
        BackgroundColor3 = typeColors[type_],
        BackgroundTransparency = 0.85,
        Position = UDim2.new(0, 16, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 42, 0, 42),
        Parent = notification
    })
    AddCorner(iconHolder, 10)
    
    local icon = Create("ImageLabel", {
        Name = "Icon",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0, 22, 0, 22),
        Image = typeIcons[type_],
        ImageColor3 = typeColors[type_],
        Parent = iconHolder
    })
    
    -- Title
    local titleLabel = Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 70, 0, 14),
        Size = UDim2.new(1, -100, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = CurrentTheme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notification
    })
    
    -- Description
    local descLabel = Create("TextLabel", {
        Name = "Description",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 70, 0, 36),
        Size = UDim2.new(1, -100, 0, 30),
        Font = Enum.Font.Gotham,
        Text = description,
        TextColor3 = CurrentTheme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Parent = notification
    })
    
    -- Progress bar
    local progressBg = Create("Frame", {
        Name = "ProgressBg",
        BackgroundColor3 = CurrentTheme.Primary,
        Position = UDim2.new(0, 0, 1, -3),
        Size = UDim2.new(1, 0, 0, 3),
        Parent = notification
    })
    
    local progress = Create("Frame", {
        Name = "Progress",
        BackgroundColor3 = typeColors[type_],
        Size = UDim2.new(1, 0, 1, 0),
        Parent = progressBg
    })
    AddCorner(progress, 2)
    
    -- Close button
    local closeBtn = Create("TextButton", {
        Name = "CloseBtn",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -30, 0, 10),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = CurrentTheme.TextDark,
        TextSize = 18,
        Parent = notification
    })
    
    -- Animations
    Tween(notification, {Position = UDim2.new(0, 0, 0, 0)}, 0.4, Enum.EasingStyle.Back)
    Tween(progress, {Size = UDim2.new(0, 0, 1, 0)}, duration, Enum.EasingStyle.Linear)
    
    local function close()
        Tween(notification, {Position = UDim2.new(1, 100, 0, 0), BackgroundTransparency = 1}, 0.3)
        task.delay(0.3, function()
            notification:Destroy()
        end)
    end
    
    closeBtn.MouseButton1Click:Connect(close)
    closeBtn.MouseEnter:Connect(function()
        Tween(closeBtn, {TextColor3 = CurrentTheme.Error}, 0.2)
    end)
    closeBtn.MouseLeave:Connect(function()
        Tween(closeBtn, {TextColor3 = CurrentTheme.TextDark}, 0.2)
    end)
    
    task.delay(duration, close)
end

-- ═══════════════════════════════════════════════════════════════
-- MAIN LIBRARY
-- ═══════════════════════════════════════════════════════════════

function LuxuraLib:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Luxura UI"
    local subtitle = config.Subtitle or "v2.0"
    local theme = config.Theme or "Dark"
    local size = config.Size or UDim2.new(0, 650, 0, 450)
    local keybind = config.Keybind or Enum.KeyCode.RightControl
    
    CurrentTheme = Themes[theme] or Themes.Dark
    
    -- Destroy existing GUI
    if CoreGui:FindFirstChild("LuxuraUI") then
        CoreGui:FindFirstChild("LuxuraUI"):Destroy()
    end
    
    ScreenGui = Create("ScreenGui", {
        Name = "LuxuraUI",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Parent = CoreGui
    })
    
    CreateNotificationHolder()
    
    -- Main Container with blur
    local mainContainer = Create("Frame", {
        Name = "MainContainer",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = CurrentTheme.Primary,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = size,
        ClipsDescendants = true,
        Parent = ScreenGui
    })
    AddCorner(mainContainer, 16)
    AddStroke(mainContainer, CurrentTheme.Border, 2, 0.3)
    AddShadow(mainContainer, 60, 0.4)
    
    -- Animated gradient background
    local gradientBg = Create("Frame", {
        Name = "GradientBg",
        BackgroundColor3 = CurrentTheme.Accent,
        BackgroundTransparency = 0.95,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 0,
        Parent = mainContainer
    })
    local gradient = AddGradient(gradientBg, {
        ColorSequenceKeypoint.new(0, CurrentTheme.Accent),
        ColorSequenceKeypoint.new(0.5, CurrentTheme.AccentLight),
        ColorSequenceKeypoint.new(1, CurrentTheme.Accent)
    }, 45)
    
    -- Animate gradient
    task.spawn(function()
        while gradientBg and gradientBg.Parent do
            Tween(gradient, {Rotation = gradient.Rotation + 360}, 10, Enum.EasingStyle.Linear)
            task.wait(10)
        end
    end)
    
    -- Top bar
    local topBar = Create("Frame", {
        Name = "TopBar",
        BackgroundColor3 = CurrentTheme.Secondary,
        Size = UDim2.new(1, 0, 0, 55),
        Parent = mainContainer
    })
    Create("UICorner", {
        CornerRadius = UDim.new(0, 16),
        Parent = topBar
    })
    
    -- Fix corners
    local cornerFix = Create("Frame", {
        Name = "CornerFix",
        BackgroundColor3 = CurrentTheme.Secondary,
        Position = UDim2.new(0, 0, 1, -16),
        Size = UDim2.new(1, 0, 0, 16),
        BorderSizePixel = 0,
        Parent = topBar
    })
    
    -- Logo/Icon
    local logoContainer = Create("Frame", {
        Name = "LogoContainer",
        BackgroundColor3 = CurrentTheme.Accent,
        Position = UDim2.new(0, 16, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 38, 0, 38),
        Parent = topBar
    })
    AddCorner(logoContainer, 10)
    AddGradient(logoContainer, {
        ColorSequenceKeypoint.new(0, CurrentTheme.Accent),
        ColorSequenceKeypoint.new(1, CurrentTheme.AccentDark)
    }, 135)
    
    local logoIcon = Create("TextLabel", {
        Name = "LogoIcon",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "L",
        TextColor3 = CurrentTheme.Text,
        TextSize = 20,
        Parent = logoContainer
    })
    
    -- Title
    local titleLabel = Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 65, 0, 10),
        Size = UDim2.new(0, 200, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = CurrentTheme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar
    })
    
    local subtitleLabel = Create("TextLabel", {
        Name = "Subtitle",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 65, 0, 30),
        Size = UDim2.new(0, 200, 0, 16),
        Font = Enum.Font.Gotham,
        Text = subtitle,
        TextColor3 = CurrentTheme.TextDark,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar
    })
    
    -- Window controls
    local controlsContainer = Create("Frame", {
        Name = "Controls",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -120, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Size = UDim2.new(0, 100, 0, 30),
        Parent = topBar
    })
    
    Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8),
        Parent = controlsContainer
    })
    
    local function createControlButton(name, icon, color, callback)
        local btn = Create("TextButton", {
            Name = name,
            BackgroundColor3 = CurrentTheme.Tertiary,
            Size = UDim2.new(0, 28, 0, 28),
            Font = Enum.Font.GothamBold,
            Text = icon,
            TextColor3 = CurrentTheme.TextDark,
            TextSize = 14,
            Parent = controlsContainer
        })
        AddCorner(btn, 8)
        
        btn.MouseEnter:Connect(function()
            Tween(btn, {BackgroundColor3 = color, TextColor3 = CurrentTheme.Text}, 0.2)
        end)
        btn.MouseLeave:Connect(function()
            Tween(btn, {BackgroundColor3 = CurrentTheme.Tertiary, TextColor3 = CurrentTheme.TextDark}, 0.2)
        end)
        btn.MouseButton1Click:Connect(function()
            Ripple(btn)
            if callback then callback() end
        end)
        
        return btn
    end
    
    local minimized = false
    local originalSize = size
    
    createControlButton("Minimize", "—", CurrentTheme.Warning, function()
        minimized = not minimized
        if minimized then
            Tween(mainContainer, {Size = UDim2.new(0, size.X.Offset, 0, 55)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        else
            Tween(mainContainer, {Size = originalSize}, 0.3, Enum.EasingStyle.Back)
        end
    end)
    
    createControlButton("Close", "×", CurrentTheme.Error, function()
        Tween(mainContainer, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, 0.3)
        task.delay(0.3, function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainContainer.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Tween(mainContainer, {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }, 0.05)
        end
    end)
    
    -- Tab container
    local tabContainer = Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = CurrentTheme.Secondary,
        Position = UDim2.new(0, 0, 0, 55),
        Size = UDim2.new(0, 180, 1, -55),
        Parent = mainContainer
    })
    
    -- Tab list
    local tabList = Create("ScrollingFrame", {
        Name = "TabList",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 12),
        Size = UDim2.new(1, -24, 1, -24),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = CurrentTheme.Accent,
        ScrollBarImageTransparency = 0.5,
        Parent = tabContainer
    })
    
    Create("UIListLayout", {
        Padding = UDim.new(0, 6),
        Parent = tabList
    })
    
    -- Content container
    local contentContainer = Create("Frame", {
        Name = "ContentContainer",
        BackgroundColor3 = CurrentTheme.Primary,
        Position = UDim2.new(0, 180, 0, 55),
        Size = UDim2.new(1, -180, 1, -55),
        ClipsDescendants = true,
        Parent = mainContainer
    })
    
    -- Keybind to toggle
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == keybind then
            mainContainer.Visible = not mainContainer.Visible
        end
    end)
    
    -- Opening animation
    mainContainer.Size = UDim2.new(0, 0, 0, 0)
    mainContainer.BackgroundTransparency = 1
    Tween(mainContainer, {Size = originalSize, BackgroundTransparency = 0}, 0.5, Enum.EasingStyle.Back)
    
    -- Window object
    local Window = {}
    Window.Tabs = {}
    local currentTab = nil
    
    function Window:SetTheme(themeName)
        if Themes[themeName] then
            CurrentTheme = Themes[themeName]
            -- Update all colors (simplified)
            mainContainer.BackgroundColor3 = CurrentTheme.Primary
            topBar.BackgroundColor3 = CurrentTheme.Secondary
            tabContainer.BackgroundColor3 = CurrentTheme.Secondary
            contentContainer.BackgroundColor3 = CurrentTheme.Primary
        end
    end
    
    function Window:CreateTab(config)
        config = config or {}
        local tabName = config.Name or "Tab"
        local tabIcon = config.Icon or "rbxassetid://7733960981"
        
        local tabBtn = Create("TextButton", {
            Name = tabName,
            BackgroundColor3 = CurrentTheme.Tertiary,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 42),
            Font = Enum.Font.Gotham,
            Text = "",
            Parent = tabList
        })
        AddCorner(tabBtn, 10)
        
        -- Tab icon
        local iconLabel = Create("ImageLabel", {
            Name = "Icon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 14, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, 18, 0, 18),
            Image = tabIcon,
            ImageColor3 = CurrentTheme.TextDark,
            Parent = tabBtn
        })
        
        -- Tab name
        local nameLabel = Create("TextLabel", {
            Name = "Name",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 42, 0, 0),
            Size = UDim2.new(1, -56, 1, 0),
            Font = Enum.Font.GothamMedium,
            Text = tabName,
            TextColor3 = CurrentTheme.TextDark,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tabBtn
        })
        
        -- Selection indicator
        local indicator = Create("Frame", {
            Name = "Indicator",
            BackgroundColor3 = CurrentTheme.Accent,
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(0, 3, 0, 0),
            Parent = tabBtn
        })
        AddCorner(indicator, 2)
        
        -- Tab content page
        local tabPage = Create("ScrollingFrame", {
            Name = tabName .. "Page",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = CurrentTheme.Accent,
            ScrollBarImageTransparency = 0.5,
            Visible = false,
            Parent = contentContainer
        })
        AddPadding(tabPage, 16)
        
        local pageLayout = Create("UIListLayout", {
            Padding = UDim.new(0, 12),
            Parent = tabPage
        })
        
        -- Auto-resize canvas
        pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabPage.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 32)
        end)
        
        -- Tab selection
        local function selectTab()
            for _, tab in pairs(Window.Tabs) do
                Tween(tab.Button, {BackgroundTransparency = 1}, 0.2)
                Tween(tab.Icon, {ImageColor3 = CurrentTheme.TextDark}, 0.2)
                Tween(tab.Name, {TextColor3 = CurrentTheme.TextDark}, 0.2)
                Tween(tab.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.2)
                tab.Page.Visible = false
            end
            
            Tween(tabBtn, {BackgroundTransparency = 0.8}, 0.2)
            Tween(iconLabel, {ImageColor3 = CurrentTheme.Accent}, 0.2)
            Tween(nameLabel, {TextColor3 = CurrentTheme.Text}, 0.2)
            Tween(indicator, {Size = UDim2.new(0, 3, 0.6, 0)}, 0.3, Enum.EasingStyle.Back)
            tabPage.Visible = true
            currentTab = tabName
        end
        
        tabBtn.MouseButton1Click:Connect(function()
            Ripple(tabBtn)
            selectTab()
        end)
        
        tabBtn.MouseEnter:Connect(function()
            if currentTab ~= tabName then
                Tween(tabBtn, {BackgroundTransparency = 0.9}, 0.2)
            end
        end)
        
        tabBtn.MouseLeave:Connect(function()
            if currentTab ~= tabName then
                Tween(tabBtn, {BackgroundTransparency = 1}, 0.2)
            end
        end)
        
        -- Update tab list canvas size
        local tabListLayout = tabList:FindFirstChildOfClass("UIListLayout")
        tabList.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y)
        
        local Tab = {
            Button = tabBtn,
            Icon = iconLabel,
            Name = nameLabel,
            Indicator = indicator,
            Page = tabPage
        }
        
        -- Select first tab
        if #Window.Tabs == 0 then
            task.defer(selectTab)
        end
        
        table.insert(Window.Tabs, Tab)
        
        -- ═══════════════════════════════════════════════════════════════
        -- TAB ELEMENTS
        -- ═══════════════════════════════════════════════════════════════
        
        function Tab:CreateSection(name)
            local section = Create("Frame", {
                Name = name .. "Section",
                BackgroundColor3 = CurrentTheme.Secondary,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = tabPage
            })
            AddCorner(section, 12)
            AddStroke(section, CurrentTheme.Border, 1, 0.5)
            
            -- Section header
            local header = Create("Frame", {
                Name = "Header",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 40),
                Parent = section
            })
            
            local headerLine = Create("Frame", {
                Name = "Line",
                BackgroundColor3 = CurrentTheme.Accent,
                Position = UDim2.new(0, 14, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Size = UDim2.new(0, 3, 0, 16),
                Parent = header
            })
            AddCorner(headerLine, 2)
            
            local headerText = Create("TextLabel", {
                Name = "Text",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 26, 0, 0),
                Size = UDim2.new(1, -40, 1, 0),
                Font = Enum.Font.GothamBold,
                Text = name,
                TextColor3 = CurrentTheme.Text,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = header
            })
            
            -- Elements container
            local elements = Create("Frame", {
                Name = "Elements",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = section
            })
            AddPadding(elements, 10)
            
            Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                Parent = elements
            })
            
            local Section = {}
            
            -- BUTTON
            function Section:CreateButton(config)
                config = config or {}
                local btnName = config.Name or "Button"
                local btnDesc = config.Description
                local callback = config.Callback or function() end
                
                local height = btnDesc and 58 or 42
                
                local btnHolder = Create("Frame", {
                    Name = btnName .. "Button",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    Parent = elements
                })
                AddCorner(btnHolder, 10)
                
                local btn = Create("TextButton", {
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    Parent = btnHolder
                })
                
                local btnText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, btnDesc and 10 or 0),
                    Size = UDim2.new(1, -28, 0, btnDesc and 20 or height),
                    Font = Enum.Font.GothamMedium,
                    Text = btnName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = btnHolder
                })
                
                if btnDesc then
                    local descText = Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 32),
                        Size = UDim2.new(1, -28, 0, 18),
                        Font = Enum.Font.Gotham,
                        Text = btnDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = btnHolder
                    })
                end
                
                -- Arrow icon
                local arrow = Create("TextLabel", {
                    Name = "Arrow",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -30, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 16, 0, 16),
                    Font = Enum.Font.GothamBold,
                    Text = "→",
                    TextColor3 = CurrentTheme.TextDark,
                    TextSize = 14,
                    Parent = btnHolder
                })
                
                btn.MouseEnter:Connect(function()
                    Tween(btnHolder, {BackgroundColor3 = CurrentTheme.Accent}, 0.2)
                    Tween(arrow, {Position = UDim2.new(1, -26, 0.5, 0)}, 0.2)
                end)
                btn.MouseLeave:Connect(function()
                    Tween(btnHolder, {BackgroundColor3 = CurrentTheme.Tertiary}, 0.2)
                    Tween(arrow, {Position = UDim2.new(1, -30, 0.5, 0)}, 0.2)
                end)
                btn.MouseButton1Click:Connect(function()
                    Ripple(btn)
                    callback()
                end)
            end
            
            -- TOGGLE
            function Section:CreateToggle(config)
                config = config or {}
                local toggleName = config.Name or "Toggle"
                local toggleDesc = config.Description
                local default = config.Default or false
                local callback = config.Callback or function() end
                
                local toggled = default
                local height = toggleDesc and 58 or 42
                
                local toggleHolder = Create("Frame", {
                    Name = toggleName .. "Toggle",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    Parent = elements
                })
                AddCorner(toggleHolder, 10)
                
                local toggleBtn = Create("TextButton", {
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    Parent = toggleHolder
                })
                
                local toggleText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, toggleDesc and 10 or 0),
                    Size = UDim2.new(1, -80, 0, toggleDesc and 20 or height),
                    Font = Enum.Font.GothamMedium,
                    Text = toggleName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = toggleHolder
                })
                
                if toggleDesc then
                    local descText = Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 32),
                        Size = UDim2.new(1, -80, 0, 18),
                        Font = Enum.Font.Gotham,
                        Text = toggleDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = toggleHolder
                    })
                end
                
                -- Toggle switch
                local switch = Create("Frame", {
                    Name = "Switch",
                    BackgroundColor3 = CurrentTheme.Primary,
                    Position = UDim2.new(1, -60, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 46, 0, 24),
                    Parent = toggleHolder
                })
                AddCorner(switch, 12)
                AddStroke(switch, CurrentTheme.Border, 1, 0.5)
                
                local knob = Create("Frame", {
                    Name = "Knob",
                    BackgroundColor3 = CurrentTheme.TextDark,
                    Position = UDim2.new(0, 3, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 18, 0, 18),
                    Parent = switch
                })
                AddCorner(knob, 10)
                
                local function updateToggle()
                    if toggled then
                        Tween(switch, {BackgroundColor3 = CurrentTheme.Accent}, 0.2)
                        Tween(knob, {Position = UDim2.new(1, -21, 0.5, 0), BackgroundColor3 = CurrentTheme.Text}, 0.2, Enum.EasingStyle.Back)
                    else
                        Tween(switch, {BackgroundColor3 = CurrentTheme.Primary}, 0.2)
                        Tween(knob, {Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = CurrentTheme.TextDark}, 0.2, Enum.EasingStyle.Back)
                    end
                    callback(toggled)
                end
                
                if default then
                    updateToggle()
                end
                
                toggleBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    updateToggle()
                end)
                
                toggleBtn.MouseEnter:Connect(function()
                    Tween(toggleHolder, {BackgroundColor3 = Color3.fromRGB(
                        CurrentTheme.Tertiary.R * 255 + 10,
                        CurrentTheme.Tertiary.G * 255 + 10,
                        CurrentTheme.Tertiary.B * 255 + 10
                    )}, 0.2)
                end)
                toggleBtn.MouseLeave:Connect(function()
                    Tween(toggleHolder, {BackgroundColor3 = CurrentTheme.Tertiary}, 0.2)
                end)
                
                local ToggleObj = {}
                function ToggleObj:Set(value)
                    toggled = value
                    updateToggle()
                end
                function ToggleObj:Get()
                    return toggled
                end
                return ToggleObj
            end
            
            -- SLIDER
            function Section:CreateSlider(config)
                config = config or {}
                local sliderName = config.Name or "Slider"
                local sliderDesc = config.Description
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local increment = config.Increment or 1
                local suffix = config.Suffix or ""
                local callback = config.Callback or function() end
                
                local value = default
                local height = sliderDesc and 75 or 60
                
                local sliderHolder = Create("Frame", {
                    Name = sliderName .. "Slider",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    Parent = elements
                })
                AddCorner(sliderHolder, 10)
                
                local sliderText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, 10),
                    Size = UDim2.new(0.5, -14, 0, 18),
                    Font = Enum.Font.GothamMedium,
                    Text = sliderName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = sliderHolder
                })
                
                local valueLabel = Create("TextLabel", {
                    Name = "Value",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0, 10),
                    Size = UDim2.new(0.5, -14, 0, 18),
                    Font = Enum.Font.GothamBold,
                    Text = tostring(value) .. suffix,
                    TextColor3 = CurrentTheme.Accent,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = sliderHolder
                })
                
                if sliderDesc then
                    local descText = Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 28),
                        Size = UDim2.new(1, -28, 0, 16),
                        Font = Enum.Font.Gotham,
                        Text = sliderDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = sliderHolder
                    })
                end
                
                -- Slider track
                local track = Create("Frame", {
                    Name = "Track",
                    BackgroundColor3 = CurrentTheme.Primary,
                    Position = UDim2.new(0, 14, 1, -20),
                    Size = UDim2.new(1, -28, 0, 6),
                    Parent = sliderHolder
                })
                AddCorner(track, 3)
                
                local fill = Create("Frame", {
                    Name = "Fill",
                    BackgroundColor3 = CurrentTheme.Accent,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    Parent = track
                })
                AddCorner(fill, 3)
                AddGradient(fill, {
                    ColorSequenceKeypoint.new(0, CurrentTheme.AccentDark),
                    ColorSequenceKeypoint.new(1, CurrentTheme.Accent)
                }, 0)
                
                local knob = Create("Frame", {
                    Name = "Knob",
                    BackgroundColor3 = CurrentTheme.Text,
                    Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 16, 0, 16),
                    Parent = track
                })
                AddCorner(knob, 8)
                AddStroke(knob, CurrentTheme.Accent, 2, 0)
                
                local dragging = false
                
                local function updateSlider(input)
                    local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    value = math.floor((min + (max - min) * pos) / increment + 0.5) * increment
                    value = math.clamp(value, min, max)
                    
                    local percent = (value - min) / (max - min)
                    Tween(fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                    Tween(knob, {Position = UDim2.new(percent, 0, 0.5, 0)}, 0.1)
                    valueLabel.Text = tostring(value) .. suffix
                    callback(value)
                end
                
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        updateSlider(input)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateSlider(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)
                
                local SliderObj = {}
                function SliderObj:Set(val)
                    value = math.clamp(val, min, max)
                    local percent = (value - min) / (max - min)
                    Tween(fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.2)
                    Tween(knob, {Position = UDim2.new(percent, 0, 0.5, 0)}, 0.2)
                    valueLabel.Text = tostring(value) .. suffix
                    callback(value)
                end
                function SliderObj:Get()
                    return value
                end
                return SliderObj
            end
            
            -- DROPDOWN
            function Section:CreateDropdown(config)
                config = config or {}
                local dropName = config.Name or "Dropdown"
                local dropDesc = config.Description
                local options = config.Options or {}
                local default = config.Default
                local multiSelect = config.MultiSelect or false
                local callback = config.Callback or function() end
                
                local selected = multiSelect and {} or default
                local opened = false
                local height = dropDesc and 58 or 42
                
                if multiSelect and default then
                    for _, v in pairs(default) do
                        selected[v] = true
                    end
                end
                
                local dropHolder = Create("Frame", {
                    Name = dropName .. "Dropdown",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    ClipsDescendants = true,
                    Parent = elements
                })
                AddCorner(dropHolder, 10)
                
                local dropBtn = Create("TextButton", {
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, height),
                    Text = "",
                    Parent = dropHolder
                })
                
                local dropText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, dropDesc and 10 or 0),
                    Size = UDim2.new(1, -80, 0, dropDesc and 20 or height),
                    Font = Enum.Font.GothamMedium,
                    Text = dropName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = dropHolder
                })
                
                if dropDesc then
                    Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 32),
                        Size = UDim2.new(1, -80, 0, 18),
                        Font = Enum.Font.Gotham,
                        Text = dropDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = dropHolder
                    })
                end
                
                -- Selected display
                local selectedDisplay = Create("TextLabel", {
                    Name = "Selected",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -50, 0, dropDesc and 10 or 0),
                    Size = UDim2.new(0, 30, 0, dropDesc and 20 or height),
                    Font = Enum.Font.Gotham,
                    Text = default or "...",
                    TextColor3 = CurrentTheme.Accent,
                    TextSize = 11,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = dropHolder
                })
                
                -- Arrow
                local arrow = Create("TextLabel", {
                    Name = "Arrow",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -30, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 16, 0, height),
                    Font = Enum.Font.GothamBold,
                    Text = "▼",
                    TextColor3 = CurrentTheme.TextDark,
                    TextSize = 10,
                    Parent = dropHolder
                })
                
                -- Options container
                local optionsContainer = Create("Frame", {
                    Name = "Options",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, height + 5),
                    Size = UDim2.new(1, -16, 0, 0),
                    ClipsDescendants = true,
                    Parent = dropHolder
                })
                
                Create("UIListLayout", {
                    Padding = UDim.new(0, 4),
                    Parent = optionsContainer
                })
                
                local function updateDisplay()
                    if multiSelect then
                        local list = {}
                        for opt, _ in pairs(selected) do
                            table.insert(list, opt)
                        end
                        selectedDisplay.Text = #list > 0 and table.concat(list, ", ") or "..."
                    else
                        selectedDisplay.Text = selected or "..."
                    end
                end
                
                local function createOption(optionName)
                    local optBtn = Create("TextButton", {
                        Name = optionName,
                        BackgroundColor3 = CurrentTheme.Primary,
                        Size = UDim2.new(1, 0, 0, 32),
                        Font = Enum.Font.Gotham,
                        Text = "",
                        Parent = optionsContainer
                    })
                    AddCorner(optBtn, 8)
                    
                    local optText = Create("TextLabel", {
                        Name = "Text",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -40, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = optionName,
                        TextColor3 = CurrentTheme.TextDark,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = optBtn
                    })
                    
                    local check = Create("TextLabel", {
                        Name = "Check",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -30, 0.5, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        Size = UDim2.new(0, 20, 0, 20),
                        Font = Enum.Font.GothamBold,
                        Text = "✓",
                        TextColor3 = CurrentTheme.Accent,
                        TextTransparency = 1,
                        TextSize = 14,
                        Parent = optBtn
                    })
                    
                    local function updateCheck()
                        local isSelected = multiSelect and selected[optionName] or selected == optionName
                        Tween(check, {TextTransparency = isSelected and 0 or 1}, 0.2)
                        Tween(optText, {TextColor3 = isSelected and CurrentTheme.Accent or CurrentTheme.TextDark}, 0.2)
                    end
                    
                    optBtn.MouseEnter:Connect(function()
                        Tween(optBtn, {BackgroundColor3 = CurrentTheme.Secondary}, 0.2)
                    end)
                    optBtn.MouseLeave:Connect(function()
                        Tween(optBtn, {BackgroundColor3 = CurrentTheme.Primary}, 0.2)
                    end)
                    optBtn.MouseButton1Click:Connect(function()
                        if multiSelect then
                            selected[optionName] = not selected[optionName]
                            if not selected[optionName] then selected[optionName] = nil end
                            callback(selected)
                        else
                            selected = optionName
                            callback(selected)
                        end
                        updateCheck()
                        updateDisplay()
                        
                        for _, child in pairs(optionsContainer:GetChildren()) do
                            if child:IsA("TextButton") and child.Name ~= optionName then
                                local otherCheck = child:FindFirstChild("Check")
                                local otherText = child:FindFirstChild("Text")
                                if otherCheck and otherText then
                                    local isSelected = multiSelect and selected[child.Name] or selected == child.Name
                                    Tween(otherCheck, {TextTransparency = isSelected and 0 or 1}, 0.2)
                                    Tween(otherText, {TextColor3 = isSelected and CurrentTheme.Accent or CurrentTheme.TextDark}, 0.2)
                                end
                            end
                        end
                    end)
                    
                    updateCheck()
                end
                
                for _, opt in pairs(options) do
                    createOption(opt)
                end
                
                local optionsHeight = #options * 36
                
                local function toggleDropdown()
                    opened = not opened
                    local targetHeight = opened and (height + optionsHeight + 15) or height
                    Tween(dropHolder, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.3, Enum.EasingStyle.Back)
                    Tween(arrow, {Rotation = opened and 180 or 0}, 0.3)
                    Tween(optionsContainer, {Size = UDim2.new(1, -16, 0, opened and optionsHeight or 0)}, 0.3)
                end
                
                dropBtn.MouseButton1Click:Connect(toggleDropdown)
                
                dropBtn.MouseEnter:Connect(function()
                    Tween(dropHolder, {BackgroundColor3 = Color3.fromRGB(
                        CurrentTheme.Tertiary.R * 255 + 8,
                        CurrentTheme.Tertiary.G * 255 + 8,
                        CurrentTheme.Tertiary.B * 255 + 8
                    )}, 0.2)
                end)
                dropBtn.MouseLeave:Connect(function()
                    Tween(dropHolder, {BackgroundColor3 = CurrentTheme.Tertiary}, 0.2)
                end)
                
                updateDisplay()
                
                local DropObj = {}
                function DropObj:Set(value)
                    if multiSelect then
                        selected = {}
                        for _, v in pairs(value) do
                            selected[v] = true
                        end
                    else
                        selected = value
                    end
                    updateDisplay()
                    callback(selected)
                end
                function DropObj:Get()
                    return selected
                end
                function DropObj:Refresh(newOptions)
                    for _, child in pairs(optionsContainer:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    options = newOptions
                    for _, opt in pairs(options) do
                        createOption(opt)
                    end
                    optionsHeight = #options * 36
                end
                return DropObj
            end
            
            -- INPUT
            function Section:CreateInput(config)
                config = config or {}
                local inputName = config.Name or "Input"
                local inputDesc = config.Description
                local placeholder = config.Placeholder or "Type here..."
                local default = config.Default or ""
                local callback = config.Callback or function() end
                
                local height = inputDesc and 75 or 60
                
                local inputHolder = Create("Frame", {
                    Name = inputName .. "Input",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    Parent = elements
                })
                AddCorner(inputHolder, 10)
                
                local inputText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, 10),
                    Size = UDim2.new(1, -28, 0, 18),
                    Font = Enum.Font.GothamMedium,
                    Text = inputName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = inputHolder
                })
                
                if inputDesc then
                    Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 28),
                        Size = UDim2.new(1, -28, 0, 16),
                        Font = Enum.Font.Gotham,
                        Text = inputDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = inputHolder
                    })
                end
                
                local inputBox = Create("TextBox", {
                    Name = "InputBox",
                    BackgroundColor3 = CurrentTheme.Primary,
                    Position = UDim2.new(0, 14, 1, -32),
                    Size = UDim2.new(1, -28, 0, 26),
                    Font = Enum.Font.Gotham,
                    Text = default,
                    PlaceholderText = placeholder,
                    PlaceholderColor3 = CurrentTheme.TextDarker,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 12,
                    ClearTextOnFocus = false,
                    Parent = inputHolder
                })
                AddCorner(inputBox, 6)
                AddPadding(inputBox, 8)
                
                local inputStroke = AddStroke(inputBox, CurrentTheme.Border, 1, 0.5)
                
                inputBox.Focused:Connect(function()
                    Tween(inputStroke, {Color = CurrentTheme.Accent, Transparency = 0}, 0.2)
                end)
                inputBox.FocusLost:Connect(function(enterPressed)
                    Tween(inputStroke, {Color = CurrentTheme.Border, Transparency = 0.5}, 0.2)
                    callback(inputBox.Text, enterPressed)
                end)
                
                local InputObj = {}
                function InputObj:Set(value)
                    inputBox.Text = value
                    callback(value, false)
                end
                function InputObj:Get()
                    return inputBox.Text
                end
                return InputObj
            end
            
            -- KEYBIND
            function Section:CreateKeybind(config)
                config = config or {}
                local keybindName = config.Name or "Keybind"
                local keybindDesc = config.Description
                local default = config.Default or Enum.KeyCode.E
                local callback = config.Callback or function() end
                
                local currentKey = default
                local listening = false
                local height = keybindDesc and 58 or 42
                
                local keybindHolder = Create("Frame", {
                    Name = keybindName .. "Keybind",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    Parent = elements
                })
                AddCorner(keybindHolder, 10)
                
                local keybindBtn = Create("TextButton", {
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    Parent = keybindHolder
                })
                
                local keybindText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, keybindDesc and 10 or 0),
                    Size = UDim2.new(1, -100, 0, keybindDesc and 20 or height),
                    Font = Enum.Font.GothamMedium,
                    Text = keybindName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybindHolder
                })
                
                if keybindDesc then
                    Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 32),
                        Size = UDim2.new(1, -100, 0, 18),
                        Font = Enum.Font.Gotham,
                        Text = keybindDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = keybindHolder
                    })
                end
                
                local keyDisplay = Create("Frame", {
                    Name = "KeyDisplay",
                    BackgroundColor3 = CurrentTheme.Primary,
                    Position = UDim2.new(1, -80, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 65, 0, 28),
                    Parent = keybindHolder
                })
                AddCorner(keyDisplay, 6)
                AddStroke(keyDisplay, CurrentTheme.Border, 1, 0.5)
                
                local keyText = Create("TextLabel", {
                    Name = "KeyText",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = Enum.Font.GothamBold,
                    Text = default.Name,
                    TextColor3 = CurrentTheme.Accent,
                    TextSize = 11,
                    Parent = keyDisplay
                })
                
                keybindBtn.MouseButton1Click:Connect(function()
                    listening = true
                    keyText.Text = "..."
                    Tween(keyDisplay, {BackgroundColor3 = CurrentTheme.Accent}, 0.2)
                    Tween(keyText, {TextColor3 = CurrentTheme.Text}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input, processed)
                    if listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            currentKey = input.KeyCode
                            keyText.Text = input.KeyCode.Name
                            listening = false
                            Tween(keyDisplay, {BackgroundColor3 = CurrentTheme.Primary}, 0.2)
                            Tween(keyText, {TextColor3 = CurrentTheme.Accent}, 0.2)
                        end
                    elseif not processed and input.KeyCode == currentKey then
                        callback(currentKey)
                    end
                end)
                
                keybindBtn.MouseEnter:Connect(function()
                    Tween(keybindHolder, {BackgroundColor3 = Color3.fromRGB(
                        CurrentTheme.Tertiary.R * 255 + 8,
                        CurrentTheme.Tertiary.G * 255 + 8,
                        CurrentTheme.Tertiary.B * 255 + 8
                    )}, 0.2)
                end)
                keybindBtn.MouseLeave:Connect(function()
                    Tween(keybindHolder, {BackgroundColor3 = CurrentTheme.Tertiary}, 0.2)
                end)
                
                local KeybindObj = {}
                function KeybindObj:Set(key)
                    currentKey = key
                    keyText.Text = key.Name
                end
                function KeybindObj:Get()
                    return currentKey
                end
                return KeybindObj
            end
            
            -- COLOR PICKER
            function Section:CreateColorPicker(config)
                config = config or {}
                local colorName = config.Name or "Color Picker"
                local colorDesc = config.Description
                local default = config.Default or Color3.fromRGB(255, 255, 255)
                local callback = config.Callback or function() end
                
                local currentColor = default
                local opened = false
                local height = colorDesc and 58 or 42
                
                local colorHolder = Create("Frame", {
                    Name = colorName .. "ColorPicker",
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    Size = UDim2.new(1, 0, 0, height),
                    ClipsDescendants = true,
                    Parent = elements
                })
                AddCorner(colorHolder, 10)
                
                local colorBtn = Create("TextButton", {
                    Name = "Button",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, height),
                    Text = "",
                    Parent = colorHolder
                })
                
                local colorText = Create("TextLabel", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14, 0, colorDesc and 10 or 0),
                    Size = UDim2.new(1, -80, 0, colorDesc and 20 or height),
                    Font = Enum.Font.GothamMedium,
                    Text = colorName,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = colorHolder
                })
                
                if colorDesc then
                    Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 14, 0, 32),
                                                Size = UDim2.new(1, -80, 0, 18),
                        Font = Enum.Font.Gotham,
                        Text = colorDesc,
                        TextColor3 = CurrentTheme.TextDarker,
                        TextSize = 11,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Parent = colorHolder
                    })
                end
                
                -- Color preview
                local colorPreview = Create("Frame", {
                    Name = "Preview",
                    BackgroundColor3 = default,
                    Position = UDim2.new(1, -55, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 40, 0, 26),
                    Parent = colorHolder
                })
                AddCorner(colorPreview, 6)
                AddStroke(colorPreview, CurrentTheme.Border, 1, 0.3)
                
                -- Color picker panel
                local pickerPanel = Create("Frame", {
                    Name = "PickerPanel",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, height + 10),
                    Size = UDim2.new(1, -20, 0, 150),
                    Parent = colorHolder
                })
                
                -- Saturation/Value picker
                local svPicker = Create("ImageLabel", {
                    Name = "SVPicker",
                    BackgroundColor3 = currentColor,
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(1, -35, 0, 120),
                    Image = "rbxassetid://4155801252",
                    Parent = pickerPanel
                })
                AddCorner(svPicker, 8)
                
                local svGradient = Create("ImageLabel", {
                    Name = "Gradient",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Image = "rbxassetid://4155801252",
                    Parent = svPicker
                })
                AddCorner(svGradient, 8)
                
                local svCursor = Create("Frame", {
                    Name = "Cursor",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(1, 0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 16, 0, 16),
                    Parent = svPicker
                })
                AddCorner(svCursor, 8)
                AddStroke(svCursor, Color3.fromRGB(0, 0, 0), 2, 0)
                
                -- Hue slider
                local hueSlider = Create("Frame", {
                    Name = "HueSlider",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(1, -25, 0, 0),
                    Size = UDim2.new(0, 20, 0, 120),
                    Parent = pickerPanel
                })
                AddCorner(hueSlider, 6)
                
                local hueGradient = Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                    }),
                    Rotation = 90,
                    Parent = hueSlider
                })
                
                local hueCursor = Create("Frame", {
                    Name = "Cursor",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Position = UDim2.new(0.5, 0, 0, 0),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(1, 6, 0, 6),
                    Parent = hueSlider
                })
                AddCorner(hueCursor, 3)
                AddStroke(hueCursor, Color3.fromRGB(0, 0, 0), 2, 0)
                
                -- RGB inputs
                local rgbContainer = Create("Frame", {
                    Name = "RGBContainer",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 128),
                    Size = UDim2.new(1, 0, 0, 22),
                    Parent = pickerPanel
                })
                
                Create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, 8),
                    Parent = rgbContainer
                })
                
                local h, s, v = currentColor:ToHSV()
                
                local function updateColor()
                    currentColor = Color3.fromHSV(h, s, v)
                    colorPreview.BackgroundColor3 = currentColor
                    svPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    callback(currentColor)
                end
                
                local function createRGBInput(label, getValue, setValue)
                    local container = Create("Frame", {
                        Name = label,
                        BackgroundColor3 = CurrentTheme.Primary,
                        Size = UDim2.new(0, 55, 1, 0),
                        Parent = rgbContainer
                    })
                    AddCorner(container, 4)
                    
                    local labelText = Create("TextLabel", {
                        Name = "Label",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 6, 0, 0),
                        Size = UDim2.new(0, 14, 1, 0),
                        Font = Enum.Font.GothamBold,
                        Text = label,
                        TextColor3 = CurrentTheme.Accent,
                        TextSize = 10,
                        Parent = container
                    })
                    
                    local input = Create("TextBox", {
                        Name = "Input",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 20, 0, 0),
                        Size = UDim2.new(1, -24, 1, 0),
                        Font = Enum.Font.Gotham,
                        Text = tostring(getValue()),
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 10,
                        Parent = container
                    })
                    
                    input.FocusLost:Connect(function()
                        local val = tonumber(input.Text)
                        if val then
                            val = math.clamp(val, 0, 255)
                            setValue(val)
                            input.Text = tostring(val)
                        else
                            input.Text = tostring(getValue())
                        end
                    end)
                    
                    return input
                end
                
                local rInput = createRGBInput("R", function() return math.floor(currentColor.R * 255) end, function(val)
                    local g, b = currentColor.G * 255, currentColor.B * 255
                    currentColor = Color3.fromRGB(val, g, b)
                    h, s, v = currentColor:ToHSV()
                    updateColor()
                end)
                
                local gInput = createRGBInput("G", function() return math.floor(currentColor.G * 255) end, function(val)
                    local r, b = currentColor.R * 255, currentColor.B * 255
                    currentColor = Color3.fromRGB(r, val, b)
                    h, s, v = currentColor:ToHSV()
                    updateColor()
                end)
                
                local bInput = createRGBInput("B", function() return math.floor(currentColor.B * 255) end, function(val)
                    local r, g = currentColor.R * 255, currentColor.G * 255
                    currentColor = Color3.fromRGB(r, g, val)
                    h, s, v = currentColor:ToHSV()
                    updateColor()
                end)
                
                -- SV Picker interaction
                local svDragging = false
                
                svPicker.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        svDragging = true
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local pos = Vector2.new(input.Position.X, input.Position.Y)
                        local relativePos = pos - svPicker.AbsolutePosition
                        s = math.clamp(relativePos.X / svPicker.AbsoluteSize.X, 0, 1)
                        v = math.clamp(1 - (relativePos.Y / svPicker.AbsoluteSize.Y), 0, 1)
                        
                        svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                        updateColor()
                        
                        rInput.Text = tostring(math.floor(currentColor.R * 255))
                        gInput.Text = tostring(math.floor(currentColor.G * 255))
                        bInput.Text = tostring(math.floor(currentColor.B * 255))
                    end
                end)
                
                -- Hue slider interaction
                local hueDragging = false
                
                hueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        hueDragging = true
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local pos = input.Position.Y
                        local relativeY = pos - hueSlider.AbsolutePosition.Y
                        h = math.clamp(relativeY / hueSlider.AbsoluteSize.Y, 0, 1)
                        
                        hueCursor.Position = UDim2.new(0.5, 0, h, 0)
                        updateColor()
                        
                        rInput.Text = tostring(math.floor(currentColor.R * 255))
                        gInput.Text = tostring(math.floor(currentColor.G * 255))
                        bInput.Text = tostring(math.floor(currentColor.B * 255))
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        svDragging = false
                        hueDragging = false
                    end
                end)
                
                -- Toggle color picker
                local function togglePicker()
                    opened = not opened
                    local targetHeight = opened and (height + 170) or height
                    Tween(colorHolder, {Size = UDim2.new(1, 0, 0, targetHeight)}, 0.3, Enum.EasingStyle.Back)
                end
                
                colorBtn.MouseButton1Click:Connect(togglePicker)
                
                colorBtn.MouseEnter:Connect(function()
                    Tween(colorHolder, {BackgroundColor3 = Color3.fromRGB(
                        CurrentTheme.Tertiary.R * 255 + 8,
                        CurrentTheme.Tertiary.G * 255 + 8,
                        CurrentTheme.Tertiary.B * 255 + 8
                    )}, 0.2)
                end)
                colorBtn.MouseLeave:Connect(function()
                    Tween(colorHolder, {BackgroundColor3 = CurrentTheme.Tertiary}, 0.2)
                end)
                
                -- Set initial position
                svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                hueCursor.Position = UDim2.new(0.5, 0, h, 0)
                
                local ColorObj = {}
                function ColorObj:Set(color)
                    currentColor = color
                    h, s, v = color:ToHSV()
                    colorPreview.BackgroundColor3 = color
                    svPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                    svCursor.Position = UDim2.new(s, 0, 1 - v, 0)
                    hueCursor.Position = UDim2.new(0.5, 0, h, 0)
                    rInput.Text = tostring(math.floor(color.R * 255))
                    gInput.Text = tostring(math.floor(color.G * 255))
                    bInput.Text = tostring(math.floor(color.B * 255))
                    callback(color)
                end
                function ColorObj:Get()
                    return currentColor
                end
                return ColorObj
            end
            
            -- LABEL
            function Section:CreateLabel(text)
                local label = Create("TextLabel", {
                    Name = "Label",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 24),
                    Font = Enum.Font.Gotham,
                    Text = text,
                    TextColor3 = CurrentTheme.TextDark,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = elements
                })
                
                local LabelObj = {}
                function LabelObj:Set(newText)
                    label.Text = newText
                end
                return LabelObj
            end
            
            -- PARAGRAPH
            function Section:CreateParagraph(config)
                config = config or {}
                local title = config.Title or "Paragraph"
                local content = config.Content or ""
                
                local paragraphHolder = Create("Frame", {
                    Name = "Paragraph",
                    BackgroundColor3 = CurrentTheme.Primary,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = elements
                })
                AddCorner(paragraphHolder, 8)
                AddPadding(paragraphHolder, 12)
                
                local titleLabel = Create("TextLabel", {
                    Name = "Title",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 18),
                    Font = Enum.Font.GothamBold,
                    Text = title,
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = paragraphHolder
                })
                
                local contentLabel = Create("TextLabel", {
                    Name = "Content",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 22),
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Font = Enum.Font.Gotham,
                    Text = content,
                    TextColor3 = CurrentTheme.TextDark,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                    Parent = paragraphHolder
                })
                
                local ParagraphObj = {}
                function ParagraphObj:Set(newConfig)
                    if newConfig.Title then titleLabel.Text = newConfig.Title end
                    if newConfig.Content then contentLabel.Text = newConfig.Content end
                end
                return ParagraphObj
            end
            
            -- DIVIDER
            function Section:CreateDivider()
                local divider = Create("Frame", {
                    Name = "Divider",
                    BackgroundColor3 = CurrentTheme.Border,
                    BackgroundTransparency = 0.5,
                    Size = UDim2.new(1, 0, 0, 1),
                    Parent = elements
                })
            end
            
            return Section
        end
        
        return Tab
    end
    
    -- Notify function on window
    function Window:Notify(config)
        LuxuraLib:Notify(config)
    end
    
    return Window
end

return LuxuraLib
