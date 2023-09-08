extends Node2D
class_name LifebarComponent

@export var healthComponent : HealthComponent
@onready var texture_progess_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextureProgressBar/Label
@onready var life_value:float
@onready var _display_life_value :float = 0.0 : 
		set(value): _update_display_life(value)
@onready var max_life_value:float

var lifeStats : LifeStats

func init(lifeStatsInit: LifeStats) -> void :
	lifeStats = lifeStatsInit
	lifeStats.connect("update_life_value",set_life)
	lifeStats.connect("update_max_life_value",set_max_life)
	_force_update_health_info()
	
func _force_update_health_info():
	if(healthComponent is HealthComponent && healthComponent.lifeStats != null) :
		set_life(healthComponent.lifeStats.VALUE)
		set_max_life(healthComponent.lifeStats.MAX_VALUE)
	
func _update_display_life(display_life):
	if label != null:
		label.text = str(round(display_life)) +" / "+ str(round(max_life_value))
	if texture_progess_bar != null && max_life_value > 0:	
		texture_progess_bar.value = (display_life/max_life_value)*100
	return display_life

func set_life(life):
	var current_life_value = life_value
	life_value = life
	var tween = get_tree().create_tween()
	tween.tween_property(self,"_display_life_value",life_value,0.1).from(current_life_value)

func set_max_life(max_life):
	max_life_value= max_life
	_update_display_life(_display_life_value)
