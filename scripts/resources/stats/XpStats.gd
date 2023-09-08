extends Resource

class_name XpStats

signal update_value
signal update_max_value
signal update_xp_multiplier
signal update_level


enum STATS_KEY{
	XP_MULTIPLIER
}

@export var VALUE: float = 0.0:
	set(updated_value):
		VALUE = updated_value
		update_value.emit(VALUE)
		
@export var MAX_VALUE: float = 10.0:
	set(updated_value):
		MAX_VALUE = updated_value
		update_max_value.emit(MAX_VALUE)
		
@export var XP_MULTIPLIER: float= 1.0:
	set(updated_value):
		XP_MULTIPLIER = updated_value
		update_xp_multiplier.emit(XP_MULTIPLIER)
		
@export var LEVEL: int = 1:
	set(updated_value):
		LEVEL = updated_value
		update_level.emit(LEVEL)

