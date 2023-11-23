extends Area2D

var target: Node2D
@export var loot: Loot = Loot.new()
@onready var modifier = preload( "res://scripts/resources/stats/modifiers/xp_loot.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_modifier = modifier.duplicate()
	loot.modifiers = []
	loot.modifiers.push_back(new_modifier)
	top_level=true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target != null:
		if global_position.distance_to(target.global_position) < 5 :
			if target.has_method("collect"):
				target.collect(loot)
			queue_free()
		else :
			global_position = global_position.move_toward(target.global_position, delta * 100)  
			pass

func set_target(new_target):
	target= new_target
