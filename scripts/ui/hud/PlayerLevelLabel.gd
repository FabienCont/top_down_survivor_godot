extends Label

func _ready():
	Signals.stats_update_ui.connect(update_stats)
	pass
	
func update_stats(player_info: PlayerInfo) -> void:
	var level =  player_info.stats_controller.get_current_stat(StatsConstEntity.names.level)
	text = "Lvl "+str(level.value)
