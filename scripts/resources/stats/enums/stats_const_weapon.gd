extends StatsConstModel
class_name StatsConstWeapon

enum names{
	default=0,
	nb_projectile=30,
	rotation_between_projectiles=31,
}

static func get_string(name) -> String:
	return names.keys()[names.values().find(name)]

static func get_names():
	return names
