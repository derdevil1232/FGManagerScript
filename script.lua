-- CONFIGURATION
local BACKEND_URL = "https://hszuecvdvvubdzkwxvay.supabase.co/functions/v1/link-account" -- Replace this with your actual backend endpoint

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Confirm = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

TextBox.Parent = Frame
TextBox.PlaceholderText = "Enter your magic key"
TextBox.Size = UDim2.new(1, -20, 0, 30)
TextBox.Position = UDim2.new(0, 10, 0, 10)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = false

Confirm.Parent = Frame
Confirm.Text = "Confirm"
Confirm.Size = UDim2.new(1, -20, 0, 30)
Confirm.Position = UDim2.new(0, 10, 0, 55)
Confirm.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
Confirm.TextColor3 = Color3.fromRGB(255, 255, 255)

Confirm.MouseButton1Click:Connect(function()
    local magicKey = TextBox.Text
    if magicKey == "" then
        Confirm.Text = "Enter a key!"
        wait(1)
        Confirm.Text = "Confirm"
        return
    end

    -- Send data to backend
    local HttpService = game:GetService("HttpService")
    local response

    pcall(function()
        response = request({
            Url = BACKEND_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                username = game.Players.LocalPlayer.Name,
                key = magicKey
            })
        })
    end)

    if response and response.Success then
        Confirm.Text = "Linked!"
    else
        Confirm.Text = "Failed!"
    end

    wait(2)
    ScreenGui:Destroy()
end)
