-- H4ll0 W0rld | Visual Error Prank

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ══════════════════════════════
--     SETUP GUI
-- ══════════════════════════════

local gui = Instance.new("ScreenGui")
gui.Name = "VisualErrorPrank"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ══════════════════════════════
--     HELPERS
-- ══════════════════════════════

local function makeFakeRobloxError(title, code, msg)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, 160)
    frame.Position = UDim2.new(
        0.5 + math.random(-20,20)/100,
        -190 + math.random(-40,40),
        0.5 + math.random(-20,20)/100,
        -80 + math.random(-40,40)
    )
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.ZIndex = 10
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(200, 30, 30)
    stroke.Thickness = 1.5
    stroke.Parent = frame

    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 36)
    titleBar.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 11
    titleBar.Parent = frame
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -16, 1, 0)
    titleLbl.Position = UDim2.new(0, 10, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "⚠ " .. title
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 13
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 12
    titleLbl.Parent = titleBar

    local closeX = Instance.new("TextButton")
    closeX.Size = UDim2.new(0, 28, 0, 28)
    closeX.Position = UDim2.new(1, -32, 0.5, -14)
    closeX.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
    closeX.Text = "✕"
    closeX.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeX.TextSize = 13
    closeX.Font = Enum.Font.GothamBold
    closeX.BorderSizePixel = 0
    closeX.ZIndex = 12
    closeX.Parent = titleBar
    Instance.new("UICorner", closeX).CornerRadius = UDim.new(0, 4)
    closeX.MouseButton1Click:Connect(function() frame:Destroy() end)

    -- Code
    local codeLbl = Instance.new("TextLabel")
    codeLbl.Size = UDim2.new(1, -20, 0, 22)
    codeLbl.Position = UDim2.new(0, 10, 0, 42)
    codeLbl.BackgroundTransparency = 1
    codeLbl.Text = "Error Code: " .. code
    codeLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    codeLbl.TextSize = 11
    codeLbl.Font = Enum.Font.GothamBold
    codeLbl.TextXAlignment = Enum.TextXAlignment.Left
    codeLbl.ZIndex = 12
    codeLbl.Parent = frame

    -- Message
    local msgLbl = Instance.new("TextLabel")
    msgLbl.Size = UDim2.new(1, -20, 0, 50)
    msgLbl.Position = UDim2.new(0, 10, 0, 64)
    msgLbl.BackgroundTransparency = 1
    msgLbl.Text = msg
    msgLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    msgLbl.TextSize = 11
    msgLbl.Font = Enum.Font.Gotham
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.TextYAlignment = Enum.TextYAlignment.Top
    msgLbl.TextWrapped = true
    msgLbl.ZIndex = 12
    msgLbl.Parent = frame

    -- Buttons row
    local btnRow = Instance.new("Frame")
    btnRow.Size = UDim2.new(1, -20, 0, 28)
    btnRow.Position = UDim2.new(0, 10, 1, -36)
    btnRow.BackgroundTransparency = 1
    btnRow.ZIndex = 11
    btnRow.Parent = frame

    local function makeBtn(text, xPos, w, bgColor)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, w, 1, 0)
        btn.Position = UDim2.new(0, xPos, 0, 0)
        btn.BackgroundColor3 = bgColor
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.ZIndex = 12
        btn.Parent = btnRow
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseButton1Click:Connect(function() frame:Destroy() end)
        return btn
    end

    makeBtn("Retry", 0, 80, Color3.fromRGB(40,40,40))
    makeBtn("Report", 86, 80, Color3.fromRGB(50,20,20))
    makeBtn("Close Game", 172, 100, Color3.fromRGB(120,0,0))

    -- Drag
    frame.Active = true
    frame.Draggable = true

    -- Pop-in animation
    frame.Size = UDim2.new(0,0,0,0)
    frame.Position = UDim2.new(0.5,0,0.5,0)
    TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
        Size = UDim2.new(0,380,0,160),
        Position = UDim2.new(
            0.5 + math.random(-20,20)/100, -190 + math.random(-40,40),
            0.5 + math.random(-20,20)/100, -80 + math.random(-40,40)
        )
    }):Play()

    return frame
end

-- ══════════════════════════════
--     GLITCH OVERLAY
-- ══════════════════════════════

