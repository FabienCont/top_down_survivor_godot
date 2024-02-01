extends Node

class_name GameClock

signal wave_changed

@onready var time:float = 0.0
@onready var wave:int = 1:
	set(value):
		wave = value
		wave_changed.emit()
