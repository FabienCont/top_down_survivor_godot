extends StatsConstModel
class_name StatsConstAmmo

enum names{
	pierce=0,
	range=1,
}
static func get_string(name) -> String:
	return names.keys()[names.values().find(name)]

static func get_names():
	return names
