-- decrypted from locker

 local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local function AddDraggingFunctionality(DragPoint, Main)
    pcall(
        function()
            local Dragging, DragInput, StartPos, FramePos

            local function update(input)
                local Delta = input.Position - StartPos
                TweenService:Create(
                    Main,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                    {
                        Position = UDim2.new(
                            FramePos.X.Scale,
                            FramePos.X.Offset + Delta.X,
                            FramePos.Y.Scale,
                            FramePos.Y.Offset + Delta.Y
                        )
                    }
                ):Play()
            end

            DragPoint.InputBegan:Connect(
                function(input)
                    if
                        input.UserInputType == Enum.UserInputType.MouseButton1 or
                            input.UserInputType == Enum.UserInputType.Touch
                     then
                        Dragging = true
                        StartPos = input.Position
                        FramePos = Main.Position

                        input.Changed:Connect(
                            function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    Dragging = false
                                end
                            end
                        )
                    end
                end
            )

            DragPoint.InputChanged:Connect(
                function(input)
                    if
                        input.UserInputType == Enum.UserInputType.MouseMovement or
                            input.UserInputType == Enum.UserInputType.Touch
                     then
                        DragInput = input
                    end
                end
            )

            UserInputService.InputChanged:Connect(
                function(input)
                    if input == DragInput and Dragging then
                        update(input)
                    end
                end
            )
        end
    )
end
local library = {
    Theme = {
        Dark = {
            Main = Color3.fromRGB(11, 11, 15)
        }
    }
}

local Cryo = Instance.new("ScreenGui")
Cryo.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
Cryo.DisplayOrder = 10
Cryo.ResetOnSpawn = false
Cryo.Parent = CoreGui
Cryo.Name = "Cryo"
Cryo.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if gethui then
    Cryo.Parent = gethui()
else
    Cryo.Parent = CoreGui
end

if gethui then
    for _, Interface in ipairs(gethui():GetChildren()) do
        if Interface.Name == Cryo.Name and Interface ~= Cryo then
            Interface.Enabled = false
        end
    end
else
    for _, Interface in ipairs(CoreGui:GetChildren()) do
        if Interface.Name == Cryo.Name and Interface ~= Cryo then
            Interface.Enabled = false
        end
    end
end
if LocalPlayer.PlayerGui:FindFirstChild("TopbarStandard") then
    for _, v in pairs(LocalPlayer.PlayerGui.TopbarStandard.Holders.Left:GetChildren()) do
        if v.Name == "Frame" and v:FindFirstChild("Logo") then
            v.Visible = false
        end
    end
else
    for _, v in pairs(CoreGui:GetChildren()) do
        if v.Name == "CryoTop" then
            v.Enabled = false
        end
    end
    for _, v in pairs(gethui():GetChildren()) do
        if v.Name == "CryoTop" then
            v.Enabled = false
        end
    end
end

function library.Notify(Options)
    local cfg = {
        Title = Options.Title or "Warning",
        Info = Options.Info or "Info",
        Duration = Options.Duration or 10
    }
    local SnackBarTemplate = Instance.new("Frame")
    SnackBarTemplate.Parent = Cryo:FindFirstChild("SnackBarContainer")
    SnackBarTemplate.Name = "SnackBarTemplate"
    SnackBarTemplate.Position = UDim2.new(0, 0, 0.348, 0)
    SnackBarTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SnackBarTemplate.Size = UDim2.new(0.899999976, 0, 0.652, 0)
    SnackBarTemplate.BorderSizePixel = 0
    SnackBarTemplate.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
    SnackBarTemplate.BackgroundTransparency = 1
    TweenService:Create(
        SnackBarTemplate,
        TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    ):Play()
    local SnackBarTemplateCorner = Instance.new("UICorner")
    SnackBarTemplateCorner.Parent = SnackBarTemplate
    SnackBarTemplateCorner.Name = "SnackBarTemplateCorner"

    local Close = Instance.new("ImageLabel")
    Close.ImageTransparency = 0.4
    Close.Parent = SnackBarTemplate
    Close.Name = "Close"
    Close.ImageRectOffset = Vector2.new(304, 304)
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(0.907601178, 0, 0.342, 0)
    Close.Image = "rbxassetid://8445470984"
    Close.ImageRectSize = Vector2.new(96, 96)
    Close.Size = UDim2.new(0.300000012, 0, 0.3, 0)

    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Parent = Close
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height

    local DropShadow = Instance.new("ImageLabel")
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.ImageTransparency = 0.5
    DropShadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
    DropShadow.Parent = SnackBarTemplate
    DropShadow.Name = "DropShadow"
    DropShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow.Size = UDim2.new(1, 10, 1, 10)
    DropShadow.Image = "rbxassetid://297694300"
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0, -5, 0, -5)
    DropShadow.SliceScale = 0.05
    DropShadow.ZIndex = -5
    DropShadow.SliceCenter = Rect.new(Vector2.new(95, 103), Vector2.new(894, 902))

    local WarningIcon = Instance.new("Frame")
    WarningIcon.AnchorPoint = Vector2.new(0, 0.5)
    WarningIcon.Parent = SnackBarTemplate
    WarningIcon.Name = "WarningIcon"
    WarningIcon.Position = UDim2.new(0.028057693, 0, 0.498, 0)
    WarningIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    WarningIcon.Size = UDim2.new(0.1, 0, 0.5, 0)
    WarningIcon.BorderSizePixel = 0
    WarningIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = WarningIcon

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.79
    UIStroke.Parent = WarningIcon
    UIStroke.Thickness = 0.51

    local InfoOutline = Instance.new("ImageLabel")
    InfoOutline.Parent = WarningIcon
    InfoOutline.Name = "InfoOutline"
    InfoOutline.AnchorPoint = Vector2.new(0.5, 0.5)
    InfoOutline.Image = "rbxassetid://8445471499"
    InfoOutline.BackgroundTransparency = 1
    InfoOutline.Position = UDim2.new(0.5, 0, 0.5, 0)
    InfoOutline.ImageRectOffset = Vector2.new(204, 304)
    InfoOutline.ImageRectSize = Vector2.new(96, 96)
    InfoOutline.Size = UDim2.new(0.800000012, 0, 0.8, 0)

    local R_1 = Instance.new("UIGradient")
    R_1.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
    }
    R_1.Name = "R_1"
    R_1.Parent = WarningIcon

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = SnackBarTemplate
    TitleLabel.Text = cfg.Title
    TitleLabel.Size = UDim2.new(0.75, 0, 0.1, 0)
    TitleLabel.Position = UDim2.new(0.15, 0, 0.25, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
    TitleLabel.TextScaled = true
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextYAlignment = Enum.TextYAlignment.Center

    local TitleConstraint = Instance.new("UITextSizeConstraint")
    TitleConstraint.MaxTextSize = 26
    TitleConstraint.MinTextSize = 10
    TitleConstraint.Parent = TitleLabel

    -- Info Text
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Parent = SnackBarTemplate
    InfoLabel.Text = cfg.Info
    InfoLabel.Size = UDim2.new(0.7, 0, 0.1, 0)
    InfoLabel.Position = UDim2.new(0.15, 0, 0.45, 0)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    InfoLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json")
    InfoLabel.TextScaled = true
    InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    InfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    InfoLabel.TextWrapped = true

    local InfoConstraint = Instance.new("UITextSizeConstraint")
    InfoConstraint.MaxTextSize = 22
    InfoConstraint.MinTextSize = 8
    InfoConstraint.Parent = InfoLabel

    local UIStroke_1 = Instance.new("UIStroke")
    UIStroke_1.Thickness = 0.51
    UIStroke_1.Transparency = 0.79
    UIStroke_1.Parent = SnackBarTemplate
    UIStroke_1.Color = Color3.fromRGB(255, 255, 255)
    local closebtn = Instance.new("TextButton")
    closebtn.Text = ""
    closebtn.Parent = Close
    closebtn.BackgroundTransparency = 1
    closebtn.Size = UDim2.new(1, 0, 1, 0)

    local Resize = Instance.new("TextButton")
    Resize.FontFace =
        Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    Resize.TextColor3 = Color3.fromRGB(0, 0, 0)
    Resize.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Resize.Text = ""
    Resize.Parent = Main
    Resize.AnchorPoint = Vector2.new(0.5, 0.5)
    Resize.Name = "Resize"
    Resize.BackgroundTransparency = 0.86
    Resize.Position = UDim2.new(0.994983673, 0, 0.988, 0)
    Resize.Size = UDim2.new(0, 24, 0, 24)
    Resize.BorderSizePixel = 0
    Resize.TextSize = 14
    Resize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    else
    end
    Close.MouseEnter:Connect(
        function()
            TweenService:Create(
                Close,
                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 0}
            ):Play()
        end
    )
    Close.MouseLeave:Connect(
        function()
            TweenService:Create(
                Close,
                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 0.4}
            ):Play()
        end
    )
    closebtn.MouseButton1Click:Connect(
        function()
            TweenService:Create(
                Close,
                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 0.4}
            ):Play()
            TweenService:Create(
                SnackBarTemplate,
                TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            ):Play()
            wait(.2)
            SnackBarTemplate:Destroy()
        end
    )
    if cfg.Duration then
        wait(cfg.Duration)
        TweenService:Create(
            Close,
            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageTransparency = 0.4}
        ):Play()
        TweenService:Create(
            SnackBarTemplate,
            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        ):Play()
        wait(.2)
        SnackBarTemplate:Destroy()
    end
