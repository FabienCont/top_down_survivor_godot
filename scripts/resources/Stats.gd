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

var attack = AttackStats.new()
var common = CommonStats.new()
var life = LifeStats.new()
var xp = XpStats.new()
