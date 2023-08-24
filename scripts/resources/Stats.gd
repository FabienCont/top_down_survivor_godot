extends Resource

class_name Stats

enum STATS_KEY{
	XP_MULTIPLIER,
	DAMAGE,
	MAX_LIFE,
	MOVEMENT_SPEED,
	LIFE,
	ATTACK_SPEED
}

@export var attack = AttackStats.new()
@export var common = CommonStats.new()
@export var life = LifeStats.new()
@export var xp = XpStats.new()
