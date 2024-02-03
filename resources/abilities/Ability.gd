extends Resource

class_name Ability

@export var is_executing:bool=false
@export var is_ready:bool=true
@export var cooldown:float

var entity: Entity
var timer_cooldown:Timer
var timer_ability:Timer

signal ability_finished
signal ability_is_ready

func init_timer_ability() -> void:
	timer_ability = Timer.new()
	timer_ability.one_shot = true
	timer_ability.timeout.connect(end)
	entity.add_child(timer_ability)
	
func init_timer_cooldown() -> void:
	timer_cooldown = Timer.new()
	timer_cooldown.one_shot = true
	timer_cooldown.timeout.connect(refresh)
	entity.add_child(timer_cooldown)

func has_requirements() -> bool:
	return true

func init_ability(entity_init:Entity)-> void:
	entity = entity_init
	if has_requirements():
		pass

func refresh() -> void:
	is_ready=true
	ability_is_ready.emit()
	
func end()->void:
	is_executing = false
	ability_finished.emit()
	if cooldown != null:
		if timer_cooldown ==null:
			init_timer_cooldown()
		timer_cooldown.start(cooldown)
	else:
		refresh()
	
func can_be_used() -> bool:
	return is_executing == false && is_ready == true

func update(_delta: float) -> void:
	pass
	
func execute(_delta:float)->void:
	is_executing = true
	is_ready=false
