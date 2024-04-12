extends Node
class_name ItemHelper

const collectable = preload("res://scenes/interractions/Collectable.tscn")

static func create_collectable(item:Item) -> Collectable :
	var scene = collectable.instantiate()
	scene.loot.item = item.duplicate(true)
	return scene
