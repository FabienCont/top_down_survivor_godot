extends Node2D

@onready var spawner :SpawnerComponent = $SpawnerComponent
@onready var playerNode: CharacterBody2D = $Player
var gameClock: GameClock 

func _ready():
	Signals.level_loaded.emit()
	Signals.player_died.connect(_level_failed)
	
func init(gameClockInit: GameClock,characterInit:Character):
	spawner.gameClock = gameClockInit
	spawner.start_spawn()
	playerNode.init(characterInit)
	
func _level_failed():
	GlobalInfo.goToMenu()

func _level_succeed():
	GlobalInfo.goToNextLevel()
