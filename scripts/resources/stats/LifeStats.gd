extends Resource

class_name LifeStats

signal update_life_value
signal update_max_life_value

enum STATS_KEY{
	MAX_VALUE,
	VALUE,
}

@export var VALUE: float = 10:
	set(updated_value):
		VALUE = updated_value
		emit_update_life_value(updated_value)
	
@export var MAX_VALUE: float = 10:
	set(updated_value):
		MAX_VALUE = updated_value
		emit_update_max_life_value(updated_value)

func emit_update_life_value(value_update: float):
	update_life_value.emit(value_update)

func emit_update_max_life_value(value_update: float):
	update_max_life_value.emit(value_update)
