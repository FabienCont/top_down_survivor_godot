extends Node
class_name SpawnerComponent

@export var scene_preparation_function :Callable
@export var ready_to_spawn: bool = false
@export var interval_time_to_spawn: float = 2.0
@export var nb_to_spawn: int = 1
@export var infinite_spawn: bool = true
@export var node_to_spawn: Node
@export var scene_to_spawn: PackedScene
@export var player: Node
@export var group:String

@export var game_clock: GameClock 
@onready var nb_spawned = 0

func start_spawn() -> void:
	_await_spawn_time()
		
func _process(_delta: float) -> void:
	if ready_to_spawn && ( infinite_spawn==true || nb_spawned<nb_to_spawn):
		_spawn_scene()

func _await_spawn_time():
	var factor = 1.0 / (game_clock.wave * 1.2)
	await get_tree().create_timer(interval_time_to_spawn * factor).timeout
	ready_to_spawn=true
	
func _spawn_scene() -> void:
	ready_to_spawn=false
	nb_spawned+=1
	var scene = scene_to_spawn.instantiate()
	scene.target = player 
	if(scene_preparation_function is Callable && scene_preparation_function.is_null() != true):
		scene_preparation_function.call(scene)
	if group:
		scene.add_to_group(group)
	node_to_spawn.add_child(scene)
	_await_spawn_time()
	
