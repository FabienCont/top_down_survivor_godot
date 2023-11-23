extends Node
class_name FollowTargetComponent

@export var velocityComponent: VelocityComponent
@export var target: Node2D

func set_node_to_follow(node:Node2D):
	target = node

func follow_target(node: Node2D,delta: float):
	if target != null:
		var direction = (target.global_position-node.global_position ).normalized()
		velocityComponent.accelerate_in_direction(direction,delta)
