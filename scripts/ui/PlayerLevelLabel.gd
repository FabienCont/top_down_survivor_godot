extends Label

func _ready():
	Signals.stats_update_ui.connect(update_stats)
	pass
	
func update_stats(player: Player) -> void:
	text = "Lvl "+str(player.stats.xp.LEVEL)
