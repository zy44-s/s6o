-- [[ s6o HUB - THE ULTIMATE EDITION ]]
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "s6o HUB 🚀 [OFFICIAL]",
   LoadingTitle = "جاري تحميل ترسانة s6o...",
   LoadingSubtitle = "بواسطة s6o",
   ConfigurationSaving = { Enabled = false }
})

-- [[ 1. قائمة سكربتاتي ]]
local MyScripts = Window:CreateTab("سكربتاتي 📂", 4483362458)
MyScripts:CreateButton({
   Name = "تفعيل Aimbot (Murders vs Sheriffs) 🎯",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/nexuscripts/DUELS-Murders-vs-Sheriffs/refs/heads/main/Aimbot.lua"))()
   end,
})

-- [[ 2. الرئيسية: الحركة والهبدات ]]
local MainTab = Window:CreateTab("الرئيسية ⚡", 4483362458)

MainTab:CreateSlider({
   Name = "سرعة المشي",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(V) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = V end,
})

MainTab:CreateSlider({
   Name = "قوة القفز",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = 50,
   Callback = function(V) 
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = V
       game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
   end,
})

-- ميزة الطيران (الهبدة 1)
local Flying = false
MainTab:CreateToggle({
   Name = "نظام الطيران (s6o Fly) ✈️",
   CurrentValue = false,
   Callback = function(v)
       Flying = v
       local plr = game.Players.LocalPlayer
       local mouse = plr:GetMouse()
       if Flying then
           local bg = Instance.new("BodyGyro", plr.Character.HumanoidRootPart)
           local bv = Instance.new("BodyVelocity", plr.Character.HumanoidRootPart)
           bg.P = 9e4
           bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
           bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
           spawn(function()
               while Flying do
                   wait()
                   plr.Character.Humanoid.PlatformStand = true
                   bv.velocity = mouse.Hit.lookVector * 100
                   bg.cframe = CFrame.new(plr.Character.HumanoidRootPart.Position, mouse.Hit.p)
               end
               plr.Character.Humanoid.PlatformStand = false
               bg:Destroy()
               bv:Destroy()
           end)
       end
   end,
})

-- ميزة الدوران (الهبدة 2)
MainTab:CreateToggle({
   Name = "الدوران السريع (Spin Bot) 🌀",
   CurrentValue = false,
   Callback = function(v)
       _G.Spin = v
       spawn(function()
           while _G.Spin do
               pcall(function()
                   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
               end)
               task.wait()
           end
       end)
   end,
})

-- [[ 3. المراقبة والاختفاء ]]
local WatchTab = Window:CreateTab("المراقبة 👻", 4483362458)
WatchTab:CreateButton({
   Name = "تفعيل الاختفاء",
   Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/BaconAtoms/Scripts/main/Invisible.lua"))() end,
})

local target = ""
WatchTab:CreateInput({
   Name = "اسم اللاعب للمراقبة",
   PlaceholderText = "اكتب الاسم هنا...",
   Callback = function(t) target = t end,
})

WatchTab:CreateToggle({
   Name = "بدء المراقبة",
   CurrentValue = false,
   Callback = function(v)
       if v then
           local p = game.Players:FindFirstChild(target)
           if p then game.Workspace.CurrentCamera.CameraSubject = p.Character.Humanoid end
       else
           game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
       end
   end,
})

-- [[ 4. الشيك بوينت ]]
local TeleTab = Window:CreateTab("شيك بوينت 📍", 4483362458)
local pos = nil
TeleTab:CreateButton({Name = "حفظ المكان الحالي", Callback = function() pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame end})
TeleTab:CreateButton({Name = "العودة للمكان المحفوظ", Callback = function() if pos then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos end end})

-- [[ 5. إضافات وسيارات ]]
local ExtraTab = Window:CreateTab("إضافات 🚗", 4483362458)
ExtraTab:CreateButton({
   Name = "كاشف الأسماء (ESP)",
   Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/Exunys/Exunys-ESP/main/Resources/Scripts/Main.lua'))() end,
})
ExtraTab:CreateButton({
   Name = "سرعة سيارة بروكهافن",
   Callback = function() pcall(function() game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent.Drive.MaxSpeed = 300 end) end,
})

Rayfield:Notify({Title = "s6o HUB", Content = "تم تفعيل الترسانة كاملة! ✅", Duration = 5})
