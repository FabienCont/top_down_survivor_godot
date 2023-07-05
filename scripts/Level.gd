extends Node2D

func _ready():
	Signals.level_loaded.emit()
	Signals.player_died.connect(_level_failed)
	
func _level_failed():
	GlobalInfo.goToMenu()

func _level_succeed():
	GlobalInfo.goToNextLevel()
