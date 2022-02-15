GM.Name = "Gunfight"
GM.Author = "Pikachu/Penial"
GM.Email = "jacksonwassermann55@icloud.com"
GM.Website = "https://github.com/PikachuPenial"

DeriveGamemode("sandbox")

function GM:initialize()
  --Do my stuff here ig
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

  --Slide/Leaning
RunConsoleCommand("cl_leaning_distance", "800")
RunConsoleCommand("cl_qslide_view", "0")
RunConsoleCommand("sv_qslide_duration", "0.50")
RunConsoleCommand("sv_qslide_speedmult", "1.75")

  --Dynamic Height
RunConsoleCommand("sv_ec2_dynamicheight", "0")
RunConsoleCommand("sv_ec2_dynamicheight_min", "42")
RunConsoleCommand("sv_ec2_dynamicheight_max", "64")


  --Modern Warfare Base Debug
RunConsoleCommand("mgbase_debug_crosshair", "0")
RunConsoleCommand("mgbase_debug_disablebreathing", "0")
RunConsoleCommand("mgbase_debug_freeview", "0")
RunConsoleCommand("mgbase_debug_projectiles", "0")
RunConsoleCommand("mgbase_debug_range", "0")
RunConsoleCommand("mgbase_debug_reverb", "0")
RunConsoleCommand("mgbase_debug_vmrender", "1")
RunConsoleCommand("mgbase_debug_wmrender", "1")

  --Modern Warfare Base PostFX
RunConsoleCommand("mgbase_fx_blur", "0")
RunConsoleCommand("mgbase_fx_cheap_particles", "0")
RunConsoleCommand("mgbase_fx_cheap_reticles", "0")
RunConsoleCommand("mgbase_fx_laser_weaponcolor", "0")
RunConsoleCommand("mgbase_fx_reticle_brightness", "3")
RunConsoleCommand("mgbase_fx_smoke", "1")
RunConsoleCommand("mgbase_fx_vmblur", "0")
RunConsoleCommand("mgbase_fx_vmblur_hip", "0")
RunConsoleCommand("mgbase_fx_vmfov", "1")
RunConsoleCommand("mgbase_fx_vmfov_ads", "1")

  --Modern Warfare Base Player Models
RunConsoleCommand("mgbase_rig", "1")
RunConsoleCommand("mgbase_rig_skin", "0")
RunConsoleCommand("mgbase_gloves", "1")
RunConsoleCommand("mgbase_gloves_skin", "0")

  --Modern Warfare Base Hud
RunConsoleCommand("mgbase_hud_firemode", "0")
RunConsoleCommand("mgbase_hud_flashlight", "0")
RunConsoleCommand("mgbase_hud_sights", "1")
RunConsoleCommand("mgbase_hud_xhair", "1")
RunConsoleCommand("mgbase_hud_xhaircolor", "1")

  --Modern Warfare Base Mechanics
RunConsoleCommand("mgbase_autoreload", "0")
RunConsoleCommand("mgbase_manualrechamber", "1")
RunConsoleCommand("mgbase_saveatts", "0")

  --Modern Warfare Base Server Multipliers
RunConsoleCommand("mgbase_sv_accuracy", "1")
RunConsoleCommand("mgbase_sv_pvedamage", "1")
RunConsoleCommand("mgbase_sv_pvpdamage", "1")
RunConsoleCommand("mgbase_sv_recoil", "2")

  --Modern Warfare Base Setup / Allow Attachments
RunConsoleCommand("mgbase_sv_customization", "1")