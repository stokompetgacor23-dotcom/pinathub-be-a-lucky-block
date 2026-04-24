-- =======================================================
-- PINATHUB - BE A LUCKY BLOCK (WINDUI)
-- All features from original script + Infinite Jump
-- FINAL VERSION - Settings Tab Removed
-- =======================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local UIS = UserInputService

-- =======================================================
-- ANTI AFK
-- =======================================================
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- =======================================================
-- INFINITE JUMP VARIABLE
-- =======================================================
local InfiniteJumpEnabled = false

-- =======================================================
-- NOTIFICATION SYSTEM
-- =======================================================
local notifHolder = Instance.new("ScreenGui")
notifHolder.Name = "PinatHubNotifications"
notifHolder.ResetOnSpawn = false
notifHolder.Parent = Player:WaitForChild("PlayerGui")

local notifFrame = Instance.new("Frame")
notifFrame.Name = "NotificationHolder"
notifFrame.Size = UDim2.new(0, 350, 1, -20)
notifFrame.Position = UDim2.new(1, -370, 0, 10)
notifFrame.BackgroundTransparency = 1
notifFrame.Parent = notifHolder

local notifList = Instance.new("UIListLayout")
notifList.Name = "NotifList"
notifList.Padding = UDim.new(0, 8)
notifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
notifList.VerticalAlignment = Enum.VerticalAlignment.Top
notifList.SortOrder = Enum.SortOrder.LayoutOrder
notifList.Parent = notifFrame

local function ShowNotification(title, message, duration)
    duration = duration or 3
    
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 330, 0, 70)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    notif.BackgroundTransparency = 1
    notif.BorderSizePixel = 0
    notif.ClipsDescendants = true
    notif.Parent = notifFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notif
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(80, 80, 90)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = notif
    
    local accent = Instance.new("Frame")
    accent.Name = "Accent"
    accent.Size = UDim2.new(0, 4, 1, 0)
    accent.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    accent.BorderSizePixel = 0
    accent.Parent = notif
    
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 4)
    accentCorner.Parent = accent
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 14, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = notif
    
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 18)
    messageLabel.Position = UDim2.new(0, 14, 0, 32)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 14
    messageLabel.Parent = notif
    
    local progressBg = Instance.new("Frame")
    progressBg.Name = "ProgressBg"
    progressBg.Size = UDim2.new(1, -20, 0, 3)
    progressBg.Position = UDim2.new(0, 10, 1, -8)
    progressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    progressBg.BorderSizePixel = 0
    progressBg.Parent = notif
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(1, 0)
    progressCorner.Parent = progressBg
    
    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.new(1, 0, 1, 0)
    progress.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
    progress.BorderSizePixel = 0
    progress.Parent = progressBg
    
    local progressCorner2 = Instance.new("UICorner")
    progressCorner2.CornerRadius = UDim.new(1, 0)
    progressCorner2.Parent = progress
    
    notif.Position = UDim2.new(1, 50, 0, 0)
    
    local fadeIn = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -340, 0, 0),
        BackgroundTransparency = 0
    })
    
    local fadeOut = TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0, 0),
        BackgroundTransparency = 1
    })
    
    local progressTween = TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 1, 0)
    })
    
    fadeIn:Play()
    progressTween:Play()
    
    task.delay(duration, function()
        if notif and notif.Parent then
            fadeOut:Play()
            task.wait(0.3)
            pcall(function() notif:Destroy() end)
        end
    end)
    
    return notif
end

-- =======================================================
-- LOGO LAUNCHER
-- =======================================================
local logoGui = Instance.new("ScreenGui")
logoGui.Name = "PinatHubLogo"
logoGui.ResetOnSpawn = false
logoGui.Parent = Player:WaitForChild("PlayerGui", 5)

local logoButton = Instance.new("ImageButton")
logoButton.Name = "LogoButton"
logoButton.Size = UDim2.new(0, 60, 0, 60)
logoButton.Position = UDim2.new(0.5, -30, 0.5, -30)
logoButton.BackgroundTransparency = 1
logoButton.Image = "rbxassetid://85767833021251"
logoButton.ImageColor3 = Color3.fromRGB(180, 0, 255)
logoButton.ScaleType = Enum.ScaleType.Fit
logoButton.Parent = logoGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = logoButton

local hoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)})
local unhoverTween = TweenService:Create(logoButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)})

logoButton.MouseEnter:Connect(function()
    hoverTween:Play()
end)

logoButton.MouseLeave:Connect(function()
    unhoverTween:Play()
end)

local dragging = false
local dragInput, dragStart, startPos

logoButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = logoButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

logoButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        logoButton.Position = newPos
    end
end)

-- =======================================================
-- LOAD WINDUI
-- =======================================================
local WindUI = (function()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua", true))()
    end)
    return success and result or nil
end)()

if not WindUI then 
    ShowNotification("Error", "Failed to load WindUI Library", 5)
    return 
end

-- =======================================================
-- CREATE CUSTOM WINDOW
-- =======================================================
local Window = WindUI:CreateWindow({
    Title = "PinatHub",
    Author = "@viunze on tiktok",
    Folder = "PinatHub",
    NewElements = true,
    OpenButton = {
        Enabled = false
    },
    Topbar = { Height = 44, ButtonsType = "Default" }
})

Window:Tag({ Title = "Be a Lucky Block Script", Icon = "star", Color = Color3.fromHex("#BA00FF"), Border = true })

local guiVisible = true
logoButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    if Window then
        pcall(function()
            if guiVisible then
                Window:Open()
            else
                Window:Minimize()
            end
        end)
    end
end)

-- =======================================================
-- CREATE TABS (Settings Tab Removed)
-- =======================================================
local MainTab = Window:Tab({ Title = "Main", Icon = "box" })
local UpgradesTab = Window:Tab({ Title = "Upgrades", Icon = "gauge" })
local BrainrotsTab = Window:Tab({ Title = "Brainrots", Icon = "bot" })
local StatsTab = Window:Tab({ Title = "Stats", Icon = "chart-column" })
local CommunityTab = Window:Tab({ Title = "Community", Icon = "users" })

-- =======================================================
-- MAIN TAB - FEATURES
-- =======================================================

-- Playtime Rewards Section
local PlaytimeSection = MainTab:Section({ Title = "Playtime Rewards" })

local autoClaiming = false
local claimGift = ReplicatedStorage:FindFirstChild("Packages")
if claimGift then claimGift = claimGift:FindFirstChild("_Index") end
if claimGift then claimGift = claimGift:FindFirstChild("sleitnick_knit@1.7.0") end
if claimGift then claimGift = claimGift:FindFirstChild("knit") end
if claimGift then claimGift = claimGift:FindFirstChild("Services") end
if claimGift then claimGift = claimGift:FindFirstChild("PlaytimeRewardService") end
if claimGift then claimGift = claimGift:FindFirstChild("RF") end
if claimGift then claimGift = claimGift:FindFirstChild("ClaimGift") end

PlaytimeSection:Toggle({
    Title = "Auto Claim Playtime Rewards",
    Desc = "Automatically claim all playtime rewards",
    Value = false,
    Callback = function(state)
        autoClaiming = state
        if not state then return end
        task.spawn(function()
            while autoClaiming do
                for reward = 1, 12 do
                    if not autoClaiming then break end
                    if claimGift then
                        pcall(function()
                            claimGift:InvokeServer(reward)
                        end)
                    end
                    task.wait(0.25)
                end
                task.wait(1)
            end
        end)
    end
})

MainTab:Space()

-- Rebirth Section
local RebirthSection = MainTab:Section({ Title = "Rebirth" })

local rebirth = ReplicatedStorage:FindFirstChild("Packages")
if rebirth then rebirth = rebirth:FindFirstChild("_Index") end
if rebirth then rebirth = rebirth:FindFirstChild("sleitnick_knit@1.7.0") end
if rebirth then rebirth = rebirth:FindFirstChild("knit") end
if rebirth then rebirth = rebirth:FindFirstChild("Services") end
if rebirth then rebirth = rebirth:FindFirstChild("RebirthService") end
if rebirth then rebirth = rebirth:FindFirstChild("RF") end
if rebirth then rebirth = rebirth:FindFirstChild("Rebirth") end

