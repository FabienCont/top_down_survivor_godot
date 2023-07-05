extends Area2D

var target: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level=true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target != null:
		if global_position.distance_to(target.global_position) < 5 :
			if target.has_method("collect"):
				target.collect()
			queue_free()
		else :
			global_position = global_position.move_toward(target.global_position, delta * 100)  
			pass

func set_target(new_target):
	target= new_target
