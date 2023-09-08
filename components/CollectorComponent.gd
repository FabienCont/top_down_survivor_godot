extends Area2D
class_name CollectorComponent

signal new_element_interact(element: Area2D)

@onready var collectables= {}
@onready var collision_shape_2D: CollisionShape2D= $CollisionShape2D
@onready var circle: CircleShape2D = collision_shape_2D.shape
var common_stats :CommonStats

func init(commonStatsInit: CommonStats):
	common_stats = commonStatsInit
	common_stats.connect('update_collect_distance',_set_collector_size)
	_set_collector_size(common_stats.collect_distance)

func _set_collector_size(collect_distance:float):
	circle.radius = common_stats.collect_distance
	
func _on_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.has_method("set_target"):
		area.set_target(get_parent())
	pass # Replace with function body.
