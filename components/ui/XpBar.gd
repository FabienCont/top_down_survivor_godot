extends Node2D

@onready var texture_progess_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextureProgressBar/Label
@onready var xp_value:float
@onready var _display_xp_value :float = 0.0 : 
		set(value): _update_display_xp(value)
@onready var max_xp_value:float

# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	_display_xp_value=xp_value
	Signals.xp_update.connect(set_xp)
	Signals.max_xp_update.connect(set_xp)
	pass
	
func _update_display_xp(display_xp):
	if label != null:
		label.text = str(round(display_xp)) +" / "+ str(round(max_xp_value))
	if texture_progess_bar != null && max_xp_value > 0:	
		texture_progess_bar.value = (display_xp/max_xp_value)*100
	return display_xp

func set_xp(life):
	xp_value = life
	var tween = get_tree().create_tween()
	tween.tween_property(self,"_display_xp_value",xp_value,0.1).from_current()

func set_max_xp(max_xp):
	max_xp_value= max_xp
	_update_display_xp(_display_xp_value)
