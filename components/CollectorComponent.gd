extends Area2D
class_name CollectorComponent

signal new_element_interact(element: Area2D)

@onready var collectables= {}

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.has_method("set_target"):
		area.set_target(get_parent())
	pass # Replace with function body.
