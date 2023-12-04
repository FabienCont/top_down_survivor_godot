extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.stats_update.connect(update_stats)
	Signals.upgrade_selected.connect(apply_upgrade)
	
func update_stats(player_info: PlayerInfo)->void:
	update_level(player_info)
	
func apply_upgrade(player_info:PlayerInfo, upgrade: Upgrade)->void:
	player_info.upgrades_controller.add_upgrade(upgrade)
	Signals.end_level_up.emit()

func apply_modifier() -> void:
	pass
	
func apply_effect() -> void:
	pass
	
func update_level(player_info :PlayerInfo):
	var stats_controller = player_info.stats_controller
	var xp = stats_controller.get_current_stat(StatsConstEntity.names.xp)
	var level = stats_controller.get_current_stat(StatsConstEntity.names.level)
	var life = stats_controller.get_current_stat(StatsConstEntity.names.life)
	var max_life = stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	var xp_before_next_level = stats_controller.get_current_stat(StatsConstEntity.names.xp_before_next_level)
	var xp_last_level = stats_controller.get_current_stat(StatsConstEntity.names.xp_last_level)
	
	while xp.value >= xp_before_next_level.value :
		if life.value + 20 > max_life.value : 
			life.value = max_life.value
		else:
			life.value = life.value + 20
		level.value = level.value + 1
		xp_last_level.value = xp_before_next_level.value
		xp.value = xp.value - xp_last_level.value
		xp_before_next_level.value = xp_before_next_level.value * 1.6
		Signals.start_level_up.emit(player_info)
	
	Signals.stats_update_ui.emit(player_info)
	Signals.stats_update_node.emit(player_info)
	
