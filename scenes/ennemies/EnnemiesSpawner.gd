extends Node2D

class_name EnnemiesSpawner

@onready var spawner :SpawnerComponent = $SpawnerComponent
@export var player: Player
@export var node_to_spawn: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(game_clock_init: GameClock):
	spawner.node_to_spawn = node_to_spawn
	spawner.gameClock = game_clock_init
	spawner.scene_preparation_function = ennemy_scene_preparation
	spawner.player = player
	spawner.start_spawn()

func ennemy_scene_preparation(ennemy_to_spawn: Ennemy):
	ennemy_to_spawn.set_sprite(ennemy_to_spawn.sprite)
	
