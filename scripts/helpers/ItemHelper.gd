extends Node
class_name ItemHelper

const collectable = preload("res://scenes/collectables/Collectable.tscn")

static func create_collectable(item:Item) -> Collectable :
	var scene = collectable.instantiate()
	scene.loot.item = item.duplicate(true)
	return scene
