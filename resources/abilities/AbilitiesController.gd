extends Resource

class_name AbilitiesController

signal dash_ability_changed(ability :Ability)
signal move_ability_changed(ability :Ability)
signal attack_ability_changed(ability :Ability)

@export var dash_ability :Resource
@export var move_ability :Resource
@export var attack_ability :Resource
var entity:Entity

func init(entity_init):
	entity = entity_init
	attack_ability = attack_ability.duplicate()
	if dash_ability!=null:
		add_dash_ability(dash_ability.new())
	if move_ability!=null:
		add_move_ability(move_ability.new())
	if attack_ability!=null:
		add_attack_ability(attack_ability.new())

func add_dash_ability(ability :Ability):
	dash_ability = ability
	dash_ability.init_ability(entity)
	dash_ability_changed.emit(dash_ability)
	
func remove_dash_ability(ability :Ability):
	dash_ability=ability

func add_move_ability(ability :Ability):
	move_ability = ability
	move_ability.init_ability(entity)
	move_ability_changed.emit(move_ability)
	
func remove_move_ability(ability :Ability):
	move_ability=ability

func add_attack_ability(ability :Ability):
	attack_ability = ability
	attack_ability.init_ability(entity)
	attack_ability_changed.emit(attack_ability)
	
func remove_attack_ability(ability :Ability):
	attack_ability=ability
