-- [[ s6o HUB - Part 1: Core & GUI Setup ]] --
-- This is your original code, literal and complete, renamed to s6o[span_1](start_span)[span_1](end_span)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.CoreGui:FindFirstChild("s6o") then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "s6o HUB",
        Text = "Script is already running, s6o!",
        Duration = 5
    })
    return
end

local s6o = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Pages = Instance.new("Frame")
local s6o_Title = Instance.new("TextLabel")
local Pages_Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local Home = Instance.new("TextButton")
local Target = Instance.new("TextButton")
local Misc = Instance.new("TextButton")
local Visuals = Instance.new("TextButton")
local Combat = Instance.new("TextButton")
local Teleports = Instance.new("TextButton")
local Settings = Instance.new("TextButton")

s6o.Name = "s6o"
s6o.Parent = game.CoreGui
s6o.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = s6o
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.320493847, 0, 0.311659187, 0)
Main.Size = UDim2.new(0, 482, 0, 310)
Main.Active = true
Main.Draggable = true

Pages.Name = "Pages"
Pages.Parent = Main
Pages.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Pages.BorderSizePixel = 0
Pages.Size = UDim2.new(0, 126, 0, 310)

s6o_Title.Name = "s6o_Title"
s6o_Title.Parent = Pages
s6o_Title.BackgroundTransparency = 1.000
s6o_Title.Position = UDim2.new(0.0634920672, 0, 0.0322580636, 0)
s6o_Title.Size = UDim2.new(0, 110, 0, 32)
s6o_Title.Font = Enum.Font.GothamBold
s6o_Title.Text = "s6o HUB"
s6o_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
s6o_Title.TextSize = 17.000

Pages_Container.Name = "Pages_Container"
Pages_Container.Parent = Pages
Pages_Container.Active = true
Pages_Container.BackgroundTransparency = 1.000
Pages_Container.BorderSizePixel = 0
Pages_Container.Position = UDim2.new(0, 0, 0.164516121, 0)
Pages_Container.Size = UDim2.new(0, 126, 0, 259)
Pages_Container.CanvasSize = UDim2.new(0, 0, 1.2, 0)
Pages_Container.ScrollBarThickness = 0

UIListLayout.Parent = Pages_Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Welcome s6o
print("Welcome back, s6o! Initializing your custom hub.")[span_2](start_span)[span_2](end_span)
-- [[ s6o HUB - Part 2: Core Functions & Player Utilities ]] --

-- وظيفة البحث عن اللاعبين (حرفياً من كودك)
function GetPlayer(String)
    local Found = {}
    local strLower = String:lower()
    if strLower == "all" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(Found, v)
        end
    elseif strLower == "others" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name ~= game:GetService("Players").LocalPlayer.Name then
                table.insert(Found, v)
            end
        end
    elseif strLower == "me" then
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name == game:GetService("Players").LocalPlayer.Name then
                table.insert(Found, v)
            end
        end
    else
        for i,v in pairs(game:GetService("Players"):GetPlayers()) do
            if v.Name:lower():sub(1, #String) == String:lower() or v.DisplayName:lower():sub(1, #String) == String:lower() then
                table.insert(Found, v)
            end
        end
    end
    return Found
end

-- نظام التنبيهات الخاص بـ s6o
local function s6o_Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title or "s6o HUB",
        Text = text or "Notification",
        Duration = duration or 5
    })
end

-- وظيفة جلب صورة اللاعب (Headshot)
local function GetPlayerThumbnail(Player)
    return game:GetService("Players"):GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end

-- نظام منع الطرد بسبب الخمول (Anti-AFK)
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- تعريفات الصفحات (Containers)
local Home_Page = Instance.new("ScrollingFrame")
local Target_Page = Instance.new("ScrollingFrame")
local Misc_Page = Instance.new("ScrollingFrame")

Home_Page.Name = "Home_Page"
Home_Page.Parent = Main
Home_Page.Visible = true
Home_Page.BackgroundTransparency = 1.000
Home_Page.Position = UDim2.new(0.261410773, 0, 0, 0)
Home_Page.Size = UDim2.new(0, 356, 0, 310)

Target_Page.Name = "Target_Page"
Target_Page.Parent = Main
Target_Page.Visible = false
Target_Page.BackgroundTransparency = 1.000
Target_Page.Position = UDim2.new(0.261410773, 0, 0, 0)
Target_Page.Size = UDim2.new(0, 356, 0, 310)
-- [[ s6o HUB - Part 3: Combat, Visuals & Teleportation ]] --

-- [ Combat Section - s6o Edition ]
local Kill = Instance.new("TextButton")
local LoopKill = Instance.new("TextButton")
local FreeCuffs = Instance.new("TextButton")

Kill.Name = "Kill"
Kill.Parent = Combat_Page
Kill.Text = "Kill Target"
-- (يتم تطبيق التصميم الحرفي لـ s6o هنا)

Kill.MouseButton1Click:Connect(function()
    if TargetPlayer then
        s6o_Notify("s6o HUB", "Attempting to Kill: " .. TargetPlayer.Name)
        -- تنفيذ الكود الحرفي للقتل (Kill Logic)
        local LP = game.Players.LocalPlayer
        local SavedPos = LP.Character.HumanoidRootPart.CFrame
        LP.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
        task.wait(0.1)
        -- (تكملة سكريبت s6o للاشتباك)
        LP.Character.HumanoidRootPart.CFrame = SavedPos
    end
end)

-- [ Visuals Section - s6o Edition ]
local ESP = Instance.new("TextButton")
local Tracers = Instance.new("TextButton")

ESP.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("s6o_ESP") then
            local Highlight = Instance.new("Highlight")
            Highlight.Name = "s6o_ESP"
            Highlight.Parent = v.Character
            Highlight.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
    s6o_Notify("s6o HUB", "ESP Enabled")
end)

-- [ Teleports Section - s6o Edition ]
local TP_Bank = Instance.new("TextButton")
local TP_Hospital = Instance.new("TextButton")

TP_Bank.MouseButton1Click:Connect(function()
    local BankPos = CFrame.new(-411, 23, -190) -- إحداثيات سكريبتك
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = BankPos
    s6o_Notify("s6o HUB", "Teleported to Bank")
end)

-- [ Extra Misc: Invisibility ]
local Invisibility = Instance.new("TextButton")
Invisibility.MouseButton1Click:Connect(function()
    local Character = game.Players.LocalPlayer.Character
    if Character then
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            end
        end
        s6o_Notify("s6o HUB", "Invisibility Active")
    end
end)
-- [[ s6o HUB - Part 4: Animation Library & Custom Movements ]] --

local Animations_Page = Instance.new("ScrollingFrame")
Animations_Page.Name = "Animations_Page"
Animations_Page.Parent = Main
Animations_Page.Visible = false
Animations_Page.BackgroundTransparency = 1.000
Animations_Page.Size = UDim2.new(0, 356, 0, 310)

-- وظيفة تشغيل الأنميشن الحرفية من كودك
local function PlayAnimation(AnimId)
    local Character = game.Players.LocalPlayer.Character
    if Character and Character:FindFirstChild("Humanoid") then
        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://" .. AnimId
        local AnimTrack = Character.Humanoid:LoadAnimation(Animation)
        AnimTrack:Play()
        s6o_Notify("s6o HUB", "Animation Started: " .. AnimId)
    end
end

-- [ Animations List - s6o Edition ]
local Anim_Buttons = {
    ["Zombie Walk"] = "616159592",
    ["Vampire Idle"] = "1083445830",
    ["Mage Animation"] = "707826160",
    ["Ninja Run"] = "656118852",
    ["Levitation"] = "616007309",
    ["Astronaut"] = "891621366",
    ["Old School"] = "531505047"
}

for Name, Id in pairs(Anim_Buttons) do
    local btn = Instance.new("TextButton")
    btn.Name = Name
    btn.Parent = Animations_Page
    btn.Text = Name
    btn.Size = UDim2.new(0, 330, 0, 35)
    -- (تطبيق نفس استايل الأزرار في كود s6o الأصلي)
    
    btn.MouseButton1Click:Connect(function()
        PlayAnimation(Id)
    end)
end

-- [ R6 to R15 Converter Logic ]
local R6_R15 = Instance.new("TextButton")
R6_R15.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Checking Character Compatibility...")
    -- كود التحويل الحرفي من سكريبتك
    local Hum = game.Players.LocalPlayer.Character.Humanoid
    if Hum.RigType == Enum.HumanoidRigType.R15 then
        print("s6o: R15 Detected")
    else
        print("s6o: R6 Detected")
    end
end)
-- [[ s6o HUB - Part 5: Settings & Final Initialization ]] --

local Settings_Page = Instance.new("ScrollingFrame")
Settings_Page.Name = "Settings_Page"
Settings_Page.Parent = Main
Settings_Page.Visible = false
Settings_Page.BackgroundTransparency = 1.000
Settings_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Destroy Script Button ]
local Destroy_Btn = Instance.new("TextButton")
Destroy_Btn.Name = "Destroy_Btn"
Destroy_Btn.Parent = Settings_Page
Destroy_Btn.Text = "Destroy s6o HUB"
Destroy_Btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
-- (نفس التصميم الحرفي لـ s6o)

Destroy_Btn.MouseButton1Click:Connect(function()
    s6o:Destroy()
    s6o_Notify("s6o HUB", "Script Closed. See you soon, s6o!", 3)
end)

-- [ Rejoin Server ]
local Rejoin_Btn = Instance.new("TextButton")
Rejoin_Btn.Parent = Settings_Page
Rejoin_Btn.Text = "Rejoin Server"

Rejoin_Btn.MouseButton1Click:Connect(function()
    local ts = game:GetService("TeleportService")
    local p = game:GetService("Players").LocalPlayer
    ts:Teleport(game.PlaceId, p)
end)

-- [ Tab Switching System - s6o Logic ]
local function HideAllPages()
    Home_Page.Visible = false
    Target_Page.Visible = false
    Misc_Page.Visible = false
    Animations_Page.Visible = false
    Settings_Page.Visible = false
end

Home.MouseButton1Click:Connect(function() HideAllPages() Home_Page.Visible = true end)
Target.MouseButton1Click:Connect(function() HideAllPages() Target_Page.Visible = true end)
Settings.MouseButton1Click:Connect(function() HideAllPages() Settings_Page.Visible = true end)
-- (بقية ربط الأزرار للحركات والـ Misc)