local glitchOverlay = Instance.new("Frame")
glitchOverlay.Size = UDim2.new(1,0,1,0)
glitchOverlay.BackgroundColor3 = Color3.fromRGB(180,0,0)
glitchOverlay.BackgroundTransparency = 1
glitchOverlay.BorderSizePixel = 0
glitchOverlay.ZIndex = 5
glitchOverlay.Parent = gui

local function flashGlitch()
    local flashes = math.random(2,5)
    for i = 1, flashes do
        TweenService:Create(glitchOverlay, TweenInfo.new(0.03), {
            BackgroundTransparency = math.random(5,8)/10
        }):Play()
        task.wait(0.04)
        TweenService:Create(glitchOverlay, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play()
        task.wait(math.random(3,8)/100)
    end
end

-- ══════════════════════════════
--     FAKE CONSOLE LOG
-- ══════════════════════════════

local consoleFrame = Instance.new("Frame")
consoleFrame.Size = UDim2.new(0, 420, 0, 200)
consoleFrame.Position = UDim2.new(0, 8, 1, -210)
consoleFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
consoleFrame.BorderSizePixel = 0
consoleFrame.ZIndex = 8
consoleFrame.Visible = false
consoleFrame.Parent = gui
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 4)

local conStroke = Instance.new("UIStroke")
conStroke.Color = Color3.fromRGB(50,0,0)
conStroke.Thickness = 1
conStroke.Parent = consoleFrame

local conHeader = Instance.new("Frame")
conHeader.Size = UDim2.new(1,0,0,24)
conHeader.BackgroundColor3 = Color3.fromRGB(20,0,0)
conHeader.BorderSizePixel = 0
conHeader.ZIndex = 9
conHeader.Parent = consoleFrame
Instance.new("UICorner", conHeader).CornerRadius = UDim.new(0, 4)

local conTitle = Instance.new("TextLabel")
conTitle.Size = UDim2.new(1,-10,1,0)
conTitle.Position = UDim2.new(0,8,0,0)
conTitle.BackgroundTransparency = 1
conTitle.Text = "⚠ Output — CRITICAL ERRORS DETECTED"
conTitle.TextColor3 = Color3.fromRGB(200,0,0)
conTitle.TextSize = 10
conTitle.Font = Enum.Font.GothamBold
conTitle.TextXAlignment = Enum.TextXAlignment.Left
conTitle.ZIndex = 10
conTitle.Parent = conHeader

local conScroll = Instance.new("ScrollingFrame")
conScroll.Size = UDim2.new(1,-8,1,-32)
conScroll.Position = UDim2.new(0,4,0,28)
conScroll.BackgroundTransparency = 1
conScroll.BorderSizePixel = 0
conScroll.ScrollBarThickness = 3
conScroll.ScrollBarImageColor3 = Color3.fromRGB(80,0,0)
conScroll.ZIndex = 9
conScroll.Parent = consoleFrame

local conLayout = Instance.new("UIListLayout")
conLayout.SortOrder = Enum.SortOrder.LayoutOrder
conLayout.Padding = UDim.new(0,1)
conLayout.Parent = conScroll

conLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    conScroll.CanvasSize = UDim2.new(0,0,0,conLayout.AbsoluteContentSize.Y)
    conScroll.CanvasPosition = Vector2.new(0, conLayout.AbsoluteContentSize.Y)
end)

local logOrder = 0
local LOG_COLORS = {
    ERROR = Color3.fromRGB(255,60,60),
    WARN  = Color3.fromRGB(255,180,0),
    FATAL = Color3.fromRGB(255,0,0),
    INFO  = Color3.fromRGB(100,100,100),
}

local function addLog(level, message)
    logOrder += 1
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1,0,0,14)
    lbl.BackgroundTransparency = 1
    lbl.Text = "[" .. level .. "] " .. message
    lbl.TextColor3 = LOG_COLORS[level] or Color3.fromRGB(150,150,150)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.Code
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = logOrder
    lbl.ZIndex = 10
    lbl.Parent = conScroll
end

