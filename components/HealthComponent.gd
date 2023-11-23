extends Node
class_name HealthComponent

var life : Stat
	
func init(stats_init: StatsController) -> void :
	life = stats_init.get_current_stat(stats_const.names.life)
	
func damage(attack: Attack):
	life.value -= attack.attack_damage
	if life.value <= 0:
		var parent = get_parent();
		if parent.has_method("die"):
			parent.die();

