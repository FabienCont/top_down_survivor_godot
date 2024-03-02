extends StatsControllerModel
class_name StatsControllerAmmo

func _init():
	target = StatTarget.names.find_key(StatTarget.names.AMMO)
