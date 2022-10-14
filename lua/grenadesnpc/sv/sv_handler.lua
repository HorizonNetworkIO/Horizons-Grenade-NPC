util.AddNetworkString("HZNGrenades:OpenShop")
function HZNGrenades:OpenShop(ply, npcEntity)
    net.Start("HZNGrenades:OpenShop")
    net.WriteEntity(npcEntity)
    net.Send(ply)
end

util.AddNetworkString("HZNGrenades:PurchaseGrenade")
net.Receive("HZNGrenades:PurchaseGrenade", function(len, ply)
    local npcEntity = net.ReadEntity()
    local grenade = net.ReadUInt(8)

    if (ply:HasWeapon(HZNGrenades.Config.Grenades[grenade].swep)) then
        ply:ChatPrint("[{#1A9FF9 Grenade Shop}] You already have this grenade!")
        return
    end

    if (!ply:canAfford(HZNGrenades.Config.Grenades[grenade].price)) then
        ply:ChatPrint("[{#1A9FF9 Grenade Shop}] You can't afford this grenade!")
        return
    end

    if (!HZNLib:InDistance(ply, npcEntity, HZNLib.USE_DISTANCE)) then
        ply:ChatPrint("[{#1A9FF9 Grenade Shop}] You are too far away from the shop!")
        return
    end

    ply:addMoney(-HZNGrenades.Config.Grenades[grenade].price)
    ply:Give(HZNGrenades.Config.Grenades[grenade].swep)
    ply:ChatPrint("[{#1A9FF9 Grenade Shop}] You have purchased a " .. HZNGrenades.Config.Grenades[grenade].name .. " for {#1A9FF9 " .. DLL.FormatMoney(HZNGrenades.Config.Grenades[grenade].price) .. "}!")
end)