@tool
extends Node
class_name TopDownControllerComponent2D

@onready var has_move_this_frame := false
@onready var move_this_frame:= Vector2()
@onready var disable := false
@onready var look_direction := Vector2()
@onready var direction := Vector2()
@onready var old_mouse_pos := Vector2()
@onready var is_joypad :bool = false
@onready var joypad_index :int = 0
@onready var is_look_direction_normalized:= true

func _ready():
	if not Engine.is_editor_hint():	
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

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
	var mouse_pos = get_parent().get_global_mouse_position()
	if Input.get_last_mouse_velocity() != Vector2.ZERO && mouse_pos != null :
		look_direction = (mouse_pos-get_parent().global_position)
		old_mouse_pos = mouse_pos
		is_look_direction_normalized= false
	var joypad_direction = Input.get_vector("look_left","look_right","look_up","look_down")
	if joypad_direction != Vector2.ZERO :
		look_direction = joypad_direction
		is_look_direction_normalized= true
	_update_velocity(delta)

func has_normalized_look_direction()-> bool:
	return is_look_direction_normalized
	
func get_current_direction():
	return direction 

func get_input_direction() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")
	
func _update_velocity(_delta):
	if disable == true:
		return
	var input_dir = get_input_direction()
	
	if input_dir.x == 0 && input_dir.y == 0 :
		direction = Vector2.ZERO
	else:
		_save_move(input_dir)
		direction = Vector2(input_dir.x, input_dir.y).normalized()
