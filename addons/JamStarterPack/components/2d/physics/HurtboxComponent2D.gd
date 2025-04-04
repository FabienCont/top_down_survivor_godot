@tool
extends CollisionShape2D

class_name HurtboxComponent2D

@export var health_component: HealthComponent:
	set(value):
		health_component = value
		update_configuration_warnings()
		
@export var shield_component: ShieldComponent:
	set(value):
		shield_component = value

func _get_configuration_warnings():
	if health_component == null:
		return ["HealthComponent is missing"]
	return []
	
func damage(attack: AttackInterface):
	var parent = get_parent()
	if parent.has_method("hurt") : 
		parent.hurt(attack)
	if shield_component:
		shield_component.damage(attack)
	if health_component:
		health_component.damage(attack)
