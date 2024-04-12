extends StatsConstModel
class_name StatsConstEntity

enum names{
	life = 0,
	max_life= 1,
	collector_distance= 2,
	visibility= 3,
	xp= 4,
	level=6,
	movement_speed=7,
	acceleration=8,
	damage=9,
	attack_speed=10,
	xp_multiplier=11,
	xp_before_next_level=12,
	xp_last_level=13
}

static func get_string(name) -> String:
	return names.keys()[names.values().find(name)]

static func get_names():
	return names
