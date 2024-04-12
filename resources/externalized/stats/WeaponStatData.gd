extends StatDataAbstract

class_name WeaponStatData

@export var nb_projectile:float=1.0
@export var rotation_between_projectiles:float=4.0
@export var knockback:float=1.0


func _get_stat_key(property_name:String) -> int:
	return  StatsConstWeapon.names[property_name]
	
func _get_target() -> String:
	return "WEAPON"
