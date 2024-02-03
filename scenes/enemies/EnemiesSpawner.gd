extends Node2D

class_name EnemiesSpawner

@onready var spawner :SpawnerComponent = $SpawnerComponent
@onready var spawn_animation_scene = preload("res://scenes/spawner/devil_door_spawn.tscn")
@onready var rnd: RandomNumberGenerator = RandomNumberGenerator.new()

@export var player: Player
@export var node_to_spawn: Node

var possible_rules = []
var dir_path_rules = "res://resources/spawn_infos/waves_spawn_rules/"
var resource_extension="tres"
var game_clock:GameClock
var enemies_spawn_rule :EnemiesSpawnRules
@export var arena: NavigationRegion2D

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
	spawner.scene_preparation_function = enemy_scene_preparation
	spawner.player = player
	update_spawn_rule()
	spawner.start_spawn()

func update_spawn_rule():
	enemies_spawn_rule = possible_rules[game_clock.wave-1]
	enemies_spawn_rule.compute_enemy_probability_to_spawn()
	
func enemy_scene_preparation(enemy_to_spawn: Enemy):
	var enemy_info = get_random_enemy_info().duplicate(true)
	enemy_to_spawn.global_position = _calc_position_spawn(enemy_info.spawn_in_arena,arena) 
	enemy_to_spawn.init_enemy(enemy_info)

	if enemy_info.name=="ghost" : 
		enemy_to_spawn.distance_before_attack = 100.0
	if enemy_info.spawn_in_arena == true:
		var spawner_scene = spawn_animation_scene.instantiate()
		spawner_scene.scene_to_spawn = enemy_to_spawn
		spawner_scene.global_position = enemy_to_spawn.global_position
		var parent = enemy_to_spawn.get_parent()
		parent.remove_child(enemy_to_spawn)
		parent.add_child(spawner_scene)
	
func get_random_enemy_info()->EnemyInfo:
	return enemies_spawn_rule.get_random_enemy_info().enemy_info
	#var index = randi() % possible_enemies.size()
	#return possible_enemies[index] 

func _calc_position_spawn(spawn_in_arena:bool,arena_to_calc) -> Vector2 :
	if spawn_in_arena == true:
		return calc_position_spawn_in_arena(arena_to_calc)
	else:
		return calc_position_spawn_outside_arena()
	
func calc_position_spawn_in_arena(arena_to_calc) -> Vector2:
	var polygon = arena_to_calc.navigation_polygon.get_vertices()
	var polygonRandomPointGeneratorHelper = PolygonRandomPointGeneratorHelper.new(polygon)
	return polygonRandomPointGeneratorHelper.get_random_point()
	
func calc_position_spawn_outside_arena() -> Vector2:
	var camera_vision = 340
	var pos = (Vector2.ONE * camera_vision).rotated(rnd.randf_range(0, PI))
	if player != null:
		pos = pos + player.global_position
		return pos
	return Vector2(0,0)
	
