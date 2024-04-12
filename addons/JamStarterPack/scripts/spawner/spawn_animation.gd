extends Node2D

@export var spawn_animation: PackedScene
var scene_to_spawn: Node
var animatedSprite2D: AnimatedSprite2D 
# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite2D= spawn_animation.instantiate()
	add_child(animatedSprite2D)
	animatedSprite2D.play("Spawn")
	animatedSprite2D.animation_finished.connect(spawn_scene)

func spawn_scene():
	replace_by(scene_to_spawn)
	animatedSprite2D.play("EndSpawn")
	animatedSprite2D.animation_finished.connect(end_spawn)

func end_spawn():
	animatedSprite2D.queue_free()
