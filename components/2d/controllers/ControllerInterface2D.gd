extends Node

class_name ControllerInterface2D

@onready var _has_move_this_frame := false
@onready var _move_this_frame:= Vector2()
@onready var disable := false
@onready var look_direction := Vector2()
@onready var direction := Vector2()
@onready var old_mouse_pos := Vector2()
@onready var is_joypad :bool = false
@onready var joypad_index :int = 0
@onready var _is_look_direction_normalized:= true

func _has_move() -> bool:
	return false

func get_move_direction() -> Vector2 :
	return Vector2(0.0,0.0)
	
func get_look_direction() -> Vector2:
	return look_direction
	
func has_dash() -> bool:
	return false
func has_attack() -> bool:
	return false
		
func has_prepare_attack() -> bool:
	return false
	
func _reset_move() -> void:
	_has_move_this_frame = false
	_move_this_frame = Vector2()
	
func _save_move(move: Vector2) -> void:
	_has_move_this_frame = true
	_move_this_frame = move
	
func update_control(delta):
	return

func has_normalized_look_direction()-> bool:
	return _is_look_direction_normalized
	
func get_current_direction():
	return direction 

func get_input_direction() -> Vector2:
	return  Vector2(0.0,0.0)
	
func _update_velocity(_delta) -> void:
	return
