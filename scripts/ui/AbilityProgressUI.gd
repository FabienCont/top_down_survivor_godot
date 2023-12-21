extends TextureProgressBar

var ability :Ability

func init_ability(new_ability)-> void:
	ability = new_ability
	ability.ability_is_ready.connect(set_value_to_max)
	ability.ability_finished.connect(set_value_to_min)


func set_value_to_min()->void:
	value = 0.0
	
func set_value_to_max()->void:
	value = 100.0

func update_dash(percent_before_ready) -> void:
	if ability && not ability.is_ready:
		var timer = ability.timer_cooldown
		value = (ability.timer_cooldown.time_left/ability.timer_cooldown.wait_time)*100
