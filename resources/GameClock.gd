extends Resource

class_name GameClock

signal wave_changed

@export var time:float = 0.0
@export var wave:int = 1:
	set(value):
		wave = value
		wave_changed.emit()
