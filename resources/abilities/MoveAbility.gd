extends Ability

var velocity_component:VelocityComponent2D

func has_requirement() -> bool:
	return entity.velocity_component is VelocityComponent2D
	
func init_ability(entity_init:Entity)-> void:
	super(entity_init)
	velocity_component = entity.velocity_component

func can_be_used()-> bool:
	return entity.has_die() != true
	
func execute(delta:float)->void:
	var direction = entity.get_current_direction()
	if direction == Vector2.ZERO:
		velocity_component.decelerate(delta)	
	else:
		velocity_component.accelerate_in_direction(direction,delta)
	velocity_component.move(entity)
