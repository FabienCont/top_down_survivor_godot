extends Resource

class_name CommonStats

signal update_collect_distance
signal update_visibility
signal update_movement_speed

enum STATS_KEY{
	MOVEMENT_SPEED,
}

@export var MOVEMENT_SPEED: float = 55:
	set(updated_value):
		MOVEMENT_SPEED = updated_value
		emit_update_movement_speed(updated_value)
@export var visibility: int = 6:
	set(updated_value):
		visibility = updated_value
		emit_update_visibility(updated_value)
@export var collect_distance: int = 6:
	set(updated_value):
		collect_distance = updated_value
		emit_update_collect_distance(updated_value)

func emit_update_movement_speed(update_value: float) -> void :
	update_movement_speed.emit(update_value)

func emit_update_visibility(update_value: float) -> void :
	update_visibility.emit(update_value)

func emit_update_collect_distance(update_value: float) -> void :
	update_collect_distance.emit(update_value)
