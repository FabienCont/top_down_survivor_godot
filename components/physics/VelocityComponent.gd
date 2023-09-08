extends Node

class_name VelocityComponent

@export var MAX_SPEED = 100.0
@export var SPEED_FACTOR = 55.0
@export var ACCELERATION_FACTOR = 200.0
@export var FRICTION = 3.0
@onready var current_velocity:= Vector2()

var common_stats: CommonStats

func init(common_stats_init: CommonStats):
	common_stats = common_stats_init
	common_stats.connect("update_movement_speed",_set_speed_factor)
	
func _set_speed_factor(value: float):
	SPEED_FACTOR = value
	
func update_velocity(velocity: Vector2):
	current_velocity = velocity
	
func move_node(node:Node2D):
	current_velocity = current_velocity.clamp(Vector2(-MAX_SPEED,-MAX_SPEED),Vector2(MAX_SPEED,MAX_SPEED))
	node.position = node.position + current_velocity
	
func move(characterBody2D : CharacterBody2D):
	#current_velocity = current_velocity.clamp(Vector2(-MAX_SPEED,-MAX_SPEED),Vector2(MAX_SPEED,MAX_SPEED))
	characterBody2D.velocity = current_velocity
	characterBody2D.move_and_slide()

func accelerate_in_direction(direction: Vector2, delta:float):
	accelerate_to_velocity(direction * SPEED_FACTOR ,delta)

func decelerate(delta:float):
	accelerate_to_velocity(Vector2.ZERO,delta * FRICTION)
	
func accelerate_to_velocity(velocity: Vector2,delta:float):
	current_velocity = current_velocity.move_toward(velocity,delta * ACCELERATION_FACTOR)
