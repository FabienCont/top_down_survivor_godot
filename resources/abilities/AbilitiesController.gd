extends Resource

class_name AbilitiesController

signal ability_changed(key:String,ability :Ability)
signal ability_removed(key:String,ability :Ability)

var entity:Entity
@export var abilities: Dictionary = {}

func init(entity_init: Entity):
	entity = entity_init

func add(key:String,ability :Ability):
	abilities[key] = ability
	ability.init_ability(entity)
	ability_changed.emit(key,ability)
	
func remove(key:String,ability :Ability):
	abilities[key] = null
	ability_removed.emit(key,ability)

func get_ability(key: String) -> Ability:
	if  abilities.has(key):
		return abilities[key]
	else:
		return null
