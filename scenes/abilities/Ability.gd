extends Node

class_name Ability

@export var is_executing:bool=false
@export var timer_cooldown:Timer
@export var timer_ability:Timer
@export var is_ready:bool=true
@export var cooldown:float

@onready var possessor: Entity = get_parent()
signal ability_finished
signal ability_is_ready

func init_timer_ability() -> void:
	timer_ability = Timer.new()
	timer_ability.one_shot = true
	timer_ability.timeout.connect(end)
	add_child(timer_ability)
	
func init_timer_cooldown() -> void:
	timer_cooldown = Timer.new()
	timer_cooldown.one_shot = true
	timer_cooldown.timeout.connect(refresh)
	add_child(timer_cooldown)

func _ready() -> void:
	if has_requirements():
		_init_ability()
		
func has_requirements() -> bool:
	return true

func _init_ability()-> void:
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
