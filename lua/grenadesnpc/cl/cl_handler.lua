function HZNGrenades:PurchaseGrenade(entity, grenade)
    if (LocalPlayer():HasWeapon(HZNGrenades.Config.Grenades[grenade].swep)) then
        LocalPlayer():ChatPrint("[{#1A9FF9 Grenade Shop}] You already have this grenade!")
        return
    end

    if (!LocalPlayer():canAfford(HZNGrenades.Config.Grenades[grenade].price)) then
        LocalPlayer():ChatPrint("[{#1A9FF9 Grenade Shop}] You can't afford this grenade!")
        return
    end
    
    if (!HZNLib:InDistance(LocalPlayer(), entity, HZNLib.USE_DISTANCE)) then
        LocalPlayer():ChatPrint("[{#1A9FF9 Grenade Shop}] You are too far away from the shop!")
        return
    end

    net.Start("HZNGrenades:PurchaseGrenade")
        net.WriteEntity(entity)
        net.WriteUInt(grenade, 8)
    net.SendToServer()
end

net.Receive("HZNGrenades:OpenShop", function()
    local ent = net.ReadEntity()
    HZNGrenades:OpenShop(ent)
end)