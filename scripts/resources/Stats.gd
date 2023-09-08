extends Resource

class_name Stats

signal update_attack_stats
signal update_common_stats
signal update_life_stats
signal update_xp_stats

enum STATS_KEY{
	XP_MULTIPLIER,
	DAMAGE,
	MAX_LIFE,
	MOVEMENT_SPEED,
	LIFE,
	ATTACK_SPEED
}

@export var attack = AttackStats.new():
	set(updated_value):
		attack = updated_value
		emit_update_attack_stats(updated_value)
@export var common = CommonStats.new():
	set(updated_value):
		common = updated_value
		emit_update_common_stats(updated_value)
@export var life = LifeStats.new():
	set(updated_value):
		life = updated_value
		emit_update_life_stats(updated_value)
@export var xp = XpStats.new():
	set(updated_value):
		xp = updated_value
		emit_update_xp_stats(updated_value)

func emit_update_attack_stats(value_update: AttackStats):
	update_attack_stats.emit(value_update)

func emit_update_life_stats(value_update: LifeStats):
	update_life_stats.emit(value_update)

func emit_update_common_stats(value_update: CommonStats):
	update_common_stats.emit(value_update)

func emit_update_xp_stats(value_update: XpStats):
	update_xp_stats.emit(value_update)