local runningRebirth = false

RebirthSection:Toggle({
    Title = "Auto Rebirth",
    Desc = "Automatically rebirth when available",
    Value = false,
    Callback = function(state)
        runningRebirth = state
        if not state then return end
        task.spawn(function()
            while runningRebirth do
                if rebirth then
                    pcall(function()
                        rebirth:InvokeServer()
                    end)
                end
                task.wait(1)
            end
        end)
    end
})

MainTab:Space()

-- Event Pass Section
local EventPassSection = MainTab:Section({ Title = "Event Pass" })

local runningEventPass = false
local claimPass = ReplicatedStorage:FindFirstChild("Packages")
if claimPass then claimPass = claimPass:FindFirstChild("_Index") end
if claimPass then claimPass = claimPass:FindFirstChild("sleitnick_knit@1.7.0") end
if claimPass then claimPass = claimPass:FindFirstChild("knit") end
if claimPass then claimPass = claimPass:FindFirstChild("Services") end
if claimPass then claimPass = claimPass:FindFirstChild("SeasonPassService") end
if claimPass then claimPass = claimPass:FindFirstChild("RF") end
if claimPass then claimPass = claimPass:FindFirstChild("ClaimPassReward") end

EventPassSection:Toggle({
    Title = "Auto Claim Event Pass Rewards",
    Desc = "Automatically claim all event pass rewards",
    Value = false,
    Callback = function(state)
        runningEventPass = state
        if not state then return end
        task.spawn(function()
            while runningEventPass do
                local success, gui = pcall(function()
                    return Player.PlayerGui:WaitForChild("Windows"):WaitForChild("Event"):WaitForChild("Frame"):WaitForChild("Frame"):WaitForChild("Windows"):WaitForChild("Pass"):WaitForChild("Main"):WaitForChild("ScrollingFrame")
                end)
                if success and gui then
                    for i = 1, 10 do
                        if not runningEventPass then break end
                        local item = gui:FindFirstChild(tostring(i))
                        if item and item:FindFirstChild("Frame") and item.Frame:FindFirstChild("Free") then
                            local free = item.Frame.Free
                            local locked = free:FindFirstChild("Locked")
                            local claimed = free:FindFirstChild("Claimed")
                            if locked and locked.Visible then
                                while runningEventPass and locked and locked.Visible do
                                    task.wait(0.2)
                                end
                            end
                            if runningEventPass and locked and not locked.Visible and claimPass then
                                pcall(function()
                                    claimPass:InvokeServer("Free", i)
                                end)
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

MainTab:Space()

-- Codes Section
local CodesSection = MainTab:Section({ Title = "Codes" })

local redeemCode = ReplicatedStorage:FindFirstChild("Packages")
if redeemCode then redeemCode = redeemCode:FindFirstChild("_Index") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("sleitnick_knit@1.7.0") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("knit") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("Services") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("CodesService") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("RF") end
if redeemCode then redeemCode = redeemCode:FindFirstChild("RedeemCode") end

local codes = {"release"}

CodesSection:Button({
    Title = "Redeem All Codes",
    Desc = "Redeem all available codes",
    Callback = function()
        for _, code in ipairs(codes) do
            if redeemCode then
                pcall(function()
                    redeemCode:InvokeServer(code)
                end)
            end
            task.wait(1)
        end
        ShowNotification("Codes", "All codes redeemed!", 3)
    end
})

MainTab:Space()

-- Luckyblock Section
local LuckyblockSection = MainTab:Section({ Title = "Luckyblock" })

local buySkin = ReplicatedStorage:FindFirstChild("Packages")
if buySkin then buySkin = buySkin:FindFirstChild("_Index") end
if buySkin then buySkin = buySkin:FindFirstChild("sleitnick_knit@1.7.0") end
if buySkin then buySkin = buySkin:FindFirstChild("knit") end
if buySkin then buySkin = buySkin:FindFirstChild("Services") end
if buySkin then buySkin = buySkin:FindFirstChild("SkinService") end
if buySkin then buySkin = buySkin:FindFirstChild("RF") end
if buySkin then buySkin = buySkin:FindFirstChild("BuySkin") end

local skins = {
    "prestige_mogging_luckyblock",
    "mogging_luckyblock",
    "colossus _luckyblock",
    "inferno_luckyblock",
    "divine_luckyblock",
    "spirit_luckyblock",
    "cyborg_luckyblock",
    "void_luckyblock",
    "gliched_luckyblock",
    "lava_luckyblock",
    "freezy_luckyblock",
    "fairy_luckyblock"
}

local suffix = {
    K = 1e3, M = 1e6, B = 1e9, T = 1e12,
    Qa = 1e15, Qi = 1e18, Sx = 1e21,
    Sp = 1e24, Oc = 1e27, No = 1e30, Dc = 1e33
}

local function parseCash(text)
    text = text:gsub("%$", ""):gsub(",", ""):gsub("%s+", "")
    local num = tonumber(text:match("[%d%.]+"))
    local suf = text:match("%a+")
    if not num then return 0 end
    if suf and suffix[suf] then
        return num * suffix[suf]
    end
    return num
end

local runningAutoBuy = false

LuckyblockSection:Toggle({
    Title = "Auto Buy Best Luckyblock",
    Desc = "Automatically buy the best luckyblock you can afford",
    Value = false,
    Callback = function(state)
        runningAutoBuy = state
        if not state then return end
        task.spawn(function()
            while runningAutoBuy do
                local gui = Player.PlayerGui:FindFirstChild("Windows")
                if gui then
                    local pickaxeShop = gui:FindFirstChild("PickaxeShop")
                    if pickaxeShop then
                        local shopContainer = pickaxeShop:FindFirstChild("ShopContainer")
                        if shopContainer then
                            local scrollingFrame = shopContainer:FindFirstChild("ScrollingFrame")
                            if scrollingFrame and Player.leaderstats then
                                local cash = Player.leaderstats.Cash.Value
                                local bestSkin = nil
                                local bestPrice = 0
                                for i = 1, #skins do
                                    local name = skins[i]
                                    local item = scrollingFrame:FindFirstChild(name)
                                    if item then
                                        local main = item:FindFirstChild("Main")
                                        if main then
                                            local buyFolder = main:FindFirstChild("Buy")
                                            if buyFolder then
                                                local buyButton = buyFolder:FindFirstChild("BuyButton")
                                                if buyButton and buyButton.Visible then
                                                    local cashLabel = buyButton:FindFirstChild("Cash")
                                                    if cashLabel then
                                                        local price = parseCash(cashLabel.Text)
                                                        if cash >= price and price > bestPrice then
                                                            bestSkin = name
                                                            bestPrice = price
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                if bestSkin and buySkin then
                                    pcall(function()
                                        buySkin:InvokeServer(bestSkin)
                                    end)
                                end
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

MainTab:Space()

-- Sell Brainrot Section
local SellSection = MainTab:Section({ Title = "Sell Brainrot" })

local sellBrainrot = ReplicatedStorage:FindFirstChild("Packages")
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("_Index") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("sleitnick_knit@1.7.0") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("knit") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("Services") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("InventoryService") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("RF") end
if sellBrainrot then sellBrainrot = sellBrainrot:FindFirstChild("SellBrainrot") end

SellSection:Button({
    Title = "Sell Held Brainrot",
    Desc = "Sell the brainrot you are currently holding",
    Callback = function()
        Window:Dialog({
            Title = "Confirm Sale",
            Content = "Are you sure you want to sell this held Brainrot?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local character = Player.Character or Player.CharacterAdded:Wait()
                        local tool = character:FindFirstChildOfClass("Tool")
                        if not tool then
                            ShowNotification("ERROR!", "Equip the Brainrot you want to Sell", 5)
                            return
                        end
                        local entityId = tool:GetAttribute("EntityId")
                        if not entityId or not sellBrainrot then return end
                        pcall(function()
                            sellBrainrot:InvokeServer(entityId)
                        end)
                        ShowNotification("SOLD!", "Sold: " .. tool.Name, 5)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function() end
                }
            }
        })
    end
})

MainTab:Space()

-- Pickup Brainrots Section
local PickupSection = MainTab:Section({ Title = "Pickup Brainrots" })

local pickupBrainrot = ReplicatedStorage:FindFirstChild("Packages")
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("_Index") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("sleitnick_knit@1.7.0") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("knit") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("Services") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("ContainerService") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("RF") end
if pickupBrainrot then pickupBrainrot = pickupBrainrot:FindFirstChild("PickupBrainrot") end

PickupSection:Button({
    Title = "Pickup All Your Brainrots",
    Desc = "Pick up all brainrots from your plot",
    Callback = function()
        Window:Dialog({
            Title = "Confirm Pickup!",
            Content = "Pick up all Brainrots?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local username = Player.Name
                        local plotsFolder = workspace:WaitForChild("Plots")
                        local myPlot = nil
                        for i = 1, 5 do
                            local plot = plotsFolder:FindFirstChild(tostring(i))
                            if plot and plot:FindFirstChild(tostring(i)) then
                                local inner = plot[tostring(i)]
                                for _, v in pairs(inner:GetDescendants()) do
                                    if v:IsA("BillboardGui") and string.find(v.Name, username) then
                                        myPlot = inner
                                        break
                                    end
                                end
                            end
                            if myPlot then break end
                        end
                        if myPlot and pickupBrainrot then
                            local containers = myPlot:FindFirstChild("Containers")
                            if containers then
                                for i = 1, 30 do
                                    local containerFolder = containers:FindFirstChild(tostring(i))
                                    if containerFolder and containerFolder:FindFirstChild(tostring(i)) then
                                        local container = containerFolder[tostring(i)]
                                        local innerModel = container:FindFirstChild("InnerModel")
                                        if innerModel and #innerModel:GetChildren() > 0 then
                                            pcall(function()
                                                pickupBrainrot:InvokeServer(tostring(i))
                                            end)
                                            task.wait(0.1)
                                        end
                                    end
                                end
                            end
                        end
                        ShowNotification("Done!", "Picked up all Brainrots", 5)
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function() end
                }
            }
        })
    end
})

-- =======================================================
-- UPGRADES TAB
-- =======================================================

UpgradesTab:Section({ Title = "Speed Upgrades" })

local upgrade = ReplicatedStorage:FindFirstChild("Packages")
if upgrade then upgrade = upgrade:FindFirstChild("_Index") end
if upgrade then upgrade = upgrade:FindFirstChild("sleitnick_knit@1.7.0") end
if upgrade then upgrade = upgrade:FindFirstChild("knit") end
if upgrade then upgrade = upgrade:FindFirstChild("Services") end
if upgrade then upgrade = upgrade:FindFirstChild("UpgradesService") end
if upgrade then upgrade = upgrade:FindFirstChild("RF") end
if upgrade then upgrade = upgrade:FindFirstChild("Upgrade") end

local speedAmount = 1
local speedDelay = 0.5
local runningSpeedUpgrade = false

UpgradesTab:Input({
    Title = "Speed Amount",
    Desc = "Number of upgrades to buy each time",
    Placeholder = "Number",
    Value = "1",
    Callback = function(Value)
        speedAmount = tonumber(Value) or 1
    end
})

UpgradesTab:Slider({
    Title = "Upgrade Interval",
    Desc = "Delay between upgrades (seconds)",
    Value = { Min = 0, Max = 5, Default = 1 },
    Rounding = 1,
    Callback = function(Value)
        speedDelay = Value
    end
})

UpgradesTab:Toggle({
    Title = "Auto Upgrade Speed",
    Desc = "Automatically upgrade movement speed",
    Value = false,
    Callback = function(state)
        runningSpeedUpgrade = state
        if not state then return end
        task.spawn(function()
            while runningSpeedUpgrade do
                if upgrade then
                    pcall(function()
                        upgrade:InvokeServer("MovementSpeed", speedAmount)
                    end)
                end
                task.wait(speedDelay)
            end
        end)
    end
})

-- =======================================================
-- BRAINROTS TAB
-- =======================================================

-- Boss Detectors Section
local BossSection = BrainrotsTab:Section({ Title = "Boss Detectors" })

local storedParts = {}
local folder = workspace:WaitForChild("BossTouchDetectors")
local runningRBTD = false

BossSection:Toggle({
    Title = "Remove Bad Boss Touch Detectors",
    Desc = "Will make it so only the last boss can capture you",
    Value = false,
    Callback = function(state)
        runningRBTD = state
        if state then
            storedParts = {}
            for _, obj in ipairs(folder:GetChildren()) do
                if obj.Name ~= "base14" then
                    table.insert(storedParts, obj)
                    obj.Parent = nil
                end
            end
        else
            for _, obj in ipairs(storedParts) do
                if obj then
                    obj.Parent = folder
                end
            end
            storedParts = {}
        end
    end
})

BrainrotsTab:Space()

-- Teleport Section
local TeleportSection = BrainrotsTab:Section({ Title = "Teleport" })

TeleportSection:Button({
    Title = "Teleport to End",
    Desc = "Teleport all brainrots to the end zone",
    Callback = function()
        local modelsFolder = workspace:WaitForChild("RunningModels")
        local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")
        for _, obj in ipairs(modelsFolder:GetChildren()) do
            if obj:IsA("Model") then
                if obj.PrimaryPart then
                    obj:SetPrimaryPartCFrame(target.CFrame)
                else
                    local part = obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        part.CFrame = target.CFrame
                    end
                end
            elseif obj:IsA("BasePart") then
                obj.CFrame = target.CFrame
            end
        end
        ShowNotification("Teleport", "Brainrots teleported to end!", 3)
    end
})

BrainrotsTab:Space()

-- Farming Section
local FarmingSection = BrainrotsTab:Section({ Title = "Farming" })

local autoFarming = false

FarmingSection:Toggle({
    Title = "Auto Farm Best Brainrots",
    Desc = "Automatically farm the best brainrots",
    Value = false,
    Callback = function(state)
        autoFarming = state
        if state then
            task.spawn(function()
                while autoFarming do
                    local character = Player.Character or Player.CharacterAdded:Wait()
                    local root = character:WaitForChild("HumanoidRootPart")
                    local humanoid = character:WaitForChild("Humanoid")
                    local userId = Player.UserId
                    local modelsFolder = workspace:WaitForChild("RunningModels")
                    local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")
                    
                    root.CFrame = CFrame.new(715, 39, -2122)
                    task.wait(0.3)
                    humanoid:MoveTo(Vector3.new(710, 39, -2122))
                    
                    local ownedModel = nil
                    repeat
                        task.wait(0.3)
                        for _, obj in ipairs(modelsFolder:GetChildren()) do
                            if obj:IsA("Model") and obj:GetAttribute("OwnerId") == userId then
                                ownedModel = obj
                                break
                            end
                        end
                    until ownedModel ~= nil or not autoFarming
                    
                    if not autoFarming then break end
                    
                    if ownedModel.PrimaryPart then
                        ownedModel:SetPrimaryPartCFrame(target.CFrame)
                    else
                        local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                        if part then
                            part.CFrame = target.CFrame
                        end
                    end
                    task.wait(0.7)
                    
                    if ownedModel and ownedModel.Parent == modelsFolder then
                        if ownedModel.PrimaryPart then
                            ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
                        else
                            local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                            if part then
                                part.CFrame = target.CFrame * CFrame.new(0, -5, 0)
                            end
                        end
                    end
                    
                    repeat
                        task.wait(0.3)
                    until not autoFarming or (ownedModel == nil or ownedModel.Parent ~= modelsFolder)
                    
                    if not autoFarming then break end
                    
                    local oldCharacter = Player.Character
                    repeat
                        task.wait(0.2)
                    until not autoFarming or (Player.Character ~= oldCharacter and Player.Character ~= nil)
                    
                    if not autoFarming then break end
                    
                    task.wait(0.4)
                    local newChar = Player.Character
                    if newChar then
                        local newRoot = newChar:FindFirstChild("HumanoidRootPart")
                        if newRoot then
                            newRoot.CFrame = CFrame.new(737, 39, -2118)
                        end
                    end
                    task.wait(2.1)
                end
            end)
        end
    end
})

-- =======================================================
-- STATS TAB
-- =======================================================

StatsTab:Section({ Title = "Lucky Block Speed" })

local runningSpeedMod = false
local speedValue = 1000
local originalSpeed = nil
local currentModel = nil

local function getMyModel()
    local folder = workspace:FindFirstChild("RunningModels")
    if not folder then return nil end
    for _, model in ipairs(folder:GetChildren()) do
        if model:GetAttribute("OwnerId") == Player.UserId then
            return model
        end
    end
    return nil
end

local function applySpeed()
    local model = getMyModel()
    if not model then
        currentModel = nil
        return
    end
    if model ~= currentModel then
        currentModel = model
        originalSpeed = model:GetAttribute("MovementSpeed")
    end
    if runningSpeedMod then
        if originalSpeed == nil then
            originalSpeed = model:GetAttribute("MovementSpeed")
        end
        model:SetAttribute("MovementSpeed", speedValue)
    end
end

task.spawn(function()
    while true do
        if runningSpeedMod then
            applySpeed()
        end
        task.wait(0.2)
    end
end)

StatsTab:Toggle({
    Title = "Enable Custom Lucky Block Speed",
    Desc = "Override your lucky block's movement speed",
    Value = false,
    Callback = function(state)
        runningSpeedMod = state
        if not state then
            local model = getMyModel()
            if model and originalSpeed ~= nil then
                model:SetAttribute("MovementSpeed", originalSpeed)
            end
            originalSpeed = nil
            currentModel = nil
        end
    end
})

StatsTab:Slider({
    Title = "Lucky Block Speed",
    Desc = "Set your lucky block's speed",
    Value = { Min = 50, Max = 3000, Default = 1000 },
    Rounding = 0,
    Callback = function(Value)
        speedValue = Value
        if runningSpeedMod then
            local model = getMyModel()
            if model then
                model:SetAttribute("MovementSpeed", Value)
            end
        end
    end
})

StatsTab:Space()

-- Infinite Jump Section
local JumpSection = StatsTab:Section({ Title = "Jump" })

JumpSection:Toggle({
    Title = "Infinite Jump",
    Desc = "Enable unlimited jumps",
    Value = false,
    Callback = function(value)
        InfiniteJumpEnabled = value
        if value then
            ShowNotification("Infinite Jump", "Enabled", 2)
        else
            ShowNotification("Infinite Jump", "Disabled", 2)
        end
    end
})

-- =======================================================
-- COMMUNITY TAB
-- =======================================================

local WhatsAppSection = CommunityTab:Section({ Title = "WhatsApp Group" })

WhatsAppSection:Button({
    Title = "Join WhatsApp Group",
    Desc = "Click to copy WhatsApp group link",
    Callback = function()
        if setclipboard then
            setclipboard("https://chat.whatsapp.com/I8hG44FLgrRAwQcS3lvEft")
            ShowNotification("Success", "WhatsApp link copied to clipboard!", 3)
        else
            ShowNotification("Error", "Clipboard not supported!", 2)
        end
    end
})

CommunityTab:Space()

local DiscordSection = CommunityTab:Section({ Title = "Discord Server" })

DiscordSection:Button({
    Title = "Join Discord Server",
    Desc = "Click to copy Discord server link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/eDbaHKEf7G")
            ShowNotification("Success", "Discord link copied to clipboard!", 3)
        else
            ShowNotification("Error", "Clipboard not supported!", 2)
        end
    end
})

CommunityTab:Space()

local CreditSection = CommunityTab:Section({ Title = "Credits" })

CreditSection:Paragraph({
    Title = "PinatHub",
    Desc = "by viunze"
})

-- =======================================================
-- INFINITE JUMP HANDLER
-- =======================================================
UserInputService.JumpRequest:connect(function()
    if InfiniteJumpEnabled then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

-- =======================================================
-- CHARACTER RESPAWN HANDLER
-- =======================================================
Player.CharacterAdded:Connect(function(character)
    task.wait(0.5)
    currentModel = nil
    originalSpeed = nil
end)

-- =======================================================
-- INITIAL NOTIFICATION
-- =======================================================
task.wait(1)
ShowNotification("PinatHub", "Loaded", 5)

print("PinatHub Loaded")
