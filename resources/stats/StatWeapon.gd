@tool
extends StatModel
class_name StatWeapon

@export var key_selector : StatsConstWeapon.names:
	set(key_value):
		key = int(key_value)
		key_selector=key_value
		_name = StatsConstWeapon.get_string(key)
