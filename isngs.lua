-- ==========================================
-- 🏷️ NAMA: HTP HILBRAM
-- 📦 MAP: South Bronx
-- 💻 PLATFORM: PC
-- 🔄 SUPPORT: SEMUA Executor
-- ⌨️ MENU: CTRL + 1
-- ==========================================

repeat task.wait() until game:IsLoaded()
local S=game,Pl=S:GetService"Players",RS=S:GetService"RunService",UIS=S:GetService"UserInputService",C=workspace.CurrentCamera,LP=Pl.LocalPlayer,G=S:GetService"CoreGui",M=LP:GetMouse()

-- KONFIGURASI
local SET={
    AIM={E=false,SA=false,AL=true,TC=false,FC=150,MD=800,SM=8,PT="HumanoidRootPart"},
    ESP={E=false,N=true,H=true,B=true,TC=false,EC=Color3.fromRGB(255,50,50),TCo=Color3.fromRGB(50,255,50)}
}

local T=nil,V=false,D={},Sk={},FC=nil

-- FUNGSI DASAR
local function R()local c=LP.Character return c and c:FindFirstChild"HumanoidRootPart"end
local function Al(p)local c=p.Character,h=c and c:FindFirstChildOfClass"Humanoid",r=c and c:FindFirstChild"HumanoidRootPart"return h and r and h.Health>0 end
local function Tm(p)return SET.AIM.TC and p.Team and LP.Team and p.Team==LP.Team end
local function See(p)local lr=R()if not lr then return false end local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude rp.FilterDescendantsInstances={LP.Character}local d=(p.Position-lr.Position)local r=workspace:Raycast(lr.Position,d.Unit*math.min(d.Magnitude-0.1,500),rp)return not r or r.Instance:IsDescendantOf(p.Character)end

-- CARI MUSUH TERDEKAT
local function GT()local lr=R()if not lr then return end local p,sd=nil,math.huge local sc=C.ViewportSize/2 for _,v in pairs(Pl:GetPlayers())do if v~=LP and Al(v)and not Tm(v)then local c=v.Character,t=c and c:FindFirstChild(SET.AIM.PT)or c:FindFirstChild"HumanoidRootPart"if t and See(t)then local d=(t.Position-lr.Position).Magnitude if d<=SET.AIM.MD then local sp,vs=C:WorldToScreenPoint(t.Position)if vs then local ds=(Vector2.new(sp.X,sp.Y)-sc).Magnitude if ds<=SET.AIM.FC and ds<sd then sd=ds;p=v end end end end end end return p end

-- SILENT AIM (jika didukung executor)
pcall(function()if not hookmetamethod then return end;local o=hookmetamethod(game,"__index",function(s,k)if SET.AIM.SA and T and Al(T)then if s==M and k=="Hit"then local t=T.Character and T.Character:FindFirstChild(SET.AIM.PT)or T.Character:FindFirstChild"HumanoidRootPart"if t then return CFrame.new(t.Position)end end end;return o(s,k)end)end)

-- AIMBOT / AIM LOCK (universal semua executor)
RS.RenderStepped:Connect(function()
    if SET.AIM.E then
        T=GT()
        if T and Al(T)then
            local t=T.Character and T.Character:FindFirstChild(SET.AIM.PT)or T.Character:FindFirstChild"HumanoidRootPart"
            if t and SET.AIM.AL and not SET.AIM.SA then
                local cf=C.CFrame:Lerp(CFrame.new(C.CFrame.Position,t.Position),1/math.clamp(SET.AIM.SM,1,20))
                C.CFrame=cf
            end
        end
    end
end)

-- ESP
RS.RenderStepped:Connect(function()
    if not SET.ESP.E then for _,v in pairs(D)do v.B.Visible=false;v.T.Visible=false end return end
    for _,p in pairs(Pl:GetPlayers())do if p==LP or not Al(p)then goto c end
        local r=p.Character and p.Character:FindFirstChild"HumanoidRootPart"local lr=R()if not r or not lr then goto c end
        local d=(r.Position-lr.Position).Magnitude local sp,vs=C:WorldToViewportPoint(r.Position)if not vs then goto c end
        local Co=Tm(p)and SET.ESP.TCo or SET.ESP.EC
        if not D[p]then D[p]={B=Drawing.new"Square",T=Drawing.new"Text"}D[p].B.Thickness=2 D[p].T.Size=12 end
        local a,b=Vector2.new(sp.X-15,sp.Y-45),Vector2.new(sp.X+15,sp.Y+35)
        D[p].B.Color=Co D[p].B.Position=a D[p].B.Size=b-a D[p].B.Visible=SET.ESP.B
        D[p].T.Color=Co D[p].T.Position=Vector2.new(sp.X,sp.Y-55)
        D[p].T.Text=(SET.ESP.N and p.Name.."  "or"")..(SET.ESP.H and math.floor(p.Character:FindFirstChildOfClass"Humanoid".Health).."HP"or"")
        D[p].T.Visible=SET.ESP.N or SET.ESP.H
        ::c::
    end
end)

-- MENU
do local SG=Instance.new"ScreenGui"SG.Parent=G SG.Name="HILBRAM"
local M=Instance.new"Frame"M.Size=UDim2.new(0,220,0,320)M.Position=UDim2.new(.5,-110,.5,-160)M.BackgroundColor3=Color3.fromRGB(15,15,25)M.Active=true;M.Draggable=true;M.Visible=false;M.Parent=SG;Instance.new("UICorner",M).CornerRadius=UDim.new(0,12)
local T=Instance.new"TextLabel"T.Size=UDim2.new(1,-20,0,35)T.Position=UDim2.new(0,10,0,5)T.BackgroundTransparency=1;T.Text="HTP  HILBRAM"T.TextColor3=Color3.fromRGB(120,90,255);T.Font=Enum.Font.GothamBlack;T.TextSize=16;T.Parent=M
local function B(n,k,t)local b=Instance.new"TextButton"b.Size=UDim2.new(1,-20,0,38)b.Position=UDim2.new(0,10,0,50+((k-1)*42))b.BackgroundColor3=t and Color3.fromRGB(40,180,120)or Color3.fromRGB(35,35,55)b.Text=n;b.TextColor3=Color3.new(1,1,1);b.Font=Enum.Font.GothamBold;b.TextSize=11;b.Parent=M;Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)b.MouseButton1Click:Connect(function()t=not t;b.BackgroundColor3=t and Color3.fromRGB(40,180,120)or Color3.fromRGB(35,35,55)end)end
B("🎯 AIMBOT AKTIF",1,SET.AIM.E)
B("🔇 SILENT AIM",2,SET.AIM.SA)
B("🎯 AIM LOCK",3,SET.AIM.AL)
B("👤 ESP NAMA",4,SET.ESP.N)
B("❤️ ESP DARAH",5,SET.ESP.H)
B("📦 ESP KOTAK",6,SET.ESP.B)
UIS.InputBegan:Connect(function(i)if i.KeyCode==Enum.KeyCode.LeftControl then V=not V;M.Visible=V end end)end

print("✅ HTP HILBRAM | South Bronx | BERJALAN!")
print("⌨️ TEKAN CTRL + 1 = BUKA/TUTUP MENU")
print("⚠️ Silent Aim hanya aktif jika executor mendukung hookmetamethod")