local FAKE_LOGS = {
    {"FATAL", "Stack overflow in CoreGui.MainModule:3829"},
    {"ERROR", "Attempt to index nil value 'workspace.CurrentCamera'"},
    {"ERROR", "Script injection detected — integrity check failed"},
    {"WARN",  "RemoteEvent flood detected: 847 calls/sec"},
    {"FATAL", "Memory corruption at address 0x00FF3A21"},
    {"ERROR", "Invalid CFrame matrix — NaN values propagating"},
    {"WARN",  "Physics service: joint solver diverged"},
    {"FATAL", "Replication queue overflow — dropping packets"},
    {"ERROR", "DataStore service: connection timed out (3/3)"},
    {"FATAL", "Client-server state desync — rolling back..."},
    {"ERROR", "Workspace instance tree corrupted"},
    {"FATAL", "CRITICAL: Shutdown sequence initiated"},
    {"ERROR", "Unable to recover — last save: NULL"},
    {"FATAL", "██████████████████████████████"},
}

-- ══════════════════════════════
--     FAKE DISCONNECTED SCREEN
-- ══════════════════════════════

local disconnectScreen = Instance.new("Frame")
disconnectScreen.Size = UDim2.new(1,0,1,0)
disconnectScreen.BackgroundColor3 = Color3.fromRGB(0,0,0)
disconnectScreen.BackgroundTransparency = 1
disconnectScreen.BorderSizePixel = 0
disconnectScreen.ZIndex = 20
disconnectScreen.Visible = false
disconnectScreen.Parent = gui

local dcIcon = Instance.new("TextLabel")
dcIcon.Size = UDim2.new(0,80,0,80)
dcIcon.Position = UDim2.new(0.5,-40,0.4,-80)
dcIcon.BackgroundTransparency = 1
dcIcon.Text = "⛔"
dcIcon.TextSize = 60
dcIcon.Font = Enum.Font.Gotham
dcIcon.ZIndex = 21
dcIcon.Parent = disconnectScreen

local dcTitle = Instance.new("TextLabel")
dcTitle.Size = UDim2.new(0.8,0,0,40)
dcTitle.Position = UDim2.new(0.1,0,0.5,-20)
dcTitle.BackgroundTransparency = 1
dcTitle.Text = "Lost Connection to Game Server"
dcTitle.TextColor3 = Color3.fromRGB(255,255,255)
dcTitle.TextSize = 22
dcTitle.Font = Enum.Font.GothamBold
dcTitle.ZIndex = 21
dcTitle.Parent = disconnectScreen

local dcCode = Instance.new("TextLabel")
dcCode.Size = UDim2.new(0.8,0,0,24)
dcCode.Position = UDim2.new(0.1,0,0.5,30)
dcCode.BackgroundTransparency = 1
dcCode.Text = "Error Code: 769 — Disconnected from server (VISUAL ONLY 👻)"
dcCode.TextColor3 = Color3.fromRGB(150,150,150)
dcCode.TextSize = 12
dcCode.Font = Enum.Font.Gotham
dcCode.ZIndex = 21
dcCode.Parent = disconnectScreen

local dcBtn = Instance.new("TextButton")
dcBtn.Size = UDim2.new(0,160,0,40)
dcBtn.Position = UDim2.new(0.5,-80,0.5,70)
dcBtn.BackgroundColor3 = Color3.fromRGB(0,100,200)
dcBtn.Text = "Reconnect"
dcBtn.TextColor3 = Color3.fromRGB(255,255,255)
dcBtn.TextSize = 14
dcBtn.Font = Enum.Font.GothamBold
dcBtn.BorderSizePixel = 0
dcBtn.ZIndex = 21
dcBtn.Parent = disconnectScreen
Instance.new("UICorner", dcBtn).CornerRadius = UDim.new(0, 6)

dcBtn.MouseButton1Click:Connect(function()
    TweenService:Create(disconnectScreen, TweenInfo.new(0.3), {BackgroundTransparency=1}):Play()
    task.wait(0.3)
    disconnectScreen.Visible = false
end)

-- ══════════════════════════════
--     SCREEN SHAKE
-- ══════════════════════════════

local function screenShake(intensity, duration)
    local cam = workspace.CurrentCamera
    local originalCFrame = cam.CFrame
    local elapsed = 0

    local conn
    conn = RunService.RenderStepped:Connect(function(dt)
        elapsed += dt
        if elapsed >= duration then
            conn:Disconnect()
            return
        end
        local fade = 1 - (elapsed / duration)
        cam.CFrame = cam.CFrame * CFrame.Angles(
            math.rad(math.random(-intensity, intensity) * fade * 0.3),
            math.rad(math.random(-intensity, intensity) * fade * 0.3),
            0
        )
    end)
