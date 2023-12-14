extends Node2D

class_name EnnemiesSpawner

@onready var spawner :SpawnerComponent = $SpawnerComponent
@export var player: Player
@export var node_to_spawn: Node

var possible_ennemies = []
var dir_path_ennemies = "res://scripts/resources/ennemies/"
var resource_extension="tres"

func _ready() -> void :
	for file_path in DirAccess.get_files_at(dir_path_ennemies): 
		if file_path.get_extension() == resource_extension:  
			possible_ennemies.append( load(dir_path_ennemies+file_path) )
	pass # Replace with function body.

func init(game_clock_init: GameClock):
	spawner.node_to_spawn = node_to_spawn
	spawner.gameClock = game_clock_init
	spawner.scene_preparation_function = ennemy_scene_preparation
	spawner.player = player
	spawner.start_spawn()

func ennemy_scene_preparation(ennemy_to_spawn: Ennemy):
	var ennemy_info = get_random_ennemy_info()

	ennemy_to_spawn.weapon_info = ennemy_info.weapon_info
	ennemy_to_spawn.init(ennemy_info.stats_controller,ennemy_info.upgrades_controller)
	if ennemy_info.name=="ghost" : 
		ennemy_to_spawn.distance_before_attack = 100.0
	ennemy_to_spawn.set_sprite(ennemy_info.sprite.instantiate() as AnimatedSprite2D)
	
func get_random_ennemy_info()->EnnemyInfo:
	var index = randi() % possible_ennemies.size()
	return possible_ennemies[index] 
