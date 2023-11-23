extends Node2D

@onready var spawner :SpawnerComponent = $SpawnerComponent
@onready var playerNode: CharacterBody2D = $Player
var gameClock: GameClock 

func _ready():
	Signals.level_loaded.emit()
	Signals.player_died.connect(_level_failed)
	
func init(game_clock_init: GameClock,player_init:Player):
	spawner.gameClock = game_clock_init
	spawner.start_spawn()
	playerNode.init(player_init)
	
func _level_failed():
	Engine.time_scale = 0.5
	await get_tree().create_timer(2.0).timeout
	Engine.time_scale = 1.0
	GlobalInfo.goToMenu()

func _level_succeed():
	GlobalInfo.goToNextLevel()
