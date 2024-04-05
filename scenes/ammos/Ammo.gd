extends Node2D
class_name Ammo

@onready var velocity_component :VelocityComponent2D = $VelocityComponent 
@onready var sprite :Node2D
@onready var hitbox_component :HitboxComponent2D = $HitboxComponent 
@onready var stats_controller: StatsController
@onready var ammo_info: AmmoInfo
@onready var upgrades_controller: UpgradesController
@onready var emiter

@onready var init_position: Vector2
var pierce_stat: StatModel
var range_stat: StatModel
var ennemy_pierced := 0 
@onready var direction = Vector2(1,0)
@onready var collision_layer: int
@onready var collision_mask: int

func init(collision_layer_init: int,collision_mask_init: int,ammo_info_init: AmmoInfo,upgrades_controller_init: UpgradesController) -> void:
	ammo_info = ammo_info_init
	stats_controller = ammo_info.stats_controller
	upgrades_controller = upgrades_controller_init
	stats_controller.set_upgrades_controller(upgrades_controller_init)
	stats_controller.init()
	sprite = ammo_info.sprite.instantiate()
	add_child(sprite)
	pierce_stat = stats_controller.get_current_stat(StatsConstAmmo.names.pierce)
	range_stat = stats_controller.get_current_stat(StatsConstAmmo.names.range)
	collision_layer = collision_layer_init
	collision_mask = collision_mask_init
	emiter = get_parent()
func clone() -> Node:
	var node = self.duplicate()	
	node.init(collision_layer,collision_mask,ammo_info,upgrades_controller)
	return node
	
func _ready() -> void:
	top_level=true
	init_position = Vector2(global_position)
	direction = direction.rotated(global_rotation)
	hitbox_component.collision_layer = collision_layer
	hitbox_component.collision_mask = collision_mask
	
func get_range_value() -> float:
	if range_stat != null:
		return range_stat.value
	return 500.0
	
func get_pierce_value() -> float:
	if pierce_stat != null:
		return pierce_stat.value
	return 3
	
func _process(_delta: float) -> void:
	if init_position.distance_to(global_position) > get_range_value():
		destroy()
	velocity_component.move_node(self)

func destroy():
	queue_free()
	
func _on_hitbox_component_hit(_attack: AttackInterface) -> void:
	ennemy_pierced += 1 
	if ennemy_pierced >= get_pierce_value():
		destroy()
		
func _on_hitbox_component_hit_terrain() -> void:
	destroy()
