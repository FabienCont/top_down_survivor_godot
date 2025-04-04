extends Ability

var dash_shadow_count:=0

func has_requirements() -> bool:
	return true

func init_ability(entity_init:Entity)-> void:
	super(entity_init)
	cooldown = 15.0

func end()->void:
	super()
	entity.velocity_component.update_velocity(Vector2.ZERO)
	
func create_ghost(_delta:float) -> void:
	DashGhostHelper.create_ghost(entity,entity.sprite_component)

func update(delta: float) -> void:
	pass
	
func execute(delta:float)->void:
	super(delta)
	if timer_ability == null:
		init_timer_ability()
	dash_shadow_count=0
	var direction = entity.get_current_direction()
	entity.velocity_component.update_velocity(direction * 180 )
	entity.velocity_component.move(entity)
	timer_ability.start(0.180)
