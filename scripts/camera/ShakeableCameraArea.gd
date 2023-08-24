extends Area2D

@export var trauma_reduction_rate := 1.0
@export var node_to_follow :Node2D

@export var max_x := 16.0
@export var max_y := 16.0

@export var current: bool = true
@export var noise : FastNoiseLite
@export var noise_speed := 20.0

var trauma := 0.0

var time := 0.0

@onready var camera :Camera2D= $Camera2D 
@onready var initial_offset : Vector2= camera.offset

func _ready():
	camera.make_current()
	camera.node_to_follow = node_to_follow
	
func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate, 0.0)
	
	camera.offset.x = initial_offset.x + max_x * get_shake_intensity() * get_noise_from_seed(0)
	camera.offset.y = initial_offset.y + max_y * get_shake_intensity() * get_noise_from_seed(0)
	
func add_trauma(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)

func get_shake_intensity() -> float:
	return trauma * trauma

func get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)

### trauma_causer.gd
### COPY THIS CODE INTO ITS OWN FILE!

#extends Area

#@export var trauma_amount := 0.1

#Calling this method will check for all shakeable cameras the "trauma causer" overlaps with, then increase the screenshake intensity.
#func cause_trauma():
#	var trauma_areas := get_overlapping_areas()
#	for area in trauma_areas:
#		if area.has_method("add_trauma"):
#			area.add_trauma(trauma_amount)
