extends Node
class_name SpawnerComponent

@export var scene_preparation_function :Callable
 
@export var ready_to_spawn: bool = false
@export var interval_time_to_spawn: float = 2.0
@export var nb_to_spawn: int = 1
@export var infinite_spawn: bool = true
@export var node_to_spawn: Node
@export var scene_to_spawn: PackedScene
@export var group:String

@onready var nb_spawned = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ready_to_spawn == false :
		await_spawn_time()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if ready_to_spawn && ( infinite_spawn==true || nb_spawned<nb_to_spawn):
		spawnScene()

func await_spawn_time():
	await get_tree().create_timer(interval_time_to_spawn).timeout
	ready_to_spawn=true
	
func spawnScene():
	ready_to_spawn=false
	nb_spawned+=1
	var scene = scene_to_spawn.instantiate()
	if(scene_preparation_function is Callable && scene_preparation_function.is_null() != true):
		scene_preparation_function.call(scene)
	scene.target = $"../Player"
	node_to_spawn.add_child(scene)
	if group:
		scene.add_to_group(group)
	await_spawn_time()
	
