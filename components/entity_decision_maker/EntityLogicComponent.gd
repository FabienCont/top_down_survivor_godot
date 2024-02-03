extends Node

class_name EntityLogicComponent

var entity: Entity

func init():
	var entity = get_parent()
	
func process_logic(delta:float) -> void:
	return

func die_logic () -> void:
	return

func hurt_logic() -> void:
	return

func collect(loot : Loot) -> void:
	return
