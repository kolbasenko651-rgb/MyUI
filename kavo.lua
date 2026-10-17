local Kavo = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}
function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}
local themeStyles = {
    RJTheme1 = { SchemeColor = Color3.fromRGB(112, 112, 112), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme2 = { SchemeColor = Color3.fromRGB(139,123,139), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme3 = { SchemeColor = Color3.fromRGB(98, 77, 128), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme4 = { SchemeColor = Color3.fromRGB(128, 77, 112), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme5 = { SchemeColor = Color3.fromRGB(150, 141, 71), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme6 = { SchemeColor = Color3.fromRGB(86, 128, 61), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme7 = { SchemeColor = Color3.fromRGB(95, 81, 168), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) },
    RJTheme8 = { SchemeColor = Color3.fromRGB(150, 72, 148), Background = Color3.fromRGB(15,15,15), Header = Color3.fromRGB(15,15,15), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20) }
}

local SettingsT = {}
local Name = "KavoConfig.JSON"

pcall(function()
    if not pcall(function() readfile(Name) end) then
        writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
    end
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Kavo:ToggleUI()
    if game.CoreGui:FindFirstChild(LibName) then
        game.CoreGui[LibName].Enabled = not game.CoreGui[LibName].Enabled
    end
end

function Kavo.CreateLib(kavName, themeList)
    if not themeList then
        themeList = themes
    end
    if type(themeList) == "string" and themeStyles[themeList] then
        themeList = themeStyles[themeList]
    else
        themeList.SchemeColor = themeList.SchemeColor or Color3.fromRGB(74, 99, 135)
        themeList.Background = themeList.Background or Color3.fromRGB(36, 37, 43)
        themeList.Header = themeList.Header or Color3.fromRGB(28, 29, 34)
        themeList.TextColor = themeList.TextColor or Color3.fromRGB(255,255,255)
        themeList.ElementColor = themeList.ElementColor or Color3.fromRGB(32, 32, 38)
    end

    kavName = kavName or "Library"
    for _,v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
        end
    end
    
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local minimize = Instance.new("ImageButton")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local infoContainer = Instance.new("Frame")
    local blurFrame = Instance.new("Frame")

    -- Текст "А" для мини-квадрата
    local miniText = Instance.new("TextLabel")
    miniText.Name = "MiniText"
    miniText.Parent = Main
    miniText.BackgroundTransparency = 1.000
    miniText.Size = UDim2.new(1, 0, 1, 0)
    miniText.Font = Enum.Font.GothamBold
    miniText.Text = "A"
    miniText.TextColor3 = themeList.TextColor
    miniText.TextSize = 22.000
    miniText.Visible = false

    local activeThreads = true
    Kavo:DraggingEnabled(MainHeader, Main)

    blurFrame.Name = "blurFrame"
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(-0.0222222228, 0, -0.0371747203, 0)
    blurFrame.Size = UDim2.new(0, 376, 0, 289)
    blurFrame.ZIndex = 999

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    Objects[MainHeader] = "BackgroundColor3"
    MainHeader.Size = UDim2.new(0, 525, 0, 29)
    
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    Objects[coverup] = "BackgroundColor3"
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundTransparency = 1.000
    title.Position = UDim2.new(0.0171428565, 0, 0.344827592, 0)
    title.Size = UDim2.new(0, 204, 0, 8)
    title.Font = Enum.Font.Gotham
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 16.000
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- Кнопка закрытия
    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(0.949999988, 0, 0.137999997, 0)
    close.Size = UDim2.new(0, 21, 0, 21)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    close.MouseButton1Click:Connect(function()
        activeThreads = false
        game.TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 1}):Play()
        task.wait(0.05)
        game.TweenService:Create(Main, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0,0,0,0),
            Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
        }):Play()
        task.wait(0.15)
        ScreenGui:Destroy()
    end)

    -- Кнопка сворачивания
    minimize.Name = "minimize"
    minimize.Parent = MainHeader
    minimize.BackgroundTransparency = 1.000
    minimize.Position = UDim2.new(0.900000036, 0, 0.137999997, 0)
    minimize.Size = UDim2.new(0, 21, 0, 21)
    minimize.ZIndex = 2
    minimize.Image = "rbxassetid://3926307971"
    minimize.ImageRectOffset = Vector2.new(884, 284)
    minimize.ImageRectSize = Vector2.new(36, 36)

    local minimized = false
    local prevSize, prevPos = Main.Size, Main.Position

    local function toggleMinimize()
        if not minimized then
            minimized = true
            prevSize = Main.Size
            prevPos = Main.Position
            
            MainSide.Visible = false
            pages.Visible = false
            infoContainer.Visible = false
            coverup.Visible = false
            MainHeader.Visible = false -- Прячем шапку целиком, чтобы остался только чистый квадрат
            miniText.Visible = true

            game.TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 45, 0, 45)
            }):Play()
        else
            minimized = false
            miniText.Visible = false

            game.TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = prevSize
            }):Play()
            
            task.wait(0.15)
            MainHeader.Visible = true
            MainSide.Visible = true
            pages.Visible = true
            infoContainer.Visible = true
            coverup.Visible = true
        end
    end

    minimize.MouseButton1Click:Connect(toggleMinimize)

    -- Делаем сам мини-квадрат с буквой А кликабельным для открытия обратно
    Main.InputBegan:Connect(function(inputObject)
        if minimized and inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Проверяем, что не просто перетаскивали мышку, а именно кликнули
            toggleMinimize()
        end
    end)

    -- Включаем перетаскивание для самого квадрата в свернутом виде
    Kavo:DraggingEnabled(Main, Main)

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(0, 0, 0.0911949649, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.949939311, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    infoContainer.Name = "infoContainer"
    infoContainer.Parent = Main
    infoContainer.BackgroundTransparency = 1.000
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299047619, 0, 0.874213815, 0)
    infoContainer.Size = UDim2.new(0, 368, 0, 33)

    coroutine.wrap(function()
        while activeThreads and task.wait() do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
            miniText.TextColor3 = themeList.TextColor
        end
    end)()

    local Tabs = {}
    local first = true

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")

        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            game.TweenService:Create(page, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)
            }):Play()
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 16, themeList.SchemeColor.g * 255 - 15, themeList.SchemeColor.b * 255 - 28)

        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)

        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 14.000
        tabButton.BackgroundTransparency = 1

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        end

        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton

        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)

        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for _,v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for _,v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    Utility:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            Utility:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)

        local Sections = {}
        local focusing = false
        local viewDe = false

        coroutine.wrap(function()
            while activeThreads and task.wait() do
                page.BackgroundColor3 = themeList.Background
                tabButton.TextColor3 = themeList.TextColor
                tabButton.BackgroundColor3 = themeList.SchemeColor
            end
        end)()
    
        function Sections:NewSection(secName, hidden)
            secName = secName or "Section"
            local sectionFrame = Instance.new("Frame")
            local sectionlistoknvm = Instance.new("UIListLayout")
            local sectionHead = Instance.new("Frame")
            local sHeadCorner = Instance.new("UICorner")
            local sectionName = Instance.new("TextLabel")
            local sectionInners = Instance.new("Frame")
            local sectionElListing = Instance.new("UIListLayout")
            
            sectionHead.Visible = not (hidden or false)

            sectionFrame.Name = "sectionFrame"
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background
            sectionFrame.BorderSizePixel = 0
            
            sectionlistoknvm.Name = "sectionlistoknvm"
            sectionlistoknvm.Parent = sectionFrame
            sectionlistoknvm.SortOrder = Enum.SortOrder.LayoutOrder
            sectionlistoknvm.Padding = UDim.new(0, 5)

            sectionHead.Name = "sectionHead"
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            sectionHead.Size = UDim2.new(0, 352, 0, 33)

            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Parent = sectionHead

            sectionName.Name = "sectionName"
            sectionName.Parent = sectionHead
            sectionName.BackgroundTransparency = 1.000
            sectionName.Position = UDim2.new(0.0198863633, 0, 0, 0)
            sectionName.Size = UDim2.new(0.980113626, 0, 1, 0)
            sectionName.Font = Enum.Font.Gotham
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            sectionName.TextSize = 14.000
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
               
            sectionInners.Name = "sectionInners"
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundTransparency = 1.000

            sectionElListing.Name = "sectionElListing"
            sectionElListing.Parent = sectionInners
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 3)

            coroutine.wrap(function()
                while activeThreads and task.wait() do
                    sectionFrame.BackgroundColor3 = themeList.Background
                    sectionHead.BackgroundColor3 = themeList.SchemeColor
                    sectionName.TextColor3 = themeList.TextColor
                end
            end)()

            local function updateSectionFrame()
                local innerSc = sectionElListing.AbsoluteContentSize
                sectionInners.Size = UDim2.new(1, 0, 0, innerSc.Y)
                local frameSc = sectionlistoknvm.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, frameSc.Y)
            end
            
            updateSectionFrame()
            UpdateSize()

            local Elements = {}
            function Elements:NewButton(bname, tipINf, callback)
                local ButtonFunction = {}
                tipINf = tipINf or "Tip..."
                bname = bname or "Button"
                callback = callback or function() end

                local buttonElement = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local btnInfo = Instance.new("TextLabel")
                local viewInfo = Instance.new("ImageButton")
                local touch = Instance.new("ImageLabel")
                local Sample = Instance.new("ImageLabel")

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = themeList.ElementColor
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(0, 352, 0, 33)
                buttonElement.AutoButtonColor = false
                buttonElement.Text = ""

                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = buttonElement

                viewInfo.Name = "viewInfo"
                viewInfo.Parent = buttonElement
                viewInfo.BackgroundTransparency = 1.000
                viewInfo.Position = UDim2.new(0.93, 0, 0.152, 0)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = "rbxassetid://3926305904"
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)

                Sample.Name = "Sample"
                Sample.Parent = buttonElement
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.600

                local moreInfo = Instance.new("TextLabel")
                local UICorner_More = Instance.new("UICorner")

                moreInfo.Name = "TipMore"
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(0, 353, 0, 33)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = "  "..tipINf
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14.000
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left

                UICorner_More.CornerRadius = UDim.new(0, 4)
                UICorner_More.Parent = moreInfo

                touch.Name = "touch"
                touch.Parent = buttonElement
                touch.BackgroundTransparency = 1.000
                touch.Position = UDim2.new(0.02, 0, 0.18, 0)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = "rbxassetid://3926305904"
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)

                btnInfo.Name = "btnInfo"
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundTransparency = 1.000
                btnInfo.Position = UDim2.new(0.0967, 0, 0.272, 0)
                btnInfo.Size = UDim2.new(0, 314, 0, 14)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor
                btnInfo.TextSize = 14.000
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                updateSectionFrame()
                UpdateSize()

                local ms = game.Players.LocalPlayer:GetMouse()

                buttonElement.MouseButton1Click:Connect(function()
                    if not focusing then
                        callback()
                        local c = Sample:Clone()
                        c.Parent = buttonElement
                        local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                        c.Position = UDim2.new(0, x, 0, y)
                        local size = math.max(buttonElement.AbsoluteSize.X, buttonElement.AbsoluteSize.Y) * 1.5
                        c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', 0.35, true)
                        for _ = 1, 10 do
                            c.ImageTransparency = c.ImageTransparency + 0.05
                            task.wait(0.35 / 12)
                        end
                        c:Destroy()
                    end
                end)

                viewInfo.MouseButton1Click:Connect(function()
                    if not viewDe then
                        viewDe = true
                        focusing = true
                        for _,v in next, infoContainer:GetChildren() do
                            if v ~= moreInfo then
                                Utility:TweenObject(v, {Position = UDim2.new(0,0,2,0)}, 0.2)
                            end
                        end
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,0,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                        task.wait(1.5)
                        focusing = false
                        Utility:TweenObject(moreInfo, {Position = UDim2.new(0,0,2,0)}, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                        viewDe = false
                    end
                end)

                coroutine.wrap(function()
                    while activeThreads and task.wait() do
                        buttonElement.BackgroundColor3 = themeList.ElementColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        touch.ImageColor3 = themeList.SchemeColor
                        btnInfo.TextColor3 = themeList.TextColor
                    end
                end)()

                function ButtonFunction:UpdateButton(newTitle)
                    btnInfo.Text = newTitle
                end
                return ButtonFunction
            end
            return Elements
        end
        return Sections
    end  
    return Tabs
end
return Kavo
