extends TextureProgressBar

@onready var label: Label = $Label
@onready var xp_value:float
@onready var _display_xp_value :float = 0.0 :
		get: return _display_xp_value
		set(param): _update_display_xp(param)
@onready var max_xp_value:float
@onready var tween: Tween

func _ready():
	await RenderingServer.frame_post_draw
	_display_xp_value=xp_value
	Signals.stats_update_ui.connect(update_stats)
	pass
	
func _update_display_xp(display_xp):
	if label != null:
		label.text = str(round(display_xp)) +" / "+ str(round(max_xp_value))
	if max_xp_value > 0:
		value = (display_xp/max_xp_value)*100
	return display_xp

func update_stats(player_info: PlayerInfo)->void:
	var stats=player_info.stats_controller
	var xp = stats.get_current_stat(StatsConstEntity.names.xp) 
	var xp_before_next_level = stats.get_current_stat(StatsConstEntity.names.xp_before_next_level)
	var xp_last_level = stats.get_current_stat(StatsConstEntity.names.xp_last_level)
	set_xp(xp.value - xp_last_level.value)
	set_max_xp(xp_before_next_level.value - xp_last_level.value)
	
func set_xp(xp):
	var current_xp_value = xp_value
	xp_value = xp
	if tween:
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"_display_xp_value",xp_value,0.2).from(current_xp_value)

func set_max_xp(max_xp):
	max_xp_value= max_xp
	_update_display_xp(_display_xp_value)
