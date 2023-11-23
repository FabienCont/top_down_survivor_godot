extends Node2D
class_name Weapon

@export var collider: CollisionShape2D 

@onready var weapon_sprite:Sprite2D
@onready var animation_player:AnimationPlayer
@onready var touched_ennemies= {}
@onready var attack_can_hurt : bool = false
@onready var stats: StatsController
@onready var effects:EffectsController 

var attack_speed:Stat

signal attack_has_end()
signal hit(attack:Attack)

func init(stats_init: StatsController,weapon_info_init: WeaponInfo,effects_init:EffectsController):
	stats = stats_init
	weapon_sprite = weapon_info_init.sprite.instantiate()
	animation_player = weapon_sprite.get_child(0)
	effects = effects_init
	attack_speed = stats_init.get_current_stat(stats_const.names.attack_speed)
	add_child(weapon_sprite)
	idle(null)
	
func start_attack():
	pass

func attack_start_to_hurt():
	pass

func start_recovery_attack():
	pass
	
func end_attack(_arg):
	animation_player.animation_finished.disconnect(end_attack)
	attack_has_end.emit()
	idle(null)
	pass
	
func idle(_arg):
	animation_player.play("Idle")
	
func damage(_hurtboxComponent :HurtboxComponent):
	pass	
