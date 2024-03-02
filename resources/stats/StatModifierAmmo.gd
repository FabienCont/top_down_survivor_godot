extends StatModifier
class_name StatModifierAmmo

func _init():
	target = StatTarget.names.find_key(StatTarget.names.AMMO)
