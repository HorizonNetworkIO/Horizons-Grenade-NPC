local PANEL = {}

local sw = function(x) return (x * ScrW())/1920 end
local sh = function(y) return (y * ScrH())/1080 end

local navbarSize = sh(50)

local function hasGrenade(id) return LocalPlayer():HasWeapon(HZNGrenades.Config.Grenades[id].swep) end

function HZNGrenades:OpenShop(ent)
    if (HZNGrenades.ShopMenu) then
        HZNGrenades.ShopMenu:Remove()
    end

    HZNGrenades.ShopMenu = vgui.Create("DLL.Frame")
    HZNGrenades.ShopMenu:SetTitle("Grenade Shop")
    HZNGrenades.ShopMenu:SetSize(sw(500), sh(370))
    HZNGrenades.ShopMenu:Center()
    HZNGrenades.ShopMenu:MakePopup()
    HZNGrenades.ShopMenu:Open()
    HZNGrenades.ShopMenu.npcEntity = ent

    HZNGrenades.ShopMenu.grid = vgui.Create("DGrid", HZNGrenades.ShopMenu)
    HZNGrenades.ShopMenu.grid:Dock(FILL)
    HZNGrenades.ShopMenu.grid:DockMargin(0, 0, 0, 0)
    HZNGrenades.ShopMenu.grid:SetCols(2)
    HZNGrenades.ShopMenu.grid:SetColWide(sw(250))
    HZNGrenades.ShopMenu.grid:SetRowHeight(sh(170))

    for k, v in ipairs(HZNGrenades.Config.Grenades) do 
        local slot = vgui.Create("DLL.Button", HZNGrenades.ShopMenu.grid)
        slot.NormalCol = Color(46, 46, 46)
        slot.HoverCol = DLL.OffsetColor(slot.NormalCol, -15)
        slot.ClickedCol = DLL.OffsetColor(slot.NormalCol, 15)
        slot.BackgroundCol = slot.NormalCol
        slot:SetSize(sw(238), sh(158))
        slot.id = k
        HZNGrenades.ShopMenu.grid:AddItem(slot)
        slot.PaintExtra = function(s, w, h)
            local price = hasGrenade(k) and "Reached Limit!" or DLL.FormatMoney(v.price)
            local col = DLL.Colors.PrimaryText

            draw.SimpleText(v.name, "HZN:Bold@25", w/2, sh(20), col, 1, 1)
            draw.SimpleText(price, "HZN:Bold@25", w/2, h - sh(20), col, 1, 1)
        end
        slot:SetText("")
        slot.DoClick = function(s)
            HZNGrenades:PurchaseGrenade(HZNGrenades.ShopMenu.npcEntity, k)
        end

        local modelView = vgui.Create("DModelPanel", slot)
        modelView:SetSize(sw(210), sh(110))
        modelView:SetPos(sw(10), sh(40))
        modelView:SetModel(v.model)
        modelView:SetFOV(60)
        modelView:SetCamPos(Vector(15, 25, 0))
        modelView:SetLookAt(Vector(0, 0, 0))
        modelView:SetMouseInputEnabled(false)

        if (k == 1) then
            modelView:SetLookAt(Vector(0, 0, 2))
        elseif (k == 3) then
            modelView:SetLookAt(Vector(0, 0, -3))
        elseif (k == 4) then
            modelView:SetLookAt(Vector(0, 0, 2))
        end
    end
end