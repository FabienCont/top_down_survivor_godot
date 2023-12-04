@tool
extends StatModel
class_name StatEntity

@export var key_selector : StatsConstEntity.names:
	set(key_value):
		key = int(key_value)
		key_selector=key_value
		_name = StatsConstEntity.get_string(key)
