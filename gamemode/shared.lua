GM.Name = "Gunfight"
GM.Author = "Pikachu/Penial"
GM.Email = "jacksonwassermann55@icloud.com"
GM.Website = "https://github.com/PikachuPenial"

DeriveGamemode("sandbox")

function GM:initialize()
  --Do my stuff here ig
end

function GM:ContextMenuOpen()
  return false
end

  --Disabling NoClip/Tinnitus
RunConsoleCommand("sbox_noclip", "0")
RunConsoleCommand("dsp_off", "1")

  --Realistic Fall Damage
RunConsoleCommand("mp_falldamage", "1")

  --Anti-Bunnyhopping
RunConsoleCommand("vk_enabled", "1")
RunConsoleCommand("vk_suppressor", "1")
RunConsoleCommand("vk_speedlimit", "1")