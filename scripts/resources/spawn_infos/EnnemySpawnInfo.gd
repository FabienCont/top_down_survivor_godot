extends Resource

class_name EnnemySpawnInfo

@export var ennemy_info: EnnemyInfo
@export var _probability: float=1.0
@export var difficulty: float=1.0
@export var max_occurence: int=1000000

var current_probability:= 0.0

func calc_current_probability(current_difficulty: float) -> void:
	current_difficulty = (difficulty/current_probability) * _probability
