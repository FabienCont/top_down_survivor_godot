extends Node2D
class_name Ammo

@onready var velocityComponent :VelocityComponent = $VelocityComponent 
@onready var sprite :Node2D
@onready var hitboxComponent :HitboxComponent = $HitboxComponent 
@onready var stats: StatsController
@onready var ammo_info: AmmoInfo

var init_position: Vector2
var pierce: Stat
var range: Stat
var ennemy_pierced := 0 

func init(stats_init:StatsController, ammo_info_init:AmmoInfo) -> void:
	stats = stats_init
	ammo_info = ammo_info_init
	sprite = ammo_info.sprite.instantiate()
	init_position = global_position
	add_child(sprite)
	pierce = stats.get_current_stat(stats_const.names.pierce)
	range = stats.get_current_stat(stats_const.names.range)
	#var child = sprite.get_child(0)
	#if child !=null && child is AnimationPlayer:
	#	child.play("Idle")
	
func _ready() -> void:
	top_level=true

func get_range_value() -> float:
	if range != null:
		return range.value
	return 500.0
func get_pierce_value() -> float:
	if pierce != null:
		return pierce.value
	return 3
	
func _process(delta: float) -> void:
	if init_position.distance_to(global_position) > get_range_value():
		destroy()
	var direction = Vector2(1,0)
	direction = direction.rotated(global_rotation)
	velocityComponent.accelerate_in_direction(direction,delta)
	velocityComponent.move_node(self)
	
func destroy():
	queue_free()
	
func _on_hitbox_component_hit(_attack: Attack) -> void:
	ennemy_pierced += 1 
	if ennemy_pierced >= get_pierce_value():
		destroy()
