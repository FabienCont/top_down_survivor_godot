extends Weapon

class_name DistantWeapon

var ammo_info :AmmoInfo
var nb_projectiles_stat: Stat
var rotation_between_projectiles_stat: Stat

func init(stats_init: StatsController,weapon_info_init: WeaponInfo,effects_init: EffectsController) -> void:
	super.init(stats_init,weapon_info_init,effects_init)
	ammo_info = weapon_info_init.ammo_info
	nb_projectiles_stat = stats.get_current_stat(stats_const.names.nb_projectile)
	rotation_between_projectiles_stat = stats.get_current_stat(stats_const.names.rotation_between_projectiles)
	
func start_attack():
	animation_player.speed_scale = attack_speed.value
	animation_player.play("prepareShot")
	animation_player.animation_finished.connect(shoot)

func _get_rotation_between_projectiles():
	if rotation_between_projectiles_stat == null:
		return  8
	return rotation_between_projectiles_stat.value
	
func _get_nb_projectiles():
	if nb_projectiles_stat == null:
		return  1
	return nb_projectiles_stat.value
	
func shoot(_arg):
	animation_player.animation_finished.disconnect(shoot)
	animation_player.animation_finished.connect(end_attack)
	animation_player.play("Shoot")
	SoundManager.playFireArrowSound()
	var new_ammo = ammo_info.scene.instantiate()
	new_ammo.global_position = get_parent().global_position
	new_ammo.global_rotation = get_parent().global_rotation
	new_ammo.init(stats,ammo_info)
	var nb_projectile = _get_nb_projectiles()
	if nb_projectile > 1:
		new_ammo = ProjectileHelper.multiply_projectile2D(new_ammo,nb_projectile,_get_rotation_between_projectiles() )
	add_child(new_ammo)

func idle(_arg):
	animation_player.play("Idle")
	var time_factor = 1 / attack_speed.value
	#await get_tree().create_timer(0.3 * time_factor).timeout
	#start_attack()