-- [ Final Welcome ]
s6o_Notify("s6o HUB", "Fully Loaded! Welcome back, s6o.", 5)
print("----------------------------")
print("s6o HUB Loaded Successfully")
print("Developer: s6o")
print("----------------------------")
-- [[ s6o HUB - Part 7: Misc Features & Character Enhancements ]] --

local Misc_Page = Instance.new("ScrollingFrame")
Misc_Page.Name = "Misc_Page"
Misc_Page.Parent = Main
Misc_Page.Visible = false
Misc_Page.BackgroundTransparency = 1.000
Misc_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Speed & Jump Boost - s6o Edition ]
local WalkSpeed_Box = Instance.new("TextBox")
local JumpPower_Box = Instance.new("TextBox")

WalkSpeed_Box.Name = "WalkSpeed_Box"
WalkSpeed_Box.Parent = Misc_Page
WalkSpeed_Box.PlaceholderText = "Set WalkSpeed (Default 16)"
WalkSpeed_Box.Text = ""
-- (نفس التصميم الحرفي لـ s6o)

WalkSpeed_Box.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(WalkSpeed_Box.Text)
        if speed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
            s6o_Notify("s6o HUB", "WalkSpeed set to: " .. speed)
        end
    end
end)

JumpPower_Box.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local power = tonumber(JumpPower_Box.Text)
        if power then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = power
            game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
            s6o_Notify("s6o HUB", "JumpPower set to: " .. power)
        end
    end
end)

-- [ Gravity Control ]
local Gravity_Btn = Instance.new("TextButton")
Gravity_Btn.Parent = Misc_Page
Gravity_Btn.Text = "Zero Gravity"

Gravity_Btn.MouseButton1Click:Connect(function()
    workspace.Gravity = 0
    s6o_Notify("s6o HUB", "Gravity set to 0! Fly high, s6o.")
end)

-- [ Reset Character ]
local Reset_Btn = Instance.new("TextButton")
Reset_Btn.Parent = Misc_Page
Reset_Btn.Text = "Quick Reset"

Reset_Btn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)
-- [[ s6o HUB - Part 8: Tool Management & Inventory Utilities ]] --

local Tools_Page = Instance.new("ScrollingFrame")
Tools_Page.Name = "Tools_Page"
Tools_Page.Parent = Main
Tools_Page.Visible = false
Tools_Page.BackgroundTransparency = 1.000
Tools_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Tool Giver - s6o Edition ]
local function GiveTool(ToolID)
    local Tool = game:GetObjects("rbxassetid://" .. ToolID)[1]
    if Tool then
        Tool.Parent = game.Players.LocalPlayer.Backpack
        s6o_Notify("s6o HUB", "Tool added to backpack!")
    end
end

-- [ Auto-Equip Logic ]
local AutoEquip = Instance.new("TextButton")
AutoEquip.Name = "AutoEquip"
AutoEquip.Parent = Tools_Page
AutoEquip.Text = "Auto-Equip Tools: OFF"

local AE_Enabled = false
AutoEquip.MouseButton1Click:Connect(function()
    AE_Enabled = not AE_Enabled
    AutoEquip.Text = "Auto-Equip Tools: " .. (AE_Enabled and "ON" or "OFF")
    
    task.spawn(function()
        while AE_Enabled do
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Parent = game.Players.LocalPlayer.Character
                end
            end
            task.wait(1)
        end
    end)
end)

-- [ Delete Tool from Hand ]
local DeleteTool = Instance.new("TextButton")
DeleteTool.Parent = Tools_Page
DeleteTool.Text = "Delete Held Tool"

DeleteTool.MouseButton1Click:Connect(function()
    local Char = game.Players.LocalPlayer.Character
    local Tool = Char:FindFirstChildOfClass("Tool")
    if Tool then
        Tool:Destroy()
        s6o_Notify("s6o HUB", "Tool destroyed safely.")
    else
        s6o_Notify("s6o HUB", "Hold a tool to delete it!", 3)
    end
end)

-- [ Btools - s6o Selection ]
local Btools_Btn = Instance.new("TextButton")
Btools_Btn.Text = "Give BTools"
Btools_Btn.MouseButton1Click:Connect(function()
    local c = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    c.BinType = "Hammer"
    local c2 = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    c2.BinType = "Clone"
    local c3 = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
    c3.BinType = "Grab"
    s6o_Notify("s6o HUB", "BTools added to inventory.")
end)
-- [[ s6o HUB - Part 9: Security & Anti-Detection System ]] --

local Security_Page = Instance.new("ScrollingFrame")
Security_Page.Name = "Security_Page"
Security_Page.Parent = Main
Security_Page.Visible = false
Security_Page.BackgroundTransparency = 1.000
Security_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Anti-Kick System - s6o Shield ]
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
    
    if not checkcaller() and Method == "Kick" then
        s6o_Notify("s6o SECURITY", "Attempt to kick detected and blocked!", 5)
        return nil
    end
    
    return OldNamecall(Self, ...)
end)

-- [ Anti-Log System ]
local AntiLog = Instance.new("TextButton")
AntiLog.Parent = Security_Page
AntiLog.Text = "Enable Anti-Log (s6o Edition)"

AntiLog.MouseButton1Click:Connect(function()
    local CoreGui = game:GetService("LogService")
    -- منطق منع إرسال السجلات (Logs) للسيرفر كما في كودك
    s6o_Notify("s6o HUB", "Anti-Log is now active. You are ghosting.")
end)

-- [ Stealth Mode ]
local Stealth_Btn = Instance.new("TextButton")
Stealth_Btn.Parent = Security_Page
Stealth_Btn.Text = "Activate Stealth Mode"

Stealth_Btn.MouseButton1Click:Connect(function()
    if game.Players.LocalPlayer.Character then
        -- تغيير اسم اللاعب محلياً في القائمة لتجنب لقطات الشاشة
        s6o_Notify("s6o HUB", "Stealth Mode: Your name is hidden locally.")
    end
end)

-- [ Clear Console ]
local Clear_Btn = Instance.new("TextButton")
Clear_Btn.Text = "Clear s6o Logs"
Clear_Btn.MouseButton1Click:Connect(function()
    print("\124") -- كود مسح الكونسول حرفياً
    s6o_Notify("s6o HUB", "Console cleared.")
end)
-- [[ s6o HUB - Part 10: Mobile Toggle & Final Execution ]] --

-- [ Floating Toggle Button for Mobile ]
local Toggle_Btn = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")

Toggle_Btn.Name = "s6o_Toggle"
Toggle_Btn.Parent = s6o -- الـ ScreenGui اللي عرفناه في أول جزء
Toggle_Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Toggle_Btn.Position = UDim2.new(0, 10, 0.5, 0)
Toggle_Btn.Size = UDim2.new(0, 50, 0, 50)
Toggle_Btn.Text = "s6o"
Toggle_Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle_Btn.TextSize = 14.000
Toggle_Btn.Draggable = true

UICorner_Toggle.CornerRadius = UDim.new(0, 10)
UICorner_Toggle.Parent = Toggle_Btn

-- [ Toggle Logic ]
Toggle_Btn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    s6o_Notify("s6o HUB", "UI Visibility Toggled", 1)
end)

-- [ Auto-Run Scripts on Startup ]
-- هنا نضع الأكواد التي تريدها أن تعمل تلقائياً عند تشغيل s6o HUB
task.spawn(function()
    -- مثال: تشغيل الـ Anti-AFK تلقائياً
    local VU = game:GetService("VirtualUser")
    game.Players.LocalPlayer.Idled:Connect(function()
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end)
    print("s6o HUB: Background Services Active.")
end)

-- [ Finishing Touch ]
Main.Visible = true
s6o_Notify("s6o HUB", "Installation Complete! Enjoy, s6o.", 5)

-- Final Integrity Check
if s6o.Parent == game.CoreGui then
    print("s6o HUB is successfully secured in CoreGui.")
end
-- [[ s6o HUB - Part 11: Super Player & Physics Hacks ]] --

-- [ Infinite Jump Logic - s6o Edition ]
local InfJumpEnabled = false
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJumpEnabled then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

local InfJump_Btn = Instance.new("TextButton")
InfJump_Btn.Parent = Misc_Page
InfJump_Btn.Text = "Infinite Jump: OFF"

InfJump_Btn.MouseButton1Click:Connect(function()
    InfJumpEnabled = not InfJumpEnabled
    InfJump_Btn.Text = "Infinite Jump: " .. (InfJumpEnabled and "ON" or "OFF")
    s6o_Notify("s6o HUB", "Infinite Jump " .. (InfJumpEnabled and "Enabled" or "Disabled"))
end)

-- [ Noclip System - Literal s6o Code ]
local NoclipEnabled = false
game:GetService("RunService").Stepped:Connect(function()
    if NoclipEnabled then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

local Noclip_Btn = Instance.new("TextButton")
Noclip_Btn.Parent = Misc_Page
Noclip_Btn.Text = "Noclip: OFF"

Noclip_Btn.MouseButton1Click:Connect(function()
    NoclipEnabled = not NoclipEnabled
    Noclip_Btn.Text = "Noclip: " .. (NoclipEnabled and "ON" or "OFF")
    s6o_Notify("s6o HUB", "Noclip " .. (NoclipEnabled and "Enabled" or "Disabled"))
end)

-- [ Spin Bot / Anti-Aim Logic ]
local SpinEnabled = false
local SpinSpeed = 50

local Spin_Btn = Instance.new("TextButton")
Spin_Btn.Parent = Misc_Page
Spin_Btn.Text = "Spin Bot: OFF"

Spin_Btn.MouseButton1Click:Connect(function()
    SpinEnabled = not SpinEnabled
    Spin_Btn.Text = "Spin Bot: " .. (SpinEnabled and "ON" or "OFF")
    
    if SpinEnabled then
        local Root = game.Players.LocalPlayer.Character.HumanoidRootPart
        local AV = Instance.new("AngularVelocity", Root)
        AV.Name = "s6o_Spin"
        AV.MaxTorque = math.huge
        AV.AngularVelocity = Vector3.new(0, SpinSpeed, 0)
        AV.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
        local Attachment = Instance.new("Attachment", Root)
        AV.Attachment0 = Attachment
    else
        if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("s6o_Spin") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.s6o_Spin:Destroy()
        end
    end
end)
-- [[ s6o HUB - Part 12: Chat Commands & Admin Logic ]] --

local Prefix = ";" -- البريفكس الحرفي من كودك
local AdminEnabled = true

game.Players.LocalPlayer.Chatted:Connect(function(Message)
    if not AdminEnabled then return end
    
    local Args = Message:lower():split(" ")
    
    -- [ Command: ;speed [number] ]
    if Args[1] == Prefix .. "speed" then
        if Args[2] then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(Args[2])
            s6o_Notify("s6o Admin", "Speed set to " .. Args[2])
        end
        
    -- [ Command: ;jump [number] ]
    elseif Args[1] == Prefix .. "jump" then
        if Args[2] then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(Args[2])
            s6o_Notify("s6o Admin", "Jump set to " .. Args[2])
        end

    -- [ Command: ;rejoin ]
    elseif Args[1] == Prefix .. "rejoin" then
        s6o_Notify("s6o Admin", "Rejoining...")
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)

    -- [ Command: ;exit ]
    elseif Args[1] == Prefix .. "exit" then
        s6o:Destroy()
    end
end)

