@tool
extends Node2D
class_name LifebarComponent

@export var healthComponent : HealthComponent:
	set(value):
		healthComponent = value
		update_configuration_warnings()
		
@onready var texture_progess_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextureProgressBar/Label
@onready var life_value:float
@onready var _display_life_value :float = 0.0 : 
		set(value): _update_display_life(value)
@onready var max_life_value:float

var life : Stat
var max_life : Stat

func _get_configuration_warnings():
	if healthComponent == null:
		return ["HealthComponent is missing"]
	return []
	
func init(stats_init: StatsController) -> void :
	life = stats_init.get_current_stat(stats_const.names.life)
	max_life = stats_init.get_current_stat(stats_const.names.max_life)
	life.update_value.connect(set_life)
	max_life.update_value.connect(set_max_life)
	_force_update_health_info()
	
func _force_update_health_info():
	if(healthComponent is HealthComponent) :
		set_life(life.value)
		set_max_life(max_life.value)
	
func _update_display_life(display_life):
	if label != null:
		label.text = str(round(display_life)) +" / "+ str(round(max_life_value))
	if texture_progess_bar != null && max_life_value > 0:	
		texture_progess_bar.value = (display_life/max_life_value)*100
	return display_life

func set_life(value: float):
	var current_life_value = life_value
	life_value = value
	var tween = get_tree().create_tween()
	tween.tween_property(self,"_display_life_value",life_value,0.1).from(current_life_value)

func set_max_life(value: float):
	max_life_value= value
	_update_display_life(_display_life_value)
