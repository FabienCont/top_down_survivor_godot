extends DamageableComponentInterface
class_name ShieldComponent

var shield : StatModel

func init(shield_init: StatModel) -> void :
	shield = shield_init
	
func damage(attack: AttackInterface):
	shield.value -= attack.attack_damage
	if shield.value <= 0:
		attack.attack_damage -= shield.value
		shield.value = 0.0
