extends Resource
class_name stats_const

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
	#distant_weapons
	nb_projectile=30,
	rotation_between_projectiles=31,
	#ammo
	pierce=32,
	range=32,
}



static func get_string(name: names) -> String:
	return names.keys()[names.values().find(name)]
