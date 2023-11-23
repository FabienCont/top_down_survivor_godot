extends Label

func _ready():
	Signals.stats_update_ui.connect(update_stats)
	pass
	
func update_stats(player: Player) -> void:
	var level =  player.stats.get_current_stat(stats_const.names.level)
	text = "Lvl "+str(level.value)

