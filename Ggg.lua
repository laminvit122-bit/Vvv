local RS = game:GetService("ReplicatedStorage")
local weaponEvents = RS:WaitForChild("WeaponEvents", 5)

if not weaponEvents then
    warn("WeaponEvents не найден!")
    return
end

local gunBeam = weaponEvents:FindFirstChild("GunBeam")

if not gunBeam then
    warn("GunBeam не найден!")
    return
end

print("[Hook] Установлен на GunBeam. Жди выстрела...")

-- Hook
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    
    if self == gunBeam and method == "FireServer" then
        print("\n=== GunBeam:FireServer ===")
        print("Количество аргументов:", select("#", ...))
        for i, arg in ipairs({...}) do
            print("  [" .. i .. "]:", typeof(arg), tostring(arg))
            -- Если это Instance - показать его путь
            if typeof(arg) == "Instance" then
                print("       → Путь:", arg:GetFullName())
            end
        end
    end
    return oldNamecall(self, ...)
end)
