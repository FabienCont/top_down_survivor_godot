extends Node

func _ready() -> void:
	Signals.level_loaded.emit()