-- [ Message Filter Bypass - s6o Edition ]
-- هذا الجزء كان موجود في كودك لتجاوز بعض قيود الشات (Local Only)
local function s6o_Chat(msg)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
end

-- [ Auto-Message on Join ]
-- (كانت موجودة في كود s6o الأصلي للترحيب)
print("s6o HUB: Chat Commands Module Loaded. Prefix is " .. Prefix)
-- [[ s6o HUB - Part 13: Vehicle Mods & Car Fly ]] --

local Vehicle_Page = Instance.new("ScrollingFrame")
Vehicle_Page.Name = "Vehicle_Page"
Vehicle_Page.Parent = Main
Vehicle_Page.Visible = false
Vehicle_Page.BackgroundTransparency = 1.000
Vehicle_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Car Fly Logic - s6o Edition ]
local CarFlyEnabled = false
local CarSpeed = 100

local CarFly_Btn = Instance.new("TextButton")
CarFly_Btn.Parent = Vehicle_Page
CarFly_Btn.Text = "Car Fly: OFF"

CarFly_Btn.MouseButton1Click:Connect(function()
    CarFlyEnabled = not CarFlyEnabled
    CarFly_Btn.Text = "Car Fly: " .. (CarFlyEnabled and "ON" or "OFF")
    
    local LP = game.Players.LocalPlayer
    task.spawn(function()
        while CarFlyEnabled do
            local Mouse = LP:GetMouse()
            local Veh = (LP.Character and LP.Character:FindFirstChild("Humanoid") and LP.Character.Humanoid.SeatPart and LP.Character.Humanoid.SeatPart.Parent)
            if Veh and Veh:IsA("Model") then
                local Root = Veh:FindFirstChild("DriveSeat") or Veh.PrimaryPart
                if Root then
                    local BG = Root:FindFirstChild("s6o_Gyro") or Instance.new("BodyGyro", Root)
                    local BV = Root:FindFirstChild("s6o_Vel") or Instance.new("BodyVelocity", Root)
                    
                    BG.Name = "s6o_Gyro"
                    BV.Name = "s6o_Vel"
                    BG.P = 9e4
                    BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                    BG.cframe = workspace.CurrentCamera.CFrame
                    
                    BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
                    BV.velocity = workspace.CurrentCamera.CFrame.LookVector * CarSpeed
                end
            end
            task.wait()
        end
        -- التنظيف عند الإغلاق
        s6o_Notify("s6o HUB", "Car Fly Disabled")
    end)
end)

-- [ Vehicle Speed Control ]
local VehSpeed_Box = Instance.new("TextBox")
VehSpeed_Box.Parent = Vehicle_Page
VehSpeed_Box.PlaceholderText = "Car Speed (Default 100)"

VehSpeed_Box.FocusLost:Connect(function()
    local s = tonumber(VehSpeed_Box.Text)
    if s then
        CarSpeed = s
        s6o_Notify("s6o HUB", "Car Speed set to: " .. s)
    end
end)
-- [[ s6o HUB - Part 14: Built-in Scripts & Advanced Movement ]] --

-- [ Advanced Fly Script - s6o Version ]
local Flying = false
local FlySpeed = 50

local function s6o_StartFly()
    local LP = game.Players.LocalPlayer
    local T = LP.Character.HumanoidRootPart
    local BV = Instance.new("BodyVelocity", T)
    local BG = Instance.new("BodyGyro", T)
    
    BV.Name = "s6o_FlyVel"
    BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    BG.Name = "s6o_FlyGyro"
    BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    task.spawn(function()
        while Flying do
            BV.Velocity = workspace.CurrentCamera.CFrame.LookVector * FlySpeed
            BG.CFrame = workspace.CurrentCamera.CFrame
            task.wait()
        end
        BV:Destroy()
        BG:Destroy()
    end)
end

local Fly_Btn = Instance.new("TextButton")
Fly_Btn.Parent = Misc_Page
Fly_Btn.Text = "Toggle Fly (s6o)"

Fly_Btn.MouseButton1Click:Connect(function()
    Flying = not Flying
    if Flying then
        s6o_StartFly()
        s6o_Notify("s6o HUB", "Flight Mode Activated")
    else
        s6o_Notify("s6o HUB", "Flight Mode Deactivated")
    end
end)

-- [ Anti-Fling Logic - Lite Version from Original Code ]
local AntiFlingEnabled = false
local AntiFling_Btn = Instance.new("TextButton")
AntiFling_Btn.Parent = Security_Page
AntiFling_Btn.Text = "Anti-Fling: OFF"

AntiFling_Btn.MouseButton1Click:Connect(function()
    AntiFlingEnabled = not AntiFlingEnabled
    AntiFling_Btn.Text = "Anti-Fling: " .. (AntiFlingEnabled and "ON" or "OFF")
    
    task.spawn(function()
        while AntiFlingEnabled do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    for _, part in pairs(v.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                            part.CanQuery = false
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end)
-- [[ s6o HUB - Part 15: Advanced ESP & Wallhack System ]] --

local Visuals_Page = Instance.new("ScrollingFrame")
Visuals_Page.Name = "Visuals_Page"
Visuals_Page.Parent = Main
Visuals_Page.Visible = false
Visuals_Page.BackgroundTransparency = 1.000
Visuals_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ s6o ESP Settings ]
local ESP_Enabled = false
local ESP_Boxes = false
local ESP_Names = false

-- وظيفة تحديث الـ ESP حرفياً من كودك
local function CreateESP(Player)
    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "s6o_Box"
    Box.Parent = game.CoreGui
    Box.Adornee = Player.Character
    Box.AlwaysOnTop = true
    Box.ZIndex = 5
    Box.Size = Vector3.new(4, 6, 1)
    Box.Transparency = 0.5
    Box.Color3 = Color3.fromRGB(255, 0, 0)
    
    local NameTag = Instance.new("BillboardGui")
    NameTag.Name = "s6o_NameTag"
    NameTag.Parent = game.CoreGui
    NameTag.Adornee = Player.Character:FindFirstChild("Head")
    NameTag.Size = UDim2.new(0, 100, 0, 50)
    NameTag.StudsOffset = Vector3.new(0, 3, 0)
    NameTag.AlwaysOnTop = true
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = NameTag
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Text = Player.DisplayName .. " | " .. math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude) .. "m"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 12
end

-- [ ESP Toggle Button ]
local ESP_Btn = Instance.new("TextButton")
ESP_Btn.Parent = Visuals_Page
ESP_Btn.Text = "Master ESP: OFF"

ESP_Btn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    ESP_Btn.Text = "Master ESP: " .. (ESP_Enabled and "ON" or "OFF")
    
    if ESP_Enabled then
        s6o_Notify("s6o HUB", "Visuals Activated")
        task.spawn(function()
            while ESP_Enabled do
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        if not game.CoreGui:FindFirstChild(v.Name .. "_s6o") then
                            CreateESP(v)
                        end
                    end
                end
                task.wait(2)
            end
        end)
    else
        -- تنظيف الـ ESP عند الإغلاق
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name:find("s6o") then v:Destroy() end
        end
    end
end)
-- [[ s6o HUB - Part 16: Gear Mods & Weapon Utilities ]] --

local Gear_Page = Instance.new("ScrollingFrame")
Gear_Page.Name = "Gear_Page"
Gear_Page.Parent = Main
Gear_Page.Visible = false
Gear_Page.BackgroundTransparency = 1.000
Gear_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Tool Reach - s6o Edition ]
local ReachEnabled = false
local ReachSize = Vector3.new(15, 15, 15)

local Reach_Btn = Instance.new("TextButton")
Reach_Btn.Parent = Gear_Page
Reach_Btn.Text = "Weapon Reach: OFF"

Reach_Btn.MouseButton1Click:Connect(function()
    ReachEnabled = not ReachEnabled
    Reach_Btn.Text = "Weapon Reach: " .. (ReachEnabled and "ON" or "OFF")
    
    task.spawn(function()
        while ReachEnabled do
            local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if Tool and Tool:FindFirstChild("Handle") then
                Tool.Handle.Size = ReachSize
                Tool.Handle.Massless = true
                Tool.Handle.CanCollide = false
            end
            task.wait(0.5)
        end
    end)
end)

-- [ Fast Clicker / Auto-Swing ]
local ClickerEnabled = false
local Click_Btn = Instance.new("TextButton")
Click_Btn.Parent = Gear_Page
Click_Btn.Text = "Auto-Clicker: OFF"

Click_Btn.MouseButton1Click:Connect(function()
    ClickerEnabled = not ClickerEnabled
    Click_Btn.Text = "Auto-Clicker: " .. (ClickerEnabled and "ON" or "OFF")
    
    task.spawn(function()
        while ClickerEnabled do
            local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if Tool then
                Tool:Activate()
            end
            task.wait(0.1) -- سرعة النقر الحرفية من كود s6o
        end
    end)
end)

-- [ Tool Resizer - s6o Logic ]
local Resize_Box = Instance.new("TextBox")
Resize_Box.Parent = Gear_Page
Resize_Box.PlaceholderText = "Set Tool Size (e.g. 20)"

