@tool
extends StatModifier
class_name StatModifierEntity

@export var key_selector : StatsConstEntity.names:
	set(value_key_selector):
		key = int(value_key_selector)
	get:
		return key as StatsConstEntity.names
		
func _init():
	target = StatTarget.names.ENTITY
