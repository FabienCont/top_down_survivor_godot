extends Area2D
class_name CollectorComponent2D

@onready var collectables= {}
@onready var collision_shape_2D: CollisionShape2D= $CollisionShape2D
@onready var circle: CircleShape2D = collision_shape_2D.shape
var collector_distance :StatModel

func init(collector_distance_init: StatModel):
	collector_distance= collector_distance_init
	collector_distance.update_value.connect(_set_collector_size)
	_set_collector_size(collector_distance.value)

func _set_collector_size(value :float):
	circle.radius = value
	
func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_method("set_target"):
		area.set_target(get_parent())
	pass # Replace with function body.
