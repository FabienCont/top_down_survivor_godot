extends Ability

@onready var dash_shadow_count:=0

func has_requirements() -> bool:
	return possessor.velocity_component is VelocityComponent

func _init_ability():
	cooldown = 2.0

func end()->void:
	super()
	possessor.velocity_component.update_velocity(Vector2.ZERO )
	
func create_ghost(_delta:float) -> void:
	DashGhostHelper.create_ghost(possessor,possessor.sprite)

func update(delta: float) -> void:
	if(dash_shadow_count%2==0):
		create_ghost(delta)
	dash_shadow_count+=1
	possessor.velocity_component.move(possessor)
	
func execute(delta:float)->void:
	super(delta)
	if timer_ability == null:
		init_timer_ability()
	dash_shadow_count=0
	var direction = possessor.get_current_direction()
	possessor.velocity_component.update_velocity(direction * 165 )
	possessor.velocity_component.move(possessor)
	timer_ability.start(0.165)
