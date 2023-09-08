extends Resource

class_name AttackStats

signal update_attack_speed
signal update_damage

enum STATS_KEY{
	DAMAGE,
	ATTACK_SPEED
}

@export var ATTACK_SPEED: float = 1:
	set(updated_value):
		ATTACK_SPEED = updated_value
		emit_update_attack_speed(updated_value)
@export var DAMAGE: int = 1:
	set(updated_value):
		DAMAGE = updated_value
		emit_update_damage(updated_value)

func emit_update_attack_speed(update_value: float) -> void :
	update_attack_speed.emit(update_value)

func emit_update_damage(update_value: float) -> void :
	update_damage.emit(update_value)
