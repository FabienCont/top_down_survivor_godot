extends Resource

class_name EnnemiesSpawnRules

@export var ennemies_spawn_info: Array[EnnemySpawnInfo]=[]
var difficulty =1.0
var total_probability: float = 0.0

func compute_ennemy_probability_to_spawn() -> void:
	var computed_value = 0.0
	for ennemy_spawn_info in ennemies_spawn_info:
		ennemy_spawn_info.calc_current_probability(difficulty)
		computed_value += ennemy_spawn_info.current_probability
	total_probability = computed_value

func get_random_ennemy_info() -> EnnemySpawnInfo:
	var random_ennemy_info = null
	var random_probability = get_random_probability()
	var random_counter = 0 
	for ennemy_spawn_info in ennemies_spawn_info:
		random_counter += ennemy_spawn_info.current_probability
		if random_counter <= random_probability:
			random_ennemy_info = ennemy_spawn_info
			random_ennemy_info.max_occurence -= 1
			if random_ennemy_info.max_occurence == 0:
				ennemies_spawn_info.erase(ennemy_spawn_info)
			break
	return random_ennemy_info
	
func get_random_probability() -> float:
	return randf() * total_probability
