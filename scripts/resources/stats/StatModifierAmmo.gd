@tool
extends StatModifier
class_name StatModifierAmmo

@export var key_selector : StatsConstAmmo.names:
	set(value_key_selector):
		key = int(value_key_selector)
	get:
		return key

func _init():
	target = StatTarget.names.AMMO 