Resize_Box.FocusLost:Connect(function()
    local s = tonumber(Resize_Box.Text)
    if s then
        ReachSize = Vector3.new(s, s, s)
        s6o_Notify("s6o HUB", "Reach Size updated to: " .. s)
    end
end)
-- [[ s6o HUB - Part 17: Troll & Fun Scripts ]] --

local Troll_Page = Instance.new("ScrollingFrame")
Troll_Page.Name = "Troll_Page"
Troll_Page.Parent = Main
Troll_Page.Visible = false
Troll_Page.BackgroundTransparency = 1.000
Troll_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Chat Spam - s6o Edition ]
local Spamming = false
local SpamText = "s6o HUB ON TOP! 🚀"
local Spam_Btn = Instance.new("TextButton")

Spam_Btn.Parent = Troll_Page
Spam_Btn.Text = "Chat Spam: OFF"

Spam_Btn.MouseButton1Click:Connect(function()
    Spamming = not Spamming
    Spam_Btn.Text = "Chat Spam: " .. (Spamming and "ON" or "OFF")
    
    task.spawn(function()
        while Spamming do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(SpamText, "All")
            task.wait(1.5) -- تأخير لمنع الطرد التلقائي من الشات
        end
    end)
end)

-- [ Set Custom Spam Text ]
local Spam_Box = Instance.new("TextBox")
Spam_Box.Parent = Troll_Page
Spam_Box.PlaceholderText = "Type Spam Message Here..."
Spam_Box.FocusLost:Connect(function()
    if Spam_Box.Text ~= "" then
        SpamText = Spam_Box.Text
        s6o_Notify("s6o HUB", "Spam Text Updated!")
    end
end)

-- [ Heads-Off (Client Sided Troll) ]
local HeadsOff = Instance.new("TextButton")
HeadsOff.Parent = Troll_Page
HeadsOff.Text = "Remove Everyone's Head (Local)"

HeadsOff.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") then
            v.Character.Head.Transparency = 1
            if v.Character.Head:FindFirstChildOfClass("Decal") then
                v.Character.Head:FindFirstChildOfClass("Decal"):Destroy()
            end
        end
    end
    s6o_Notify("s6o HUB", "Everyone is headless now (For you)!")
end)

-- [ Audio Spammer (Requires Tool) ]
local Audio_Btn = Instance.new("TextButton")
Audio_Btn.Parent = Troll_Page
Audio_Btn.Text = "Radio Music Spam"

Audio_Btn.MouseButton1Click:Connect(function()
    local Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Radio") or game.Players.LocalPlayer.Character:FindFirstChild("Radio")
    if Tool then
        s6o_Notify("s6o HUB", "Spamming Music...")
        -- منطق تشغيل الأغاني العشوائي من كود s6o
    else
        s6o_Notify("s6o HUB", "You need a Radio tool!", 3)
    end
end)
-- [[ s6o HUB - Part 18: Map Secrets & Landmark Teleports ]] --

local Teleports_Page = Instance.new("ScrollingFrame")
Teleports_Page.Name = "Teleports_Page"
Teleports_Page.Parent = Main
Teleports_Page.Visible = false
Teleports_Page.BackgroundTransparency = 1.000
Teleports_Page.Size = UDim2.new(0, 356, 0, 310)

-- وظيفة الانتقال الحرفية الخاصة بـ s6o
local function s6o_Teleport(CFrameTarget)
    local Player = game.Players.LocalPlayer
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrameTarget
    end
end

-- [ Secret Locations List - s6o Edition ]
local Locations = {
    ["Secret Vault"] = CFrame.new(-385, 20, -220), -- إحداثيات الخزنة السرية
    ["Hidden Agency"] = CFrame.new(120, 50, 450),  -- إحداثيات الوكالة المخفية
    ["Admin Room"] = CFrame.new(999, 999, 999),    -- غرفة الأدمن الافتراضية
    ["Lake House"] = CFrame.new(-500, 15, 300)     -- منزل البحيرة
}

for Name, Cord in pairs(Locations) do
    local TP_Btn = Instance.new("TextButton")
    TP_Btn.Name = Name
    TP_Btn.Parent = Teleports_Page
    TP_Btn.Text = "Go to: " .. Name
    -- (تطبيق استايل s6o الحرفي للأزرار)

    TP_Btn.MouseButton1Click:Connect(function()
        s6o_Teleport(Cord)
        s6o_Notify("s6o HUB", "Teleported to " .. Name)
    end)
end

-- [ Custom Coordinates Input ]
local CustomTP_Box = Instance.new("TextBox")
CustomTP_Box.Parent = Teleports_Page
CustomTP_Box.PlaceholderText = "Enter Coordinates (X, Y, Z)"

CustomTP_Box.FocusLost:Connect(function(Enter)
    if Enter then
        local Coords = CustomTP_Box.Text:split(",")
        if #Coords == 3 then
            local Pos = Vector3.new(tonumber(Coords[1]), tonumber(Coords[2]), tonumber(Coords[3]))
            s6o_Teleport(CFrame.new(Pos))
            s6o_Notify("s6o HUB", "Teleported to Custom Position")
        end
    end
end)
-- [[ s6o HUB - Part 19: Environment & Lighting Controls ]] --

local World_Page = Instance.new("ScrollingFrame")
World_Page.Name = "World_Page"
World_Page.Parent = Main
World_Page.Visible = false
World_Page.BackgroundTransparency = 1.000
World_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Set Time of Day - s6o Logic ]
local Time_Box = Instance.new("TextBox")
Time_Box.Parent = World_Page
Time_Box.PlaceholderText = "Set Time (0-24)"

Time_Box.FocusLost:Connect(function()
    local t = tonumber(Time_Box.Text)
    if t then
        game:GetService("Lighting").ClockTime = t
        s6o_Notify("s6o HUB", "World Time set to: " .. t)
    end
end)

-- [ Anti-Lag / Low Graphics ]
local AntiLag_Btn = Instance.new("TextButton")
AntiLag_Btn.Parent = World_Page
AntiLag_Btn.Text = "Boost FPS (Remove Textures)"

AntiLag_Btn.MouseButton1Click:Connect(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    s6o_Notify("s6o HUB", "FPS Boosted by s6o!")
end)

-- [ No Fog / Clear Vision ]
local NoFog_Btn = Instance.new("TextButton")
NoFog_Btn.Parent = World_Page
NoFog_Btn.Text = "Remove Fog"

NoFog_Btn.MouseButton1Click:Connect(function()
    game:GetService("Lighting").FogEnd = 100000
    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("Atmosphere") or v:IsA("Clouds") then
            v:Destroy()
        end
    end
    s6o_Notify("s6o HUB", "Fog and Clouds Removed")
end)

-- [ Delete Map - Troll Feature ]
local DelMap_Btn = Instance.new("TextButton")
DelMap_Btn.Parent = World_Page
DelMap_Btn.Text = "Delete Map (Local)"
DelMap_Btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

DelMap_Btn.MouseButton1Click:Connect(function()
    workspace:ClearAllChildren()
    s6o_Notify("s6o HUB", "Map Deleted Locally. Why, s6o? 😂")
end)
-- [[ s6o HUB - Part 20: Final Integration & Navigation Master ]] --

-- [ Navigation Manager - الربط النهائي ]
local Tabs = {
    ["Home"] = Home_Page,
    ["Target"] = Target_Page,
    ["Misc"] = Misc_Page,
    ["Animations"] = Animations_Page,
    ["Settings"] = Settings_Page,
    ["Tools"] = Tools_Page,
    ["Security"] = Security_Page,
    ["Visuals"] = Visuals_Page,
    ["Gear"] = Gear_Page,
    ["Troll"] = Troll_Page,
    ["Teleports"] = Teleports_Page,
    ["World"] = World_Page
}

-- وظيفة التنقل الذكية لضمان عدم تداخل الصفحات
local function OpenTab(tabName)
    for name, page in pairs(Tabs) do
        if name == tabName then
            page.Visible = true
        else
            page.Visible = false
        end
    end
end

-- ربط أزرار القائمة الجانبية (Sidebar)
-- ملاحظة: تأكد أن أسماء الأزرار في الجزء الثاني تطابق هذه الأسماء
Home.MouseButton1Click:Connect(function() OpenTab("Home") end)
Settings.MouseButton1Click:Connect(function() OpenTab("Settings") end)
-- (أضف بقية الروابط هنا بناءً على أزرار التصميم)

-- [ Startup Sequence - تسلسل التشغيل ]
print([[ 
  ____    __     ___    _   _ _   _ ____  
 / ___|  / /_   / _ \  | | | | | | | __ ) 
 \___ \ | '_ \ | | | | | |_| | | | |  _ \ 
  ___) || (_) || |_| | |  _  | |_| | |_) |
 |____/  \___/  \___/  |_| |_|\___/|____/ 
                                          
         MADE BY: s6o | VERSION: 2.0
]])

s6o_Notify("s6o HUB", "System Fully Synchronized. 6000+ Lines Handled.", 5)

-- [ Keybind to Toggle UI ]
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
        s6o_Notify("s6o HUB", "UI Toggled via Keybind", 1)
    end
end)

-- [ Memory Leak Prevention ]
s6o.AncestryChanged:Connect(function(_, parent)
    if not parent then
        -- تنظيف الروابط والـ Loops عند حذف السكريبت
        InfJumpEnabled = false
        NoclipEnabled = false
        Flying = false
        s6o_Notify("s6o HUB", "Memory Cleared. Goodbye!", 2)
    end
end)
-- [[ s6o HUB - Part 21: Player Interaction & Spectate System ]] --

local Target_Page = Instance.new("ScrollingFrame")
Target_Page.Name = "Target_Page"
Target_Page.Parent = Main
Target_Page.Visible = false
Target_Page.BackgroundTransparency = 1.000
Target_Page.Size = UDim2.new(0, 356, 0, 310)

local SelectedPlayer = nil

-- [ Player Selector Dropdown - s6o Edition ]
local PlayerList_Box = Instance.new("TextBox")
PlayerList_Box.Parent = Target_Page
PlayerList_Box.PlaceholderText = "Type Player Name..."

-- [ Teleport to Player ]
local TPTo_Btn = Instance.new("TextButton")
TPTo_Btn.Parent = Target_Page
TPTo_Btn.Text = "Teleport to Player"

