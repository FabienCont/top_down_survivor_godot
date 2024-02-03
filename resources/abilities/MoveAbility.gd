extends Ability

var attack_speed_stat:StatModel
var velocity_component:VelocityComponent2D

func has_requirement() -> bool:
	return possessor.velocity_component is VelocityComponent2D
	
func init_ability(entity:Entity)-> void:
	super(entity)
	velocity_component = possessor.velocity_component

func can_be_used()-> bool:
	return possessor.has_die() != true
	
func execute(delta:float)->void:
	var direction = possessor.get_current_direction()
	if direction == Vector2.ZERO:
		velocity_component.decelerate(delta)	
	else:
		velocity_component.accelerate_in_direction(possessor.get_current_direction(),delta)
	velocity_component.move(possessor)
