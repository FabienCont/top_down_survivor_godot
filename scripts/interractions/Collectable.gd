extends Area2D
class_name Collectable

var target: Node2D
@export var loot: Loot = Loot.new()

func _ready() -> void:
	var sprite = Sprite2D.new()
	sprite.texture= loot.item.texture
	add_child(sprite)
	top_level=true

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
	target = new_target