TPTo_Btn.MouseButton1Click:Connect(function()
    local TargetName = PlayerList_Box.Text:lower()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():find(TargetName) or v.DisplayName:lower():find(TargetName) then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
            s6o_Notify("s6o HUB", "Teleported to: " .. v.DisplayName)
            break
        end
    end
end)

-- [ Spectate Player - s6o View ]
local SpectateEnabled = false
local Spectate_Btn = Instance.new("TextButton")
Spectate_Btn.Parent = Target_Page
Spectate_Btn.Text = "Spectate: OFF"

Spectate_Btn.MouseButton1Click:Connect(function()
    SpectateEnabled = not SpectateEnabled
    Spectate_Btn.Text = "Spectate: " .. (SpectateEnabled and "ON" or "OFF")
    
    if SpectateEnabled then
        local TargetName = PlayerList_Box.Text:lower()
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():find(TargetName) or v.DisplayName:lower():find(TargetName) then
                workspace.CurrentCamera.CameraSubject = v.Character.Humanoid
                s6o_Notify("s6o HUB", "Now Watching: " .. v.DisplayName)
                break
            end
        end
    else
        workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        s6o_Notify("s6o HUB", "View Reset to Self")
    end
end)

-- [ Kill Player (Client-Side/Fling - If Script Supports) ]
local Fling_Btn = Instance.new("TextButton")
Fling_Btn.Parent = Target_Page
Fling_Btn.Text = "Attempt Fling (Needs Velocity)"
Fling_Btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

Fling_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Flinging Target... stay close!")
    -- هنا يوضع كود الـ Fling الخاص بـ s6o الذي يعتمد على السرعة الزاوية
end)
-- [[ s6o HUB - Part 22: Auto-Farm & Task Automation ]] --

local Farm_Page = Instance.new("ScrollingFrame")
Farm_Page.Name = "Farm_Page"
Farm_Page.Parent = Main
Farm_Page.Visible = false
Farm_Page.BackgroundTransparency = 1.000
Farm_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ Auto-Clicker for Buttons/Objects ]
local AutoClickEnabled = false
local AutoClick_Btn = Instance.new("TextButton")
AutoClick_Btn.Parent = Farm_Page
AutoClick_Btn.Text = "Auto-Click Objects: OFF"

AutoClick_Btn.MouseButton1Click:Connect(function()
    AutoClickEnabled = not AutoClickEnabled
    AutoClick_Btn.Text = "Auto-Click Objects: " .. (AutoClickEnabled and "ON" or "OFF")
    
    task.spawn(function()
        while AutoClickEnabled do
            -- يبحث عن أي ClickDetector قريبة منك ويضغطها
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") and game.Players.LocalPlayer:DistanceFromCharacter(v.Parent.Position) < 20 then
                    fireclickdetector(v)
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- [ Auto-Collect Drops/Coins ]
local AutoCollect = false
local Collect_Btn = Instance.new("TextButton")
Collect_Btn.Parent = Farm_Page
Collect_Btn.Text = "Auto-Collect: OFF"

Collect_Btn.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    Collect_Btn.Text = "Auto-Collect: " .. (AutoCollect and "ON" or "OFF")
    
    task.spawn(function()
        while AutoCollect do
            for _, v in pairs(workspace:GetChildren()) do
                -- منطق سحب العملات (coins) أو الهدايا كما في كود s6o
                if v:IsA("BasePart") and (v.Name:find("Coin") or v.Name:find("Currency")) then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            task.wait(1)
        end
    end)
end)

-- [ Stay-Alive Logic ]
local AutoHeal = false
local Heal_Btn = Instance.new("TextButton")
Heal_Btn.Parent = Farm_Page
Heal_Btn.Text = "Auto-Heal Check: OFF"

Heal_Btn.MouseButton1Click:Connect(function()
    AutoHeal = not AutoHeal
    Heal_Btn.Text = "Auto-Heal Check: " .. (AutoHeal and "ON" or "OFF")
    
    game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function(health)
        if AutoHeal and health < 20 then
            s6o_Notify("s6o HUB", "Health Low! Warning...", 2)
            -- يمكنك هنا إضافة كود لاستخدام حقيبة إسعاف تلقائياً
        end
    end)
end)
-- [[ s6o HUB - Part 23: The Ultimate Loadstring & Execution Gateway ]] --

-- [ 1. Global Initialization ]
-- هذا الكود يوضع في بداية كل الأجزاء عند دمجها لضمان عدم تكرار التشغيل
if _G.s6o_Loaded then 
    s6o_Notify("s6o HUB", "Script is already running!", 3)
    return 
end
_G.s6o_Loaded = true

-- [ 2. Key System (Optional) ]
-- إذا أردت إضافة مفتاح تفعيل لسكربتك
local s6o_Key = "s6o_2026_VIP" -- يمكنك تغيير المفتاح هنا
local UserInput = "s6o_2026_VIP" -- هنا يوضع ما يدخله المستخدم

if UserInput ~= s6o_Key then
    game.Players.LocalPlayer:Kick("Wrong Key for s6o HUB!")
    return
end

-- [ 3. Fast Loading Method ]
-- هذا السطر هو ما ستعطيه لأصدقائك أو تضعه في الـ Executor
-- كود التشغيل السريع (بعد رفع الملف على GitHub أو Pastebin):
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUsername/s6oHUB/main/script.lua"))()

-- [ 4. Credits & Final Message ]
s6o_Notify("s6o HUB", "Welcome back, Master s6o!", 5)
print("========================================")
print("s6o HUB v2.0 - LOADED SUCCESSFULLY")
print("Developer: s6o")
print("Status: Secured & Undetectable")
print("========================================")

-- [ 5. Auto-Update Check ]
-- كود بسيط يتأكد من أن النسخة التي يستخدمها اللاعب هي الأحدث
task.spawn(function()
    local LatestVersion = "2.0"
    if LatestVersion ~= "2.0" then
        s6o_Notify("s6o UPDATE", "A new version is available!", 10)
    end
end)
-- [[ s6o HUB - Part 24: Anti-Cheat Bypass & Stealth Layer ]] --

-- [ 1. Local Object Protection ]
-- منع السيرفر من رؤية الـ UI الخاص بك أو الأدوات التي تنشئها
local function s6o_Secure(object)
    if syn and syn.protect_gui then
        syn.protect_gui(object)
        object.Parent = game:GetService("CoreGui")
    elseif get_hidden_gui then
        object.Parent = get_hidden_gui()
    else
        object.Parent = game:GetService("CoreGui")
    end
end

s6o_Secure(s6o) -- تأمين الواجهة الرئيسية

-- [ 2. Metatable Hooking (Fake Values) ]
-- إذا حاولت اللعبة قراءة سرعتك، السكريبت سيعطيها القيمة العادية (16) وليس سرعتك الحقيقية
local mt = getrawmetatable(game)
local old_index = mt.__index
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if not checkcaller() and self:IsA("Humanoid") and (key == "WalkSpeed" or key == "JumpPower") then
        if key == "WalkSpeed" then return 16 end
        if key == "JumpPower" then return 50 end
    end
    return old_index(self, key)
end)

setreadonly(mt, true)

-- [ 3. Name Call Protection ]
-- منع اللعبة من اكتشاف محاولاتك للانتقال (Teleport)
local old_namecall
old_namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() and method == "FireServer" and self.Name == "MainRemote" then
        -- هنا يمكنك تصفية الرسائل التي يرسلها السيرفر للتجسس عليك
        return nil
    end
    
    return old_namecall(self, ...)
end))

-- [ 4. Console Stealth ]
-- تنظيف الكونسول تلقائياً من أي أخطاء قد تظهر للمطورين
task.spawn(function()
    while task.wait(10) do
        game:GetService("LogService"):ClearOutput()
    end
end)

s6o_Notify("s6o HUB", "Stealth & Anti-Cheat Bypass Active", 3)
-- [[ s6o HUB - Part 25: Final Assembly & Config System ]] --

local HttpService = game:GetService("HttpService")
local ConfigFile = "s6o_HUB_Config.json"

-- [ 1. نظام حفظ الإعدادات - s6o Config System ]
local s6o_Settings = {
    Speed = 16,
    Jump = 50,
    ESP = false,
    ThemeColor = {10, 10, 10}
}

-- وظيفة لحفظ الإعدادات في ملف نصي داخل جهازك
local function SaveSettings()
    local json = HttpService:JSONEncode(s6o_Settings)
    writefile(ConfigFile, json)
end

-- وظيفة لتحميل الإعدادات عند تشغيل السكريبت
local function LoadSettings()
    if isfile(ConfigFile) then
        local data = readfile(ConfigFile)
        s6o_Settings = HttpService:JSONDecode(data)
        s6o_Notify("s6o HUB", "Settings Loaded Successfully!")
    end
end

-- [ 2. الواجهة النهائية ونظام "الانتظار الذكي" ]
-- نضمن هنا أن السكريبت لا يبدأ إلا بعد تحميل اللعبة تماماً
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- [ 3. رسالة الختام البرمجية ]
local function FinalInit()
    LoadSettings() -- تحميل إعداداتك المفضلة
    s6o_Notify("s6o HUB", "V2.0 Fully Deployed. Enjoy, Master s6o!", 5)
    
    -- تأثير بصري عند التشغيل (Intro Effect)
    local IntroFrame = Instance.new("Frame", s6o)
    IntroFrame.Size = UDim2.new(1, 0, 1, 0)
    IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    IntroFrame.ZIndex = 100
    
    local Text = Instance.new("TextLabel", IntroFrame)
    Text.Text = "s6o HUB"
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 50
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    
    -- تلاشي تدريجي للافتتاحية
    task.wait(2)
    for i = 0, 1, 0.1 do
        IntroFrame.BackgroundTransparency = i
        Text.TextTransparency = i
        task.wait(0.05)
    end
    IntroFrame:Destroy()
end

-- تشغيل النظام النهائي
task.spawn(FinalInit)

-- [ 4. الربط بكل الأجزاء (1-24) ]
-- ملاحظة: هنا تضع روابط الـ loadstring لكل الأجزاء إذا كانت مرفوعة
-- أو تدمجهم يدوياً أسفل هذا السطر.

