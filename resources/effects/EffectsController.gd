extends Resource
class_name EffectsController

@export var effects: Array[EffectResource] = []

func get_effects_by_state(state: String) -> Array[EffectResource]:
	return effects.filter(func(effect): return effect.state ==  state)
 
func add_effects(effects_to_add:Array[EffectResource]) -> void :
	for effect in effects_to_add: 
		effects.push_back(effect)

func remove_effects(effect:EffectResource) -> void :
	effects.erase(effect)
