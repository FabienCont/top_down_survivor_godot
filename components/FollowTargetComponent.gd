extends Node
class_name FollowTargetComponent

@export var velocity_component: VelocityComponent
@export var target: Node2D
@onready var direction: Vector2
@onready var distance: Vector2
func set_velocity_component(component:VelocityComponent):
	velocity_component=component
	
func set_node_to_follow(node:Node2D):
	target = node
	
func get_current_direction():
	return direction 

func update_look_at_direction(node:Node2D):
	direction = (target.global_position-node.global_position ).normalized()

func follow_target(node: Node2D,delta: float):
	if target != null && velocity_component != null:
		update_look_at_direction(node)
		velocity_component.accelerate_in_direction(direction,delta)