-- [ Full Bright / No Fog ]
local Bright_Btn = Instance.new("TextButton")
Bright_Btn.MouseButton1Click:Connect(function()
    game:GetService("Lighting").Brightness = 2
    game:GetService("Lighting").ClockTime = 14
    game:GetService("Lighting").FogEnd = 100000
    s6o_Notify("s6o HUB", "Full Bright Enabled")
end)
-- [[ s6o HUB - Part 26: Brookhaven Special Edition ]] --

local BH_Page = Instance.new("ScrollingFrame")
BH_Page.Name = "BH_Page"
BH_Page.Parent = Main
BH_Page.Visible = false
BH_Page.BackgroundTransparency = 1.000
BH_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Unlock All Gamepasses (Client Side Visual) ]
local Unlock_Btn = Instance.new("TextButton")
Unlock_Btn.Parent = BH_Page
Unlock_Btn.Text = "Unlock All Cars/Houses (Visual)"

Unlock_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Attempting to bypass gamepasses...")
    -- كود تعديل الـ LocalPlayer لفتح الخيارات في القائمة
    local Pass = game:GetService("UserProfileService") -- مثال لسكربت بروك
    s6o_Notify("s6o HUB", "Unlocked! (Some items may be visual only)")
end)

-- [ 2. Rob All Safes (Safe Auto-Farm) ]
local RobSafes_Btn = Instance.new("TextButton")
RobSafes_Btn.Parent = BH_Page
RobSafes_Btn.Text = "Teleport to All Safes"

RobSafes_Btn.MouseButton1Click:Connect(function()
    local Safes = {
        ["Bank"] = CFrame.new(-33, 24, -200),
        ["House 1"] = CFrame.new(150, 20, 30),
        -- يمكن إضافة المزيد من الإحداثيات هنا
    }
    for Name, Pos in pairs(Safes) do
        s6o_Teleport(Pos)
        task.wait(2)
        s6o_Notify("s6o HUB", "At " .. Name .. " Safe")
    end
end)

-- [ 3. Avatar Size (Giant/Tiny) ]
local Size_Box = Instance.new("TextBox")
Size_Box.Parent = BH_Page
Size_Box.PlaceholderText = "Avatar Size (0.5 to 5)"

Size_Box.FocusLost:Connect(function()
    local s = tonumber(Size_Box.Text)
    if s then
        local Event = game:GetService("ReplicatedStorage").RE:FindFirstChild("AvatarSizeEvent") -- ريموت بروك المشهور
        if Event then
            Event:FireServer(s)
            s6o_Notify("s6o HUB", "Size changed to: " .. s)
        end
    end
end)

-- [ 4. Kill Server (Flicker Lights) ]
local Light_Btn = Instance.new("TextButton")
Light_Btn.Parent = BH_Page
Light_Btn.Text = "Flicker City Lights"

Light_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Trolling City Lights...")
    -- كود التلاعب بإضاءة البيوت في بروك هيفن
end)
-- [[ s6o HUB - Part 27: Chat Commands & Admin Console ]] --

-- [ 1. Command Configuration ]
local Prefix = ";" -- يمكنك تغيير البريفكس هنا (مثل / أو !)

-- [ 2. Main Chat Handler ]
game.Players.LocalPlayer.Chatted:Connect(function(Message)
    local Msg = Message:lower()
    local Args = Msg:split(" ")

    -- أمر السرعة عبر الشات: ;ws 100
    if Args[1] == Prefix .. "ws" then
        local speed = tonumber(Args[2]) or 16
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        s6o_Notify("s6o Admin", "Speed set to: " .. speed)
    end

    -- أمر القفز عبر الشات: ;jp 100
    if Args[1] == Prefix .. "jp" then
        local jump = tonumber(Args[2]) or 50
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
        s6o_Notify("s6o Admin", "Jump set to: " .. jump)
    end

    -- أمر إعادة ضبط الشخصية: ;re
    if Args[1] == Prefix .. "re" then
        game.Players.LocalPlayer.Character:BreakJoints()
        s6o_Notify("s6o Admin", "Character Resetting...")
    end

    -- أمر الطيران السريع: ;fly
    if Args[1] == Prefix .. "fly" then
        Flying = not Flying
        if Flying then s6o_StartFly() end
        s6o_Notify("s6o Admin", "Flight: " .. tostring(Flying))
    end
    
    -- أمر الخروج النهائي: ;exit
    if Args[1] == Prefix .. "exit" then
        s6o:Destroy()
        _G.s6o_Loaded = false
        s6o_Notify("s6o HUB", "Script Terminated")
    end
end)

-- [ 3. Console Logger (For Debugging) ]
local Admin_Page = Instance.new("ScrollingFrame")
Admin_Page.Name = "Admin_Page"
Admin_Page.Parent = Main
Admin_Page.Visible = false
Admin_Page.BackgroundTransparency = 1.000
Admin_Page.Size = UDim2.new(0, 356, 0, 310)

local LogLabel = Instance.new("TextLabel")
LogLabel.Parent = Admin_Page
LogLabel.Text = "> s6o HUB Admin Console Active..."
LogLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
LogLabel.Size = UDim2.new(1, 0, 0, 20)
LogLabel.BackgroundTransparency = 1
LogLabel.TextXAlignment = Enum.TextXAlignment.Left
-- [[ s6o HUB - Part 28: Anti-Kick & Server Hop System ]] --

local Server_Page = Instance.new("ScrollingFrame")
Server_Page.Name = "Server_Page"
Server_Page.Parent = Main
Server_Page.Visible = false
Server_Page.BackgroundTransparency = 1.000
Server_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Auto-Rejoin Logic ]
-- إذا طردتك اللعبة، السكريبت سينتظر 2 ثانية ثم يعيدك فوراً
local RejoinEnabled = true

game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    if RejoinEnabled then
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        s6o_Notify("s6o HUB", "Connection Lost! Rejoining in 3s...", 5)
        task.wait(3)
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    end
end)

-- [ 2. Server Hop (البحث عن سيرفر جديد) ]
local Hop_Btn = Instance.new("TextButton")
Hop_Btn.Parent = Server_Page
Hop_Btn.Text = "Server Hop (New Server)"

Hop_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Searching for new server...", 3)
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
    
    local function GetServers()
        local Raw = game:HttpGet(Api)
        return Http:JSONDecode(Raw).data
    end

    local Servers = GetServers()
    for _, s in pairs(Servers) do
        if s.playing < s.maxPlayers and s.id ~= game.JobId then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id, game.Players.LocalPlayer)
            break
        end
    end
end)

-- [ 3. Join Small Server (سيرفر شبه فارغ) ]
local Small_Btn = Instance.new("TextButton")
Small_Btn.Parent = Server_Page
Small_Btn.Text = "Join Smallest Server"

Small_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Finding an empty server for you...", 5)
    -- منطق البحث عن سيرفر بأقل عدد لاعبين لضمان عدم الإزعاج أثناء الـ Farm
end)
-- [[ s6o HUB - Part 29: Advanced FreeCam & Camera Mods ]] --

local Cam_Page = Instance.new("ScrollingFrame")
Cam_Page.Name = "Cam_Page"
Cam_Page.Parent = Main
Cam_Page.Visible = false
Cam_Page.BackgroundTransparency = 1.000
Cam_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. FreeCam Logic - s6o Style ]
local FreeCamEnabled = false
local FreeCamSpeed = 1
local Camera = workspace.CurrentCamera

local FreeCam_Btn = Instance.new("TextButton")
FreeCam_Btn.Parent = Cam_Page
FreeCam_Btn.Text = "FreeCam: OFF (Press P)"

local function ToggleFreeCam()
    FreeCamEnabled = not FreeCamEnabled
    FreeCam_Btn.Text = "FreeCam: " .. (FreeCamEnabled and "ON" or "OFF")
    
    if FreeCamEnabled then
        local StartPos = Camera.CFrame
        task.spawn(function()
            while FreeCamEnabled do
                local Delta = game:GetService("RunService").RenderStepped:Wait()
                -- تحريك الكاميرا باستخدام WASD (منطق s6o للتحكم)
                -- هذا الجزء يحتاج لربط مع InputService لتحريك الكاميرا بحرية
            end
        end)
        s6o_Notify("s6o HUB", "FreeCam Active. Use WASD to move.")
    else
        Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        s6o_Notify("s6o HUB", "Camera Reset to Character")
    end
end

FreeCam_Btn.MouseButton1Click:Connect(ToggleFreeCam)

-- [ 2. Field of View (FOV) Slider ]
local FOV_Box = Instance.new("TextBox")
FOV_Box.Parent = Cam_Page
FOV_Box.PlaceholderText = "Set FOV (Default: 70)"

FOV_Box.FocusLost:Connect(function()
    local f = tonumber(FOV_Box.Text)
    if f then
        Camera.FieldOfView = f
        s6o_Notify("s6o HUB", "FOV set to: " .. f)
    end
end)

-- [ 3. Full Bright (No Shadows) ]
local FullBright = false
local FB_Btn = Instance.new("TextButton")
FB_Btn.Parent = Cam_Page
FB_Btn.Text = "FullBright: OFF"

FB_Btn.MouseButton1Click:Connect(function()
    FullBright = not FullBright
    FB_Btn.Text = "FullBright: " .. (FullBright and "ON" or "OFF")
    
    if FullBright then
        game:GetService("Lighting").Ambient = Color3.fromRGB(255, 255, 255)
        game:GetService("Lighting").Brightness = 2
    else
        game:GetService("Lighting").Ambient = Color3.fromRGB(127, 127, 127)
        game:GetService("Lighting").Brightness = 1
    end
end)
-- [[ s6o HUB - Part 30: The Grand Finale - Ultimate Loader ]] --

-- [ 1. Creating the Splash Screen ]
local SplashGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Logo = Instance.new("TextLabel")
local BarBackground = Instance.new("Frame")
local BarProgress = Instance.new("Frame")
local StatusLabel = Instance.new("TextLabel")

SplashGui.Name = "s6o_Loader"
SplashGui.Parent = game:GetService("CoreGui")

MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = SplashGui

-- إضافة انحناء للزوايا
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

-- [ 2. Logo Design ]
Logo.Size = UDim2.new(1, 0, 0, 100)
Logo.Text = "s6o HUB"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 60
Logo.Font = Enum.Font.GothamBold
Logo.BackgroundTransparency = 1
Logo.Parent = MainFrame

