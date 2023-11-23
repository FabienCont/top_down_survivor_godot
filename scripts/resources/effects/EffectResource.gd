extends Resource
class_name EffectResource


enum EffectTarget {
	ENTITY,
	WEAPON,
	DISTANT_WEAPON,
	AMMO
}

@export var name: String="undefined"
@export var state: String="undefined"
@export var handler: EffectHandler
