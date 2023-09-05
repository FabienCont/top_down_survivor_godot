extends Node
class_name HealthComponent

signal update_health(value: float)
signal update_max_health(value: float)

var lifeStats : LifeStats
	
func init(lifeStatsInit: LifeStats) -> void :
	lifeStats = lifeStatsInit
	_emit_update_max_life(lifeStats.MAX_VALUE)
	_emit_update_life(lifeStats.VALUE)
	_set_life_stats(lifeStats)
	
func _emit_update_max_life(max_life_value:float) : 
	update_max_health.emit(max_life_value)
	
func _emit_update_life(life_value:float) :
	update_health.emit(life_value)

func _set_life_stats(lifeStatsUpdate: LifeStats):
	_emit_update_max_life(lifeStatsUpdate.MAX_VALUE)
	_emit_update_life(lifeStatsUpdate.VALUE)
	
func damage(attack: Attack):
	lifeStats.VALUE -= attack.attack_damage
	_emit_update_life(lifeStats.VALUE)
	
	if lifeStats.VALUE <= 0:
		var parent = get_parent();
		if parent.has_method("die"):
			parent.die();

	
