@tool
extends StatModifier
class_name StatModifierWeapon

@export var key_selector : StatsConstWeapon.names:
	set(value_key_selector):
		key = int(value_key_selector)
	get:
		return key

func _init():
	target = StatTarget.names.WEAPON 
	
