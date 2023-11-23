extends Node

class_name VelocityComponent

@export var rotation_speed := 2.0
@export var MAX_SPEED := 100.0
@export var SPEED_FACTOR := 30.0
@export var ACCELERATION_FACTOR := 30.0
@export var FRICTION := 10.0
@onready var current_velocity:= Vector2()
@onready var last_velocity:= Vector2()
@onready var movement_speed: Stat
@onready var acceleration: Stat

var stats: StatsController

func init(stats_init: StatsController):
	stats = stats_init
	movement_speed = stats.get_current_stat(stats_const.names.movement_speed)
	acceleration = stats.get_current_stat(stats_const.names.acceleration)
	movement_speed.update_value.connect(_set_speed_factor)
	acceleration.update_value.connect(_set_acceleration_factor)
	_set_acceleration_factor(movement_speed.value)
	_set_speed_factor(acceleration.value)
	
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
	last_velocity= direction * SPEED_FACTOR
	accelerate_to_velocity(direction * SPEED_FACTOR ,delta)

func decelerate(delta:float):
	#accelerate_to_velocity(Vector2.ZERO,delta * FRICTION)
	current_velocity *= 1 - (delta * FRICTION)
func accelerate_to_velocity(velocity: Vector2,delta:float):
	#velocity=current_velocity.slerp(velocity,delta*3.0)
	current_velocity = current_velocity.move_toward(velocity,delta * ACCELERATION_FACTOR)

