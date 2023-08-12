class_name TopDownControllerComponent
extends Node

@export var velocityComponent: VelocityComponent

@onready var has_move_this_frame = false
@onready var move_this_frame:= Vector2()
@onready var disable = false

func has_move() -> bool:
	return has_move_this_frame
	
func get_move_direction() -> Vector2 :
	return move_this_frame

func has_attack() -> bool:
	if Input.is_action_just_pressed("click"):
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
	_update_velocity(delta)

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
		var direction = Vector2(input_dir.x, input_dir.y).normalized()
		velocityComponent.accelerate_in_direction(direction,delta)
