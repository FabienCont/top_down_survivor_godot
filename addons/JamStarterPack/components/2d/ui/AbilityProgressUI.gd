extends TextureProgressBar

var ability :Ability

func init_ability(new_ability: Ability)-> void:
	ability = new_ability
	if ability:
		ability.ability_is_ready.connect(set_value_to_max)
		ability.ability_execute.connect(set_value_to_min)
		set_value_to_max()

func set_value_to_min()->void:
	value = 0.0
	
func set_value_to_max()->void:
	value = 100.0

func _process(delta)-> void:
	if ability && not ability.is_executing && not ability.is_ready:
		value =  100.0 - (ability.timer_cooldown.time_left/ability.timer_cooldown.wait_time)*100
