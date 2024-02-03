@tool
extends CollisionShape2D

class_name HurtboxComponent2D

@export var health_component: HealthComponent:
	set(value):
		health_component = value
		update_configuration_warnings()

func _get_configuration_warnings():
	if health_component == null:
		return ["HealthComponent is missing"]
	return []
	
func damage(attack: Attack):
	var parent = get_parent()
	if parent.has_method("hurt") : 
		parent.hurt(attack)
	if health_component:
		health_component.damage(attack)
