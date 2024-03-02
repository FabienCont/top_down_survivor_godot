extends StatModifier
class_name StatModifierEntity

func _init():
	target = StatTarget.names.find_key(StatTarget.names.ENTITY)
