extends Resource
class_name EffectsController

@export var effects: Array[EffectInfo] = []
@export var dico: Dictionary = {}

func get_effects_by_state(state: String) -> Array[EffectInfo]:
	return dico[state]
 
func add_effects(effects_to_add:Array[EffectInfo]) -> void :
	for effect in effects_to_add: 
		add_effect(effect)

func add_effect(effect_to_add:EffectInfo) -> void :
	_add_effect_dico(effect_to_add)
	effects.push_back(effect_to_add)
	
func remove_effect(effect:EffectInfo) -> void :
	effects.erase(effect)
	dico.erase(effect)

func _remove_effect_dico(effect:EffectInfo) -> void :
	var state = effect.state
	dico[state].erase(effect)
	if dico[state].size() == 0:
		dico.erase(state)

func _add_effect_dico(effect:EffectInfo) -> void :
	var state = effect.state
	if not dico.has(state):
		dico[state] = []
	dico[state].push_back(effect)