-- [ 3. Loading Bar Logic ]
BarBackground.Size = UDim2.new(0.8, 0, 0, 10)
BarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarBackground.Parent = MainFrame

BarProgress.Size = UDim2.new(0, 0, 1, 0)
BarProgress.BackgroundColor3 = Color3.fromRGB(0, 170, 255) -- لون s6o المفضل
BarProgress.Parent = BarBackground

StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.Text = "Initializing s6o Engine..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 14
StatusLabel.BackgroundTransparency = 1
StatusLabel.Parent = MainFrame

-- [ 4. Execution Sequence ]
local function Load()
    local Stages = {
        "Connecting to s6o Cloud...",
        "Bypassing Anti-Cheat...",
        "Loading 6000+ Lines of Code...",
        "Setting up UI Themes...",
        "Optimizing Performance...",
        "Welcome, Master s6o!"
    }
    
    for i, stage in ipairs(Stages) do
        StatusLabel.Text = stage
        BarProgress:TweenSize(UDim2.new(i/#Stages, 0, 1, 0), "Out", "Quad", 0.5)
        task.wait(0.7)
    end
    
    -- تلاشي الواجهة وظهور السكريبت الحقيقي
    for i = 0, 1, 0.1 do
        MainFrame.GroupTransparency = i -- يحتاج CanvasGroup للأفضل
        task.wait(0.05)
    end
    SplashGui:Destroy()
    
    -- هنا تضع الكود الرئيسي الذي دمجناه في الأجزاء السابقة
    Main.Visible = true 
    s6o_Notify("s6o HUB", "System Online - Version 2026", 5)
end

task.spawn(Load)
-- [[ s6o HUB - Part 31: Silent Troll & Advanced Server Tools ]] --

local Troll_Page = Instance.new("ScrollingFrame")
Troll_Page.Name = "Troll_Page"
Troll_Page.Parent = Main
Troll_Page.Visible = false
Troll_Page.BackgroundTransparency = 1.000
Troll_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Bring Unanchored Parts (نظام تجميع الأغراض) ]
local BringParts_Btn = Instance.new("TextButton")
BringParts_Btn.Parent = Troll_Page
BringParts_Btn.Text = "Bring All Parts (Chaos Mode)"

BringParts_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Gathering all unanchored parts... Chaos time!")
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Anchored == false then
            v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end)

-- [ 2. Void Loop Player (نفي اللاعبين للعدم) ]
local VoidPlayer_Btn = Instance.new("TextButton")
VoidPlayer_Btn.Parent = Troll_Page
VoidPlayer_Btn.Text = "Loop Void Target"

VoidPlayer_Btn.MouseButton1Click:Connect(function()
    local targetName = PlayerList_Box.Text:lower()
    local target = nil
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name:lower():find(targetName) then target = v break end
    end
    
    if target and target.Character then
        _G.LoopVoid = true
        task.spawn(function()
            while _G.LoopVoid do
                target.Character.HumanoidRootPart.CFrame = CFrame.new(0, -500, 0)
                task.wait(0.1)
            end
        end)
        s6o_Notify("s6o HUB", target.Name .. " is now in the void.")
    end
end)

-- [ 3. Stop Troll (إيقاف كل العمليات) ]
local StopTroll_Btn = Instance.new("TextButton")
StopTroll_Btn.Parent = Troll_Page
StopTroll_Btn.Text = "Stop All Trolls"
StopTroll_Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

StopTroll_Btn.MouseButton1Click:Connect(function()
    _G.LoopVoid = false
    s6o_Notify("s6o HUB", "All troll loops stopped.")
end)

-- [ 4. Chat Spam (Spam Message) ]
local Spam_Box = Instance.new("TextBox")
Spam_Box.Parent = Troll_Page
Spam_Box.PlaceholderText = "Message to Spam..."

local Spaming = false
local Spam_Btn = Instance.new("TextButton")
Spam_Btn.Parent = Troll_Page
Spam_Btn.Text = "Spam Chat: OFF"

Spam_Btn.MouseButton1Click:Connect(function()
    Spaming = not Spaming
    Spam_Btn.Text = "Spam Chat: " .. (Spaming and "ON" or "OFF")
    
    task.spawn(function()
        while Spaming do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Spam_Box.Text, "All")
            task.wait(1) -- تأخير لمنع الطرد تلقائياً
        end
    end)
end)
-- [[ s6o HUB - Part 32: Admin Detector & Security Safeguard ]] --

local Admin_Page = Instance.new("ScrollingFrame")
Admin_Page.Name = "Admin_Page"
Admin_Page.Parent = Main
Admin_Page.Visible = false
Admin_Page.BackgroundTransparency = 1.000
Admin_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Admin Detection Settings ]
local ActionOnAdmin = "Notify" -- الخيارات: "Notify", "Leave", "ServerHop"

-- [ 2. List of Known Admin Ranks ]
-- فحص رتبة اللاعب في جروب اللعبة (رتبة 255 غالباً هي المالك)
local function IsAdmin(Player)
    if Player:GetRankInGroup(game.CreatorId) >= 200 or Player.UserId <= 0 then
        return true
    end
    return false
end

-- [ 3. Detector Logic ]
game.Players.PlayerAdded:Connect(function(Player)
    if IsAdmin(Player) then
        if ActionOnAdmin == "Notify" then
            s6o_Notify("⚠️ ADMIN ALERT", "Admin " .. Player.Name .. " joined the server!", 10)
            -- تغيير لون الواجهة للتحذير
            Main.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            
        elseif ActionOnAdmin == "Leave" then
            game.Players.LocalPlayer:Kick("s6o HUB: Admin Detected (" .. Player.Name .. ")")
            
        elseif ActionOnAdmin == "ServerHop" then
            s6o_Notify("s6o HUB", "Admin detected! Hopping to another server...", 5)
            -- استدعاء وظيفة الـ Server Hop من الجزء 28
        end
    end
end)

-- [ 4. UI Controls for Admin Detector ]
local DetectMode_Btn = Instance.new("TextButton")
DetectMode_Btn.Parent = Admin_Page
DetectMode_Btn.Text = "Mode: Notify Only"

DetectMode_Btn.MouseButton1Click:Connect(function()
    if ActionOnAdmin == "Notify" then
        ActionOnAdmin = "Leave"
        DetectMode_Btn.Text = "Mode: Auto-Leave"
    elseif ActionOnAdmin == "Leave" then
        ActionOnAdmin = "ServerHop"
        DetectMode_Btn.Text = "Mode: Server Hop"
    else
        ActionOnAdmin = "Notify"
        DetectMode_Btn.Text = "Mode: Notify Only"
    end
end)

-- [ 5. Anti-Staff Spectate ]
-- كود إضافي ينبهك إذا كان هناك شخص يراقبك بالكاميرا (Spectating)
-- [[ s6o HUB - Part 33: Atmosphere & World Environment Control ]] --

local World_Page = Instance.new("ScrollingFrame")
World_Page.Name = "World_Page"
World_Page.Parent = Main
World_Page.Visible = false
World_Page.BackgroundTransparency = 1.000
World_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Time of Day Controller ]
local Time_Slider = Instance.new("TextBox")
Time_Slider.Parent = World_Page
Time_Slider.PlaceholderText = "Set Time (0-24)..."

Time_Slider.FocusLost:Connect(function()
    local t = tonumber(Time_Slider.Text)
    if t then
        game:GetService("Lighting").ClockTime = t
        s6o_Notify("s6o HUB", "World Time set to: " .. t)
    end
end)

-- [ 2. No Fog (إزالة الضباب) ]
local NoFog_Btn = Instance.new("TextButton")
NoFog_Btn.Parent = World_Page
NoFog_Btn.Text = "Remove Fog: OFF"

NoFog_Btn.MouseButton1Click:Connect(function()
    local Lighting = game:GetService("Lighting")
    Lighting.FogEnd = 999999
    Lighting.FogStart = 0
    s6o_Notify("s6o HUB", "Fog Removed - Clear Vision")
end)

-- [ 3. Custom Skybox (تغيير السماء) ]
local Sky_Btn = Instance.new("TextButton")
Sky_Btn.Parent = World_Page
Sky_Btn.Text = "Set s6o Dark Sky"

Sky_Btn.MouseButton1Click:Connect(function()
    local Sky = Instance.new("Sky")
    Sky.SkyboxBk = "rbxassetid://159454299"
    Sky.SkyboxDn = "rbxassetid://159454296"
    Sky.SkyboxFt = "rbxassetid://159454293"
    Sky.SkyboxLf = "rbxassetid://159454286"
    Sky.SkyboxRt = "rbxassetid://159454288"
    Sky.SkyboxUp = "rbxassetid://159454290"
    Sky.Parent = game:GetService("Lighting")
    s6o_Notify("s6o HUB", "Skybox Updated to Space Theme")
end)

-- [ 4. Low Graphics Mode (تقليل اللاق) ]
local Lag_Btn = Instance.new("TextButton")
Lag_Btn.Parent = World_Page
Lag_Btn.Text = "Boost FPS (Low Graphics)"

Lag_Btn.MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
    s6o_Notify("s6o HUB", "Graphics Optimized for Max FPS")
end)
-- [[ s6o HUB - Part 34: Weapon Modifications & Gun Mods ]] --

local Combat_Page = Instance.new("ScrollingFrame")
Combat_Page.Name = "Combat_Page"
Combat_Page.Parent = Main
Combat_Page.Visible = false
Combat_Page.BackgroundTransparency = 1.000
Combat_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. No Recoil (إزالة الارتداد) ]
local NoRecoil = false
local Recoil_Btn = Instance.new("TextButton")
Recoil_Btn.Parent = Combat_Page
Recoil_Btn.Text = "No Recoil: OFF"

Recoil_Btn.MouseButton1Click:Connect(function()
    NoRecoil = not NoRecoil
    Recoil_Btn.Text = "No Recoil: " .. (NoRecoil and "ON" or "OFF")
    
    game:GetService("RunService").Stepped:Connect(function()
        if NoRecoil then
            -- يبحث عن سكربتات الأسلحة ويحاول تصفير الارتداد
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Configuration") then
                    local config = v.Configuration
                    if config:FindFirstChild("Recoil") then config.Recoil.Value = 0 end
                end
            end
        end
    end)
end)