end

-- ══════════════════════════════
--     BLUE SCREEN (BSOD)
-- ══════════════════════════════

local bsod = Instance.new("Frame")
bsod.Size = UDim2.new(1,0,1,0)
bsod.BackgroundColor3 = Color3.fromRGB(0,120,210)
bsod.BorderSizePixel = 0
bsod.ZIndex = 25
bsod.Visible = false
bsod.Parent = gui

local bsodEmoji = Instance.new("TextLabel")
bsodEmoji.Size = UDim2.new(1,0,0,80)
bsodEmoji.Position = UDim2.new(0,60,0,80)
bsodEmoji.BackgroundTransparency = 1
bsodEmoji.Text = ":("
bsodEmoji.TextColor3 = Color3.fromRGB(255,255,255)
bsodEmoji.TextSize = 80
bsodEmoji.Font = Enum.Font.GothamBold
bsodEmoji.TextXAlignment = Enum.TextXAlignment.Left
bsodEmoji.ZIndex = 26
bsodEmoji.Parent = bsod

local bsodText = Instance.new("TextLabel")
bsodText.Size = UDim2.new(0.6,0,0.5,0)
bsodText.Position = UDim2.new(0,60,0,180)
bsodText.BackgroundTransparency = 1
bsodText.Text = "Your PC ran into a problem and needs to restart.\n\n0% complete\n\n\nFor more information about this issue and possible fixes, visit\nhttps://www.windows.com/stopcode\n\nIf you call a support person, give them this info:\nStop code: SCRIPT_CRITICAL_FAILURE\n\n(VISUAL ONLY — tenang bro ini hanya visual 👻)"
bsodText.TextColor3 = Color3.fromRGB(255,255,255)
bsodText.TextSize = 14
bsodText.Font = Enum.Font.GothamBold
bsodText.TextXAlignment = Enum.TextXAlignment.Left
bsodText.TextYAlignment = Enum.TextYAlignment.Top
bsodText.TextWrapped = true
bsodText.ZIndex = 26
bsodText.Parent = bsod

local bsodClose = Instance.new("TextButton")
bsodClose.Size = UDim2.new(0,120,0,36)
bsodClose.Position = UDim2.new(1,-136,1,-52)
bsodClose.BackgroundColor3 = Color3.fromRGB(0,90,170)
bsodClose.Text = "Close (ESC)"
bsodClose.TextColor3 = Color3.fromRGB(255,255,255)
bsodClose.TextSize = 12
bsodClose.Font = Enum.Font.GothamBold
bsodClose.BorderSizePixel = 0
bsodClose.ZIndex = 26
bsodClose.Parent = bsod
Instance.new("UICorner", bsodClose).CornerRadius = UDim.new(0, 4)
bsodClose.MouseButton1Click:Connect(function()
    bsod.Visible = false
end)

-- ══════════════════════════════
--     CONTROL PANEL
-- ══════════════════════════════

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 200, 0, 300)
panel.Position = UDim2.new(0, 8, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(12,0,0)
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.ZIndex = 30
panel.Parent = gui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(150,0,0)
panelStroke.Thickness = 1.5
panelStroke.Parent = panel

local panelTitle = Instance.new("Frame")
panelTitle.Size = UDim2.new(1,0,0,34)
panelTitle.BackgroundColor3 = Color3.fromRGB(150,0,0)
panelTitle.BorderSizePixel = 0
panelTitle.ZIndex = 31
panelTitle.Parent = panel
Instance.new("UICorner", panelTitle).CornerRadius = UDim.new(0, 8)

local panelLbl = Instance.new("TextLabel")
panelLbl.Size = UDim2.new(1,-10,1,0)
panelLbl.Position = UDim2.new(0,8,0,0)
panelLbl.BackgroundTransparency = 1
panelLbl.Text = "💀 Error Prank Panel"
panelLbl.TextColor3 = Color3.fromRGB(255,255,255)
panelLbl.TextSize = 12
panelLbl.Font = Enum.Font.GothamBold
panelLbl.TextXAlignment = Enum.TextXAlignment.Left
panelLbl.ZIndex = 32
panelLbl.Parent = panelTitle

local panelLayout = Instance.new("UIListLayout")
panelLayout.SortOrder = Enum.SortOrder.LayoutOrder
panelLayout.Padding = UDim.new(0, 6)
panelLayout.Parent = panel

local panelPad = Instance.new("UIPadding")
panelPad.PaddingTop = UDim.new(0, 42)
panelPad.PaddingLeft = UDim.new(0, 8)
panelPad.PaddingRight = UDim.new(0, 8)
panelPad.Parent = panel

local function makePanelBtn(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.ZIndex = 32
    btn.Parent = panel
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(callback)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {
            BackgroundColor3 = Color3.new(
                math.min(color.R+0.08,1),
                math.min(color.G+0.08,1),
                math.min(color.B+0.08,1)
            )
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3=color}):Play()
    end)

    return btn
