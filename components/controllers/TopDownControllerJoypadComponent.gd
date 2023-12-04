@tool
extends Node
class_name TopDownControllerJoypadComponent

@export var velocityComponent: VelocityComponent:
	set(value):
		velocityComponent = value
		update_configuration_warnings()


@onready var has_move_this_frame := false
@onready var move_this_frame:= Vector2()
@onready var disable := false
@onready var look_direction := Vector2()
@onready var direction := Vector2()

func _get_configuration_warnings():
	if velocityComponent == null:
		return ["VelocityComponent is missing"]
	return []
	
func has_move() -> bool:
	return has_move_this_frame

func get_move_direction() -> Vector2 :
	return move_this_frame
	
func get_look_direction() -> Vector2:
	return look_direction
	
func has_dash() -> bool:
	if Input.is_action_just_pressed("dash"):
		return true 
	return false

func has_attack() -> bool:
	#if Input.is_action_just_released("attack"):
	#	return true 
	return false
		
func has_prepare_attack() -> bool:
	if Input.is_action_just_pressed("attack"):
		return true 
	return false
	
func _reset_move():
	has_move_this_frame = false
	move_this_frame = Vector2()
	
func _save_move(move: Vector2):
	has_move_this_frame = true
	move_this_frame = move
	
func updateControl(delta):
	_reset_move()
	var pos = get_parent().get_global_mouse_position()
	if pos != null:
		look_direction = pos 
	_update_velocity(delta)

func get_current_direction():
	return direction 
	
func get_input_direction():
	return Input.get_vector("left", "right", "up", "down")

func _update_velocity(delta):
	if velocityComponent == null || disable == true:
		return
	var input_dir = get_input_direction()
	
	if input_dir.x == 0 && input_dir.y == 0 :
		velocityComponent.decelerate(delta)	
	else:
		_save_move(input_dir)
		direction = Vector2(input_dir.x, input_dir.y).normalized()
		velocityComponent.accelerate_in_direction(direction,delta)
