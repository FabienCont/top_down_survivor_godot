extends StatsControllerModel
class_name StatsControllerEntity

func _init():
	target = StatTarget.names.find_key(StatTarget.names.ENTITY)
