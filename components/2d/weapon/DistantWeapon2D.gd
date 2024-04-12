extends WeaponComponent2D

class_name DistantWeapon2D

var ammo_info :AmmoInfo
var nb_projectiles_stat: StatModel
var rotation_between_projectiles_stat: StatModel

var is_attack_ready = false
var ammo_scene

func init(collision_layer_init:int,collision_mask_init:int,weapon_info_init: WeaponInfo,upgrades_controller_init: UpgradesController,emiter_init) -> void:
	super(collision_layer_init,collision_mask_init,weapon_info_init,upgrades_controller_init,emiter_init)
	ammo_info = weapon_info_init.ammo_info
	nb_projectiles_stat = stats_controller.get_current_stat(StatsConstWeapon.names.nb_projectile)
	rotation_between_projectiles_stat = stats_controller.get_current_stat(StatsConstWeapon.names.rotation_between_projectiles)
	ammo_scene = ammo_info.scene.instantiate()
	ammo_scene.init(collision_layer_init,collision_mask_init,ammo_info,upgrades_controller_init)
	
func start_attack(attack_speed_value: float):
	if is_attack_ready == false:
		end_attack(null)
		return
	animation_player.speed_scale = attack_speed_value
	attack(null)

func prepare_attack(attack_speed_value: float) -> float:
	animation_player.speed_scale = attack_speed_value
	animation_player.play("PrepareAttack")
	if not animation_player.animation_finished.is_connected(finish_attack_prepare):
		animation_player.animation_finished.connect(finish_attack_prepare)
	return animation_player.current_animation_length / animation_player.speed_scale

func finish_attack_prepare(_arg):
	is_attack_ready = true
	attack_ready.emit()
	if animation_player.animation_finished.is_connected(finish_attack_prepare):
		animation_player.animation_finished.disconnect(finish_attack_prepare)
	
func _get_rotation_between_projectiles():
	if rotation_between_projectiles_stat == null:
		return  8
	return rotation_between_projectiles_stat.value
	
func _get_nb_projectiles():
	return stats_controller.get_current_stat(StatsConstWeapon.names.nb_projectile).value
	
func attack(_arg):
	if animation_player.animation_finished.is_connected(attack):
		animation_player.animation_finished.disconnect(attack)
	if not animation_player.animation_finished.is_connected(end_attack):
		animation_player.animation_finished.connect(end_attack)
	animation_player.play("Attack")
	SoundManager.playFireArrowSound()
	var new_ammo = ammo_scene.duplicate()
	new_ammo.init(collision_layer,collision_mask,ammo_info,upgrades_controller)
	new_ammo.global_position = get_parent().global_position
	new_ammo.global_rotation = get_parent().global_rotation
	var nb_projectile = _get_nb_projectiles()
	if nb_projectile > 1:
		new_ammo = ProjectileHelper.multiply_projectile2D(new_ammo,nb_projectile,_get_rotation_between_projectiles() )
	add_child(new_ammo)

func idle(_arg):
	is_attack_ready = false
	animation_player.play("Idle")
