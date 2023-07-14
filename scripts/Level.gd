extends Node2D

@onready var spawner :SpawnerComponent = $SpawnerComponent
var gameClock: GameClock 

func _ready():
	Signals.level_loaded.emit()
	Signals.player_died.connect(_level_failed)
	
func start_spawn():
	spawner.gameClock = gameClock
	spawner.start_spawn()
	
func _level_failed():
	GlobalInfo.goToMenu()

func _level_succeed():
	GlobalInfo.goToNextLevel()
