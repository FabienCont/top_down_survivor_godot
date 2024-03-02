extends StatModifier
class_name StatModifierWeapon

func _init():
	target = StatTarget.names.find_key(StatTarget.names.WEAPON)
