extends Area2D
class_name CollectorComponent2D

@onready var collectables= {}
@onready var collision_shape_2D: CollisionShape2D= $CollisionShape2D
@onready var circle: CircleShape2D = collision_shape_2D.shape
@export var collector_distance := 10.0

func init(collector_distance_init: float):
	collector_distance= collector_distance_init

func _set_collector_size(value :float):
	circle.radius = value
	
func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_method("set_target"):
		area.set_target(get_parent())
	pass # Replace with function body.
