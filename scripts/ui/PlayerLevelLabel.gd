extends Label

func _ready():
	Signals.stats_update_ui.connect(update_stats)
	pass
	
func update_stats(stats: Stats) -> void:
	text = "Lvl "+str(stats.LEVEL)
