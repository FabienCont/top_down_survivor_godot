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
			stats.attack.DAMAGE = stats.attack.DAMAGE + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.ATTACK_SPEED:
			stats.attack.ATTACK_SPEED = stats.attack.ATTACK_SPEED + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.MOVEMENT_SPEED:
			stats.common.MOVEMENT_SPEED = stats.common.MOVEMENT_SPEED + upgrade.value
		UpgradeEnum.UPGRADE_TYPE.XP_MULTIPLIER:
			stats.xp.XP_MULTIPLIER = stats.xp.XP_MULTIPLIER + upgrade.value
	Signals.end_level_up.emit()

func update_level(player :Player):
	var stats = player.stats
	while stats.xp.VALUE >= stats.xp.MAX_VALUE :
		if stats.life.VALUE + 20 > stats.life.MAX_VALUE : 
			stats.life.VALUE = stats.life.MAX_VALUE
		else:
			stats.life.VALUE = stats.life.VALUE + 20
		stats.xp.LEVEL = stats.xp.LEVEL + 1
		stats.xp.VALUE = stats.xp.VALUE - stats.xp.MAX_VALUE
		stats.xp.MAX_VALUE = stats.xp.MAX_VALUE * 1.6
		Signals.start_level_up.emit(player)
	Signals.stats_update_ui.emit(player)
	Signals.stats_update_node.emit(player)
	
