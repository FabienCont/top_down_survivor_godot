extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.stats_update.connect(update_stats)
	Signals.upgrade_selected.connect(apply_upgrade)
	
func update_stats(stats: Stats)->void:
	update_level(stats)
	
func apply_upgrade(upgrade: Upgrade)->void:
	pass

func update_level(stats: Stats):
	while stats.XP >= stats.MAX_XP :
		stats.LEVEL = stats.LEVEL +1
		stats.XP = stats.XP - stats.MAX_XP
		stats.MAX_XP = stats.MAX_XP * 2
		Signals.start_level_up.emit()
	Signals.stats_update_ui.emit(stats)
