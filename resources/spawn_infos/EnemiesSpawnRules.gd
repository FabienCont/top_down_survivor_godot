extends Resource

class_name EnemiesSpawnRules

@export var enemies_spawn_info: Array[EnemySpawnInfo]=[]
var difficulty = 1.0
var total_probability: float = 0.0

func compute_enemy_probability_to_spawn() -> void:
	var computed_value = 0.0
	for enemy_spawn_info in enemies_spawn_info:
		enemy_spawn_info.calc_current_probability(difficulty)
		computed_value += enemy_spawn_info.current_probability
	total_probability = computed_value

func get_random_enemy_info() -> EnemySpawnInfo:
	var random_enemy_info = null
	var random_probability = get_random_probability()
	var random_counter = 0 
	for enemy_spawn_info in enemies_spawn_info:
		random_counter += enemy_spawn_info.current_probability
		if random_probability <= random_counter :
			random_enemy_info = enemy_spawn_info
			random_enemy_info.max_occurence -= 1
			if random_enemy_info.max_occurence == 0:
				enemies_spawn_info.erase(enemy_spawn_info)
			break
	return random_enemy_info
	
func get_random_probability() -> float:
	return randf() * total_probability
