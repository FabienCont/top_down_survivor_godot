extends Resource

class_name StatModifier

enum ModifierType {
	ADDITIVE,
	MULTIPLICATIVE,
}

enum ModifierTarget {
	ENTITY,
	WEAPON,
	AMMO
}

@export var type : ModifierType = ModifierType.ADDITIVE
@export var target: ModifierTarget = ModifierTarget.ENTITY
@export var key : stats_const.names
@export var value : float = 1.0
@export var duration : float = -1.0
@export var apply_to_base :bool = false 
