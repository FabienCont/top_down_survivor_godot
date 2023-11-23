@tool
extends Resource

class_name Stat

signal update_value(new_value: float)
signal update_base_value(new_value: float)

@export var auto_compute: bool = true
@export var key: stats_const.names:
	set(updated_value):
		key = updated_value
		_name = stats_const.get_string(key)
		notify_property_list_changed()

@export var base_value: float:
	set(updated_value):
		base_value = updated_value
		_emit_update_base_value(value)

@export var value: float:
	set(updated_value):
		value = updated_value
		_emit_update_value(value)

var _name: String = ""

func get_stat_name()-> String:
	return _name

func _emit_update_base_value(updated_value: float) -> void :
	update_base_value.emit(updated_value)
	
func _emit_update_value(updated_value: float) -> void :
	update_value.emit(updated_value)
