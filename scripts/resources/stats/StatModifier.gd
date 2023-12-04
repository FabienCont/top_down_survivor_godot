@tool
extends Resource
class_name StatModifier

enum ModifierType {
	ADDITIVE,
	MULTIPLICATIVE,
}

@export var type : ModifierType = ModifierType.ADDITIVE
@export var target: StatTarget.names = StatTarget.names.ENTITY
@export var key: int = 0
@export var value : float = 1.0
@export var duration : float = -1.0
@export var apply_to_base :bool = false 
