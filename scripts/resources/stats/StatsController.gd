@tool
extends Resource

class_name StatsController

@export_category("add_stat")
@export var stat_to_add_from_editor: Stat = Stat.new()
@export var _add_stat:=false : 
	set(_value):
		if(_value == true):
			_add_stat_from_editor()

@export_category("remove_stat")
@export var stat_to_remove_from_editor: stats_const.names
@export var _remove_stat:=false  : 
	set(_value):
		if(_value == true):
			_remove_stat_from_editor()

@export_category("stats")
@export var stats_dico: Dictionary =  {}

@export var modifiers: Array[StatModifier] = []

func _add_stat_from_editor() -> void:
	if Engine.is_editor_hint():
		stats_dico[stat_to_add_from_editor.key]=stat_to_add_from_editor.duplicate(true)
		notify_property_list_changed()

func _remove_stat_from_editor() -> void:
	if Engine.is_editor_hint():
		stats_dico.erase(stat_to_remove_from_editor)
		notify_property_list_changed()
			
func _enter_tree() -> void:	
	if Engine.is_editor_hint():
		stat_to_remove_from_editor = stats_const.names.life 
		stat_to_add_from_editor = Stat.new()
		return
		
func duplicate_dico(dict)-> Dictionary:
	dict = dict.duplicate(true)
	for key in dict:
		dict[key] = dict[key].duplicate(true)
	return dict
	
func init()-> void:
	if Engine.is_editor_hint():
		return
	var oldDico = duplicate_dico(stats_dico)
	stats_dico = duplicate_dico(stats_dico)
	if oldDico[0] == stats_dico[0]:
		print("probleme duplication raté")
	_compute_all_stats()
	
func get_current_stat(key: stats_const.names) -> Stat:
	if stats_dico.has(key):
		var stat = stats_dico[key]
		return stat
	print("warning: stat '"+stats_const.get_string(key)+"' not found")
	return null

func _sortModifiers():
	modifiers.sort_custom(_comparisonStatModifier)

func _comparisonStatModifier(a: StatModifier, _b: StatModifier)-> bool:
	if a.type == StatModifier.ModifierType.ADDITIVE:
		return true
	else:
		return false

func add_modifiers(modifiers_to_add: Array[StatModifier]) -> void :
	var keys_to_recompute = {}
	for modifier in modifiers_to_add: 
		keys_to_recompute[modifier.key] =true
		if modifier.apply_to_base == true :
			_compute_base_modifier(modifier)
		else :
			_add_modifier(modifier)
	for key in keys_to_recompute:
		compute_stat(key)

func _compute_base_modifier(modifier :StatModifier) -> void:
	if not stats_dico.has(modifier.key):
		return
	var stat:Stat = stats_dico[modifier.key]
	if modifier.type == StatModifier.ModifierType.ADDITIVE:
		stat.base_value = stat.base_value + modifier.value
	else:
		stat.base_value = stat.base_value * modifier.value
			
func _add_modifier(modifier: StatModifier) -> void:
	if modifier.type == StatModifier.ModifierType.ADDITIVE:
		modifiers.push_front(modifier)
	else:
		modifiers.push_back(modifier)

func _remove_modifier(modifier: StatModifier) -> void:
	modifiers.erase(modifier) 

func _compute_all_stats() -> void :
	for key in stats_dico:
		compute_stat(key)

func compute_stat(key) -> void:
	if not stats_dico.has(key):
		return
	var stat = stats_dico[key]
	var computed_value = stat.base_value
	
	for modifier in modifiers:
		if modifier.key == key:
			if modifier.type == StatModifier.ModifierType.ADDITIVE:
				computed_value = computed_value + modifier.value
			else:
				computed_value = computed_value * modifier.value
	stat.value = computed_value