end
function library.Ads()
    local FrameRAR = Instance.new("Frame", Cryo)
    FrameRAR.Position = UDim2.new(0.5, 0, 0.15, 0)
    FrameRAR.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FrameRAR.Size = UDim2.new(0.440646738, 0, 0.249, 0)
    FrameRAR.BorderSizePixel = 0
    FrameRAR.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    FrameRAR.AnchorPoint = Vector2.new(0.5, 0.5)

    local UICornerRAR = Instance.new("UICorner", FrameRAR)

    local UIStrokeRAR = Instance.new("UIStroke", FrameRAR)
    UIStrokeRAR.Color = Color3.fromRGB(117, 117, 117)

    local Frame_1RAR = Instance.new("Frame", FrameRAR)
    Frame_1RAR.Size = UDim2.new(0.977339745, 0, 0.938, 0)
    Frame_1RAR.ClipsDescendants = true
    Frame_1RAR.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_1RAR.Position = UDim2.new(0.011281313, 0, 0.027, 0)
    Frame_1RAR.BorderSizePixel = 0
    Frame_1RAR.BackgroundColor3 = Color3.fromRGB(10, 10, 14)

    local UICorner_1RAR = Instance.new("UICorner", Frame_1RAR)

    local UIStroke_1RAR = Instance.new("UIStroke", Frame_1RAR)
    UIStroke_1RAR.Color = Color3.fromRGB(117, 117, 117)

    local ImageLabel_3RAR = Instance.new("ImageLabel", Frame_1RAR)
    ImageLabel_3RAR.Image = "rbxassetid://123440437179493"
    ImageLabel_3RAR.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_3RAR.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_3RAR.BackgroundTransparency = 1
    ImageLabel_3RAR.BorderSizePixel = 0
    ImageLabel_3RAR.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UICorner_2RAR = Instance.new("UICorner", ImageLabel_3RAR)

    TweenService:Create(
        ImageLabel_3RAR,
        TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {ImageTransparency = 1}
    ):Play()
    TweenService:Create(
        UIStroke_1RAR,
        TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    ):Play()
    TweenService:Create(
        UIStrokeRAR,
        TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Transparency = 1}
    ):Play()
    TweenService:Create(
        Frame_1RAR,
        TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    ):Play()
    TweenService:Create(
        FrameRAR,
        TweenInfo.new(10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    ):Play()
end
function library:Window(Options)
    local cfg = {
        Name = Options.Name or "ShuShi",
        ImageLogo = Options.ImageLogo or "",
        TextLogo = Options.TextLogo or "S",
        Theme = Options.Theme or library.Theme.Dark,
        Keybind = Options.Keybind or Enum.KeyCode.RightShift,
        UsingTopbar = Options.UsiingTopbar or true,
        KeybindUI = Options.KeybindUI or false
    }
    local usingTextLogo = false
    if cfg.ImageLogo == "" or cfg.ImageLogo == nil then
        usingTextLogo = true
    end

    local CryoTop = Instance.new("ScreenGui")
    CryoTop.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    CryoTop.DisplayOrder = 10
    CryoTop.ResetOnSpawn = false
    CryoTop.Name = "CryoTop"
    CryoTop.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    if gethui then
        CryoTop.Parent = gethui()
    else
        CryoTop.Parent = CoreGui
    end

    local Main = Instance.new("Frame")
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.Parent = Cryo
    Main.Name = "Main"
    Main.Position = UDim2.new(0.499709457, 0, 0.5, 0)
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.Size = UDim2.new(0, 975, 0, 620)
    Main.BorderSizePixel = 0
    Main.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
    Main.ClipsDescendants = true
    local UIScaleMain = Instance.new("UIScale", Main)
    local camera = workspace.CurrentCamera

    local function updateMainScale()
        local size = camera.ViewportSize
        if size.X < 800 then
            UIScaleMain.Scale = 0.7
        elseif size.X < 1200 then
            UIScaleMain.Scale = 0.5
        else
            UIScaleMain.Scale = 1
        end
    end

    local Minimized = false

    updateMainScale()
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateMainScale)
    local UIScaleKeybindLists = Instance.new("UIScale", KeybindLists)

    local function updateKeybindScale()
        local size = camera.ViewportSize
        local scale = UIScaleMain.Scale -- Match the main scale
        UIScaleKeybindLists.Scale = scale
    end

    updateKeybindScale()
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateKeybindScale)

    -- After Main creation (around line 350)
    local UIScaleMain = Instance.new("UIScale", Main)
    local camera = workspace.CurrentCamera

    -- Base reference size (desktop)
    local BASE_WIDTH = 975
    local BASE_HEIGHT = 620

    local function updateAllScales()
        local viewportSize = camera.ViewportSize
        local scale = 1

        -- Calculate scale based on viewport
        if viewportSize.X < 1920 then
            scale = math.clamp(viewportSize.X / 1920, 0.6, 1)
        end

        -- Apply to main
        UIScaleMain.Scale = scale

        -- Mobile specific adjustments
        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            Main.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
            UIScaleMain.Scale = math.min(viewportSize.X / BASE_WIDTH * 0.95, 1)
        else
            Main.Size = UDim2.new(0, BASE_WIDTH, 0, BASE_HEIGHT)
        end
    end

    updateAllScales()
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateAllScales)

    -- Remove the old mobile adjustment code
    --[[ DELETE THIS:
if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
    Main.Size = UDim2.new(0.95, 0, 0.9, 0)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
end
]]
    function library:ToggleUI(state)
        if state then
            -- Hide animation
            local hideTween =
                TweenService:Create(
                Main,
                TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {
                    Size = UDim2.new(0, 0, 0, 0)
                }
            )
            hideTween:Play()
            hideTween.Completed:Wait()
            Main.Visible = false
        else
            -- Prepare before showing
            Main.Visible = true
            Main.Size = UDim2.new(0, 0, 0, 0)

            -- Show animation
            local showTween =
                TweenService:Create(
                Main,
                TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
                {
                    Size = UDim2.new(0, 975, 0, 620)
                }
            )
            showTween:Play()
        end
        if Minimized then
            TweenService:Create(
                Main,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 975, 0, 64)}
            ):Play()
            TweenService:Create(
                TabMain,
                TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.127914667, 0, 0, 298)}
            ):Play()
            TweenService:Create(
                Smaller,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 1}
            ):Play()
            TweenService:Create(
                Larger,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = .5}
            ):Play()
        else
            TweenService:Create(
                Main,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 975, 0, 620)}
            ):Play()
            TweenService:Create(
                TabMain,
                TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Position = UDim2.new(0.127914667, 0, 0.5, 0)}
            ):Play()
            TweenService:Create(
                Smaller,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = .5}
            ):Play()
            TweenService:Create(
                Larger,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = 1}
            ):Play()
        end
    end
    local Holders = Instance.new("Frame")
    Holders.Parent = CryoTop
    Holders.Name = "Holders"
    Holders.BackgroundTransparency = 1
    Holders.Size = UDim2.new(1, 0, 1, -2)

    --library.Ads()
    local Left_1 = Instance.new("ScrollingFrame")
    Left_1.Parent = Holders
    Left_1.AutomaticCanvasSize = Enum.AutomaticSize.X
    Left_1.ScrollBarThickness = 0
    Left_1.Name = "Left"
    Left_1.Size = UDim2.new(1, -24, 1, 0)
    Left_1.ElasticBehavior = Enum.ElasticBehavior.Never
    Left_1.Selectable = false
    Left_1.BackgroundTransparency = 1
    Left_1.ScrollingDirection = Enum.ScrollingDirection.X
    Left_1.ScrollingEnabled = false
    Left_1.Position = UDim2.new(0, 12, 0, 0)
    Left_1.BorderSizePixel = 0
    Left_1.CanvasSize = UDim2.new(0, 0, 1, -1)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Parent = Left_1
    UIListLayout.Padding = UDim.new(0, 12)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    if cfg.UsingTopbar then
        if LocalPlayer.PlayerGui:FindFirstChild("TopbarStandard") then
            local Frame = Instance.new("Frame")
            Frame.Parent = LocalPlayer.PlayerGui:FindFirstChild("TopbarStandard").Holders.Left
            Frame.Position = UDim2.new(0.101780012, 0, 0.961, 0)
            Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame.Size = UDim2.new(0, 135, 0, 45)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
            Frame.LayoutOrder = 9999

            local P = Instance.new("UICorner")
            P.Parent = Frame
            P.Name = "P"
            P.CornerRadius = UDim.new(0, 8)

            local Logo = Instance.new("Frame")
            Logo.AnchorPoint = Vector2.new(0, 0.5)
            Logo.Parent = Frame
            Logo.Name = "Logo"
            Logo.Position = UDim2.new(0.093999997, 0, 0.5, 0)
            Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Logo.Size = UDim2.new(0, 25, 0, 25)
            Logo.BorderSizePixel = 0
            Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Logo_1 = Instance.new("ImageLabel")
            Logo_1.Visible = false
            Logo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Logo_1.Parent = Logo
            Logo_1.Name = "Logo_1"
            Logo_1.AnchorPoint = Vector2.new(0.5, 0.5)
            Logo_1.Image = "rbxassetid://" .. cfg.ImageLogo
            Logo_1.BackgroundTransparency = 1
            Logo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
            Logo_1.Size = UDim2.new(0.699999988, 0, 0.7, 0)
            Logo_1.BorderSizePixel = 0
            Logo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local SingleTextLogo = Instance.new("TextLabel")
            SingleTextLogo.TextWrapped = true
            SingleTextLogo.Parent = Logo
            SingleTextLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
            SingleTextLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SingleTextLogo.Text = cfg.TextLogo
            SingleTextLogo.Name = "SingleTextLogo"
            SingleTextLogo.Size = UDim2.new(0.800000012, 0, 0.8, 0)
            SingleTextLogo.AnchorPoint = Vector2.new(0.5, 0.5)
            SingleTextLogo.BorderSizePixel = 0
            SingleTextLogo.BackgroundTransparency = 1
            SingleTextLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
            SingleTextLogo.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            SingleTextLogo.TextSize = 14
            SingleTextLogo.TextScaled = true
            SingleTextLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UITitle = Instance.new("TextLabel")
            UITitle.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            UITitle.Parent = Frame
            UITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            UITitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            UITitle.Text = "ShuShi"
            UITitle.Name = "UITitle"
            UITitle.TextStrokeTransparency = 0.85
            UITitle.Size = UDim2.new(0, 75, 0, 30)
            UITitle.Position = UDim2.new(0.360444486, 0, 0.164, 0)
            UITitle.BackgroundTransparency = 2
            UITitle.TextXAlignment = Enum.TextXAlignment.Left
            UITitle.BorderSizePixel = 0
            UITitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            UITitle.TextSize = 20
            UITitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
            }
            UIGradient.Parent = UITitle

            local TextButton = Instance.new("TextButton")
            TextButton.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.Text = ""
            TextButton.BackgroundTransparency = 1
            TextButton.Parent = Frame
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.BorderSizePixel = 0
            TextButton.TextSize = 14
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            local R = Instance.new("UIGradient")
            R.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
            }
            R.Name = "R"
            R.Parent = Logo
            if usingTextLogo then
                SingleTextLogo.Visible = true
                Logo_1.Visible = false
            else
                SingleTextLogo.Visible = false
                Logo_1.Visible = true
            end
            TextButton.MouseButton1Click:Connect(
                function()
                    library:ToggleUI(Main.Visible)
                end
            )

            local P_1 = Instance.new("UICorner")
            P_1.Parent = Logo
            P_1.Name = "P_1"
        else
            local Frame = Instance.new("Frame")
            Frame.Parent = Left_1
            Frame.Position = UDim2.new(0.101780012, 0, 0.961, 0)
            Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame.Size = UDim2.new(0, 135, 0, 45)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
            Frame.LayoutOrder = 9999

            local P = Instance.new("UICorner")
            P.Parent = Frame
            P.Name = "P"
            P.CornerRadius = UDim.new(0, 8)

            local Logo = Instance.new("Frame")
            Logo.AnchorPoint = Vector2.new(0, 0.5)
            Logo.Parent = Frame
            Logo.Name = "Logo"
            Logo.Position = UDim2.new(0.093999997, 0, 0.5, 0)
            Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Logo.Size = UDim2.new(0, 25, 0, 25)
            Logo.BorderSizePixel = 0
            Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Logo_1 = Instance.new("ImageLabel")
            Logo_1.Visible = false
            Logo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Logo_1.Parent = Logo
            Logo_1.Name = "Logo_1"
            Logo_1.AnchorPoint = Vector2.new(0.5, 0.5)
            Logo_1.Image = "rbxassetid://" .. cfg.ImageLogo
            Logo_1.BackgroundTransparency = 1
            Logo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
            Logo_1.Size = UDim2.new(0.699999988, 0, 0.7, 0)
            Logo_1.BorderSizePixel = 0
            Logo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local SingleTextLogo = Instance.new("TextLabel")
            SingleTextLogo.TextWrapped = true
            SingleTextLogo.Parent = Logo
            SingleTextLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
            SingleTextLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SingleTextLogo.Text = cfg.TextLogo
            SingleTextLogo.Name = "SingleTextLogo"
            SingleTextLogo.Size = UDim2.new(0.800000012, 0, 0.8, 0)
            SingleTextLogo.AnchorPoint = Vector2.new(0.5, 0.5)
            SingleTextLogo.BorderSizePixel = 0
            SingleTextLogo.BackgroundTransparency = 1
            SingleTextLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
            SingleTextLogo.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            SingleTextLogo.TextSize = 14
            SingleTextLogo.TextScaled = true
            SingleTextLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UITitle = Instance.new("TextLabel")
            UITitle.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            UITitle.Parent = Frame
            UITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            UITitle.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
            UITitle.Text = cfg.Name
            UITitle.Name = "UITitle"
            UITitle.TextStrokeTransparency = 0.85
            UITitle.Size = UDim2.new(0, 75, 0, 30)
            UITitle.Position = UDim2.new(0.360444486, 0, 0.164, 0)
            UITitle.BackgroundTransparency = 2
            UITitle.TextXAlignment = Enum.TextXAlignment.Left
            UITitle.BorderSizePixel = 0
            UITitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            UITitle.TextSize = 20
            UITitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
            }
            UIGradient.Parent = UITitle

            local TextButton = Instance.new("TextButton")
            TextButton.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.Text = ""
            TextButton.BackgroundTransparency = 1
            TextButton.Parent = Frame
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.BorderSizePixel = 0
            TextButton.TextSize = 14
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            local R = Instance.new("UIGradient")
            R.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
            }
            R.Name = "R"
            R.Parent = Logo
            TextButton.MouseButton1Click:Connect(
                function()
                    library:ToggleUI(Main.Visible)
                end
            )
            if usingTextLogo then
                SingleTextLogo.Visible = true
                Logo_1.Visible = false
            else
                SingleTextLogo.Visible = false
                Logo_1.Visible = true
            end

            local P_1 = Instance.new("UICorner")
            P_1.Parent = Logo
            P_1.Name = "P_1"
        end
    end

    local KeybindLists = Instance.new("Frame")

    if cfg.KeybindUI then
        KeybindLists.Parent = Cryo
        KeybindLists.Name = "KeybindLists"
        KeybindLists.Position = UDim2.new(0.01, 0, 0.366, 0)
        KeybindLists.BorderColor3 = Color3.fromRGB(0, 0, 0)
        KeybindLists.Size = UDim2.new(0, 282, 0, 355)
        KeybindLists.BorderSizePixel = 0
        KeybindLists.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
        KeybindLists.ClipsDescendants = true
        KeybindLists.Visible = false
    end
    local UIScaleKeybindLists = Instance.new("UIScale", KeybindLists)
    local camera = workspace.CurrentCamera

    local function updateMainScale()
        local size = camera.ViewportSize
        if size.X < 800 then
            UIScaleKeybindLists.Scale = 0.7
        elseif size.X < 1200 then
            UIScaleKeybindLists.Scale = 0.5
        else
            UIScaleKeybindLists.Scale = 1
        end
    end

    updateMainScale()
    camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateMainScale)

    local DragFrame_1 = Instance.new("Frame")
    DragFrame_1.Parent = KeybindLists
    DragFrame_1.BackgroundTransparency = 1
    DragFrame_1.Name = "DragFrame_1"
    DragFrame_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DragFrame_1.Size = UDim2.new(1, 0, 0.1, 0)
    DragFrame_1.BorderSizePixel = 0
    DragFrame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    AddDraggingFunctionality(DragFrame_1, KeybindLists)
    local UIStroke_50 = Instance.new("UIStroke")
    UIStroke_50.Thickness = 0.51
    UIStroke_50.Transparency = 0.79
    UIStroke_50.Parent = KeybindLists
    UIStroke_50.Color = Color3.fromRGB(255, 255, 255)

    local UICorner_59 = Instance.new("UICorner")
    UICorner_59.Parent = KeybindLists

    local DropShadow_2 = Instance.new("ImageLabel")
    DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow_2.ScaleType = Enum.ScaleType.Slice
    DropShadow_2.ImageTransparency = 0.5
    DropShadow_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
    DropShadow_2.Parent = KeybindLists
    DropShadow_2.Name = "DropShadow_2"
    DropShadow_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow_2.Size = UDim2.new(1, 10, 1, 10)
    DropShadow_2.Image = "rbxassetid://297694300"
    DropShadow_2.BackgroundTransparency = 1
    DropShadow_2.Position = UDim2.new(0, -5, 0, -5)
    DropShadow_2.SliceScale = 0.05
    DropShadow_2.ZIndex = -5
    DropShadow_2.SliceCenter = Rect.new(Vector2.new(95, 103), Vector2.new(894, 902))

    local KeybindContainer = Instance.new("ScrollingFrame")
    KeybindContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    KeybindContainer.Active = true
    KeybindContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeybindContainer.ScrollBarThickness = 0
    KeybindContainer.Parent = KeybindLists
    KeybindContainer.BackgroundTransparency = 1
    KeybindContainer.Position = UDim2.new(0, 0, 0.101, 0)
    KeybindContainer.Name = "KeybindContainer"
    KeybindContainer.Size = UDim2.new(0, 281, 0, 319)
    KeybindContainer.BorderSizePixel = 0
    KeybindContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UIListLayout_7 = Instance.new("UIListLayout")
    UIListLayout_7.Parent = KeybindContainer
    UIListLayout_7.Padding = UDim.new(0, 5)
    UIListLayout_7.SortOrder = Enum.SortOrder.LayoutOrder

    local UIPadding_5 = Instance.new("UIPadding")
    UIPadding_5.Parent = KeybindContainer
    UIPadding_5.PaddingTop = UDim.new(0, 3)
    UIPadding_5.PaddingLeft = UDim.new(0, 3)

    function library:ToggleKeybindUI(state)
        if state then
            KeybindLists.Visible = true
            TweenService:Create(
                KeybindLists,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 282, 0, 355)}
            ):Play()
        else
            TweenService:Create(
                KeybindLists,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 0)}
            ):Play()
            wait(.2)
            KeybindLists.Visible = false
        end
    end
    function library:AddKeyItem(Options)
        local keyitem = {}
        local cfg = {Name = Options.Name or "Keybind", Keybind = Options.Keybind or Enum.KeyCode.E}
        local KeybindInfo_1 = Instance.new("Frame")
        KeybindInfo_1.Name = "KeybindInfo_1"
        KeybindInfo_1.Parent = KeybindContainer
        KeybindInfo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        KeybindInfo_1.Size = UDim2.new(0, 276, 0, 52)
        KeybindInfo_1.BorderSizePixel = 0
        KeybindInfo_1.BackgroundColor3 = Color3.fromRGB(24, 25, 28)

        local UIStroke_53 = Instance.new("UIStroke")
        UIStroke_53.Thickness = 0.51
        UIStroke_53.Transparency = 0.79
        UIStroke_53.Parent = KeybindInfo_1
        UIStroke_53.Color = Color3.fromRGB(255, 255, 255)
        local TextLabel_48 = Instance.new("TextLabel")
        TextLabel_48.TextWrapped = true
        TextLabel_48.Parent = KeybindInfo_1
        TextLabel_48.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_48.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_48.Text = cfg.Name
        TextLabel_48.Size = UDim2.new(0, 271, 0, 40)
        TextLabel_48.AnchorPoint = Vector2.new(0, 0.5)
        TextLabel_48.Position = UDim2.new(0.047411751, 0, 0.493, 0)
        TextLabel_48.BackgroundTransparency = 1
        TextLabel_48.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel_48.BorderSizePixel = 0
        TextLabel_48.FontFace =
            Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TextLabel_48.TextSize = 18
        TextLabel_48.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local UICorner_62 = Instance.new("UICorner")
        UICorner_62.Parent = KeybindInfo_1

        local Frame_37 = Instance.new("Frame")
        Frame_37.Parent = KeybindInfo_1
        Frame_37.Position = UDim2.new(0.695450962, 0, 0.5, 0)
        Frame_37.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame_37.Size = UDim2.new(0, 79, 0, 30)
        Frame_37.BorderSizePixel = 0
        Frame_37.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
        Frame_37.AnchorPoint = Vector2.new(0.5, 0.5)

        local UICorner_63 = Instance.new("UICorner")
        UICorner_63.Parent = Frame_37

        local UIStroke_54 = Instance.new("UIStroke")
        UIStroke_54.Thickness = 0.51
        UIStroke_54.Transparency = 0.79
        UIStroke_54.Parent = Frame_37
        UIStroke_54.Color = Color3.fromRGB(255, 255, 255)

        local TextLabel_49 = Instance.new("TextLabel")
        TextLabel_49.FontFace =
            Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TextLabel_49.TextColor3 = Color3.fromRGB(145, 145, 145)
        TextLabel_49.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_49.Text = tostring(cfg.Keybind)
        TextLabel_49.Parent = Frame_37
        TextLabel_49.BackgroundTransparency = 1
        TextLabel_49.Size = UDim2.new(1, 0, 1, 0)
        TextLabel_49.BorderSizePixel = 0
        TextLabel_49.TextSize = 14
        TextLabel_49.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        local TextBoundsX = TextLabel_49.TextBounds.X

        Frame_37.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
        if TextLabel_49.Text:len() < 2 then
            Frame_37.Position = UDim2.new(0.88, 0, 0.5, 0)
        elseif TextLabel_49.Text:len() == 3 then
            Frame_37.Position = UDim2.new(0.83, 0, 0.5, 0)
        elseif TextLabel_49.Text:len() == 4 then
            Frame_37.Position = UDim2.new(0.83, 0, 0.5, 0)
        elseif TextLabel_49.Text:len() == 5 then
            Frame_37.Position = UDim2.new(0.8, 0, 0.5, 0)
        else
            Frame_37.Position = UDim2.new(0.672, 0, 0.5, 0)
        end
        function keyitem:Update(newcfg)
            cfg.Name = newcfg.Name
            cfg.Keybind = newcfg.Keybind
            TextLabel_48.Text = cfg.Name
            TextLabel_49.Text = tostring(cfg.Keybind)
            local TextBoundsX = TextLabel_49.TextBounds.X

            Frame_37.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
            if TextLabel_49.Text:len() < 2 then
                Frame_37.Position = UDim2.new(0.88, 0, 0.5, 0)
            elseif TextLabel_49.Text:len() == 3 then
                Frame_37.Position = UDim2.new(0.83, 0, 0.5, 0)
            elseif TextLabel_49.Text:len() == 4 then
                Frame_37.Position = UDim2.new(0.83, 0, 0.5, 0)
            elseif TextLabel_49.Text:len() == 5 then
                Frame_37.Position = UDim2.new(0.8, 0, 0.5, 0)
            else
                Frame_37.Position = UDim2.new(0.82, 0, 0.5, 0)
            end
        end

        local TextLabel_50 = Instance.new("TextLabel")
        TextLabel_50.FontFace =
            Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TextLabel_50.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_50.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel_50.Text = "Keybinds"
        TextLabel_50.Parent = KeybindLists
        TextLabel_50.BackgroundTransparency = 1
        TextLabel_50.Size = UDim2.new(0, 281, 0, 37)
        TextLabel_50.BorderSizePixel = 0
        TextLabel_50.TextWrapped = true
        TextLabel_50.TextSize = 17
        TextLabel_50.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local KeybindlistDragframe = Instance.new("Frame")
        KeybindlistDragframe.Parent = KeybindLists
        KeybindlistDragframe.BackgroundTransparency = 1
        KeybindlistDragframe.Name = "KeybindlistDragframe"
        KeybindlistDragframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
        KeybindlistDragframe.Size = UDim2.new(0, 282, 0, 39)
        KeybindlistDragframe.BorderSizePixel = 0
        KeybindlistDragframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local Frame_38 = Instance.new("Frame")
        Frame_38.Parent = KeybindLists
        Frame_38.Size = UDim2.new(0, 282, 0, 156)
        Frame_38.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Frame_38.ZIndex = 0
        Frame_38.BorderSizePixel = 0
        Frame_38.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local UIGradient_7 = Instance.new("UIGradient")
        UIGradient_7.Color =
            ColorSequence.new {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 40, 73)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 15))
        }
        UIGradient_7.Parent = Frame_38
        UIGradient_7.Rotation = 90

        local UICorner_64 = Instance.new("UICorner")
        UICorner_64.Parent = Frame_38
    end

    local SnackBarContainer = Instance.new("Frame")
    SnackBarContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SnackBarContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    SnackBarContainer.Parent = Cryo
    SnackBarContainer.BackgroundTransparency = 1
    SnackBarContainer.Position = UDim2.new(0.917999983, 0, 0.945, 0)
    SnackBarContainer.Name = "SnackBarContainer"
    SnackBarContainer.Size = UDim2.new(0.200000003, 0, 0.1, 0)
    SnackBarContainer.BorderSizePixel = 0
    SnackBarContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UIListLayout_1 = Instance.new("UIListLayout")
    UIListLayout_1.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_1.Parent = SnackBarContainer
    UIListLayout_1.Padding = UDim.new(0, 5)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = SnackBarContainer

    local DragFrame = Instance.new("Frame")
    DragFrame.Parent = Main
    DragFrame.BackgroundTransparency = 1
    DragFrame.Name = "DragFrame"
    DragFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    DragFrame.Size = UDim2.new(0, 975, 0, 64)
    DragFrame.BorderSizePixel = 0
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    AddDraggingFunctionality(DragFrame, Main)
    local I = Instance.new("UICorner")
    I.Parent = Main
    I.Name = "I"

    local H = Instance.new("UIStroke")
    H.Thickness = 1.5
    H.Transparency = 0.71
    H.Name = "H"
    H.Color = Color3.fromRGB(96, 205, 255)
    H.Parent = Main

    local TabMain = Instance.new("Frame")
    TabMain.AnchorPoint = Vector2.new(0.5, 0.5)
    TabMain.Parent = Main
    TabMain.Name = "TabMain"
    TabMain.Position = UDim2.new(0.127914667, 0, 0.5, 0)
    TabMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabMain.Size = UDim2.new(0, 250, 0, 620)
    TabMain.BorderSizePixel = 0
    TabMain.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    TabMain.ZIndex = 10

    local K = Instance.new("UICorner")
    K.Parent = TabMain
    K.Name = "K"

    local LeftTopBar = Instance.new("Frame")
    LeftTopBar.Parent = TabMain
    LeftTopBar.BackgroundTransparency = 1
    LeftTopBar.Name = "LeftTopBar"
    LeftTopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LeftTopBar.Size = UDim2.new(0, 250, 0, 96)
    LeftTopBar.BorderSizePixel = 0
    LeftTopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local ImageLabel_1 = Instance.new("ImageLabel", LeftTopBar)
    ImageLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_1.Image = "rbxassetid://90443869558386"
    ImageLabel_1.BackgroundTransparency = 1
    ImageLabel_1.Position = UDim2.new(0.231999993, 0, 0.302, 0)
    ImageLabel_1.Size = UDim2.new(0, 183, 0, 38)
    ImageLabel_1.BorderSizePixel = 0
    ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local ImageLabel_2 = Instance.new("ImageLabel", LeftTopBar)
    ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_2.Image = "rbxassetid://73036184137047"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Position = UDim2.new(0.035999998, 0, 0.114, 0)
    ImageLabel_2.Size = UDim2.new(0, 70, 0, 70)
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    --[[
    local Logo_2 = Instance.new("Frame")
    Logo_2.Parent = LeftTopBar
    Logo_2.Name = "Logo_2"
    Logo_2.Position = UDim2.new(0.064000003, 0, 0.208, 0)
    Logo_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo_2.Size = UDim2.new(0, 50, 0, 50)
    Logo_2.BorderSizePixel = 0
    Logo_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Logo_3 = Instance.new("ImageLabel")
    Logo_3.Visible = false
    Logo_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo_3.Parent = Logo_2
    Logo_3.Name = "Logo_3"
    Logo_3.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo_3.Image = "rbxassetid://" .. cfg.ImageLogo
    Logo_3.BackgroundTransparency = 1
    Logo_3.Position = UDim2.new(0.5, 0, 0.5, 0)
    Logo_3.Size = UDim2.new(0.699999988, 0, 0.7, 0)
    Logo_3.BorderSizePixel = 0
    Logo_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local R_2 = Instance.new("UIGradient")
    R_2.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
    }
    R_2.Name = "R_2"
    R_2.Parent = Logo_2

    local P_2 = Instance.new("UICorner")
    P_2.Parent = Logo_2
    P_2.Name = "P_2"

    local SingleTextLogo_1 = Instance.new("TextLabel")
    SingleTextLogo_1.TextWrapped = true
    SingleTextLogo_1.Parent = Logo_2
    SingleTextLogo_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    SingleTextLogo_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SingleTextLogo_1.Text = "S"
    SingleTextLogo_1.Name = "SingleTextLogo_1"
    SingleTextLogo_1.Size = UDim2.new(0.800000012, 0, 0.8, 0)
    SingleTextLogo_1.AnchorPoint = Vector2.new(0.5, 0.5)
    SingleTextLogo_1.BorderSizePixel = 0
    SingleTextLogo_1.BackgroundTransparency = 1
    SingleTextLogo_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    SingleTextLogo_1.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    SingleTextLogo_1.TextSize = 14
    SingleTextLogo_1.TextScaled = true
    SingleTextLogo_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    if usingTextLogo then
        SingleTextLogo_1.Visible = true
        Logo_3.Visible = false
    else
        SingleTextLogo_1.Visible = false
        Logo_3.Visible = true
    end
    local UITitle_1 = Instance.new("TextLabel")
    UITitle_1.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    UITitle_1.Parent = LeftTopBar
    UITitle_1.TextColor3 = Color3.fromRGB(255, 255, 255)
    UITitle_1.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
    UITitle_1.Text = cfg.Name
    UITitle_1.Name = "UITitle_1"
    UITitle_1.TextStrokeTransparency = 0.85
    UITitle_1.Size = UDim2.new(0, 149, 0, 50)
    UITitle_1.Position = UDim2.new(0.316000015, 0, 0.208, 0)
    UITitle_1.BackgroundTransparency = 2
    UITitle_1.TextXAlignment = Enum.TextXAlignment.Left
    UITitle_1.BorderSizePixel = 0
    UITitle_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UITitle_1.TextSize = 35
    UITitle_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UIGradient_1 = Instance.new("UIGradient")
    UIGradient_1.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 103, 251)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(51, 68, 175))
    }
    UIGradient_1.Parent = UITitle_1
]]
    local UserInfo = Instance.new("Frame")
    UserInfo.Parent = TabMain
    UserInfo.Name = "UserInfo"
    UserInfo.Position = UDim2.new(0, 0, 0.852, 0)
    UserInfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    UserInfo.Size = UDim2.new(0, 250, 0, 92)
    UserInfo.BorderSizePixel = 0
    UserInfo.BackgroundColor3 = Color3.fromRGB(34, 35, 38)

    local L = Instance.new("UICorner")
    L.Parent = UserInfo
    L.Name = "L"
    L.CornerRadius = UDim.new(0, 25)

    local M = Instance.new("Frame")
    M.Parent = UserInfo
    M.Name = "M"
    M.Position = UDim2.new(0.148000002, 0, 0.469, 0)
    M.BorderColor3 = Color3.fromRGB(0, 0, 0)
    M.Size = UDim2.new(0, 213, 0, 48)
    M.BorderSizePixel = 0
    M.BackgroundColor3 = Color3.fromRGB(34, 35, 38)

    local N = Instance.new("Frame")
    N.Parent = UserInfo
    N.Name = "N"
    N.Position = UDim2.new(0.800000012, 0, 0, 0)
    N.BorderColor3 = Color3.fromRGB(0, 0, 0)
    N.Size = UDim2.new(0, 50, 0, 91)
    N.BorderSizePixel = 0
    N.BackgroundColor3 = Color3.fromRGB(34, 35, 38)

    local O = Instance.new("Frame")
    O.Parent = UserInfo
    O.Name = "O"
    O.Position = UDim2.new(0.001132812, 0, 0.469, 0)
    O.BorderColor3 = Color3.fromRGB(0, 0, 0)
    O.Size = UDim2.new(0, 249, 0, 48)
    O.BorderSizePixel = 0
    O.BackgroundColor3 = Color3.fromRGB(34, 35, 38)

    local P_3 = Instance.new("UICorner")
    P_3.Parent = O
    P_3.Name = "P_3"

    local T = Instance.new("Frame")
    T.Parent = UserInfo
    T.BackgroundTransparency = 1
    T.Name = "T"
    T.BorderColor3 = Color3.fromRGB(0, 0, 0)
    T.Size = UDim2.new(1, 0, 1, 2)
    T.BorderSizePixel = 0
    T.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local U = Instance.new("Frame")
    U.AnchorPoint = Vector2.new(0, 0.5)
    U.Parent = T
    U.Name = "U"
    U.Position = UDim2.new(0.064000003, 0, 0.5, 0)
    U.BorderColor3 = Color3.fromRGB(0, 0, 0)
    U.Size = UDim2.new(0, 50, 0, 50)
    U.BorderSizePixel = 0
    U.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local S = Instance.new("UICorner")
    S.Parent = U
    S.Name = "S"

    local Singleplayer = Instance.new("ImageLabel")
    Singleplayer.Parent = U
    Singleplayer.ImageRectOffset = Vector2.new(50, 600)
    Singleplayer.BackgroundTransparency = 1
    Singleplayer.ImageRectSize = Vector2.new(50, 50)
    Singleplayer.Name = "Singleplayer"
    Singleplayer.Image = "rbxassetid://6764432408"
    Singleplayer.Size = UDim2.new(0, 50, 0, 50)

    local X = Instance.new("UIGradient")
    X.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(116, 137, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(9, 21, 237))
    }

    X.Parent = U
    X.Name = "X"
    X.Rotation = 45

    local Loggedas = Instance.new("TextLabel")
    Loggedas.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Loggedas.TextColor3 = Color3.fromRGB(115, 115, 115)
    Loggedas.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Loggedas.Text = "Logged in as"
    Loggedas.Parent = T
    Loggedas.Name = "Loggedas"
    Loggedas.Size = UDim2.new(0, 95, 0, 21)
    Loggedas.BackgroundTransparency = 1
    Loggedas.TextXAlignment = Enum.TextXAlignment.Left
    Loggedas.Position = UDim2.new(0.296000004, 0, 0.234, 0)
    Loggedas.BorderSizePixel = 0
    Loggedas.TextSize = 13
    Loggedas.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Username = Instance.new("TextLabel")
    Username.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    Username.TextColor3 = Color3.fromRGB(255, 255, 255)
    Username.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Username.Text = LocalPlayer.DisplayName
    Username.Parent = T
    Username.Name = "Username"
    Username.Size = UDim2.new(0, 95, 0, 21)
    Username.BackgroundTransparency = 1
    Username.TextXAlignment = Enum.TextXAlignment.Left
    Username.Position = UDim2.new(0.296000004, 0, 0.457, 0)
    Username.BorderSizePixel = 0
    Username.TextSize = 20
    Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local M_1 = Instance.new("Frame")
    M_1.Parent = TabMain
    M_1.Size = UDim2.new(0, 9, 0, 620)
    M_1.Name = "M_1"
    M_1.Position = UDim2.new(0.963999987, 0, 0, 0)
    M_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    M_1.ZIndex = 0
    M_1.BorderSizePixel = 0
    M_1.BackgroundColor3 = Color3.fromRGB(18, 18, 24)

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    TabContainer.Active = true
    TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabContainer.ScrollBarThickness = 0
    TabContainer.Parent = TabMain
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0.001132812, 0, 0.158, 0)
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 249, 0, 425)
    TabContainer.BorderSizePixel = 0
    TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local I = Instance.new("UIPadding")
    I.Parent = TabContainer
    I.Name = "I"

    local U_1 = Instance.new("UIListLayout")
    U_1.Parent = TabContainer
    U_1.SortOrder = Enum.SortOrder.LayoutOrder
    U_1.Name = "U_1"
    local TopBar = Instance.new("Frame")
    TopBar.Parent = Main
    TopBar.Name = "TopBar"
    TopBar.Position = UDim2.new(0.255384624, 0, 0, 0)
    TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBar.Size = UDim2.new(0, 726, 0, 69)
    TopBar.BorderSizePixel = 0
    TopBar.BackgroundColor3 = Color3.fromRGB(22, 23, 26)
    TopBar.ZIndex = 10
    local Frame = Instance.new("Frame")
    Frame.Parent = TopBar
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Size = UDim2.new(0, 12, 0, 64)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(22, 23, 26)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = TopBar
    local CurrentTabInfo = Instance.new("Frame")
    CurrentTabInfo.Parent = TopBar
    CurrentTabInfo.Name = "CurrentTabInfo"
    CurrentTabInfo.BackgroundTransparency = 1
    CurrentTabInfo.Position = UDim2.new(0, 0, 0.029, 0)
    CurrentTabInfo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CurrentTabInfo.Size = UDim2.new(0, 260, 0, 64)
    CurrentTabInfo.BorderSizePixel = 0
    CurrentTabInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local CurrentTabImageBg = Instance.new("Frame")
    CurrentTabImageBg.AnchorPoint = Vector2.new(0, 0.5)
    CurrentTabImageBg.Parent = CurrentTabInfo
    CurrentTabImageBg.Name = "CurrentTabImageBg"
    CurrentTabImageBg.Position = UDim2.new(0.048745729, 0, 0.485, 0)
    CurrentTabImageBg.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CurrentTabImageBg.Size = UDim2.new(0, 40, 0, 40)
    CurrentTabImageBg.BorderSizePixel = 0
    CurrentTabImageBg.BackgroundColor3 = Color3.fromRGB(24, 66, 147)

    local E = Instance.new("UICorner")
    E.Parent = CurrentTabImageBg
    E.Name = "E"

    local CurrentTabImage = Instance.new("ImageLabel")
    CurrentTabImage.Parent = CurrentTabImageBg
    CurrentTabImage.Name = "CurrentTabImage"
    CurrentTabImage.AnchorPoint = Vector2.new(0.5, 0.5)
    CurrentTabImage.Image = "rbxassetid://6764432408"
    CurrentTabImage.BackgroundTransparency = 1
    CurrentTabImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    CurrentTabImage.ImageRectOffset = Vector2.new(100, 950)
    CurrentTabImage.ImageRectSize = Vector2.new(50, 50)
    CurrentTabImage.Size = UDim2.new(0.800000012, 0, 0.8, 0)

    local D = Instance.new("UIStroke")
    D.Thickness = 0.51
    D.Transparency = 0.79
    D.Name = "D"
    D.Color = Color3.fromRGB(255, 255, 255)
    D.Parent = CurrentTabImageBg

    local A = Instance.new("Frame")
    A.Parent = CurrentTabInfo
    A.Name = "A"
    A.Position = UDim2.new(0, 0, 0.974, 0)
    A.BorderColor3 = Color3.fromRGB(0, 0, 0)
    A.Size = UDim2.new(0, 726, 0, 4)
    A.BorderSizePixel = 0
    A.BackgroundColor3 = Color3.fromRGB(31, 41, 55)

    local B = Instance.new("Frame")
    B.Parent = A
    B.Name = "B"
    B.Position = UDim2.new(0.017228223, 0, 0, 0)
    B.BorderColor3 = Color3.fromRGB(0, 0, 0)
    B.Size = UDim2.new(0, 40, 0, 3)
    B.BorderSizePixel = 0
    B.BackgroundColor3 = Color3.fromRGB(37, 93, 205)

    local C = Instance.new("UICorner")
    C.Parent = B
    C.Name = "C"

    local Frame_4 = Instance.new("Frame")
    Frame_4.Parent = CurrentTabInfo
    Frame_4.BackgroundTransparency = 1
    Frame_4.Position = UDim2.new(0.25, 0, 0.188, 0)
    Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_4.Size = UDim2.new(0, 186, 0, 39)
    Frame_4.BorderSizePixel = 0
    Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Parent = Frame_4
    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

    local UIPadding_1 = Instance.new("UIPadding")
    UIPadding_1.Parent = Frame_4

    local TextLabel_3 = Instance.new("TextLabel")
    TextLabel_3.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_3.TextColor3 = Color3.fromRGB(209, 209, 210)
    TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_3.Text = cfg.Name
    TextLabel_3.Parent = Frame_4
    TextLabel_3.Size = UDim2.new(0, 80, 1, 0)
    TextLabel_3.BackgroundTransparency = 1
    TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_3.Position = UDim2.new(0.25, 0, 0.094, 0)
    TextLabel_3.BorderSizePixel = 0
    TextLabel_3.TextSize = 23
    TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local TextLabel_4 = Instance.new("TextLabel")
    TextLabel_4.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_4.TextColor3 = Color3.fromRGB(82, 82, 83)
    TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_4.Text = "|"
    TextLabel_4.Parent = Frame_4
    TextLabel_4.Size = UDim2.new(-0.34946236, 80, 0.845, 3)
    TextLabel_4.BackgroundTransparency = 1
    TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_4.Position = UDim2.new(0.430107534, 0, 0, 0)
    TextLabel_4.BorderSizePixel = 0
    TextLabel_4.TextSize = 23
    TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local TextLabel_5 = Instance.new("TextLabel")
    TextLabel_5.FontFace =
        Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextLabel_5.TextColor3 = Color3.fromRGB(137, 137, 138)
    TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel_5.Text = "Home"
    TextLabel_5.Parent = Frame_4
    TextLabel_5.Size = UDim2.new(0, 80, 0.923, 3)
    TextLabel_5.BackgroundTransparency = 1
    TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_5.Position = UDim2.new(0.543010771, 0, 0, 0)
    TextLabel_5.BorderSizePixel = 0
    TextLabel_5.TextSize = 23
    TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local TopBarUtils = Instance.new("Frame")
    TopBarUtils.Parent = TopBar
    TopBarUtils.Name = "TopBarUtils"
    TopBarUtils.BackgroundTransparency = 1
    TopBarUtils.Position = UDim2.new(0.776859522, 0, 0.029, 0)
    TopBarUtils.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBarUtils.Size = UDim2.new(0, 162, 0, 64)
    TopBarUtils.BorderSizePixel = 0
    TopBarUtils.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local TopBarHolder = Instance.new("Frame")
    TopBarHolder.Parent = TopBarUtils
    TopBarHolder.BackgroundTransparency = 1
    TopBarHolder.Name = "TopBarHolder"
    TopBarHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TopBarHolder.Size = UDim2.new(1, 0, 1, 2)
    TopBarHolder.BorderSizePixel = 0
    TopBarHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Exit = Instance.new("Frame")
    Exit.LayoutOrder = 2
    Exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Exit.AnchorPoint = Vector2.new(0, 0.5)
    Exit.Name = "Exit"
    Exit.Position = UDim2.new(0.708067834, 0, 0.485, 0)
    Exit.Parent = TopBarHolder
    Exit.Size = UDim2.new(0, 40, 0, 40)
    Exit.BorderSizePixel = 0
    Exit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UICorner_7 = Instance.new("UICorner")
    UICorner_7.Parent = Exit

    local closebtn = Instance.new("TextButton")
    closebtn.Text = ""
    closebtn.Parent = Exit
    closebtn.BackgroundTransparency = 1
    closebtn.Size = UDim2.new(1, 0, 1, 0)
    local UIStroke_2 = Instance.new("UIStroke")
    UIStroke_2.Thickness = 0.51
    UIStroke_2.Transparency = 0.79
    UIStroke_2.Parent = Exit
    UIStroke_2.Color = Color3.fromRGB(255, 255, 255)

    local Close_1 = Instance.new("ImageLabel")
    Close_1.Parent = Exit
    Close_1.Name = "Close_1"
    Close_1.AnchorPoint = Vector2.new(0.5, 0.5)
    Close_1.Image = "rbxassetid://8445470984"
    Close_1.BackgroundTransparency = 1
    Close_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    Close_1.ImageRectOffset = Vector2.new(304, 304)
    Close_1.ImageRectSize = Vector2.new(96, 96)
    Close_1.Size = UDim2.new(0.800000012, 0, 0.8, 0)
    Close_1.ImageTransparency = 0.5
    Exit.MouseEnter:Connect(
        function()
            TweenService:Create(
                Close_1,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = .2}
            ):Play()
        end
    )
    Exit.MouseLeave:Connect(
        function()
            TweenService:Create(
                Close_1,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {ImageTransparency = .5}
            ):Play()
        end
    )
    closebtn.MouseButton1Click:Connect(
        function()
            library:ToggleUI(Main.Visible)
        end
    )

    UserInputService.InputBegan:Connect(
        function(input)
            if (input.KeyCode == cfg.Keybind) then
                library:ToggleUI(Main.Visible)
            end
        end
    )
    local UIGradient_2 = Instance.new("UIGradient")
    UIGradient_2.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(27, 27, 27))
    }
    UIGradient_2.Parent = Exit
    UIGradient_2.Rotation = 90

    local F = Instance.new("UIListLayout")
    F.FillDirection = Enum.FillDirection.Horizontal
    F.HorizontalAlignment = Enum.HorizontalAlignment.Right
    F.Parent = TopBarHolder
    F.Padding = UDim.new(0, 10)
    F.Name = "F"
    F.SortOrder = Enum.SortOrder.LayoutOrder

    local G = Instance.new("UIPadding")
    G.Parent = TopBarHolder
    G.PaddingTop = UDim.new(0, 12)
    G.PaddingRight = UDim.new(0, 10)
    G.Name = "G"

    local Resize = Instance.new("Frame")
    Resize.LayoutOrder = 1
    Resize.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Resize.AnchorPoint = Vector2.new(0, 0.5)
    Resize.Name = "Resize"
    Resize.Position = UDim2.new(0.148745775, 0, 0.485, 0)
    Resize.Parent = TopBarHolder
    Resize.Size = UDim2.new(0, 40, 0, 40)
    Resize.BorderSizePixel = 0
    Resize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Resizebtn = Instance.new("TextButton")
    Resizebtn.Text = ""
    Resizebtn.Parent = Resize
    Resizebtn.BackgroundTransparency = 1
    Resizebtn.Size = UDim2.new(1, 0, 1, 0)
    local UICorner_8 = Instance.new("UICorner")
    UICorner_8.Parent = Resize

    local UIStroke_3 = Instance.new("UIStroke")
    UIStroke_3.Thickness = 0.51
    UIStroke_3.Transparency = 0.79
    UIStroke_3.Parent = Resize
    UIStroke_3.Color = Color3.fromRGB(255, 255, 255)

    local UIGradient_3 = Instance.new("UIGradient")
    UIGradient_3.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(27, 27, 27))
    }
    UIGradient_3.Parent = Resize
    UIGradient_3.Rotation = 90

    local Larger = Instance.new("ImageLabel")
    Larger.ImageTransparency = 1
    Larger.Parent = Resize
    Larger.Name = "Larger"
    Larger.AnchorPoint = Vector2.new(0.5, 0.5)
    Larger.Image = "rbxassetid://6764432408"
    Larger.BackgroundTransparency = 1
    Larger.Position = UDim2.new(0.5, 0, 0.5, 0)
    Larger.ImageRectSize = Vector2.new(50, 50)
    Larger.ImageRectOffset = Vector2.new(150, 450)
    Larger.Size = UDim2.new(0.800000012, 0, 0.8, 0)
    Larger.ImageTransparency = 1
    local Smaller = Instance.new("ImageLabel")
    Smaller.Parent = Resize
    Smaller.Name = "Smaller"
    Smaller.AnchorPoint = Vector2.new(0.5, 0.5)
    Smaller.Image = "rbxassetid://6764432408"
    Smaller.BackgroundTransparency = 1
    Smaller.Position = UDim2.new(0.5, 0, 0.5, 0)
    Smaller.ImageRectOffset = Vector2.new(50, 550)
    Smaller.ImageRectSize = Vector2.new(50, 50)
    Smaller.Size = UDim2.new(0.800000012, 0, 0.8, 0)
    Smaller.ImageTransparency = 0.5
    local isAnimating = false -- Prevent clicks during animation

    Resizebtn.MouseEnter:Connect(
        function()
            -- Check current state instead of checking transparency during animation
            if Minimized then
                -- When minimized, show Larger icon on hover
                TweenService:Create(
                    Larger,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .2}
                ):Play()
            else
                -- When expanded, show Smaller icon on hover
                TweenService:Create(
                    Smaller,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .2}
                ):Play()
            end
        end
    )

    Resizebtn.MouseLeave:Connect(
        function()
            -- Check current state instead of checking transparency during animation
            if Minimized then
                -- When minimized, return Larger icon to default
                TweenService:Create(
                    Larger,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .5}
                ):Play()
            else
                -- When expanded, return Smaller icon to default
                TweenService:Create(
                    Smaller,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .5}
                ):Play()
            end
        end
    )

    Resizebtn.MouseButton1Click:Connect(
        function()
            if isAnimating then
                return
            end -- Prevent double-clicking

            isAnimating = true
            Minimized = not Minimized

            if Minimized then
                -- Minimize the window
                TweenService:Create(
                    Main,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 975, 0, 64)}
                ):Play()

                TweenService:Create(
                    TabMain,
                    TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.127914667, 0, 0, 298)}
                ):Play()

                -- Hide Smaller icon, show Larger icon
                TweenService:Create(
                    Smaller,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = 1}
                ):Play()

                local largerTween =
                    TweenService:Create(
                    Larger,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .5}
                )
                largerTween:Play()

                -- Wait for animation to complete
                largerTween.Completed:Wait()
                isAnimating = false
            else
                -- Expand the window
                TweenService:Create(
                    Main,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 975, 0, 620)}
                ):Play()

                TweenService:Create(
                    TabMain,
                    TweenInfo.new(0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {Position = UDim2.new(0.127914667, 0, 0.5, 0)}
                ):Play()

                -- Show Smaller icon, hide Larger icon
                local smallerTween =
                    TweenService:Create(
                    Smaller,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = .5}
                )
                smallerTween:Play()

                TweenService:Create(
                    Larger,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {ImageTransparency = 1}
                ):Play()

                -- Wait for animation to complete
                smallerTween.Completed:Wait()
                isAnimating = false
            end
        end
    )

    local Search = Instance.new("Frame")
    Search.AnchorPoint = Vector2.new(0, 0.5)
    Search.Parent = TopBarHolder
    Search.Name = "Search"
    Search.Position = UDim2.new(-1.059210539, 0, 0.296, 0)
    Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Search.Size = UDim2.new(0, 157, 0, 40)
    Search.BorderSizePixel = 0
    Search.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UICorner_9 = Instance.new("UICorner")
    UICorner_9.Parent = Search

    local UIStroke_4 = Instance.new("UIStroke")
    UIStroke_4.Thickness = 0.51
    UIStroke_4.Transparency = 0.79
    UIStroke_4.Parent = Search
    UIStroke_4.Color = Color3.fromRGB(255, 255, 255)

    local UIGradient_4 = Instance.new("UIGradient")
    UIGradient_4.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(54, 54, 54)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(27, 27, 27))
    }
    UIGradient_4.Parent = Search
    UIGradient_4.Rotation = 90

    local TextBox = Instance.new("TextBox")
    TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    TextBox.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.Text = ""
    TextBox.Parent = Search
    TextBox.Size = UDim2.new(0, 115, 0, 39)
    TextBox.Position = UDim2.new(0.24203822, 0, 0.024, 0)
    TextBox.BackgroundTransparency = 1
    TextBox.TextXAlignment = Enum.TextXAlignment.Left
    TextBox.BorderSizePixel = 0
    TextBox.PlaceholderText = "Search"
    TextBox.TextSize = 18
    TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.ClipsDescendants = true

    local Search_1 = Instance.new("ImageLabel")
    Search_1.Parent = Search
    Search_1.Name = "Search_1"
    Search_1.Image = "rbxassetid://8445471332"
    Search_1.BackgroundTransparency = 1
    Search_1.Position = UDim2.new(0.050955415, 0, 0.2, 0)
    Search_1.ImageRectOffset = Vector2.new(204, 104)
    Search_1.ImageRectSize = Vector2.new(96, 96)
    Search_1.Size = UDim2.new(0, 24, 0, 24)

    Search.MouseLeave:Connect(
        function()
            TweenService:Create(
                TextBox,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {PlaceholderColor3 = Color3.fromRGB(122, 122, 122)}
            ):Play()
            TweenService:Create(
                TextBox,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(122, 122, 122)}
            ):Play()
        end
    )
    Search.MouseEnter:Connect(
        function()
            TweenService:Create(
                TextBox,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {PlaceholderColor3 = Color3.fromRGB(200, 200, 200)}
            ):Play()
            TweenService:Create(
                TextBox,
                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(200, 200, 200)}
            ):Play()
        end
    )
    local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint_1.Parent = Search_1
    UIAspectRatioConstraint_1.DominantAxis = Enum.DominantAxis.Height

    local UIGradient_5 = Instance.new("UIGradient")
    UIGradient_5.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(83, 83, 83))
    }
    UIGradient_5.Parent = Search_1
    UIGradient_5.Rotation = 45

    local ContentHolder = Instance.new("Frame")
    ContentHolder.Parent = Main
    ContentHolder.Name = "ContentHolder"
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.Position = UDim2.new(0.255384624, 0, 0.111, 0)
    ContentHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContentHolder.Size = UDim2.new(0, 726, 0, 550)
    ContentHolder.BorderSizePixel = 0
    ContentHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local Frame_5 = Instance.new("Frame")
    Frame_5.Parent = ContentHolder
    Frame_5.Position = UDim2.new(0.000987323, 0, -0.004, 0)
    Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.Size = UDim2.new(0, 725, 0, 166)
    Frame_5.BorderSizePixel = 0
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    local UIGradient_6 = Instance.new("UIGradient")
    UIGradient_6.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 40, 73)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(11, 11, 15))
    }
    UIGradient_6.Parent = Frame_5
    UIGradient_6.Rotation = 90

    local ContenHolderContainer = Instance.new("Frame")
    ContenHolderContainer.ClipsDescendants = true
    ContenHolderContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ContenHolderContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    ContenHolderContainer.Parent = ContentHolder
    ContenHolderContainer.BackgroundTransparency = 1
    ContenHolderContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    ContenHolderContainer.Name = "ContenHolderContainer"
    ContenHolderContainer.Size = UDim2.new(1, 0, 1, 0)
    ContenHolderContainer.BorderSizePixel = 0
    ContenHolderContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    local FirstTab = false
    local currentTab
    TextBox:GetPropertyChangedSignal("Text"):Connect(
        function()
            local InputText = string.lower(TextBox.Text)
            for _, v in pairs(ContenHolderContainer:GetChildren()) do
                if v.Name == currentTab and v.Visible then
                    for _, v2 in pairs(v:GetDescendants()) do
                        if v2:IsA("TextLabel") and v2.TextSize == 18 then
                            v2.Parent.Visible = string.find(string.lower(v2.Text), InputText, 1, true) and true or false
                        end
                    end
                end
            end
        end
    )
    local DropShadow_1 = Instance.new("ImageLabel")
    DropShadow_1.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow_1.ScaleType = Enum.ScaleType.Slice
    DropShadow_1.ImageTransparency = 0.5
    DropShadow_1.BorderColor3 = Color3.fromRGB(27, 42, 53)
    DropShadow_1.Parent = Main
    DropShadow_1.Name = "DropShadow_1"
    DropShadow_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DropShadow_1.Size = UDim2.new(1, 10, 1, 10)
    DropShadow_1.Image = "rbxassetid://297694300"
    DropShadow_1.BackgroundTransparency = 1
    DropShadow_1.Position = UDim2.new(0, -5, 0, -5)
    DropShadow_1.SliceScale = 0.05
    DropShadow_1.ZIndex = -5
    DropShadow_1.SliceCenter = Rect.new(Vector2.new(95, 103), Vector2.new(894, 902))

    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.Parent = ContenHolderContainer
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.TweenTime = 0.1
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut

    local Tabs = {}
    function Tabs:Text(Options)
        local cfg = {
            Name = Options.Name or "Main"
        }
        local TextDivider = Instance.new("Frame")
        TextDivider.Parent = TabContainer
        TextDivider.Name = "TextDivider"
        TextDivider.BackgroundTransparency = 1
        TextDivider.Position = UDim2.new(0, 0, 0.029, 0)
        TextDivider.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextDivider.Size = UDim2.new(0, 250, 0, 41)
        TextDivider.BorderSizePixel = 0
        TextDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local DividerTextLabel = Instance.new("TextLabel")
        DividerTextLabel.FontFace =
            Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        DividerTextLabel.TextColor3 = Color3.fromRGB(135, 135, 135)
        DividerTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        DividerTextLabel.Text = cfg.Name
        DividerTextLabel.Parent = TextDivider
        DividerTextLabel.Name = "DividerTextLabel"
        DividerTextLabel.AnchorPoint = Vector2.new(0, 0.5)
        DividerTextLabel.Size = UDim2.new(0, 200, 1, 0)
        DividerTextLabel.BackgroundTransparency = 1
        DividerTextLabel.TextXAlignment = Enum.TextXAlignment.Left
        DividerTextLabel.Position = UDim2.new(0.064000003, 0, 0.5, 0)
        DividerTextLabel.BorderSizePixel = 0
        DividerTextLabel.TextSize = 20
        DividerTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
    function Tabs:Divider()
        local Divider = Instance.new("Frame")
        Divider.Parent = TabContainer
        Divider.BackgroundTransparency = 1
        Divider.Name = "Divider"
        Divider.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Divider.Size = UDim2.new(0, 250, 0, 15)
        Divider.BorderSizePixel = 0
        Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local DIviderFrame = Instance.new("Frame")
        DIviderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        DIviderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        DIviderFrame.Parent = Divider
        DIviderFrame.BackgroundTransparency = 0.5
        DIviderFrame.Position = UDim2.new(0.488000005, 0, 0.5, 0)
        DIviderFrame.Name = "DIviderFrame"
        DIviderFrame.Size = UDim2.new(0, 212, 0, 3)
        DIviderFrame.BorderSizePixel = 0
        DIviderFrame.BackgroundColor3 = Color3.fromRGB(24, 66, 147)

        local Y = Instance.new("UICorner")
        Y.Parent = DIviderFrame
        Y.Name = "Y"
    end

    function Tabs:Tab(Options)
        local Items = {}
        local cfg = {
            Name = Options.Name or "Tab",
            Image = Options.Image or "",
            Offset = Options.Offset or Vector2.new(0, 0),
            ReactSize = Options.ReactSize or Vector2.new(0, 0)
        }

        local usingImage = true

        if cfg.Image == "" then
            usingImage = false
        end
        local SelectedTab = Instance.new("Frame")
        SelectedTab.Parent = TabContainer
        SelectedTab.Name = cfg.Name
        SelectedTab.BackgroundTransparency = 1
        SelectedTab.Position = UDim2.new(0, 0, 0.107, 0)
        SelectedTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SelectedTab.Size = UDim2.new(0, 250, 0, 61)
        SelectedTab.BorderSizePixel = 0
        SelectedTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local tabbtn = Instance.new("TextButton")
        tabbtn.Name = "tabbtn"
        tabbtn.Parent = SelectedTab
        tabbtn.BackgroundTransparency = 1
        tabbtn.Size = UDim2.new(1, 0, 1, 0)
        tabbtn.Text = ""
        local Tab1 = Instance.new("Frame")
        Tab1.AnchorPoint = Vector2.new(0, 0.5)
        Tab1.Parent = SelectedTab
        Tab1.Name = "Tab1"
        Tab1.Position = UDim2.new(-0.050000001, 0, 0.5, 0)
        Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab1.Size = UDim2.new(0, 21, 0, 31)
        Tab1.BorderSizePixel = 0
        Tab1.BackgroundColor3 = Color3.fromRGB(24, 40, 73)
        Tab1.BackgroundTransparency = 1

        local UICorner_4 = Instance.new("UICorner")
        UICorner_4.Parent = Tab1

        local Bg = Instance.new("Frame")
        Bg.Parent = SelectedTab
        Bg.Name = "Bg"
        Bg.Position = UDim2.new(0.083999999, 0, 0.131, 0)
        Bg.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Bg.Size = UDim2.new(0, 207, 0, 45)
        Bg.BorderSizePixel = 0
        Bg.BackgroundColor3 = Color3.fromRGB(24, 40, 73)
        Bg.BackgroundTransparency = 1

        local TabName = Instance.new("TextLabel")
        TabName.FontFace =
            Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
        TabName.TextColor3 = Color3.fromRGB(240, 240, 240)
        TabName.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
        TabName.Parent = Bg
        TabName.Name = "TabName"
        TabName.TextStrokeTransparency = 0.9
        TabName.Size = UDim2.new(0, 156, 0, 45)
        TabName.Position = UDim2.new(0.246376812, 0, 0, 0)
        TabName.BackgroundTransparency = 1
        TabName.TextXAlignment = Enum.TextXAlignment.Left
        TabName.BorderSizePixel = 0
        TabName.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabName.TextSize = 20
        TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabName.Text = cfg.Name

        local TabImage = Instance.new("ImageLabel")
        TabImage.Parent = Bg
        TabImage.Name = "TabImage"
        TabImage.BackgroundTransparency = 1
        TabImage.Position = UDim2.new(0.024154589, 0, 0.044, 0)
        TabImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TabImage.Size = UDim2.new(0, 30, 0, 30)
        TabImage.BorderSizePixel = 0
        TabImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabImage.Image = "rbxassetid://" .. tostring(cfg.Image)
        TabImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
        TabImage.ImageRectOffset = cfg.Offset
        TabImage.BackgroundTransparency = 1
        TabImage.ImageRectSize = cfg.ReactSize

        if usingImage then
            TabName.Position = UDim2.new(0.246376812, 0, 0, 0)
            TabImage.Visible = true
            TabImage.Position = UDim2.new(0.13, 0, 0.5, 0)
            TabImage.AnchorPoint = Vector2.new(0.5, 0.5)
        else
            TabName.Position = UDim2.new(0.05, 0, 0, 0)
            TabImage.Visible = false
        end

        local UICorner_5 = Instance.new("UICorner")
        UICorner_5.Parent = Bg

        local Tab2 = Instance.new("Frame")
        Tab2.AnchorPoint = Vector2.new(0, 0.5)
        Tab2.Parent = SelectedTab
        Tab2.Name = "Tab2"
        Tab2.Position = UDim2.new(0.963999987, 0, 0.5, 0)
        Tab2.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab2.Size = UDim2.new(0, 21, 0, 31)
        Tab2.BorderSizePixel = 0
        Tab2.BackgroundColor3 = Color3.fromRGB(24, 40, 73)
        Tab2.BackgroundTransparency = 1

        if FirstTab then
            Bg.BackgroundTransparency = 1
            Tab1.BackgroundTransparency = 1
            Tab2.BackgroundTransparency = 1
        else
            FirstTab = cfg.Name
            currentTab = cfg.Name
            Bg.BackgroundTransparency = 0
            Tab1.BackgroundTransparency = 0
            Tab2.BackgroundTransparency = 0
        end
        TextLabel_5.Text = FirstTab

        local UICorner_6 = Instance.new("UICorner")
        UICorner_6.Parent = Tab2
        local SideHolder = Instance.new("Frame")
        SideHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SideHolder.AnchorPoint = Vector2.new(0.5, 0.5)
        SideHolder.Parent = ContenHolderContainer
        SideHolder.BackgroundTransparency = 1
        SideHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
        SideHolder.Name = cfg.Name
        SideHolder.Size = UDim2.new(1, 0, 1, 0)
        SideHolder.BorderSizePixel = 0
        SideHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        tabbtn.MouseButton1Click:Connect(
            function()
                for _, tab in pairs(TabContainer:GetChildren()) do
                    if tab:IsA("Frame") and tab.Name ~= "Divider" and tab.Name ~= "TextDivider" then
                        TweenService:Create(
                            tab.Tab2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            tab.Tab1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            tab.Bg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                    end
                end
                TextLabel_5.Text = cfg.Name
                TweenService:Create(
                    Tab2,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    Tab1,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    Bg,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()

                UIPageLayout:JumpTo(SideHolder)
            end
        )
        local Right = Instance.new("ScrollingFrame")
        Right.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        Right.Active = true
        Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Right.ScrollBarThickness = 0
        Right.Parent = SideHolder
        Right.BackgroundTransparency = 1
        Right.Position = UDim2.new(0.5, 0, 0.002, 0)
        Right.Name = "Right"
        Right.Size = UDim2.new(0, 350, 0, 550)
        Right.BorderSizePixel = 0
        Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        local UIListLayout_3 = Instance.new("UIListLayout")
        UIListLayout_3.Wraps = true
        UIListLayout_3.Parent = Right
        UIListLayout_3.Padding = UDim.new(0, 10)
        UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal

        local UIPadding_2 = Instance.new("UIPadding")
        UIPadding_2.Parent = Right
        UIPadding_2.PaddingTop = UDim.new(0, 5)
        UIPadding_2.PaddingLeft = UDim.new(0, 1)

        local Left = Instance.new("ScrollingFrame")
        Left.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        Left.Active = true
        Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Left.ScrollBarThickness = 0
        Left.Parent = SideHolder
        Left.BackgroundTransparency = 1
        Left.Position = UDim2.new(0.017906336, 0, 0.002, 0)
        Left.Name = "Left"
        Left.Size = UDim2.new(0, 350, 0, 550)
        Left.BorderSizePixel = 0
        Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            Left.Position = UDim2.new(0.019, 0, 0.002, 0)
        else
        end
        local UIListLayout_5 = Instance.new("UIListLayout")
        UIListLayout_5.Wraps = true
        UIListLayout_5.Parent = Left
        UIListLayout_5.Padding = UDim.new(0, 10)
        UIListLayout_5.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_5.FillDirection = Enum.FillDirection.Horizontal

        local UIPadding_4 = Instance.new("UIPadding")
        UIPadding_4.Parent = Left
        UIPadding_4.PaddingTop = UDim.new(0, 5)
        UIPadding_4.PaddingLeft = UDim.new(0, 1)

        function Items:Label(Options)
            local cfg = {
                Name = Options.Name or "Label",
                Info = Options.Info or "",
                Side = Options.Side or "Left"
            }

            local Label = Instance.new("Frame")
            Label.Name = "Label"
            Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Label.Size = UDim2.new(0, 340, 0, 52)
            Label.BorderSizePixel = 0
            Label.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                Label.Parent = Left
            else
                Label.Parent = Right
            end

            local UICorner_41 = Instance.new("UICorner")
            UICorner_41.Parent = Label

            local UIStroke_32 = Instance.new("UIStroke")
            UIStroke_32.Thickness = 0.51
            UIStroke_32.Transparency = 0.79
            UIStroke_32.Parent = Label
            UIStroke_32.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_27 = Instance.new("TextLabel")
            TextLabel_27.TextWrapped = true
            TextLabel_27.Parent = Label
            TextLabel_27.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_27.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_27.Text = cfg.Name
            TextLabel_27.Size = UDim2.new(0, 311, 0, 40)
            TextLabel_27.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_27.Position = UDim2.new(0.047411751, 0, 0.5, 0)
            TextLabel_27.BackgroundTransparency = 1
            TextLabel_27.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_27.BorderSizePixel = 0
            TextLabel_27.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_27.TextSize = 18
            TextLabel_27.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            if cfg.Info == "" then
                Label.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_27.Position = UDim2.new(0.047411751, 0, 0.5, 0)
            else
                TextLabel_27.Position = UDim2.new(0.047411751, 0, 0.224, 0)

                Label.Size = UDim2.new(0, 340, 0, 87)
                local TextLabel_29 = Instance.new("TextLabel")
                TextLabel_29.Parent = Label
                TextLabel_29.TextWrapped = true
                TextLabel_29.TextColor3 = Color3.fromRGB(100, 100, 100)
                TextLabel_29.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel_29.Text = cfg.Info
                TextLabel_29.Size = UDim2.new(0, 311, 0, 50)
                TextLabel_29.Position = UDim2.new(0.047411751, 0, 0.664, 0)
                TextLabel_29.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_29.BorderSizePixel = 0
                TextLabel_29.BackgroundTransparency = 1
                TextLabel_29.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel_29.FontFace =
                    Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                TextLabel_29.TextYAlignment = Enum.TextYAlignment.Top
                TextLabel_29.TextSize = 15
                TextLabel_29.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            end
            local Label = {}
            function Label:Change(Options)
                TextLabel_27.Text = Options.Name
                if not cfg.Info == "" then
                    TextLabel_29.Text = Options.Info
                end
            end

            return Label
        end

        function Items:Button(Options)
            local cfg = {
                Name = Options.Name or "Button",
                Info = Options.Info or "Info",
                Side = Options.Side or "Left",
                Callback = Options.Callback or print("clicked")
            }
            local Button = Instance.new("Frame")
            Button.Name = "Button"
            Button.Position = UDim2.new(-0.037249282, 0, 0.292, 0)
            Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Button.Size = UDim2.new(0, 340, 0, 87)
            Button.BorderSizePixel = 0
            Button.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                Button.Parent = Left
            else
                Button.Parent = Right
            end

            local UICorner_43 = Instance.new("UICorner")
            UICorner_43.Parent = Button

            local UIStroke_34 = Instance.new("UIStroke")
            UIStroke_34.Thickness = 0.51
            UIStroke_34.Transparency = 0.79
            UIStroke_34.Parent = Button
            UIStroke_34.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_30 = Instance.new("TextLabel")
            TextLabel_30.TextWrapped = true
            TextLabel_30.Parent = Button
            TextLabel_30.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_30.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_30.Text = cfg.Name
            TextLabel_30.Size = UDim2.new(0, 271, 0, 40)
            TextLabel_30.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_30.Position = UDim2.new(0.047411751, 0, 0.224, 0)
            TextLabel_30.BackgroundTransparency = 1
            TextLabel_30.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_30.BorderSizePixel = 0
            TextLabel_30.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_30.TextSize = 18
            TextLabel_30.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_31 = Instance.new("TextLabel")
            TextLabel_31.Parent = Button
            TextLabel_31.TextWrapped = true
            TextLabel_31.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_31.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_31.Text = cfg.Info
            TextLabel_31.Size = UDim2.new(0, 271, 0, 50)
            TextLabel_31.Position = UDim2.new(0.047411751, 0, 0.664, 0)
            TextLabel_31.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_31.BorderSizePixel = 0
            TextLabel_31.BackgroundTransparency = 1
            TextLabel_31.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_31.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_31.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_31.TextSize = 15
            TextLabel_31.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TouchApp = Instance.new("ImageLabel")
            TouchApp.ImageColor3 = Color3.fromRGB(177, 177, 177)
            TouchApp.Parent = Button
            TouchApp.Name = "TouchApp"
            TouchApp.Image = "rbxassetid://8445470392"
            TouchApp.BackgroundTransparency = 1
            TouchApp.Position = UDim2.new(0.873529434, 0, 0.322, 0)
            TouchApp.ImageRectOffset = Vector2.new(504, 504)
            TouchApp.ImageRectSize = Vector2.new(96, 96)
            TouchApp.Size = UDim2.new(0, 30, 0, 30)

            local TextButton_9 = Instance.new("TextButton")
            TextButton_9.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_9.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_9.Text = ""
            TextButton_9.Parent = Button
            TextButton_9.BackgroundTransparency = 1
            TextButton_9.Size = UDim2.new(1, 0, 1, 0)
            TextButton_9.BorderSizePixel = 0
            TextButton_9.TextSize = 14
            TextButton_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            if cfg.Info == "" then
                Button.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_30.Size = UDim2.new(0, 271, 0, 40)
                TextLabel_30.Position = UDim2.new(0.047411751, 0, 0.5, 0)
                TouchApp.Position = UDim2.new(0.873529434, 0, 0.187, 0)
                TextLabel_31.Visible = false
            else
                Button.Size = UDim2.new(0, 340, 0, 87)
                TextLabel_31.Size = UDim2.new(0, 271, 0, 50)
                TextLabel_31.Position = UDim2.new(0.047411751, 0, 0.664, 0)
                TouchApp.Position = UDim2.new(0.873529434, 0, 0.322, 0)
            end
            local Holding = false
            if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            else
                TextButton_9.MouseEnter:Connect(
                    function()
                        Holding = true

                        TweenService:Create(
                            TouchApp,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                )
                TextButton_9.MouseLeave:Connect(
                    function()
                        Holding = false
                        TweenService:Create(
                            TouchApp,
                            TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(177, 177, 177)}
                        ):Play()
                    end
                )
            end

            TextButton_9.MouseButton1Click:Connect(
                function()
                    local Success, Response = pcall(cfg.Callback)
                    if not Success then
                        library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                    end
                end
            )
            TextButton_9.MouseButton1Click:Connect(
                function()
                    TweenService:Create(
                        TouchApp,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(177, 177, 177)}
                    ):Play()
                    wait(0.2)
                    TweenService:Create(
                        TouchApp,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                    if not Holding then
                        wait(0.2)
                        TweenService:Create(
                            TouchApp,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {ImageColor3 = Color3.fromRGB(177, 177, 177)}
                        ):Play()
                    end
                end
            )
            local Button = {}

            function Button:Update(Options)
                TextLabel_30.Text = Options.Name
                TextLabel_31.Text = Options.Info
                cfg.Name = Options.Name
            end

            return Button
        end

        function Items:Toggle(Options)
            local cfg = {
                Name = Options.Name or "Toggle",
                Info = Options.Info or "",
                State = Options.State or false,
                Side = Options.Side or "Left",
                Callback = Options.Callback
            }
            local Toggle = Instance.new("Frame")
            Toggle.Name = "Toggle"
            Toggle.Position = UDim2.new(0, 0, 0.47, 0)
            Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.Size = UDim2.new(0, 340, 0, 52)
            Toggle.BorderSizePixel = 0
            Toggle.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                Toggle.Parent = Left
            else
                Toggle.Parent = Right
            end

            local UIStroke_36 = Instance.new("UIStroke")
            UIStroke_36.Thickness = 0.51
            UIStroke_36.Transparency = 0.79
            UIStroke_36.Parent = Toggle
            UIStroke_36.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_33 = Instance.new("TextLabel")
            TextLabel_33.TextWrapped = true
            TextLabel_33.Parent = Toggle
            TextLabel_33.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_33.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_33.Text = cfg.Name
            TextLabel_33.Size = UDim2.new(0, 271, 0, 40)
            TextLabel_33.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_33.Position = UDim2.new(0.047411751, 0, 0.5, 0)
            TextLabel_33.BackgroundTransparency = 1
            TextLabel_33.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_33.BorderSizePixel = 0
            TextLabel_33.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_33.TextSize = 18
            TextLabel_33.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextButton_11 = Instance.new("TextButton")
            TextButton_11.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_11.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_11.Text = ""
            TextButton_11.Parent = Toggle
            TextButton_11.BackgroundTransparency = 1
            TextButton_11.Size = UDim2.new(1, 0, 1, 0)
            TextButton_11.BorderSizePixel = 0
            TextButton_11.TextSize = 14
            TextButton_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_28 = Instance.new("Frame")
            Frame_28.Parent = Toggle
            Frame_28.Position = UDim2.new(0.873529434, 0, 0.192, 0)
            Frame_28.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_28.Size = UDim2.new(0, 30, 0, 30)
            Frame_28.BorderSizePixel = 0
            Frame_28.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_45 = Instance.new("UICorner")
            UICorner_45.Parent = Frame_28

            local UIStroke_37 = Instance.new("UIStroke")
            UIStroke_37.Thickness = 0.51
            UIStroke_37.Transparency = 0.79
            UIStroke_37.Parent = Frame_28
            UIStroke_37.Color = Color3.fromRGB(255, 255, 255)

            local UICorner_46 = Instance.new("UICorner")
            UICorner_46.Parent = Toggle
            local TextLabel_35 = Instance.new("TextLabel")
            TextLabel_35.Parent = Toggle
            TextLabel_35.TextWrapped = true
            TextLabel_35.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_35.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_35.Text = cfg.Info
            TextLabel_35.Size = UDim2.new(0, 271, 0, 50)
            TextLabel_35.Position = UDim2.new(0.047411751, 0, 0.664, 0)
            TextLabel_35.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_35.BorderSizePixel = 0
            TextLabel_35.BackgroundTransparency = 1
            TextLabel_35.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_35.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_35.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_35.TextSize = 15
            TextLabel_35.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_11.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        UIStroke_37,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )
            TextButton_11.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        UIStroke_37,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )
            local Check = Instance.new("ImageLabel")
            Check.Parent = Frame_28
            Check.Name = "Check"
            Check.Image = "rbxassetid://8445471173"
            Check.BackgroundTransparency = 1
            Check.Position = UDim2.new(0.100000001, 0, 0.1, 0)
            Check.ImageRectOffset = Vector2.new(504, 604)
            Check.ImageRectSize = Vector2.new(96, 96)
            Check.Size = UDim2.new(0, 24, 0, 24)

            if cfg.Info == "" then
                Toggle.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_35.Visible = false
                TextLabel_33.Position = UDim2.new(0.047411751, 0, 0.5, 0)
            else
                Toggle.Size = UDim2.new(0, 340, 0, 87)
                TextLabel_35.Visible = true
                TextLabel_33.Position = UDim2.new(0.047411751, 0, 0.224, 0)
            end
            local NState = cfg.State

            local Toggle = {}
            function Toggle:Set(state)
                local Success, Response = pcall(cfg.Callback, state)
                if not Success then
                    library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                end
                if state then
                    TweenService:Create(
                        Frame_28,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(24, 66, 147)}
                    ):Play()
                    TweenService:Create(
                        Check,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                else
                    TweenService:Create(
                        Frame_28,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(11, 11, 15)}
                    ):Play()
                    TweenService:Create(
                        Check,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(11, 11, 15)}
                    ):Play()
                end
            end
            Toggle:Set(NState)
            TextButton_11.MouseButton1Click:Connect(
                function()
                    NState = not NState
                    Toggle:Set(NState)
                end
            )

            function Toggle:Update(Options)
                TextLabel_33.Text = Options.Name
                TextLabel_35.Text = Options.Info
                cfg.Name = Options.Name
                cfg.Info = Options.Name
            end
            return Toggle
        end
        function Items:Keybind(Options)
            local cfg = {
                Name = Options.Name or "Keybind",
                Info = Options.Info or "",
                Keybind = Options.Keybind or Enum.KeyCode.U,
                Side = Options.Side or "Left",
                Callback = Options.Callback
            }
            local keyaa = library:AddKeyItem({Name = cfg.Name, Keybind = cfg.Keybind.Name})
            local Keybind = Instance.new("Frame")
            Keybind.Name = "Keybind"
            Keybind.Position = UDim2.new(0, 0, 0.47, 0)
            Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.Size = UDim2.new(0, 340, 0, 52)
            Keybind.BorderSizePixel = 0
            Keybind.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                Keybind.Parent = Left
            else
                Keybind.Parent = Right
            end

            local UIStroke_46 = Instance.new("UIStroke")
            UIStroke_46.Thickness = 0.51
            UIStroke_46.Transparency = 0.79
            UIStroke_46.Parent = Keybind
            UIStroke_46.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_41 = Instance.new("TextLabel")
            TextLabel_41.TextWrapped = true
            TextLabel_41.Parent = Keybind
            TextLabel_41.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_41.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_41.Text = cfg.Name
            TextLabel_41.Size = UDim2.new(0, 222, 0, 40)
            TextLabel_41.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_41.Position = UDim2.new(0.047411751, 0, 0.493, 0)
            TextLabel_41.BackgroundTransparency = 1
            TextLabel_41.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_41.BorderSizePixel = 0
            TextLabel_41.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_41.TextSize = 18
            TextLabel_41.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_55 = Instance.new("UICorner")
            UICorner_55.Parent = Keybind

            local Frame_34 = Instance.new("Frame")
            Frame_34.Parent = Keybind
            Frame_34.Position = UDim2.new(0.7297647, 0, 0.208, 0)
            Frame_34.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_34.Size = UDim2.new(0, 79, 0, 30)
            Frame_34.BorderSizePixel = 0
            Frame_34.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local TextButton_15 = Instance.new("TextButton")
            TextButton_15.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_15.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_15.Text = ""
            TextButton_15.Parent = Frame_34
            TextButton_15.BackgroundTransparency = 1
            TextButton_15.Size = UDim2.new(1, 0, 1, 0)
            TextButton_15.BorderSizePixel = 0
            TextButton_15.TextSize = 14
            TextButton_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_56 = Instance.new("UICorner")
            UICorner_56.Parent = Frame_34

            local UIStroke_47 = Instance.new("UIStroke")
            UIStroke_47.Thickness = 0.51
            UIStroke_47.Transparency = 0.79
            UIStroke_47.Parent = Frame_34
            UIStroke_47.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_42 = Instance.new("TextLabel")
            TextLabel_42.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_42.TextColor3 = Color3.fromRGB(145, 145, 145)
            TextLabel_42.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_42.Text = tostring(cfg.Keybind.Name)
            TextLabel_42.Parent = Frame_34
            TextLabel_42.BackgroundTransparency = 1
            TextLabel_42.Size = UDim2.new(1, 0, 1, 0)
            TextLabel_42.BorderSizePixel = 0
            TextLabel_42.TextSize = 14
            TextLabel_42.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_44 = Instance.new("TextLabel")
            TextLabel_44.Parent = Keybind
            TextLabel_44.TextWrapped = true
            TextLabel_44.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_44.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_44.Text = cfg.Info
            TextLabel_44.Size = UDim2.new(0, 310, 0, 47)
            TextLabel_44.Position = UDim2.new(0.047411751, 0, 0.677, 0)
            TextLabel_44.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_44.BorderSizePixel = 0
            TextLabel_44.BackgroundTransparency = 1
            TextLabel_44.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_44.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_44.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_44.TextSize = 15
            TextLabel_44.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_34.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        UIStroke_47,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                    TweenService:Create(
                        TextLabel_42,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(180, 180, 180)}
                    ):Play()
                end
            )
            Frame_34.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        UIStroke_47,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                    TweenService:Create(
                        TextLabel_42,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(145, 145, 145)}
                    ):Play()
                end
            )
            if cfg.Info == "" then
                Keybind.Size = UDim2.new(0, 340, 0, 52)
                Frame_34.Position = UDim2.new(0.7297647, 0, 0.208, 0)
                Frame_34.Size = UDim2.new(0, 79, 0, 30)
                TextLabel_44.Visible = false
                Frame_34.AnchorPoint = Vector2.new(0, 0.5)

                local TextBoundsX = TextLabel_42.TextBounds.X

                Frame_34.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
                if TextLabel_42.Text:len() < 2 then
                    Frame_34.Position = UDim2.new(0.88, 0, 0.5, 0)
                elseif TextLabel_42.Text:len() == 3 then
                    Frame_34.Position = UDim2.new(0.83, 0, 0.5, 0)
                elseif TextLabel_42.Text:len() == 4 then
                    Frame_34.Position = UDim2.new(0.83, 0, 0.5, 0)
                elseif TextLabel_42.Text:len() == 5 then
                    Frame_34.Position = UDim2.new(0.8, 0, 0.5, 0)
                else
                    Frame_34.Position = UDim2.new(0.71, 0, 0.5, 0)
                end
            else
                Keybind.Size = UDim2.new(0, 340, 0, 87)
                Frame_34.Position = UDim2.new(0.726999998, 0, 0.044, 0)
                Frame_34.Size = UDim2.new(0, 79, 0, 30)
                TextLabel_41.Position = UDim2.new(0.047411751, 0, 0.224, 0)
                Frame_34.AnchorPoint = Vector2.new(0.5, 0.5)
                local TextBoundsX = TextLabel_42.TextBounds.X

                Frame_34.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)

                if TextLabel_42.Text:len() < 2 then
                    Frame_34.Position = UDim2.new(0.91, 0, 0.23, 0)
                elseif TextLabel_42.Text:len() == 3 then
                    Frame_34.Position = UDim2.new(0.885, 0, 0.23, 0)
                elseif TextLabel_42.Text:len() == 4 then
                    Frame_34.Position = UDim2.new(0.89, 0, 0.23, 0)
                elseif TextLabel_42.Text:len() == 5 then
                    Frame_34.Position = UDim2.new(0.88, 0, 0.23, 0)
                else
                    Frame_34.Position = UDim2.new(0.842, 0, 0.23, 0)
                end
            end

            local Keybind = {}
            local listening = false

            function Keybind:Set(key)
                cfg.Keybind = key
                TextLabel_42.Text = cfg.Keybind.Name or "?"
                keyaa:Update({Name = cfg.Name, Keybind = key.Name})
            end
            function Keybind:Update(Options)
                TextLabel_41.Text = Options.Name
                TextLabel_44.Text = Options.Info
                cfg.Name = Options.Name
                cfg.Info = Options.Info
            end
            UserInputService.InputBegan:Connect(
                function(key)
                    if listening then
                        if key.UserInputType == Enum.UserInputType.Keyboard then
                            if key.KeyCode ~= Enum.KeyCode.Escape then
                                cfg.Keybind = key.KeyCode
                                keyaa:Update({Name = cfg.Name, Keybind = cfg.Keybind.Name})
                            end
                            TextLabel_42.Text = cfg.Keybind.Name or "?"
                            listening = false
                            local TextBoundsX = TextLabel_42.TextBounds.X

                            Frame_34.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
                            if cfg.Info == "" then
                                if TextLabel_42.Text:len() < 2 then
                                    Frame_34.Position = UDim2.new(0.88, 0, 0.5, 0)
                                elseif TextLabel_42.Text:len() == 3 then
                                    Frame_34.Position = UDim2.new(0.83, 0, 0.5, 0)
                                elseif TextLabel_42.Text:len() == 4 then
                                    Frame_34.Position = UDim2.new(0.83, 0, 0.5, 0)
                                elseif TextLabel_42.Text:len() == 5 then
                                    Frame_34.Position = UDim2.new(0.8, 0, 0.5, 0)
                                else
                                    Frame_34.Position = UDim2.new(0.71, 0, 0.5, 0)
                                end
                            else
                                local TextBoundsX = TextLabel_42.TextBounds.X

                                Frame_34.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)

                                if TextLabel_42.Text:len() < 2 then
                                    Frame_34.Position = UDim2.new(0.91, 0, 0.23, 0)
                                elseif TextLabel_42.Text:len() == 3 then
                                    Frame_34.Position = UDim2.new(0.885, 0, 0.23, 0)
                                elseif TextLabel_42.Text:len() == 4 then
                                    Frame_34.Position = UDim2.new(0.89, 0, 0.23, 0)
                                elseif TextLabel_42.Text:len() == 5 then
                                    Frame_34.Position = UDim2.new(0.88, 0, 0.23, 0)
                                else
                                    Frame_34.Position = UDim2.new(0.842, 0, 0.23, 0)
                                end
                            end
                        end
                    else
                        if key.KeyCode == cfg.Keybind then
                            local Success, Response = pcall(cfg.Callback)
                            if not Success then
                                library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                            end
                        end
                    end
                end
            )

            TextButton_15.MouseButton1Click:Connect(
                function()
                    if not listening then
                        listening = true
                        TextLabel_42.Text = "..."
                    end
                end
            )
            return Keybind
        end
        function Items:ToggleKeybind(Options)
            local cfg = {
                Name = Options.Name or "ToggleKeybind",
                Info = Options.Info or "",
                State = Options.State or false,
                Keybind = Options.Keybind or Enum.KeyCode.Y,
                Side = Options.Side or "Left",
                Callback = Options.Callback
            }
            local keyab = library:AddKeyItem({Name = cfg.Name, Keybind = cfg.Keybind.Name})
            local KeybindToggle = Instance.new("Frame")

            KeybindToggle.Name = "KeybindToggle"
            KeybindToggle.Position = UDim2.new(-0.037249282, 0, 0.292, 0)
            KeybindToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            KeybindToggle.Size = UDim2.new(0, 340, 0, 87)
            KeybindToggle.BorderSizePixel = 0
            KeybindToggle.BackgroundColor3 = Color3.fromRGB(24, 25, 28)

            if cfg.Side == "Left" then
                KeybindToggle.Parent = Left
            else
                KeybindToggle.Parent = Right
            end

            local UICorner_49 = Instance.new("UICorner")
            UICorner_49.Parent = KeybindToggle

            local UIStroke_40 = Instance.new("UIStroke")
            UIStroke_40.Thickness = 0.51
            UIStroke_40.Transparency = 0.79
            UIStroke_40.Parent = KeybindToggle
            UIStroke_40.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_36 = Instance.new("TextLabel")
            TextLabel_36.TextWrapped = true
            TextLabel_36.Parent = KeybindToggle
            TextLabel_36.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_36.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_36.Text = cfg.Name
            TextLabel_36.Size = UDim2.new(0, 271, 0, 40)
            TextLabel_36.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_36.Position = UDim2.new(0.047411751, 0, 0.224, 0)
            TextLabel_36.BackgroundTransparency = 1
            TextLabel_36.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_36.BorderSizePixel = 0
            TextLabel_36.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_36.TextSize = 18
            TextLabel_36.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_37 = Instance.new("TextLabel")
            TextLabel_37.Parent = KeybindToggle
            TextLabel_37.TextWrapped = true
            TextLabel_37.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_37.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_37.Text = cfg.Info
            TextLabel_37.Size = UDim2.new(0, 222, 0, 50)
            TextLabel_37.Position = UDim2.new(0.047411751, 0, 0.664, 0)
            TextLabel_37.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_37.BorderSizePixel = 0
            TextLabel_37.BackgroundTransparency = 1
            TextLabel_37.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_37.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_37.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_37.TextSize = 15
            TextLabel_37.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_30 = Instance.new("Frame")
            Frame_30.Parent = KeybindToggle
            Frame_30.Position = UDim2.new(0.873529434, 0, 0.1, 0)
            Frame_30.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_30.Size = UDim2.new(0, 30, 0, 30)
            Frame_30.BorderSizePixel = 0
            Frame_30.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local Check = Instance.new("ImageLabel")
            Check.Parent = Frame_30
            Check.Name = "Check"
            Check.Image = "rbxassetid://8445471173"
            Check.BackgroundTransparency = 1
            Check.Position = UDim2.new(0.100000001, 0, 0.1, 0)
            Check.ImageRectOffset = Vector2.new(504, 604)
            Check.ImageRectSize = Vector2.new(96, 96)
            Check.Size = UDim2.new(0, 24, 0, 24)
            local UICorner_50 = Instance.new("UICorner")
            UICorner_50.Parent = Frame_30

            local UIStroke_41 = Instance.new("UIStroke")
            UIStroke_41.Thickness = 0.51
            UIStroke_41.Transparency = 0.79
            UIStroke_41.Parent = Frame_30
            UIStroke_41.Color = Color3.fromRGB(255, 255, 255)
            Frame_30.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        UIStroke_41,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )
            Frame_30.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        UIStroke_41,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )
            local Frame_31 = Instance.new("Frame")
            Frame_31.Parent = KeybindToggle
            Frame_31.Position = UDim2.new(0.726999998, 0, 0.55, 0)
            Frame_31.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_31.Size = UDim2.new(0, 79, 0, 30)
            Frame_31.BorderSizePixel = 0
            Frame_31.BackgroundColor3 = Color3.fromRGB(11, 11, 15)
            Frame_31.AnchorPoint = Vector2.new(0.5, 0.5)

            local UICorner_51 = Instance.new("UICorner")
            UICorner_51.Parent = Frame_31

            local UIStroke_42 = Instance.new("UIStroke")
            UIStroke_42.Thickness = 0.51
            UIStroke_42.Transparency = 0.79
            UIStroke_42.Parent = Frame_31
            UIStroke_42.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_38 = Instance.new("TextLabel")
            TextLabel_38.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_38.TextColor3 = Color3.fromRGB(145, 145, 145)
            TextLabel_38.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_38.Text = tostring(cfg.Keybind.Name)
            TextLabel_38.Parent = Frame_31
            TextLabel_38.BackgroundTransparency = 1
            TextLabel_38.Size = UDim2.new(1, 0, 1, 0)
            TextLabel_38.BorderSizePixel = 0
            TextLabel_38.TextSize = 14
            TextLabel_38.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            local TextButton_13 = Instance.new("TextButton")
            TextButton_13.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_13.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_13.Text = ""
            TextButton_13.Parent = Frame_31
            TextButton_13.BackgroundTransparency = 1
            TextButton_13.Size = UDim2.new(1, 0, 1, 0)
            TextButton_13.BorderSizePixel = 0
            TextButton_13.TextSize = 14
            TextButton_13.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextButton_14 = Instance.new("TextButton")
            TextButton_14.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_14.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_14.Text = ""
            TextButton_14.Parent = Frame_30
            TextButton_14.BackgroundTransparency = 1
            TextButton_14.Size = UDim2.new(1, 0, 1, 0)
            TextButton_14.BorderSizePixel = 0
            TextButton_14.TextSize = 14
            TextButton_14.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_31.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        UIStroke_42,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )
            Frame_31.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        UIStroke_42,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )
            if cfg.Info == "" then
                KeybindToggle.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_37.Visible = false
                Frame_31.Position = UDim2.new(0.612117648, 0, 0.5, 0)
                Frame_31.Size = UDim2.new(0, 79, 0, 30)
                TextLabel_36.Position = UDim2.new(0.047411751, 0, 0.5, 0)
                Frame_30.Position = UDim2.new(0.873529434, 0, 0.5, 0)
                Frame_30.AnchorPoint = Vector2.new(0, 0.5)
                local TextBoundsX = TextLabel_38.TextBounds.X

                Frame_31.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
                if TextLabel_38.Text:len() < 2 then
                    Frame_31.Position = UDim2.new(0.81, 0, 0.5, 0)
                elseif TextLabel_38.Text:len() == 3 then
                    Frame_31.Position = UDim2.new(0.785, 0, 0.5, 0)
                elseif TextLabel_38.Text:len() == 4 then
                    Frame_31.Position = UDim2.new(0.78, 0, 0.5, 0)
                elseif TextLabel_38.Text:len() == 5 then
                    Frame_31.Position = UDim2.new(0.77, 0, 0.5, 0)
                else
                    Frame_31.Position = UDim2.new(0.742, 0, 0.5, 0)
                end
            else
                KeybindToggle.Size = UDim2.new(0, 340, 0, 87)
                TextLabel_37.Visible = true
                Frame_31.Position = UDim2.new(0.85, 0, 0.7, 0)
                Frame_31.Size = UDim2.new(0, 79, 0, 30)
                Frame_31.AnchorPoint = Vector2.new(0.5, 0.5)
                local TextBoundsX = TextLabel_38.TextBounds.X

                Frame_31.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)

                if TextLabel_38.Text:len() < 2 then
                    Frame_31.Position = UDim2.new(0.91, 0, 0.7, 0)
                elseif TextLabel_38.Text:len() == 3 then
                    Frame_31.Position = UDim2.new(0.885, 0, 0.7, 0)
                elseif TextLabel_38.Text:len() == 4 then
                    Frame_31.Position = UDim2.new(0.89, 0, 0.7, 0)
                elseif TextLabel_38.Text:len() == 5 then
                    Frame_31.Position = UDim2.new(0.88, 0, 0.7, 0)
                else
                    Frame_31.Position = UDim2.new(0.842, 0, 0.7, 0)
                end
            end
            local ToggleKeybind = {}
            function ToggleKeybind:Set(state)
                local Success, Response = pcall(cfg.Callback, state)
                if not Success then
                    library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                end
                if state then
                    TweenService:Create(
                        Frame_30,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(24, 66, 147)}
                    ):Play()
                    TweenService:Create(
                        Check,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                    ):Play()
                else
                    TweenService:Create(
                        Frame_30,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(11, 11, 15)}
                    ):Play()
                    TweenService:Create(
                        Check,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(11, 11, 15)}
                    ):Play()
                end
            end

            function ToggleKeybind:Update(Options)
                local newcfg = {
                    Name = Options.Name or cfg.Name,
                    Info = Options.Info or cfg.Info,
                    Keybind = Options.Keybind or cfg.Keybind,
                    State = Options.State or cfg.State
                }
                TextLabel_36.Text = newcfg.Name
                TextLabel_37.Text = newcfg.Info
                cfg.Name = newcfg.Name
                cfg.Info = newcfg.Info
                cfg.Keybind = newcfg.Keybind
                cfg.State = newcfg.State
                TextLabel_38.Text = tostring(newcfg.Keybind.Name)
                keyab:Update({Name = newcfg.Name, Keybind = newcfg.Keybind.Name})
            end
            local State = cfg.State
            local listening = false
            UserInputService.InputBegan:Connect(
                function(key)
                    if listening then
                        if key.UserInputType == Enum.UserInputType.Keyboard then
                            if key.KeyCode ~= Enum.KeyCode.Escape then
                                cfg.Keybind = key.KeyCode
                                keyab:Update({Name = cfg.Name, Keybind = cfg.Keybind.Name})
                            end
                            TextLabel_38.Text = tostring(cfg.Keybind.Name) or "?"
                            listening = false
                            local TextBoundsX = TextLabel_38.TextBounds.X
                            Frame_31.Size = UDim2.new(0, TextBoundsX + 20, 0, 30)
                            if cfg.Info == "" then
                                if TextLabel_38.Text:len() < 2 then
                                    Frame_31.Position = UDim2.new(0.81, 0, 0.5, 0)
                                elseif TextLabel_38.Text:len() == 3 then
                                    Frame_31.Position = UDim2.new(0.785, 0, 0.5, 0)
                                elseif TextLabel_38.Text:len() == 4 then
                                    Frame_31.Position = UDim2.new(0.78, 0, 0.5, 0)
                                elseif TextLabel_38.Text:len() == 5 then
                                    Frame_31.Position = UDim2.new(0.77, 0, 0.5, 0)
                                else
                                    Frame_31.Position = UDim2.new(0.742, 0, 0.5, 0)
                                end
                            else
                                if TextLabel_38.Text:len() < 2 then
                                    Frame_31.Position = UDim2.new(0.91, 0, 0.7, 0)
                                elseif TextLabel_38.Text:len() == 3 then
                                    Frame_31.Position = UDim2.new(0.885, 0, 0.7, 0)
                                elseif TextLabel_38.Text:len() == 4 then
                                    Frame_31.Position = UDim2.new(0.89, 0, 0.7, 0)
                                elseif TextLabel_38.Text:len() == 5 then
                                    Frame_31.Position = UDim2.new(0.88, 0, 0.7, 0)
                                else
                                    Frame_31.Position = UDim2.new(0.842, 0, 0.7, 0)
                                end
                            end
                        end
                    else
                        if key.KeyCode == cfg.Keybind then
                            State = not State
                            ToggleKeybind:Set(State)
                        end
                    end
                end
            )
            TextButton_13.MouseButton1Click:Connect(
                function()
                    if not listening then
                        listening = true
                        TextLabel_38.Text = "..."
                    end
                end
            )
            ToggleKeybind:Set(State)
            TextButton_14.MouseButton1Click:Connect(
                function()
                    State = not State
                    ToggleKeybind:Set(State)
                end
            )
            return ToggleKeybind
        end
        function Items:Textbox(Options)
            local cfg = {
                Name = Options.Name or "Textbox",
                Info = Options.Info or "",
                Side = Options.Side or "Left",
                PlaceholderText = Options.PlaceholderText or "",
                DefaultText = Options.DefaultText or "",
                Callback = Options.Callback
            }
            local TextBox_1 = Instance.new("Frame")
            TextBox_1.Name = "TextBox_1"
            TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.Size = UDim2.new(0, 340, 0, 52)
            TextBox_1.BorderSizePixel = 0
            TextBox_1.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                TextBox_1.Parent = Left
            else
                TextBox_1.Parent = Right
            end

            local UICorner_10 = Instance.new("UICorner")
            UICorner_10.Parent = TextBox_1

            local UIStroke_5 = Instance.new("UIStroke")
            UIStroke_5.Thickness = 0.51
            UIStroke_5.Transparency = 0.79
            UIStroke_5.Parent = TextBox_1
            UIStroke_5.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_6 = Instance.new("TextLabel")
            TextLabel_6.TextWrapped = true
            TextLabel_6.Parent = TextBox_1
            TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_6.Text = cfg.Name
            TextLabel_6.Size = UDim2.new(0, 185, 0, 40)
            TextLabel_6.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_6.Position = UDim2.new(0.047411751, 0, 0.5, 0)
            TextLabel_6.BackgroundTransparency = 1
            TextLabel_6.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_6.BorderSizePixel = 0
            TextLabel_6.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_6.TextSize = 18
            TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_6 = Instance.new("Frame")
            Frame_6.Parent = TextBox_1
            Frame_6.Position = UDim2.new(0.594117999, 0, 0.192, 0)
            Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_6.Size = UDim2.new(0, 124, 0, 30)
            Frame_6.BorderSizePixel = 0
            Frame_6.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_11 = Instance.new("UICorner")
            UICorner_11.Parent = Frame_6

            local UIStroke_6 = Instance.new("UIStroke")
            UIStroke_6.Thickness = 0.51
            UIStroke_6.Transparency = 0.79
            UIStroke_6.Parent = Frame_6
            UIStroke_6.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_2 = Instance.new("TextBox")
            TextBox_2.Parent = Frame_6
            TextBox_2.TextWrapped = true
            TextBox_2.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_2.Text = cfg.DefaultText
            TextBox_2.Size = UDim2.new(1, 0, 1, 0)
            TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_2.BorderSizePixel = 0
            TextBox_2.BackgroundTransparency = 1
            TextBox_2.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_2.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_2.PlaceholderText = cfg.PlaceholderText
            TextBox_2.TextSize = 14
            TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox_2.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        TextBox_2,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {PlaceholderColor3 = Color3.fromRGB(170, 170, 170)}
                    ):Play()
                    TweenService:Create(
                        TextBox_2,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(235, 235, 235)}
                    ):Play()

                    TweenService:Create(
                        UIStroke_6,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )
            TextBox_2.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        TextBox_2,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {PlaceholderColor3 = Color3.fromRGB(141, 141, 141)}
                    ):Play()
                    TweenService:Create(
                        TextBox_2,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(202, 202, 202)}
                    ):Play()

                    TweenService:Create(
                        UIStroke_6,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )

            local TextLabel_15 = Instance.new("TextLabel")
            TextLabel_15.Parent = TextBox_1
            TextLabel_15.TextWrapped = true
            TextLabel_15.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_15.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_15.Text = cfg.Info
            TextLabel_15.Size = UDim2.new(0, 178, 0, 57)
            TextLabel_15.Position = UDim2.new(0.047411751, 0, 0.706, 0)
            TextLabel_15.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_15.BorderSizePixel = 0
            TextLabel_15.BackgroundTransparency = 1
            TextLabel_15.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_15.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_15.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_15.TextSize = 15
            TextLabel_15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            if cfg.Info == "" then
                TextBox_1.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_6.Size = UDim2.new(0, 311, 0, 30)
                TextLabel_6.Position = UDim2.new(0.047411751, 0, 0.5, 0)
                TextLabel_15.Visible = false
            else
                TextLabel_15.Visible = true
                TextBox_1.Size = UDim2.new(0, 340, 0, 87)
                TextLabel_6.Size = UDim2.new(0, 178, 0, 57)
                TextLabel_6.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_6.Position = UDim2.new(0.047411751, 0, 0.172, 0)
                Frame_6.Position = UDim2.new(0.594117999, 0, 0.342, 0)
                Frame_6.Size = UDim2.new(0, 124, 0, 30)
            end

            TextBox_2.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox_2.Text > 0 then
                            pcall(
                                function()
                                    local Success, Response = pcall(cfg.Callback, TextBox_2.Text)
                                    if not Success then
                                        library.Notify(
                                            {Title = cfg.Name .. "Callback Error", Info = tostring(Response)}
                                        )
                                    end
                                end
                            )
                        end
                    end
                end
            )
            local Textbox = {}
            function Textbox:Update(newcfg)
                local newcfg = {
                    Name = newcfg.Name or cfg.Name,
                    Info = newcfg.Info or cfg.Info,
                    Side = newcfg.Side or cfg.Side,
                    PlaceholderText = newcfg.PlaceholderText or cfg.PlaceholderText,
                    DefaultText = newcfg.DefaultText or cfg.DefaultText
                }
                cfg.Name = newcfg.Name
                cfg.Info = newcfg.Info
                cfg.Side = newcfg.Side
                cfg.PlaceholderText = newcfg.PlaceholderText
                cfg.DefaultText = newcfg.DefaultText
                TextLabel_6.Text = cfg.Name
                TextLabel_15.Text = cfg.Info
            end
            function Textbox:Set(value)
                TextBox_2.Text = value
                local Success, Response = pcall(cfg.Callback, value)
                if not Success then
                    library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                end
            end
            function Textbox:Get()
                return TextBox_2.Text
            end
            return Textbox
        end

        function Items:Dropdown(Options)
            local cfg = {
                Name = Options.Name or "Dropdown",
                Info = Options.Info or "",
                Lists = Options.Lists or {},
                Default = Options.Default or "",
                Side = Options.Side or "Left",
                Multi = Options.Multi or false,
                Callback = Options.Callback
            }

            local Dropdown = Instance.new("Frame")

            Dropdown.Name = "Dropdown"
            Dropdown.Position = UDim2.new(0, 0, 0.114, 0)
            Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Dropdown.Size = UDim2.new(0, 340, 0, 87)
            Dropdown.BorderSizePixel = 0
            Dropdown.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                Dropdown.Parent = Left
            else
                Dropdown.Parent = Right
            end

            local UICorner_12 = Instance.new("UICorner")
            UICorner_12.Parent = Dropdown

            local UIStroke_7 = Instance.new("UIStroke")
            UIStroke_7.Thickness = 0.51
            UIStroke_7.Transparency = 0.79
            UIStroke_7.Parent = Dropdown
            UIStroke_7.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_7 = Instance.new("TextLabel")
            TextLabel_7.TextWrapped = true
            TextLabel_7.Parent = Dropdown
            TextLabel_7.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_7.Text = cfg.Name
            TextLabel_7.Size = UDim2.new(0, 311, 0, 30)
            TextLabel_7.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_7.Position = UDim2.new(0.047411751, 0, 0.172, 0)
            TextLabel_7.BackgroundTransparency = 1
            TextLabel_7.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_7.BorderSizePixel = 0
            TextLabel_7.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_7.TextSize = 18
            TextLabel_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_8 = Instance.new("TextLabel")
            TextLabel_8.Parent = Dropdown
            TextLabel_8.TextWrapped = true
            TextLabel_8.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_8.Text = cfg.Info
            TextLabel_8.Size = UDim2.new(0, 149, 0, 57)
            TextLabel_8.Position = UDim2.new(0.047411751, 0, 0.706, 0)
            TextLabel_8.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_8.BorderSizePixel = 0
            TextLabel_8.BackgroundTransparency = 1
            TextLabel_8.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_8.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_8.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_8.TextSize = 15
            TextLabel_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_7 = Instance.new("Frame")
            Frame_7.Parent = Dropdown
            Frame_7.Position = UDim2.new(0.520588577, 0, 0.342, 0)
            Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_7.Size = UDim2.new(0, 150, 0, 30)
            Frame_7.BorderSizePixel = 0
            Frame_7.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local drop = Instance.new("TextButton")
            drop.Text = ""
            drop.Parent = Frame_7
            drop.BackgroundTransparency = 1
            drop.Size = UDim2.new(1, 0, 1, 0)
            local UICorner_13 = Instance.new("UICorner")
            UICorner_13.Parent = Frame_7

            local UIStroke_8 = Instance.new("UIStroke")
            UIStroke_8.Thickness = 0.51
            UIStroke_8.Transparency = 0.79
            UIStroke_8.Parent = Frame_7
            UIStroke_8.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_9 = Instance.new("TextLabel")
            TextLabel_9.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_9.TextColor3 = Color3.fromRGB(145, 145, 145)
            TextLabel_9.BorderColor3 = Color3.fromRGB(0, 0, 0)

            TextLabel_9.Parent = Frame_7
            TextLabel_9.BackgroundTransparency = 1
            TextLabel_9.Size = UDim2.new(0.806665838, 0, 1, 0)
            TextLabel_9.BorderSizePixel = 0
            TextLabel_9.TextSize = 14
            TextLabel_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_9.TextTruncate = Enum.TextTruncate.AtEnd
            if cfg.Multi then
                TextLabel_9.Text = table.concat(cfg.Default, ", ")
                local Success, Response = pcall(cfg.Callback, cfg.Default)
                if not Success then
                    library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                end
            else
                TextLabel_9.Text = cfg.Default
                local Success, Response = pcall(cfg.Callback, cfg.Default)
                if not Success then
                    library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                end
            end

            if cfg.Info == "" then
                Dropdown.Size = UDim2.new(0, 340, 0, 52)
                TextLabel_8.Visible = false
                TextLabel_7.Size = UDim2.new(0, 185, 0, 40)
                TextLabel_7.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_7.Position = UDim2.new(0.047411751, 0, 0.5, 0)
                Frame_7.AnchorPoint = Vector2.new(0, 0.5)
                Frame_7.Position = UDim2.new(0.520588577, 0, 0.5, 0)
            else
                Dropdown.Size = UDim2.new(0, 340, 0, 87)
                TextLabel_7.Size = UDim2.new(0, 311, 0, 30)
                TextLabel_7.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_7.Position = UDim2.new(0.047411751, 0, 0.172, 0)
            end

            local Add = Instance.new("ImageLabel")
            Add.ImageColor3 = Color3.fromRGB(158, 158, 158)
            Add.Parent = Frame_7
            Add.Name = "Add"
            Add.Rotation = 0
            Add.Image = "rbxassetid://8445470984"
            Add.BackgroundTransparency = 1
            Add.Position = UDim2.new(0.826666653, 0, 0.167, 0)
            Add.ImageRectSize = Vector2.new(96, 96)
            Add.ImageRectOffset = Vector2.new(804, 704)
            Add.Size = UDim2.new(0, 20, 0, 20)

            local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
            UIAspectRatioConstraint_2.Parent = Add
            UIAspectRatioConstraint_2.DominantAxis = Enum.DominantAxis.Height
            local droptog = false

            local DropdownContainer = Instance.new("Frame")
            DropdownContainer.Parent = Dropdown.Parent
            DropdownContainer.Size = UDim2.new(0, 340, 0, 0)
            DropdownContainer.Visible = false
            DropdownContainer.Name = "DropdownContainer"
            DropdownContainer.ClipsDescendants = true
            DropdownContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
            DropdownContainer.Position = UDim2.new(0, 0, 0.406, 0)
            DropdownContainer.BorderSizePixel = 0
            DropdownContainer.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            DropdownContainer.ClipsDescendants = true

            local UICorner_16 = Instance.new("UICorner")
            UICorner_16.Parent = DropdownContainer

            local UIStroke_11 = Instance.new("UIStroke")
            UIStroke_11.Thickness = 0.51
            UIStroke_11.Transparency = 0.79
            UIStroke_11.Parent = DropdownContainer
            UIStroke_11.Color = Color3.fromRGB(255, 255, 255)

            local UIListLayout_4 = Instance.new("UIListLayout")
            UIListLayout_4.Parent = DropdownContainer
            UIListLayout_4.Padding = UDim.new(0, 3)
            UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

            local UIPadding_3 = Instance.new("UIPadding")
            UIPadding_3.Parent = DropdownContainer
            UIPadding_3.PaddingTop = UDim.new(0, 2)
            UIPadding_3.PaddingLeft = UDim.new(0, 2)
            drop.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Add,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(235, 235, 235)}
                    ):Play()
                    TweenService:Create(
                        TextLabel_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(200, 200, 200)}
                    ):Play()
                    TweenService:Create(
                        UIStroke_8,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )
            drop.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Add,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {ImageColor3 = Color3.fromRGB(158, 158, 158)}
                    ):Play()
                    TweenService:Create(
                        TextLabel_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(145, 145, 145)}
                    ):Play()
                    TweenService:Create(
                        UIStroke_8,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )
            local selectedValues = cfg.Default
            local selectedValue = cfg.Default
            local DropdownF = {}

            function DropdownF:Add(Name)
                local Frame_11 = Instance.new("Frame")
                Frame_11.Parent = DropdownContainer
                Frame_11.ClipsDescendants = true
                Frame_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Frame_11.Size = UDim2.new(0, 335, 0, 38)
                Frame_11.BorderSizePixel = 0
                Frame_11.BackgroundColor3 = Color3.fromRGB(33, 35, 39)

                local UICorner_18 = Instance.new("UICorner")
                UICorner_18.Parent = Frame_11

                local TextLabel_13 = Instance.new("TextLabel")
                TextLabel_13.FontFace =
                    Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
                TextLabel_13.TextColor3 = Color3.fromRGB(94, 94, 94)
                TextLabel_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel_13.Text = Name
                TextLabel_13.Parent = Frame_11
                TextLabel_13.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_13.Size = UDim2.new(0, 323, 0, 35)
                TextLabel_13.BackgroundTransparency = 1
                TextLabel_13.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel_13.Position = UDim2.new(0.046999998, 0, 0.5, 0)
                TextLabel_13.BorderSizePixel = 0
                TextLabel_13.TextSize = 14
                TextLabel_13.BackgroundColor3 = Color3.fromRGB(177, 177, 177)

                if cfg.Multi then
                    if table.find(cfg.Default or {}, Name) then
                        selectedValues[Name] = true
                        TweenService:Create(
                            TextLabel_13,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(177, 177, 177)}
                        ):Play()
                    end
                else
                    if Name == cfg.Default then
                        selectedValue = Name
                        TweenService:Create(
                            TextLabel_13,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(177, 177, 177)}
                        ):Play()
                    end
                end

                local TextButton_2 = Instance.new("TextButton")
                TextButton_2.FontFace =
                    Font.new(
                    "rbxasset://fonts/families/SourceSansPro.json",
                    Enum.FontWeight.Regular,
                    Enum.FontStyle.Normal
                )
                TextButton_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextButton_2.Text = ""
                TextButton_2.Parent = Frame_11
                TextButton_2.BackgroundTransparency = 1
                TextButton_2.Size = UDim2.new(1, 0, 1, 0)
                TextButton_2.BorderSizePixel = 0
                TextButton_2.TextSize = 14
                TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextButton_2.MouseButton1Click:Connect(
                    function()
                        if cfg.Multi then
                            local index = table.find(selectedValues, Name)
                            if index then
                                table.remove(selectedValues, index)
                                TweenService:Create(
                                    TextLabel_13,
                                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {TextColor3 = Color3.fromRGB(94, 94, 94)}
                                ):Play()
                            else
                                table.insert(selectedValues, Name)
                                TweenService:Create(
                                    TextLabel_13,
                                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {TextColor3 = Color3.fromRGB(177, 177, 177)}
                                ):Play()
                            end

                            TextLabel_9.Text = table.concat(selectedValues, ", ")

                            local Success, Response = pcall(cfg.Callback, selectedValues)
                            if not Success then
                                library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                            end
                        else
                            selectedValue = Name
                            TextLabel_9.Text = selectedValue
                            local Success, Response = pcall(cfg.Callback, selectedValue)
                            if not Success then
                                library.Notify({Title = cfg.Name .. "Callback Error", Info = tostring(Response)})
                            end

                            for _, v in pairs(DropdownContainer:GetDescendants()) do
                                if v:IsA("TextLabel") and v.Name ~= Name then
                                    TweenService:Create(
                                        v,
                                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                        {TextColor3 = Color3.fromRGB(94, 94, 94)}
                                    ):Play()
                                end
                            end
                            TweenService:Create(
                                TextLabel_13,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {TextColor3 = Color3.fromRGB(177, 177, 177)}
                            ):Play()

                            droptog = false
                            DropdownF:Toggle(droptog)
                        end
                    end
                )
            end
            function DropdownF:Toggle(state)
                if state then
                    TweenService:Create(
                        Add,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 45}
                    ):Play()
                    DropdownContainer.Visible = true
                    TweenService:Create(
                        DropdownContainer,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 340, 0, 123)}
                    ):Play()
                else
                    TweenService:Create(
                        Add,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Rotation = 0}
                    ):Play()
                    local tw =
                        TweenService:Create(
                        DropdownContainer,
                        TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 340, 0, 0)}
                    )
                    tw:Play()
                    tw.Completed:Wait()
                    DropdownContainer.Visible = false
                end
            end
            drop.MouseButton1Click:Connect(
                function()
                    droptog = not droptog
                    DropdownF:Toggle(droptog)
                end
            )
            for i, v in next, cfg.Lists do
                DropdownF:Add(v)
            end
            function DropdownF:Clear()
                TextLabel_9.Text = ""
                for i, v in pairs(DropdownContainer:GetChildren()) do
                    if v:IsA("Frame") then
                        v:Destroy()
                    end
                end
            end
            function DropdownF:Refresh(newlist)
                DropdownF:Clear()
                for i, v in next, newlist do
                    DropdownF:Add(v)
                end
            end
            return DropdownF
        end
        function Items:Slider(Options)
            local cfg = {
                Name = Options.Name or "Slider",
                Info = Options.Info or "",
                Max = Options.Max or 100,
                Min = Options.Min or 0,
                Default = Options.Default or 50,
                Decimal = Options.Decimal or false,
                Side = Options.Side or "Left",
                Callback = Options.Callback or function()
                    end
            }
            local Slider = Instance.new("Frame")
            Slider.Name = "Slider"
            Slider.Position = UDim2.new(0, 0, 0.413, 0)
            Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Slider.Size = UDim2.new(0.97, 0, 0, 124) -- Changed to relative width
            Slider.BorderSizePixel = 0
            Slider.BackgroundColor3 = Color3.fromRGB(24, 25, 28)

            if cfg.Side == "Left" then
                Slider.Parent = Left
            else
                Slider.Parent = Right
            end

            local UICorner_33 = Instance.new("UICorner")
            UICorner_33.Parent = Slider

            local UIStroke_26 = Instance.new("UIStroke")
            UIStroke_26.Thickness = 0.51
            UIStroke_26.Transparency = 0.79
            UIStroke_26.Parent = Slider
            UIStroke_26.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_24 = Instance.new("TextLabel")
            TextLabel_24.TextWrapped = true
            TextLabel_24.Parent = Slider
            TextLabel_24.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_24.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_24.Text = cfg.Name
            TextLabel_24.Size = UDim2.new(0.8, 0, 0, 40)
            TextLabel_24.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_24.Position = UDim2.new(0.047411751, 0, 0.176, 0)
            TextLabel_24.BackgroundTransparency = 1
            TextLabel_24.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_24.BorderSizePixel = 0
            TextLabel_24.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_24.TextSize = 18
            TextLabel_24.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_25 = Instance.new("TextLabel")
            TextLabel_25.Parent = Slider
            TextLabel_25.TextWrapped = true
            TextLabel_25.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_25.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_25.Text = cfg.Info
            TextLabel_25.Size = UDim2.new(0.8, 0, 0, 50)
            TextLabel_25.Position = UDim2.new(0.047411751, 0, 0.503, 0)
            TextLabel_25.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_25.BorderSizePixel = 0
            TextLabel_25.BackgroundTransparency = 1
            TextLabel_25.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_25.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_25.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_25.TextSize = 15
            TextLabel_25.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextButton_5 = Instance.new("TextButton")
            TextButton_5.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_5.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_5.Text = ""
            TextButton_5.Parent = Slider
            TextButton_5.BackgroundTransparency = 1
            TextButton_5.Size = UDim2.new(1, 0, 1, 0)
            TextButton_5.BorderSizePixel = 0
            TextButton_5.TextSize = 14
            TextButton_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_22 = Instance.new("Frame")
            Frame_22.Parent = Slider
            Frame_22.Position = UDim2.new(0.741176486, 0, 0.697, 0)
            Frame_22.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_22.Size = UDim2.new(0, 79, 0, 30)
            Frame_22.BorderSizePixel = 0
            Frame_22.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_34 = Instance.new("UICorner")
            UICorner_34.Parent = Frame_22

            local UIStroke_27 = Instance.new("UIStroke")
            UIStroke_27.Thickness = 0.51
            UIStroke_27.Transparency = 0.79
            UIStroke_27.Parent = Frame_22
            UIStroke_27.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_9 = Instance.new("TextBox")
            TextBox_9.Parent = Frame_22
            TextBox_9.TextWrapped = true
            TextBox_9.TextColor3 = Color3.fromRGB(185, 185, 185)
            TextBox_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_9.Text = ""
            TextBox_9.Size = UDim2.new(1, 0, 1, 0)
            TextBox_9.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_9.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_9.BorderSizePixel = 0
            TextBox_9.BackgroundTransparency = 1
            TextBox_9.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_9.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_9.PlaceholderText = "TextBox"
            TextBox_9.TextSize = 14
            TextBox_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_23 = Instance.new("Frame")
            Frame_23.Parent = Slider
            Frame_23.Position = UDim2.new(0.041176472, 0, 0.754, 0)
            Frame_23.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_23.Size = UDim2.new(0.66, 0, 0, 14) -- Changed to relative width
            Frame_23.BorderSizePixel = 0
            Frame_23.BackgroundColor3 = Color3.fromRGB(24, 66, 147)

            local UICorner_35 = Instance.new("UICorner")
            UICorner_35.Parent = Frame_23

            local Frame_24 = Instance.new("Frame")
            Frame_24.AnchorPoint = Vector2.new(0, 0.5)
            Frame_24.Parent = Frame_23
            Frame_24.Position = UDim2.new(0, 0, 0.5, 0)
            Frame_24.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_24.Size = UDim2.new(0, 10, 0, 10)
            Frame_24.BorderSizePixel = 0
            Frame_24.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_36 = Instance.new("UICorner")
            UICorner_36.Parent = Frame_24

            local UIStroke_28 = Instance.new("UIStroke")
            UIStroke_28.Color = Color3.fromRGB(255, 255, 255)
            UIStroke_28.Parent = Frame_24
            UIStroke_28.Thickness = 2
            UIStroke_28.Transparency = 0.44

            local TextButton_6 = Instance.new("TextButton")
            TextButton_6.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_6.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_6.Text = ""
            TextButton_6.Parent = Frame_23
            TextButton_6.BackgroundTransparency = 1
            TextButton_6.Size = UDim2.new(1, 0, 1, 0) -- Changed to fill parent
            TextButton_6.BorderSizePixel = 0
            TextButton_6.TextSize = 14
            TextButton_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            if cfg.Info == "" then
                Slider.Size = UDim2.new(0.97, 0, 0, 76)
                TextLabel_24.Size = UDim2.new(0.8, 0, 0, 40)
                TextLabel_24.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_24.Position = UDim2.new(0.047411751, 0, 0.27, 0)
                TextLabel_25.Visible = false
                Frame_23.Position = UDim2.new(0.041176472, 0, 0.596, 0)
                Frame_23.Size = UDim2.new(0.66, 0, 0, 14)
                Frame_22.Position = UDim2.new(0.741176486, 0, 0.504, 0)
                Frame_22.Size = UDim2.new(0, 78, 0, 30)
            else
                Slider.Size = UDim2.new(0.97, 0, 0, 124)
                TextLabel_25.AutomaticSize = Enum.AutomaticSize.Y
                TextLabel_25.Size = UDim2.new(0.8, 0, 0, 0)

                task.defer(
                    function()
                        local infoHeight = TextLabel_25.TextBounds.Y
                        local totalHeight = 80 + infoHeight

                        Slider.Size = UDim2.new(0.97, 0, 0, totalHeight)

                        Frame_22.Position = UDim2.new(0.741176486, 0, 0, totalHeight - 35)
                        Frame_23.Position = UDim2.new(0.041176472, 0, 0, totalHeight - 25)
                    end
                )
            end

            local SliderObj = {}
            local dragging = false

            -- FIXED: Better input handling for both desktop and mobile
            function SliderObj:Set(inputX)
                local sliderAbsPos = Frame_23.AbsolutePosition.X
                local sliderWidth = Frame_23.AbsoluteSize.X - 12
                local newX = math.clamp(inputX - sliderAbsPos, 0, sliderWidth)
                local ratio = newX / sliderWidth
                local value = cfg.Min + (cfg.Max - cfg.Min) * ratio

                if cfg.Decimal then
                    value = tonumber(string.format("%.2f", value)) or cfg.Min
                else
                    value = math.floor(value + 0.5)
                end

                Frame_24.Position = UDim2.new(0, newX, 0.5, 0)
                TextBox_9.Text = tostring(value)

                local Success, Response = pcall(cfg.Callback, value)

                if not Success then
                    library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                end
            end

            Frame_23.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        UIStroke_28,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0}
                    ):Play()
                end
            )

            -- FIXED: Support both mouse and touch input
            TextButton_6.InputBegan:Connect(
                function(input)
                    if
                        input.UserInputType == Enum.UserInputType.MouseButton1 or
                            input.UserInputType == Enum.UserInputType.Touch
                     then
                        dragging = true
                        SliderObj:Set(input.Position.X)
                        TweenService:Create(
                            UIStroke_28,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Transparency = 0}
                        ):Play()
                    end
                end
            )

            TextButton_6.InputEnded:Connect(
                function(input)
                    if
                        input.UserInputType == Enum.UserInputType.MouseButton1 or
                            input.UserInputType == Enum.UserInputType.Touch
                     then
                        dragging = false
                        TweenService:Create(
                            UIStroke_28,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Transparency = 0.44}
                        ):Play()
                    end
                end
            )

            -- FIXED: Handle both mouse movement and touch movement
            UserInputService.InputChanged:Connect(
                function(input)
                    if dragging then
                        if
                            input.UserInputType == Enum.UserInputType.MouseMovement or
                                input.UserInputType == Enum.UserInputType.Touch
                         then
                            SliderObj:Set(input.Position.X)
                        end
                    end
                end
            )

            TextBox_9.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        TextBox_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {PlaceholderColor3 = Color3.fromRGB(170, 170, 170)}
                    ):Play()
                    TweenService:Create(
                        TextBox_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(225, 225, 225)}
                    ):Play()
                    TweenService:Create(
                        UIStroke_27,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.5}
                    ):Play()
                end
            )

            TextBox_9.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        TextBox_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {PlaceholderColor3 = Color3.fromRGB(141, 141, 141)}
                    ):Play()
                    TweenService:Create(
                        TextBox_9,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {TextColor3 = Color3.fromRGB(185, 185, 185)}
                    ):Play()
                    TweenService:Create(
                        UIStroke_27,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {Transparency = 0.79}
                    ):Play()
                end
            )

            TextBox_9.FocusLost:Connect(
                function()
                    local num = tonumber(TextBox_9.Text)
                    if num then
                        local clamped = math.clamp(num, cfg.Min, cfg.Max)
                        local ratio = (clamped - cfg.Min) / (cfg.Max - cfg.Min)
                        local sliderWidth = Frame_23.AbsoluteSize.X - 12
                        local newX = sliderWidth * ratio
                        Frame_24.Position = UDim2.new(0, newX, 0.5, 0)
                        TextBox_9.Text =
                            tostring(
                            cfg.Decimal and tonumber(string.format("%.2f", clamped)) or math.floor(clamped + 0.5)
                        )
                        local Success, Response = pcall(cfg.Callback, clamped)
                        if not Success then
                            library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                        end
                    end
                end
            )

            local function setDefault()
                local defaultValue = cfg.Default

                if not cfg.Decimal then
                    defaultValue = math.floor(defaultValue + 0.5)
                else
                    defaultValue = tonumber(string.format("%.2f", defaultValue))
                end

                defaultValue = math.clamp(defaultValue, cfg.Min, cfg.Max)

                local ratio = (defaultValue - cfg.Min) / (cfg.Max - cfg.Min)
                local sliderWidth = Frame_23.AbsoluteSize.X - 12
                local newX = sliderWidth * ratio
                Frame_24.Position = UDim2.new(0, newX, 0.5, 0)

                TextBox_9.Text = tostring(defaultValue)

                if cfg.Callback then
                    local Success, Response = pcall(cfg.Callback, defaultValue)
                    if not Success then
                        library.Notify({Title = cfg.Name .. " Callback Error", Info = tostring(Response)})
                    end
                end
            end
            task.defer(setDefault)

            Frame_23.MouseLeave:Connect(
                function()
                    if not dragging then
                        TweenService:Create(
                            UIStroke_28,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Transparency = 0.44}
                        ):Play()
                    else
                        TweenService:Create(
                            UIStroke_28,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Transparency = 0}
                        ):Play()
                    end
                end
            )

            return SliderObj
        end
        function Items:Colorpicker(Options)
            local cfg = {
                Name = Options.Name or "Colorpicker",
                Info = Options.Info or "",
                Side = Options.Side or "Left",
                Default = Options.Default or Color3.fromRGB(255, 255, 255),
                Rainbow = Options.Rainbow or false,
                Callback = Options.Callback or function()
                    end
            }
            local Colorpicker = Instance.new("Frame")
            Colorpicker.Parent = Right
            Colorpicker.Name = "Colorpicker"
            Colorpicker.Position = UDim2.new(0, 0, 0.47, 0)
            Colorpicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Colorpicker.Size = UDim2.new(0, 340, 0, 52)
            Colorpicker.BorderSizePixel = 0
            Colorpicker.BackgroundColor3 = Color3.fromRGB(24, 25, 28)

            local UIStroke_14 = Instance.new("UIStroke")
            UIStroke_14.Thickness = 0.51
            UIStroke_14.Transparency = 0.79
            UIStroke_14.Parent = Colorpicker
            UIStroke_14.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_16 = Instance.new("TextLabel")
            TextLabel_16.TextWrapped = true
            TextLabel_16.Parent = Colorpicker
            TextLabel_16.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_16.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_16.Text = "Visuals aaaaaaaaaaa"
            TextLabel_16.Size = UDim2.new(0, 271, 0, 40)
            TextLabel_16.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_16.Position = UDim2.new(0.047411751, 0, 0.493, 0)
            TextLabel_16.BackgroundTransparency = 1
            TextLabel_16.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_16.BorderSizePixel = 0
            TextLabel_16.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_16.TextSize = 18
            TextLabel_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextButton_3 = Instance.new("TextButton")
            TextButton_3.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_3.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_3.Text = ""
            TextButton_3.Parent = Colorpicker
            TextButton_3.BackgroundTransparency = 1
            TextButton_3.Size = UDim2.new(1, 0, 1, 0)
            TextButton_3.BorderSizePixel = 0
            TextButton_3.TextSize = 14
            TextButton_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_13 = Instance.new("Frame")
            Frame_13.Parent = Colorpicker
            Frame_13.Position = UDim2.new(0.873529434, 0, 0.192, 0)
            Frame_13.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_13.Size = UDim2.new(0, 30, 0, 30)
            Frame_13.BorderSizePixel = 0
            Frame_13.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_21 = Instance.new("UICorner")
            UICorner_21.Parent = Frame_13

            local UIStroke_15 = Instance.new("UIStroke")
            UIStroke_15.Thickness = 0.51
            UIStroke_15.Transparency = 0.79
            UIStroke_15.Parent = Frame_13
            UIStroke_15.Color = Color3.fromRGB(255, 255, 255)

            local UICorner_22 = Instance.new("UICorner")
            UICorner_22.Parent = Colorpicker

            local Colorpicker_1 = Instance.new("Frame")
            Colorpicker_1.Parent = Right
            Colorpicker_1.Name = "Colorpicker_1"
            Colorpicker_1.Position = UDim2.new(-0.037249282, 0, 0.292, 0)
            Colorpicker_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Colorpicker_1.Size = UDim2.new(0, 340, 0, 87)
            Colorpicker_1.BorderSizePixel = 0
            Colorpicker_1.BackgroundColor3 = Color3.fromRGB(24, 25, 28)

            local UICorner_23 = Instance.new("UICorner")
            UICorner_23.Parent = Colorpicker_1

            local UIStroke_16 = Instance.new("UIStroke")
            UIStroke_16.Thickness = 0.51
            UIStroke_16.Transparency = 0.79
            UIStroke_16.Parent = Colorpicker_1
            UIStroke_16.Color = Color3.fromRGB(255, 255, 255)

            local TextLabel_17 = Instance.new("TextLabel")
            TextLabel_17.TextWrapped = true
            TextLabel_17.Parent = Colorpicker_1
            TextLabel_17.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_17.Text = "Visuals aaaaaaaaaaa"
            TextLabel_17.Size = UDim2.new(0, 271, 0, 40)
            TextLabel_17.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_17.Position = UDim2.new(0.047411751, 0, 0.224, 0)
            TextLabel_17.BackgroundTransparency = 1
            TextLabel_17.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_17.BorderSizePixel = 0
            TextLabel_17.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_17.TextSize = 18
            TextLabel_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextLabel_18 = Instance.new("TextLabel")
            TextLabel_18.Parent = Colorpicker_1
            TextLabel_18.TextWrapped = true
            TextLabel_18.TextColor3 = Color3.fromRGB(100, 100, 100)
            TextLabel_18.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_18.Text =
                "Infoasdasdaosdjkopasjdaisdasdasssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss"
            TextLabel_18.Size = UDim2.new(0, 271, 0, 50)
            TextLabel_18.Position = UDim2.new(0.047411751, 0, 0.664, 0)
            TextLabel_18.AnchorPoint = Vector2.new(0, 0.5)
            TextLabel_18.BorderSizePixel = 0
            TextLabel_18.BackgroundTransparency = 1
            TextLabel_18.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel_18.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextLabel_18.TextYAlignment = Enum.TextYAlignment.Top
            TextLabel_18.TextSize = 15
            TextLabel_18.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local TextButton_4 = Instance.new("TextButton")
            TextButton_4.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton_4.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton_4.Text = ""
            TextButton_4.Parent = Colorpicker_1
            TextButton_4.BackgroundTransparency = 1
            TextButton_4.Size = UDim2.new(1, 0, 1, 0)
            TextButton_4.BorderSizePixel = 0
            TextButton_4.TextSize = 14
            TextButton_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Frame_14 = Instance.new("Frame")
            Frame_14.Parent = Colorpicker_1
            Frame_14.Position = UDim2.new(0.873529434, 0, 0.1, 0)
            Frame_14.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Frame_14.Size = UDim2.new(0, 30, 0, 30)
            Frame_14.BorderSizePixel = 0
            Frame_14.BackgroundColor3 = Color3.fromRGB(24, 66, 147)

            local UICorner_24 = Instance.new("UICorner")
            UICorner_24.Parent = Frame_14

            local UIStroke_17 = Instance.new("UIStroke")
            UIStroke_17.Thickness = 0.51
            UIStroke_17.Transparency = 0.79
            UIStroke_17.Parent = Frame_14
            UIStroke_17.Color = Color3.fromRGB(255, 255, 255)
            -- ColorPicker Frame
            local ColorpickerContainer = Instance.new("Frame")
            ColorpickerContainer.Size = UDim2.new(0, 340, 0, 185)
            ColorpickerContainer.Name = "ColorpickerContainer"
            ColorpickerContainer.ClipsDescendants = true
            ColorpickerContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerContainer.Position = UDim2.new(0, 0, 0.11, 0)
            ColorpickerContainer.BorderSizePixel = 0
            ColorpickerContainer.BackgroundColor3 = Color3.fromRGB(24, 25, 28)
            if cfg.Side == "Left" then
                ColorpickerContainer.Parent = Left
                Colorpicker.Parent = Left
            else
                ColorpickerContainer.Parent = Right
                Colorpicker.Parent = Right
            end

            local UICorner = Instance.new("UICorner", ColorpickerContainer)

            local UIStroke = Instance.new("UIStroke", ColorpickerContainer)
            UIStroke.Color = Color3.fromRGB(255, 255, 255)
            UIStroke.Transparency = 0.79
            UIStroke.Thickness = 0.51

            local RainbowFrame = Instance.new("Frame", ColorpickerContainer)
            RainbowFrame.Name = "RainbowFrame"
            RainbowFrame.Position = UDim2.new(0.041541964, 0, 0.742, 0)
            RainbowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            RainbowFrame.Size = UDim2.new(0, 30, 0, 30)
            RainbowFrame.BorderSizePixel = 0
            RainbowFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_1 = Instance.new("UICorner", RainbowFrame)

            local UIStroke_1 = Instance.new("UIStroke", RainbowFrame)
            UIStroke_1.Thickness = 0.51
            UIStroke_1.Transparency = 0.79
            UIStroke_1.Color = Color3.fromRGB(255, 255, 255)

            local TextButton = Instance.new("TextButton", RainbowFrame)
            TextButton.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.Text = ""
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.BorderSizePixel = 0
            TextButton.TextSize = 14
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local R = Instance.new("Frame", ColorpickerContainer)
            R.Name = "R"
            R.Position = UDim2.new(0.858941317, 0, 0.054, 0)
            R.BorderColor3 = Color3.fromRGB(0, 0, 0)
            R.Size = UDim2.new(0, 39, 0, 24)
            R.BorderSizePixel = 0
            R.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_2 = Instance.new("UICorner", R)

            local UIStroke_2 = Instance.new("UIStroke", R)
            UIStroke_2.Thickness = 0.51
            UIStroke_2.Transparency = 0.79
            UIStroke_2.Color = Color3.fromRGB(255, 255, 255)

            local TextBox = Instance.new("TextBox", R)
            TextBox.CursorPosition = -1
            TextBox.Size = UDim2.new(1, 0, 1, 0)
            TextBox.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox.Text = ""
            TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox.BorderSizePixel = 0
            TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox.BackgroundTransparency = 1
            TextBox.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox.TextWrapped = true
            TextBox.PlaceholderText = "0-255"
            TextBox.TextSize = 14
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local B = Instance.new("Frame", ColorpickerContainer)
            B.Name = "B"
            B.Position = UDim2.new(0.858999789, 0, 0.408, 0)
            B.BorderColor3 = Color3.fromRGB(0, 0, 0)
            B.Size = UDim2.new(0, 39, 0, 24)
            B.BorderSizePixel = 0
            B.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_3 = Instance.new("UICorner", B)

            local UIStroke_3 = Instance.new("UIStroke", B)
            UIStroke_3.Thickness = 0.51
            UIStroke_3.Transparency = 0.79
            UIStroke_3.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_1 = Instance.new("TextBox", B)
            TextBox_1.TextWrapped = true
            TextBox_1.CursorPosition = -1
            TextBox_1.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_1.Text = ""
            TextBox_1.Size = UDim2.new(1, 0, 1, 0)
            TextBox_1.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_1.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_1.BorderSizePixel = 0
            TextBox_1.BackgroundTransparency = 1
            TextBox_1.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_1.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_1.PlaceholderText = "0-255"
            TextBox_1.TextSize = 14
            TextBox_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local G = Instance.new("Frame", ColorpickerContainer)
            G.Name = "G"
            G.Position = UDim2.new(0.858999789, 0, 0.234, 0)
            G.BorderColor3 = Color3.fromRGB(0, 0, 0)
            G.Size = UDim2.new(0, 39, 0, 24)
            G.BorderSizePixel = 0
            G.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_4 = Instance.new("UICorner", G)

            local UIStroke_4 = Instance.new("UIStroke", G)
            UIStroke_4.Thickness = 0.51
            UIStroke_4.Transparency = 0.79
            UIStroke_4.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_2 = Instance.new("TextBox", G)
            TextBox_2.TextWrapped = true
            TextBox_2.CursorPosition = -1
            TextBox_2.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_2.Text = ""
            TextBox_2.Size = UDim2.new(1, 0, 1, 0)
            TextBox_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_2.BorderSizePixel = 0
            TextBox_2.BackgroundTransparency = 1
            TextBox_2.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_2.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_2.PlaceholderText = "0-255"
            TextBox_2.TextSize = 14
            TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Hex = Instance.new("Frame", ColorpickerContainer)
            Hex.Name = "Hex"
            Hex.Position = UDim2.new(0.815058827, 0, 0.566, 0)
            Hex.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Hex.Size = UDim2.new(0, 53, 0, 24)
            Hex.BorderSizePixel = 0
            Hex.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_5 = Instance.new("UICorner", Hex)

            local UIStroke_5 = Instance.new("UIStroke", Hex)
            UIStroke_5.Thickness = 0.51
            UIStroke_5.Transparency = 0.79
            UIStroke_5.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_3 = Instance.new("TextBox", Hex)
            TextBox_3.TextWrapped = true
            TextBox_3.CursorPosition = -1
            TextBox_3.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_3.Text = ""
            TextBox_3.Size = UDim2.new(1, 0, 1, 0)
            TextBox_3.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_3.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_3.BorderSizePixel = 0
            TextBox_3.BackgroundTransparency = 1
            TextBox_3.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_3.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_3.PlaceholderText = "#fffff"
            TextBox_3.TextSize = 14
            TextBox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Wheel = Instance.new("Frame", ColorpickerContainer)
            Wheel.Name = "Wheel"
            Wheel.Position = UDim2.new(0.041176472, 0, 0.058, 0)
            Wheel.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Wheel.Size = UDim2.new(0.358823538, 0, 0.831, 0)
            Wheel.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint", Wheel)

            local Image = Instance.new("ImageLabel", Wheel)
            Image.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Image.AnchorPoint = Vector2.new(0.5, 0.5)
            Image.Image = "rbxassetid://2849458409"
            Image.BackgroundTransparency = 1
            Image.Position = UDim2.new(0.5, 0, 0.5, 0)
            Image.Name = "Image"
            Image.Size = UDim2.new(0.800000012, 0, 0.8, 0)
            Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Select = Instance.new("Frame", Image)
            Select.AnchorPoint = Vector2.new(0.5, 0.5)
            Select.BackgroundTransparency = 1
            Select.Position = UDim2.new(0.5, 0, 0.5, 0)
            Select.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Select.Name = "Select"
            Select.Size = UDim2.new(0.059999999, 0, 0.06, 0)
            Select.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_6 = Instance.new("UICorner", Select)
            UICorner_6.CornerRadius = UDim.new(0.5, 0)

            local UIStroke_6 = Instance.new("UIStroke", Select)
            UIStroke_6.Thickness = 2

            local Button = Instance.new("TextButton", Wheel)
            Button.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Button.Text = ""
            Button.BackgroundTransparency = 1
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.ZIndex = 99
            Button.TextSize = 14
            Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_7 = Instance.new("UICorner", Wheel)

            local UIStroke_7 = Instance.new("UIStroke", Wheel)
            UIStroke_7.Thickness = 0.51
            UIStroke_7.Transparency = 0.79
            UIStroke_7.Color = Color3.fromRGB(255, 255, 255)

            local Right = Instance.new("Frame", ColorpickerContainer)
            Right.AnchorPoint = Vector2.new(1, 0)
            Right.Name = "Right"
            Right.Position = UDim2.new(0.517998934, 0, 0.056, 0)
            Right.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Right.Size = UDim2.new(0.08270587, 0, 0.661, 0)
            Right.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local Value = Instance.new("Frame", Right)
            Value.AnchorPoint = Vector2.new(0.5, 0.5)
            Value.Name = "Value"
            Value.Position = UDim2.new(0.498933583, 0, 0.5, 0)
            Value.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Value.Size = UDim2.new(0.800000012, 0, 0.8, 0)
            Value.BorderSizePixel = 0
            Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIGradient = Instance.new("UIGradient", Value)
            UIGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            }
            UIGradient.Rotation = 90

            local Select_1 = Instance.new("Frame", Value)
            Select_1.AnchorPoint = Vector2.new(0, 0.5)
            Select_1.BackgroundTransparency = 1
            Select_1.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Select_1.Name = "Select_1"
            Select_1.Size = UDim2.new(1, 0, 1, 0)
            Select_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint", Select_1)
            UIAspectRatioConstraint_1.AspectRatio = 4

            local Select_2 = Instance.new("Frame", Select_2)
            Select_2.AnchorPoint = Vector2.new(0.5, 0.5)
            Select_2.BackgroundTransparency = 1
            Select_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            Select_2.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Select_2.Name = "Select_2"
            Select_2.Size = UDim2.new(1.5, 0, 1.5, 0)
            Select_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_8 = Instance.new("UICorner", Select_2)
            UICorner_8.CornerRadius = UDim.new(0.5, 0)

            local UIStroke_8 = Instance.new("UIStroke", Select_2)
            UIStroke_8.Color = Color3.fromRGB(255, 255, 255)
            UIStroke_8.Thickness = 2

            local Button_1 = Instance.new("TextButton", Value)
            Button_1.FontFace =
                Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            Button_1.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button_1.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Button_1.Text = ""
            Button_1.BackgroundTransparency = 1
            Button_1.Name = "Button_1"
            Button_1.Size = UDim2.new(1, 0, 1, 0)
            Button_1.ZIndex = 99
            Button_1.TextSize = 14
            Button_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint", Value)
            UIAspectRatioConstraint_2.AspectRatio = 0.1

            local UICorner_9 = Instance.new("UICorner", Right)

            local UIStroke_9 = Instance.new("UIStroke", Right)
            UIStroke_9.Thickness = 0.51
            UIStroke_9.Transparency = 0.79
            UIStroke_9.Color = Color3.fromRGB(255, 255, 255)

            local V = Instance.new("Frame", ColorpickerContainer)
            V.Name = "V"
            V.Position = UDim2.new(0.650176287, 0, 0.408, 0)
            V.BorderColor3 = Color3.fromRGB(0, 0, 0)
            V.Size = UDim2.new(0, 39, 0, 24)
            V.BorderSizePixel = 0
            V.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_10 = Instance.new("UICorner", V)

            local UIStroke_10 = Instance.new("UIStroke", V)
            UIStroke_10.Thickness = 0.51
            UIStroke_10.Transparency = 0.79
            UIStroke_10.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_4 = Instance.new("TextBox", V)
            TextBox_4.TextWrapped = true
            TextBox_4.CursorPosition = -1
            TextBox_4.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_4.Text = ""
            TextBox_4.Size = UDim2.new(1, 0, 1, 0)
            TextBox_4.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_4.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_4.BorderSizePixel = 0
            TextBox_4.BackgroundTransparency = 1
            TextBox_4.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_4.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_4.PlaceholderText = "0-1"
            TextBox_4.TextSize = 14
            TextBox_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local S = Instance.new("Frame", ColorpickerContainer)
            S.Name = "S"
            S.Position = UDim2.new(0.650176287, 0, 0.234, 0)
            S.BorderColor3 = Color3.fromRGB(0, 0, 0)
            S.Size = UDim2.new(0, 39, 0, 24)
            S.BorderSizePixel = 0
            S.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_11 = Instance.new("UICorner", S)

            local UIStroke_11 = Instance.new("UIStroke", S)
            UIStroke_11.Thickness = 0.51
            UIStroke_11.Transparency = 0.79
            UIStroke_11.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_5 = Instance.new("TextBox", S)
            TextBox_5.TextWrapped = true
            TextBox_5.CursorPosition = -1
            TextBox_5.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_5.Text = ""
            TextBox_5.Size = UDim2.new(1, 0, 1, 0)
            TextBox_5.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_5.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_5.BorderSizePixel = 0
            TextBox_5.BackgroundTransparency = 1
            TextBox_5.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_5.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_5.PlaceholderText = "0-1"
            TextBox_5.TextSize = 14
            TextBox_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local H = Instance.new("Frame", ColorpickerContainer)
            H.Name = "H"
            H.Position = UDim2.new(0.650117755, 0, 0.06, 0)
            H.BorderColor3 = Color3.fromRGB(0, 0, 0)
            H.Size = UDim2.new(0, 39, 0, 24)
            H.BorderSizePixel = 0
            H.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_12 = Instance.new("UICorner", H)

            local UIStroke_12 = Instance.new("UIStroke", H)
            UIStroke_12.Thickness = 0.51
            UIStroke_12.Transparency = 0.79
            UIStroke_12.Color = Color3.fromRGB(255, 255, 255)

            local TextBox_6 = Instance.new("TextBox", H)
            TextBox_6.TextWrapped = true
            TextBox_6.CursorPosition = -1
            TextBox_6.TextColor3 = Color3.fromRGB(202, 202, 202)
            TextBox_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox_6.Text = ""
            TextBox_6.Size = UDim2.new(1, 0, 1, 0)
            TextBox_6.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextBox_6.AnchorPoint = Vector2.new(0.5, 0.5)
            TextBox_6.BorderSizePixel = 0
            TextBox_6.BackgroundTransparency = 1
            TextBox_6.PlaceholderColor3 = Color3.fromRGB(141, 141, 141)
            TextBox_6.FontFace =
                Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
            TextBox_6.PlaceholderText = "0-1"
            TextBox_6.TextSize = 14
            TextBox_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local Cancel = Instance.new("Frame", ColorpickerContainer)
            Cancel.Name = "Cancel"
            Cancel.Position = UDim2.new(0.764705896, 0, 0.742, 0)
            Cancel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Cancel.Size = UDim2.new(0, 30, 0, 30)
            Cancel.BorderSizePixel = 0
            Cancel.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_13 = Instance.new("UICorner", Cancel)

            local UIStroke_13 = Instance.new("UIStroke", Cancel)
            UIStroke_13.Thickness = 0.51
            UIStroke_13.Transparency = 0.79
            UIStroke_13.Color = Color3.fromRGB(255, 255, 255)

            local Cancel_1 = Instance.new("ImageButton", Cancel_1)
            Cancel_1.Image = "rbxassetid://3192543734"
            Cancel_1.BackgroundTransparency = 1
            Cancel_1.Name = "Cancel_1"
            Cancel_1.Size = UDim2.new(0, 30, 0, 30)
            Cancel_1.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Cancel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint", Cancel_1)

            local ConfimFrame = Instance.new("Frame", ColorpickerContainer)
            ConfimFrame.Name = "ConfimFrame"
            ConfimFrame.Position = UDim2.new(0.873529434, 0, 0.742, 0)
            ConfimFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ConfimFrame.Size = UDim2.new(0, 30, 0, 30)
            ConfimFrame.BorderSizePixel = 0
            ConfimFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 15)

            local UICorner_14 = Instance.new("UICorner", ConfimFrame)

            local UIStroke_14 = Instance.new("UIStroke", ConfimFrame)
            UIStroke_14.Thickness = 0.51
            UIStroke_14.Transparency = 0.79
            UIStroke_14.Color = Color3.fromRGB(255, 255, 255)

            local Confirm = Instance.new("ImageButton", ConfimFrame)
            Confirm.Image = "rbxassetid://4510424237"
            Confirm.BackgroundTransparency = 1
            Confirm.Name = "Confirm"
            Confirm.Size = UDim2.new(0, 30, 0, 30)
            Confirm.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Confirm.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint", Confirm)

            local PreviewColorFrame = Instance.new("Frame", ColorpickerContainer)
            PreviewColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            PreviewColorFrame.Name = "PreviewColorFrame"
            PreviewColorFrame.Position = UDim2.new(0.477942258, 0, 0.82, 0)
            PreviewColorFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
            PreviewColorFrame.Size = UDim2.new(0, 31, 0, 30)
            PreviewColorFrame.BorderSizePixel = 0
            PreviewColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

            local UICorner_15 = Instance.new("UICorner", PreviewColorFrame)
            UICorner_15.CornerRadius = UDim.new(0.349999994, 0)
        end
        return Items
    end

    return Tabs
end
return library
