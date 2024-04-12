extends Resource
class_name StatsConstModel

enum names_model{
	unknow,
	interface
}

static func get_string(name) -> String:
	return names_model.keys()[names_model.values().find(name)]

static func get_names():
	return names_model
	
