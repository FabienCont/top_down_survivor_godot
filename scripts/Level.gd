extends Node2D

@onready var spawner :SpawnerComponent = $SpawnerComponent
@onready var playerNode: CharacterBody2D = $Player
var gameClock: GameClock 

func _ready():
	Signals.level_loaded.emit()
	Signals.player_died.connect(_level_failed)
	
func init(gameClockInit: GameClock,playerInit:Player):
	spawner.gameClock = gameClockInit
	spawner.start_spawn()
	playerNode.init(playerInit)
	
func _level_failed():
	Engine.time_scale = 0.5
	await get_tree().create_timer(2.0).timeout
	Engine.time_scale = 1.0
	GlobalInfo.goToMenu()

func _level_succeed():
	GlobalInfo.goToNextLevel()
