HZNGrenades.Config = {}
HZNGrenades.Config.Grenades = {}

local function addGrenade(name, price, model, swep)
    local grenade = {}
    grenade.name = name
    grenade.price = price
    grenade.model = model
    grenade.swep = swep

    table.insert(HZNGrenades.Config.Grenades, grenade)
end

addGrenade("Electric Grenade", 35000, "models/weapons/w_eq_flashbang.mdl", "weapon_sh_electricgrenade")
addGrenade("Percussion Grenade", 25000, "models/weapons/w_eq_fraggrenade.mdl", "weapon_sh_percussiongrenade")
addGrenade("Flashbang", 20000, "models/shenesis/w_flashbang.mdl", "weapon_sh_flashbang")
addGrenade("Smoke Grenade", 15000, "models/weapons/w_eq_smokegrenade.mdl", "weapon_sh_smokegrenade")