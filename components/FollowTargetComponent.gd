extends Node
class_name FollowTargetComponent

@export var velocity_component: VelocityComponent
@export var target: Node2D

func set_velocity_component(component:VelocityComponent):
	velocity_component=component
	
func set_node_to_follow(node:Node2D):
	target = node

func follow_target(node: Node2D,delta: float):
	if target != null && velocity_component != null:
		var direction = (target.global_position-node.global_position ).normalized()
		velocity_component.accelerate_in_direction(direction,delta)
