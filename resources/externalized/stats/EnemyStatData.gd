extends StatDataAbstract

class_name EnemyStatData

@export var life:float=100.0
@export var max_life:float=100.0
@export var visibility:float=100.0
@export var movement_speed:float=37.0
@export var acceleration:float=1000.0
@export var damage:float=0.0
@export var attack_speed:float=1.0
@export var collector_distance:float=10.0

func _get_stat_key(property_name:String) -> int:
	return  StatsConstEntity.names[property_name]
	
func _get_target() -> String:
	return "ENTITY"
