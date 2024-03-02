extends Node

class_name VelocityComponent2D

@export var rotation_speed := 2.0
@export var MAX_SPEED := 100.0
@export var movement_speed := 10.0
@export var acceleration := 10.0
@export var FRICTION := 10.0
@onready var current_velocity:= Vector2()

func init(movement_speed_init: float,acceleration_init: float):
	movement_speed = movement_speed_init
	acceleration = acceleration_init

func update_velocity(velocity: Vector2):
	current_velocity = velocity
	
func move_node(node:Node2D):
	node.position = node.position + current_velocity
	
func move(characterBody2D : CharacterBody2D):
	characterBody2D.velocity = current_velocity
	characterBody2D.move_and_slide()

func accelerate_in_direction(direction: Vector2, delta:float):
	accelerate_to_velocity(direction * movement_speed ,delta)

func decelerate(delta:float):
	current_velocity *= 1 - (delta * FRICTION)
	
func accelerate_to_velocity(velocity: Vector2,delta:float):
	current_velocity = current_velocity.move_toward(velocity,delta * acceleration)

