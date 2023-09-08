extends Node
class_name HealthComponent

var lifeStats : LifeStats
	
func init(lifeStatsInit: LifeStats) -> void :
	lifeStats = lifeStatsInit
	
func damage(attack: Attack):
	lifeStats.VALUE -= attack.attack_damage
	
	if lifeStats.VALUE <= 0:
		var parent = get_parent();
		if parent.has_method("die"):
			parent.die();

	
