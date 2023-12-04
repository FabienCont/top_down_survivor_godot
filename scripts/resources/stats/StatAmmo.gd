@tool
extends StatModel
class_name StatAmmo

@export var key_selector : StatsConstAmmo.names:
	set(key_value):
		key = int(key_value)
		key_selector=key_value
		_name = StatsConstAmmo.get_string(key)
