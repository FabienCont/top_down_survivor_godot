extends BoxContainer

class_name ItemBoxDescription
@onready var button: Button = $Button
@onready var description_upgrade_scene = preload("res://menu/parts/upgrade_description.tscn")

@export var texture_rect: TextureRect 
@export var label: Label
@export var upgrades_descriptions_node:Control 
@export var item:Item:
	
	set(value):
		item= value
		update_item()

signal select_item(item :Item)
func _ready() -> void:
	update_item()
	
func _on_button_pressed() -> void:
	select_item.emit(item)

func clean_upgrades_description_node()-> void:
	for node in upgrades_descriptions_node.get_children():
			upgrades_descriptions_node.remove_child(node)
			node.queue_free()
			
func update_item():
	if button != null && item != null:
		label.text = item.name
		texture_rect.texture = item.texture
		clean_upgrades_description_node()
		for upgrade in item.upgrades:
			add_descriptions_upgrade(upgrade)
	
func add_descriptions_upgrade(upgrade:Upgrade) -> void:
	for modifier in upgrade.modifiers:
		var info = format_modifier(modifier)
		var info_node = description_upgrade_scene.instantiate()
		info_node.text= info + "\n"
		upgrades_descriptions_node.add_child(info_node)

func format_modifier(stat_modifier: StatModifier) -> String:
	var sign_label = get_sign_label(stat_modifier.value)
	var label_stat = get_stat_label(stat_modifier)
	if stat_modifier.type == StatModifier.ModifierType.ADDITIVE :
		return str(" %s %.1f %s" % [sign_label, stat_modifier.value,label_stat])
	return str(" %s %.1f percent %s" % [sign_label, stat_modifier.value,label_stat])

func get_sign_label(fValue:float) -> String:
	if fValue < 0: 
		return "-" 
	return  "+"
		
func get_stat_label(stat: StatModifier):
	if StatTarget.names.find_key(StatTarget.names.ENTITY) == stat.target:
		return StatsConstEntity.get_string(stat.key)
	elif StatTarget.names.find_key(StatTarget.names.WEAPON) == stat.target:
		return StatsConstWeapon.get_string(stat.key)
	elif StatTarget.names.find_key(StatTarget.names.AMMO) == stat.target:
		return StatsConstAmmo.get_string(stat.key) 
	else:
		return "unknow"
