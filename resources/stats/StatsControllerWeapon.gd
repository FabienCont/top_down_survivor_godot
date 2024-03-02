extends StatsControllerModel
class_name StatsControllerWeapon

func _init():
	target = StatTarget.names.find_key(StatTarget.names.WEAPON)
