@tool
extends Resource

class_name StatsControllerModel

@export_category("add_stat")
@export var stat_to_add_from_editor: StatModel
@export var _add_stat:=false : 
	set(value):
		if(value == true):
			_add_stat_from_editor()
			
@export_category("stats")
@export var stats_dico: Dictionary =  {}

@export var modifiers: Array[StatModifier] = []
	
@export var target: StatTarget.names:  
	set(value):
		target=value
		if Engine.is_editor_hint():
			stat_to_add_from_editor= _get_stat_class().new()

@export var upgrades_controller:UpgradesController

signal stat_updated

func _get_stat_class() :
	if target == StatTarget.names.ENTITY:
		return StatEntity
	elif target == StatTarget.names.WEAPON:
		return StatWeapon
	else:
		return StatAmmo

func _get_stat_enum() :
	if target == StatTarget.names.ENTITY:
		return StatsConstEntity
	elif target == StatTarget.names.WEAPON:
		return StatsConstWeapon
	else:
		return StatsConstAmmo
			
func _add_stat_from_editor() -> void:
	if Engine.is_editor_hint():
		stats_dico[stat_to_add_from_editor.key]=stat_to_add_from_editor.duplicate(true)
		notify_property_list_changed()

func _remove_stat_from_editor(value) -> void:
	if Engine.is_editor_hint():
		stats_dico.erase(value)
		notify_property_list_changed()
			
func _enter_tree() -> void:	
	if Engine.is_editor_hint():
		stat_to_add_from_editor = _get_stat_class().new()
		return
		
func duplicate_dico(dict)-> Dictionary:
	dict = dict.duplicate(true)
	for key in dict:
		dict[key] = dict[key].duplicate(true)
	return dict
	
func init()-> void:
	if Engine.is_editor_hint():
		stat_to_add_from_editor= _get_stat_class().new()
		return
	var old_dico = duplicate_dico(stats_dico)
	stats_dico = duplicate_dico(stats_dico)
	var first_key = old_dico.keys()[0]
	if old_dico[first_key] == stats_dico[first_key]:
		push_warning("probleme duplication raté")
	_update_modifiers()
	_compute_all_stats()
	
func get_current_stat(key: int) -> StatModel:
	if stats_dico.has(key):
		var stat = stats_dico[key]
		return stat
	push_warning("warning: stat key '"+str(key)+"' not found")
	return null

func _sortModifiers():
	modifiers.sort_custom(_comparisonStatModifier)

func _comparisonStatModifier(a: StatModifier, _b: StatModifier)-> bool:
	if a.type == StatModifier.ModifierType.ADDITIVE:
		return true
	else:
		return false


func remove_modifiers(modifiers_to_remove: Array[StatModifier]) -> void :
	var keys_to_recompute = {}
	for modifier in modifiers_to_remove: 
		if target != modifier.target:
			continue
		if modifier.apply_to_base == false :
			keys_to_recompute[modifier.key] =true
			_remove_modifier(modifier)
	for key in keys_to_recompute:
		compute_stat(key)
		
func add_modifiers(modifiers_to_add: Array[StatModifier]) -> void :
	var keys_to_recompute = {}
	for modifier in modifiers_to_add: 
		if target != modifier.target:
			continue
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
	var stat:StatModel = stats_dico[modifier.key]
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

func set_upgrades_controller(upgrades_controller_init: UpgradesController) -> void : 
	upgrades_controller=upgrades_controller_init
	if not upgrades_controller.upgrade_added.is_connected(_add_upgrade):
		upgrades_controller.upgrade_added.connect(_add_upgrade)
	if not upgrades_controller.upgrade_consummed.is_connected(_add_upgrade):
		upgrades_controller.upgrade_consummed.connect(_add_upgrade)
	if not upgrades_controller.upgrade_removed.is_connected(_remove_upgrade):
		upgrades_controller.upgrade_removed.connect(_remove_upgrade)

func _remove_upgrade(upgrade: Upgrade) -> void:
	remove_modifiers(upgrade.modifiers)
	
func _add_upgrade(upgrade: Upgrade) -> void:
	add_modifiers(upgrade.modifiers)

func _update_modifiers() -> void :
	modifiers = []
	for upgrade in upgrades_controller.upgrades:
		_add_upgrade(upgrade)

func _compute_all_stats() -> void :
	for key in stats_dico:
		compute_stat(key)

func compute_stat(key) -> void:
	
	if not stats_dico.has(key):
		return
	var stat = stats_dico[key]
	var computed_value = stat.base_value
	for modifier in modifiers:
		if modifier.key != key:
			continue
		if modifier.type == StatModifier.ModifierType.ADDITIVE:
			computed_value = computed_value + modifier.value
		else:
			computed_value = computed_value * modifier.value
	stat.value = computed_value
	stat_updated.emit(stat)
