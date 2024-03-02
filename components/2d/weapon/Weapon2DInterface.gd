extends Node2D
class_name Weapon2DInterface

@onready var weapon_sprite:Sprite2D
@onready var animation_player:AnimationPlayer
@onready var upgrades_controller:UpgradesController 
@onready var stats_controller: StatsControllerWeapon
@onready var emiter

@onready var collision_layer: int
@onready var collision_mask: int

signal attack_ready()
signal attack_has_end()
signal hit(attack:AttackInterface)

func init(collision_layer_init: int,collision_mask_init: int,weapon_info_init: WeaponInfo,upgrades_controller_init: UpgradesController,emiter_init:Node):
	pass

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
	pass
	
func idle(_arg):
	pass
	
func damage(_hurtboxComponent :HurtboxComponent2D):
	pass

func apply_attack_modifier(attack:AttackInterface)->void:
	pass
