extends StatDataAbstract

class_name PlayerStatData

@export var life:float=100.0
@export var max_life:float=100.0
@export var collector_distance:float=10.0
@export var visibility:float=100.0
@export var level:float=1.0
@export var movement_speed:float=37.0
@export var acceleration:float=1000.0
@export var damage:float=0.0
@export var attack_speed:float=1.0
@export var xp:float=0.0
@export var xp_multiplier:float=1.0
@export var xp_before_next_level:float=6.0
@export var xp_last_level:float=0.0

func _get_stat_key(property_name:String) -> int:
	return  StatsConstEntity.names[property_name]
	
func _get_target() -> String:
	return "ENTITY"