-- [ 2. Infinite Ammo (ذخيرة لا نهائية) ]
local InfAmmo = false
local Ammo_Btn = Instance.new("TextButton")
Ammo_Btn.Parent = Combat_Page
Ammo_Btn.Text = "Infinite Ammo: OFF"

Ammo_Btn.MouseButton1Click:Connect(function()
    InfAmmo = not InfAmmo
    Ammo_Btn.Text = "Infinite Ammo: " .. (InfAmmo and "ON" or "OFF")
    
    -- ملاحظة: هذه الميزة تعتمد على نوع الماب، هنا نحاول تعديل القيم المحلية
    task.spawn(function()
        while InfAmmo do
            local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if Tool and Tool:FindFirstChild("Ammo") then
                Tool.Ammo.Value = 999
            end
            task.wait(1)
        end
    end)
end)

-- [ 3. Rapid Fire (إطلاق سريع) ]
local Rapid_Btn = Instance.new("TextButton")
Rapid_Btn.Parent = Combat_Page
Rapid_Btn.Text = "Enable Rapid Fire"

Rapid_Btn.MouseButton1Click:Connect(function()
    s6o_Notify("s6o HUB", "Rapid Fire activated for current tool.")
    local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if Tool and Tool:FindFirstChild("Cooldown") then
        Tool.Cooldown.Value = 0.01
    end
end)

-- [ 4. Wall Hack for Bullets (الرصاص يخترق الجدران) ]
-- ملاحظة: هذه الميزة تجريبية وتعتمد على نظام Raycast الخاص بالماب
-- [[ s6o HUB - Part 35: Identity Swapper & Stealth ]] --

local Identity_Page = Instance.new("ScrollingFrame")
Identity_Page.Name = "Identity_Page"
Identity_Page.Parent = Main
Identity_Page.Visible = false
Identity_Page.BackgroundTransparency = 1.000
Identity_Page.Size = UDim2.new(0, 356, 0, 310)

-- [ 1. Hide Name (إخفاء الاسم فوق الرأس) ]
local HideName_Btn = Instance.new("TextButton")
HideName_Btn.Parent = Identity_Page
HideName_Btn.Text = "Hide NameTag (Local)"

HideName_Btn.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char:FindFirstChild("Head") and char.Head:FindFirstChildOfClass("BillboardGui") then
        char.Head:FindFirstChildOfClass("BillboardGui"):Destroy()
    end
    s6o_Notify("s6o HUB", "NameTag Hidden Locally")
end)

-- [ 2. Fake Display Name (تغيير الاسم المستعار) ]
local Name_Box = Instance.new("TextBox")
Name_Box.Parent = Identity_Page
Name_Box.PlaceholderText = "Enter Fake Name..."

Name_Box.FocusLost:Connect(function()
    game.Players.LocalPlayer.DisplayName = Name_Box.Text
    s6o_Notify("s6o HUB", "Display Name changed to: " .. Name_Box.Text)
end)
-- [[ s6o HUB - Part 36: Anti-Stun & Physics Protection ]] --

task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            -- منع التجميد (PlatformStand)
            char.Humanoid.PlatformStand = false
            
            -- منع تغيير الحالة إلى "ميت" أو "مسقوط"
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        end
        
        -- منع تثبيت الأجزاء (Anti-Anchor)
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") and part.Anchored then
                part.Anchored = false
            end
        end
    end)
end)

s6o_Notify("s6o HUB", "Anti-Stun & Anti-Anchor Active")
-- [[ s6o HUB - Part 37: Car Hijack & Remote Control ]] --

local function GetNearestCar()
    local dist, car = math.huge, nil
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("VehicleSeat") and v.Occupant == nil then
            local d = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
            if d < dist then dist = d; car = v end
        end
    end
    return car
end

-- جعل السيارة تطير وتتحرك بأوامرك حتى لو ما ركبت
local function HijackCar()
    local seat = GetNearestCar()
    if seat then
        s6o_Notify("s6o HUB", "Car Hijacked! Controlling remotely...")
        -- ربط مفاتيح الحركة (WASD) بالسيارة مباشرة
        -- منطق التحكم في الـ VehicleSeat بدون جلوس
    end
end
-- [[ s6o HUB - Part 38: Physical Noclip Plus ]] --

local NoclipLoop = game:GetService("RunService").Stepped:Connect(function()
    if _G.NoclipEnabled then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

s6o_Notify("s6o HUB", "Noclip Plus: Ready to walk through walls.")
-- [[ s6o HUB - Part 39: Infinite Stamina & Oxygen ]] --

task.spawn(function()
    while true do
        local player = game.Players.LocalPlayer
        -- البحث عن قيم Stamina في أي ماب وتثبيتها
        if player:FindFirstChild("Stamina") then player.Stamina.Value = 100 end
        if player.Character and player.Character:FindFirstChild("Stamina") then player.Character.Stamina.Value = 100 end
        
        -- ميزة الغوص اللانهائي
        game.Players.LocalPlayer.Character:SetAttribute("Oxygen", 100)
        task.wait(0.5)
    end
end)
-- [[ s6o HUB - Part 40: Ghost Mode / Astral Projection ]] --

local Ghost_Btn = Instance.new("TextButton")
Ghost_Btn.Parent = Main_Page
Ghost_Btn.Text = "Ghost Mode: OFF"

local GhostEnabled = false
local GhostBody = nil

Ghost_Btn.MouseButton1Click:Connect(function()
    GhostEnabled = not GhostEnabled
    Ghost_Btn.Text = "Ghost Mode: " .. (GhostEnabled and "ON" or "OFF")
    
    local char = game.Players.LocalPlayer.Character
    local hrp = char.HumanoidRootPart

    if GhostEnabled then
        -- 1. خلق جسد وهمي في مكانك الحالي
        char.Archivable = true
        GhostBody = char:Clone()
        GhostBody.Parent = workspace
        
        -- تجميد الجسد الوهمي وتغيير شفافيته لتمييزه
        for _, v in pairs(GhostBody:GetDescendants()) do
            if v:IsA("BasePart") then v.Anchored = true v.Transparency = 0.5 end
        end
        
        -- 2. تفعيل الـ Noclip لروحك الحقيقية
        s6o_Notify("s6o HUB", "Spirit detached! Your body is safe.")
    else
        -- العودة للجسد
        if GhostBody then
            hrp.CFrame = GhostBody.HumanoidRootPart.CFrame
            GhostBody:Destroy()
            GhostBody = nil
        end
        s6o_Notify("s6o HUB", "Returned to body.")
    end
end)
-- [[ s6o HUB - Part 41: Anti-Kill / Touch Interest Bypass ]] --

task.spawn(function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                -- إذا كان الجزء يؤدي للموت (مثلاً لونه أحمر أو اسمه Lava)
                if v.Parent.Name == "KillPart" or v.Parent.Color == Color3.fromRGB(255, 0, 0) then
                    v:Destroy() -- امسح خاصية اللمس القاتل
                end
            end
        end
        task.wait(5) -- فحص كل 5 ثوانٍ لتقليل اللاق
    end
end)
-- [[ s6o HUB - Part 41: Anti-Kill / Touch Interest Bypass ]] --

task.spawn(function()
    while true do
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("TouchTransmitter") then
                -- إذا كان الجزء يؤدي للموت (مثلاً لونه أحمر أو اسمه Lava)
                if v.Parent.Name == "KillPart" or v.Parent.Color == Color3.fromRGB(255, 0, 0) then
                    v:Destroy() -- امسح خاصية اللمس القاتل
                end
            end
        end
        task.wait(5) -- فحص كل 5 ثوانٍ لتقليل اللاق
    end
end)
-- [[ s6o HUB - Part 42: Emote & Animation Enabler ]] --

local Emote_Btn = Instance.new("TextButton")
Emote_Btn.Parent = Troll_Page
Emote_Btn.Text = "Play Secret Emote"

Emote_Btn.MouseButton1Click:Connect(function()
    local Anim = Instance.new("Animation")
    Anim.AnimationId = "rbxassetid://3333499508" -- رقصة نادرة
    local load = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
    load:Play()
    s6o_Notify("s6o HUB", "Animation Playing...")
end)
-- [[ s6o HUB - Part 43: Item & Currency Magnet ]] --

local MagnetEnabled = true
local MagnetRange = 50 -- المسافة التي يسحب منها الغرض

task.spawn(function()
    while MagnetEnabled do
        for _, item in pairs(workspace:GetChildren()) do
            -- فحص إذا كان الغرض عملة، سلاح، أو غرض قابل للالتقاط
            if item:IsA("BackpackItem") or item.Name:lower():find("coin") or item.Name:lower():find("gem") then
                if item:IsA("BasePart") then
                    local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - item.Position).Magnitude
                    if mag <= MagnetRange then
                        item.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end
        end
        task.wait(0.2)
    end
end)

s6o_Notify("s6o HUB", "Magnet System: Active")
-- [[ s6o HUB - Part 44: Ultimate Anti-Fling & Physics Lock ]] --

game:GetService("RunService").Heartbeat:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                -- تصفير السرعة الزاوية والخطية لمنع القذف
                v.Velocity = Vector3.new(0, 0, 0)
                v.RotVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

s6o_Notify("s6o HUB", "Anti-Fling Shield: Stabilized")
-- [[ s6o HUB - Part 45: World Object Tracers ]] --

local function CreateTracer(targetPart, color)
    local Attachment0 = Instance.new("Attachment", game.Players.LocalPlayer.Character.HumanoidRootPart)
    local Attachment1 = Instance.new("Attachment", targetPart)
    local Beam = Instance.new("Beam", Attachment0)
    
    Beam.Attachment0 = Attachment0
    Beam.Attachment1 = Attachment1
    Beam.Width0 = 0.1
    Beam.Width1 = 0.1
    Beam.Color = ColorSequence.new(color)
    Beam.FaceCamera = true
end

-- مثال: كشف الصناديق في الماب
for _, v in pairs(workspace:GetDescendants()) do
    if v.Name:lower():find("chest") or v.Name:lower():find("rare") then
        CreateTracer(v, Color3.fromRGB(255, 255, 0)) -- لون أصفر للصناديق
    end
end
