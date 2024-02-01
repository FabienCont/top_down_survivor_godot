extends Ability

var attack_speed_stat:StatModel
var velocity_component:VelocityComponent

func has_requirement() -> bool:
	return possessor.velocity_component is VelocityComponent
	
func init_ability(owner:Entity)-> void:
	super(owner)
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
