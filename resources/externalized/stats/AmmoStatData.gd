extends StatDataAbstract

class_name AmmoStatImportData

@export var pierce:float=3
@export var range:float=500

func _get_stat_key(property_name:String) -> int:
	return  StatsConstAmmo.names[property_name]
	
func _get_target() -> String:
	return "AMMO"

