extends NavigationAgent2D

class_name PathFindComponent

@export var velocityComponent: VelocityComponent

func set_target_position_with_vector(position: Vector2):
	set_target_position(position)
	
func set_target_position_node(node: Node2D):
	set_target_position(node.global_position)

func follow_path(node: Node2D,delta: float):
	#if is_navigation_finished():
		#velocityComponent.decelerate(delta)
		#return;
	#	pass
	
	var direction = (get_next_path_position() - node.global_position).normalized()
	
	velocityComponent.accelerate_in_direction(direction,delta)
	set_velocity(velocityComponent.current_velocity)
	
func _on_velocity_computed(safe_velocity: Vector2) -> void:
	velocityComponent.current_velocity = safe_velocity
	velocityComponent.move(get_parent())
	pass
