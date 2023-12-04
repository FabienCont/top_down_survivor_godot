extends Node

class_name VelocityComponent

@export var rotation_speed := 2.0
@export var MAX_SPEED := 100.0
@export var SPEED_FACTOR := 10.0
@export var ACCELERATION_FACTOR := 10.0
@export var FRICTION := 10.0
@onready var current_velocity:= Vector2()
@onready var movement_speed: StatModel
@onready var acceleration: StatModel

func init(movement_speed_init: StatModel,acceleration_init: StatModel):
	movement_speed = movement_speed_init
	acceleration = acceleration_init
	movement_speed.update_value.connect(_set_speed_factor)
	acceleration.update_value.connect(_set_acceleration_factor)
	_set_acceleration_factor(acceleration.value)
	_set_speed_factor(movement_speed.value)
	
func _set_acceleration_factor(value: float):
	ACCELERATION_FACTOR = value
	
func _set_speed_factor(value: float):
	SPEED_FACTOR = value
	
func update_velocity(velocity: Vector2):
	current_velocity = velocity
	
func move_node(node:Node2D):
	node.position = node.position + current_velocity
	
func move(characterBody2D : CharacterBody2D):
	characterBody2D.velocity = current_velocity
	characterBody2D.move_and_slide()

func accelerate_in_direction(direction: Vector2, delta:float):
	accelerate_to_velocity(direction * SPEED_FACTOR ,delta)

func decelerate(delta:float):
	current_velocity *= 1 - (delta * FRICTION)
	
func accelerate_to_velocity(velocity: Vector2,delta:float):
	current_velocity = current_velocity.move_toward(velocity,delta * ACCELERATION_FACTOR)

