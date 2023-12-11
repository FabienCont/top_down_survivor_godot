extends Sprite2D

@export var top_down_controller_component: TopDownControllerComponent

@export var max_range: float= 80.0
@export var normalized_range_factor: float= 40.0

func set_position_sight(new_pos: Vector2):
	if new_pos.length() > max_range:
		new_pos = max_range * new_pos.normalized()
	position = new_pos
	
func _physics_process(_delta :float) -> void:
	var direction = top_down_controller_component.get_look_direction()
	if top_down_controller_component.has_normalized_look_direction() :
		direction = direction.normalized() * normalized_range_factor 
	set_position_sight(direction)
