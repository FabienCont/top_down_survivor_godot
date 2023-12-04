@tool
extends StatsControllerModel
class_name StatsControllerAmmo

@export_category("remove_stats")
@export var stat_to_remove_from_editor:  StatsConstAmmo.names
@export var _remove_stat:=false  : 
	set(_value):
		if(_value == true):
			_remove_stat_from_editor(stat_to_remove_from_editor)

func _init():
	target = StatTarget.names.AMMO 
