extends Node2D

class_name EnnemiesSpawner

@onready var spawner :SpawnerComponent = $SpawnerComponent
@onready var spawn_animation_scene = preload("res://scenes/spawner/devil_door_spawn.tscn")
@onready var rnd: RandomNumberGenerator = RandomNumberGenerator.new()

@export var player: Player
@export var node_to_spawn: Node

var possible_rules = []
var dir_path_rules = "res://resources/spawn_infos/waves_spawn_rules/"
var resource_extension="tres"
var game_clock:GameClock
var ennemies_spawn_rule :EnnemiesSpawnRules
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
	spawner.scene_preparation_function = ennemy_scene_preparation
	spawner.player = player
	update_spawn_rule()
	spawner.start_spawn()

func update_spawn_rule():
	ennemies_spawn_rule = possible_rules[game_clock.wave-1]
	ennemies_spawn_rule.compute_ennemy_probability_to_spawn()
	
func ennemy_scene_preparation(ennemy_to_spawn: Ennemy):
	var ennemy_info = get_random_ennemy_info()
	ennemy_to_spawn.global_position = _calc_position_spawn(ennemy_info.spwan_in_arena,arena) 
	ennemy_to_spawn.weapon_info = ennemy_info.weapon_info
	ennemy_to_spawn.init(ennemy_info.stats_controller,ennemy_info.upgrades_controller,ennemy_info.abilities_controller)
	if ennemy_info.name=="ghost" : 
		ennemy_to_spawn.distance_before_attack = 100.0
	ennemy_to_spawn.set_sprite(ennemy_info.sprite.instantiate() as AnimatedSprite2D)
	if ennemy_info.spwan_in_arena == true:
		var spawner_scene = spawn_animation_scene.instantiate()
		spawner_scene.scene_to_spawn = ennemy_to_spawn
		spawner_scene.global_position = ennemy_to_spawn.global_position
		var parent = ennemy_to_spawn.get_parent()
		parent.remove_child(ennemy_to_spawn)
		parent.add_child(spawner_scene)
	
func get_random_ennemy_info()->EnnemyInfo:
	return ennemies_spawn_rule.get_random_ennemy_info().ennemy_info
	#var index = randi() % possible_ennemies.size()
	#return possible_ennemies[index] 

func _calc_position_spawn(spwan_in_arena:bool,arena) -> Vector2 :
	if spwan_in_arena == true:
		return calc_position_spawn_in_arena(arena)
	else:
		return calc_position_spawn_outside_arena()
	
func calc_position_spawn_in_arena(arena) -> Vector2:
	var polygon = arena.navigation_polygon.get_vertices()
	var polygonRandomPointGeneratorHelper = PolygonRandomPointGeneratorHelper.new(polygon)
	return polygonRandomPointGeneratorHelper.get_random_point()
	
func calc_position_spawn_outside_arena() -> Vector2:
	var camera_vision = 340
	var pos = (Vector2.ONE * camera_vision).rotated(rnd.randf_range(0, PI))
	if player != null:
		pos = pos + player.global_position
		return pos
	return Vector2(0,0)
	
