extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.stats_update.connect(update_stats)
	Signals.upgrade_selected.connect(apply_upgrade)
	
func update_stats(player: Player)->void:
	update_level(player)
	
func apply_upgrade(player:Player, upgrade: Upgrade)->void:
	var stats = player.stats
	player.stats.add_modifiers(upgrade.modifiers)
	player.effects.add_effects(upgrade.effect)
	Signals.end_level_up.emit()

func update_level(player :Player):
	var stats = player.stats
	var xp = stats.get_current_stat(stats_const.names.xp)
	var level = stats.get_current_stat(stats_const.names.level)
	var life = stats.get_current_stat(stats_const.names.life)
	var max_life = stats.get_current_stat(stats_const.names.max_life)
	var xp_before_next_level = stats.get_current_stat(stats_const.names.xp_before_next_level)
	
	while xp.value >= xp_before_next_level.value :
		if life.value + 20 > max_life.value : 
			life.value = max_life.value
		else:
			life.value = life.value + 20
		level.value = level.value + 1
		xp.value = xp.value - xp_before_next_level.value
		xp_before_next_level.value = xp_before_next_level.value * 1.6
		Signals.start_level_up.emit(player)
	
	Signals.stats_update_ui.emit(player)
	Signals.stats_update_node.emit(player)
	
