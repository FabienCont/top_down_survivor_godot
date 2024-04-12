extends Node
class_name HealthComponent

var life : StatModel
	
func init(life_init: StatModel) -> void :
	life = life_init
	
func damage(attack: AttackInterface):
	life.value -= attack.attack_damage
	if life.value <= 0:
		var parent = get_parent();
		if parent.has_method("die"):
			parent.die();
