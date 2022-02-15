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
RunConsoleCommand("mgbase_sv_recoil", "1.7")

  --Modern Warfare Base Setup / Allow Attachments
RunConsoleCommand("mgbase_sv_customization", "1")

  --HUD Setup
RunConsoleCommand("gwz_hud_deathcamera_enable", "1")
RunConsoleCommand("gwz_hud_deathcamera_mode", "1")
RunConsoleCommand("gwz_hud_enable", "1")
RunConsoleCommand("gwz_hud_enable_ammo", "1")
RunConsoleCommand("gwz_hud_enable_armorbreak", "1")
RunConsoleCommand("gwz_hud_enable_attackindicator", "1")
RunConsoleCommand("gwz_hud_enable_counter", "1")
RunConsoleCommand("gwz_hud_enable_debug", "0")
RunConsoleCommand("gwz_hud_enable_healthpanel", "1")
RunConsoleCommand("gwz_hud_enable_healthteampanel", "0")
RunConsoleCommand("gwz_hud_enable_hitmarker", "1")
RunConsoleCommand("gwz_hud_enable_neardeath", "1")
RunConsoleCommand("gwz_hud_hitmark_snd_style", "0")

  --Hud Offset/Scale
RunConsoleCommand("gwz_hud_adaptscale", "0")
RunConsoleCommand("gwz_hud_offset_h", "0")
RunConsoleCommand("gwz_hud_offset_v", "0")
RunConsoleCommand("gwz_hud_scale_multiplier", "1")

  --Hud Preformance
RunConsoleCommand("gwz_hud_reduce_effect", "0")
RunConsoleCommand("gwz_hud_enable_shake_on_explosion", "1")

  --Hud Server Setup
RunConsoleCommand("gwz_hud_server_realism_mode", "0")
RunConsoleCommand("gwz_hud_server_teambased", "0")

  --Executions Setup
RunConsoleCommand("bsmod_codmw_anims_chance", "3")
RunConsoleCommand("bsmod_codv_anims_chance", "3")

  --Executions Debug
RunConsoleCommand("bsmod_debug_calcview", "0")
RunConsoleCommand("bsmod_kick_enabled", "0")

  --Executions Modifiers
RunConsoleCommand("bsmod_killmove_anytime_behind", "1")
RunConsoleCommand("bsmod_killmove_disable_defaults", "1")
RunConsoleCommand("bsmod_killmove_enable_npcs", "1")
RunConsoleCommand("bsmod_killmove_enable_players", "1")
RunConsoleCommand("bsmod_killmove_enable_teammates", "0")
RunConsoleCommand("bsmod_killmove_glow", "0")
RunConsoleCommand("bsmod_killmove_minhealth", "1")
RunConsoleCommand("bsmod_killmove_spawn_healthkit", "1")
RunConsoleCommand("bsmod_killmove_spawn_healthvial", "1")
RunConsoleCommand("bsmod_killmove_stun_npcs", "0")
RunConsoleCommand("bsmod_killmove_thirdperson", "0")
RunConsoleCommand("bsmod_killmove_time", "1")