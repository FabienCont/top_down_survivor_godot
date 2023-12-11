extends Node2D
class_name Weapon

@onready var weapon_sprite:Sprite2D
@onready var animation_player:AnimationPlayer
@onready var upgrades_controller:UpgradesController 
@onready var stats_controller: StatsControllerWeapon

@onready var collision_layer: int
@onready var collision_mask: int

signal attack_ready()
signal attack_has_end()
signal hit(attack:Attack)

func init(collision_layer_init: int,collision_mask_init: int,weapon_info_init: WeaponInfo,upgrades_controller_init: UpgradesController):
	collision_layer = collision_layer_init
	collision_mask = collision_mask_init
	stats_controller = weapon_info_init.stats_controller
	upgrades_controller = upgrades_controller_init
	stats_controller.set_upgrades_controller(upgrades_controller)
	stats_controller.init()
	weapon_info_init.stats_controller=stats_controller
	if weapon_info_init.sprite:
		weapon_sprite = weapon_info_init.sprite.instantiate()
		animation_player = weapon_sprite.get_child(0)
		add_child(weapon_sprite)
	idle(null)

func prepare_attack(_attack_speed_value:float):
	pass
	
func finish_attack_prepare(_attack_speed_value:float):
	pass

func start_attack(_attack_speed_value:float):
	pass

func attack_start_to_hurt():
	pass

func start_recovery_attack():
	pass
	
func end_attack(_arg):
	if animation_player.animation_finished.is_connected(finish_attack_prepare):
		animation_player.animation_finished.disconnect(finish_attack_prepare)
	if animation_player.animation_finished.is_connected(end_attack):
		animation_player.animation_finished.disconnect(end_attack)
	attack_has_end.emit()
	idle(null)
	pass
	
func idle(_arg):
	animation_player.play("Idle")
	
func damage(_hurtboxComponent :HurtboxComponent):
	pass	