end

-- ── BUTTONS ──

makePanelBtn("💥 Spam Error Popup", Color3.fromRGB(120,0,0), function()
    local errors = {
        {"Script Error", "0x0000029F", "A fatal exception has occurred in CoreScript.\nThe game will now shut down.\n(jangan takut ini visual 👻)"},
        {"Memory Corruption", "0xDEADBEEF", "Critical memory access violation detected in workspace. Unable to recover game state."},
        {"Connection Lost", "Error 769", "Lost connection to Roblox servers. Your data may not have been saved. Please try again."},
        {"Script Injection", "0x00FF3A21", "Unauthorized script injection detected. Game integrity compromised. Reporting to server..."},
        {"Workspace Error", "0xBAD_CODE", "Workspace tree corruption detected. All instances may be destroyed.\nDO NOT CLOSE THIS WINDOW."},
    }
    local e = errors[math.random(#errors)]
    makeFakeRobloxError(e[1], e[2], e[3])
    screenShake(2, 0.5)
    flashGlitch()
end)

makePanelBtn("📋 Fake Error Console", Color3.fromRGB(80,0,0), function()
    consoleFrame.Visible = not consoleFrame.Visible
    if consoleFrame.Visible then
        for _, v in pairs(conScroll:GetChildren()) do
            if not v:IsA("UIListLayout") then v:Destroy() end
        end
        logOrder = 0
        task.spawn(function()
            for _, log in ipairs(FAKE_LOGS) do
                if not consoleFrame.Visible then break end
                addLog(log[1], log[2])
                task.wait(math.random(10,25)/100)
            end
        end)
    end
end)

makePanelBtn("🌐 Disconnected Screen", Color3.fromRGB(0,50,100), function()
    disconnectScreen.BackgroundTransparency = 1
    disconnectScreen.Visible = true
    TweenService:Create(disconnectScreen, TweenInfo.new(0.4), {
        BackgroundTransparency = 0
    }):Play()
    screenShake(3, 0.8)
end)

makePanelBtn("💀 Blue Screen (BSOD)", Color3.fromRGB(0,80,160), function()
    bsod.Visible = true
    screenShake(5, 1)
    flashGlitch()
end)

makePanelBtn("📱 Screen Shake Only", Color3.fromRGB(60,30,0), function()
    screenShake(4, 1.5)
    flashGlitch()
end)

makePanelBtn("🔴 Red Glitch Flash", Color3.fromRGB(100,0,0), function()
    for i = 1, 6 do
        flashGlitch()
        task.wait(0.08)
    end
end)

makePanelBtn("❌ Close Panel", Color3.fromRGB(30,0,0), function()
    panel:Destroy()
end)
-- Di bagian bawah, setelah bikin panel
-- Tambah ini:

panel.Visible = false  -- hidden by default

-- Keybind toggle panel
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        panel.Visible = not panel.Visible
    end
end)

-- Hint kecil di pojok (cuma keliatan pas panel hidden)
local hint = Instance.new("TextLabel")
hint.Size = UDim2.new(0, 6, 0, 6)
hint.Position = UDim2.new(0, 0, 0.5, 0)
hint.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
hint.Text = ""
hint.BorderSizePixel = 0
hint.ZIndex = 30
hint.Parent = gui
Instance.new("UICorner", hint).CornerRadius = UDim.new(1, 0)

-- Dot juga bisa diklik buat buka panel
hint.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        panel.Visible = not panel.Visible
    end
end)

-- Sync dot visibility sama panel
panel:GetPropertyChangedSignal("Visible"):Connect(function()
    hint.Visible = not panel.Visible
end)
