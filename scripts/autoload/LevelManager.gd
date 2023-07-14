extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.stats_update.connect(update_stats)
	Signals.upgrade_selected.connect(apply_upgrade)
	
func update_stats(player: Player)->void:
	update_level(player)
	
func apply_upgrade(player:Player, upgrade: Upgrade)->void:
	var stats = player.stats
	match (upgrade.type):
		UpgradeEnum.UPGRADE_TYPE.DAMAGE:
			stats.DAMAGE = stats.DAMAGE + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.ATTACK_SPEED:
			stats.ATTACK_SPEED = stats.ATTACK_SPEED + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.MOVEMENT_SPEED:
			stats.MOVEMENT_SPEED = stats.MOVEMENT_SPEED + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.XP_MULTIPLIER:
			stats.XP_MULTIPLIER = stats.XP_MULTIPLIER + upgrade.value
	Signals.end_level_up.emit()

func update_level(player :Player):
	var stats = player.stats
	while stats.XP >= stats.MAX_XP :
		stats.LEVEL = stats.LEVEL +1
		stats.XP = stats.XP - stats.MAX_XP
		stats.MAX_XP = stats.MAX_XP * 2
		Signals.start_level_up.emit(player)
	Signals.stats_update_ui.emit(player)
