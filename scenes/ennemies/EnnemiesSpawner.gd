extends Node2D

class_name EnnemiesSpawner

@onready var spawner :SpawnerComponent = $SpawnerComponent
@export var player: Player
@export var node_to_spawn: Node

var possible_rules = []
var dir_path_rules = "res://scripts/resources/spawn_infos/waves_spawn_rules/"
var resource_extension="tres"
var game_clock:GameClock
var ennemies_spawn_rule :EnnemiesSpawnRules
func _ready() -> void :
	possible_rules= Array()
	possible_rules.resize(10)
	for file_path in DirAccess.get_files_at(dir_path_rules): 
		if file_path.get_extension() == resource_extension:  
			var index = int(file_path.get_basename().right(file_path.length() - 16 ))
			possible_rules[index-1] = load(dir_path_rules+file_path)
	pass # Replace with function body.

func init(game_clock_init: GameClock):
	spawner.node_to_spawn = node_to_spawn
	game_clock = game_clock_init
	game_clock.wave_changed.connect(update_spawn_rule)
	spawner.game_clock = game_clock_init
	spawner.scene_preparation_function = ennemy_scene_preparation
	spawner.player = player
	update_spawn_rule()
	spawner.start_spawn()

func update_spawn_rule():
	ennemies_spawn_rule = possible_rules[game_clock.wave-1]
	ennemies_spawn_rule.compute_ennemy_probability_to_spawn()
	
func ennemy_scene_preparation(ennemy_to_spawn: Ennemy):
	var ennemy_info = get_random_ennemy_info()

	ennemy_to_spawn.weapon_info = ennemy_info.weapon_info
	ennemy_to_spawn.init(ennemy_info.stats_controller,ennemy_info.upgrades_controller)
	if ennemy_info.name=="ghost" : 
		ennemy_to_spawn.distance_before_attack = 100.0
	ennemy_to_spawn.set_sprite(ennemy_info.sprite.instantiate() as AnimatedSprite2D)
	
func get_random_ennemy_info()->EnnemyInfo:
	return ennemies_spawn_rule.get_random_ennemy_info().ennemy_info
	#var index = randi() % possible_ennemies.size()
	#return possible_ennemies[index] 
