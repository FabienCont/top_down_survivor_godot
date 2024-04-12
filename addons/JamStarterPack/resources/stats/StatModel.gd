@tool
extends Resource

class_name StatModel

signal update_value(new_value: float)
signal update_base_value(new_value: float)

@export var key: int:
	set(updated_value):
		key = updated_value
		notify_property_list_changed()

@export var base_value: float:
	set(updated_value):
		base_value = updated_value
		_emit_update_base_value(value)

@export var value: float:
	set(updated_value):
		value = updated_value
		_emit_update_value(value)

func init_stat(key_init,value_init):
	if key_init:
		key = key_init
	if value_init:
		value=value_init
		base_value=value_init
		
var _name: String = ""

func get_stat_name()-> String:
	return _name

func _emit_update_base_value(updated_value: float) -> void :
	update_base_value.emit(updated_value)
	
func _emit_update_value(updated_value: float) -> void :
	update_value.emit(updated_value)
