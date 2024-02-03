extends EntityLogicComponent

class_name EnemyLogicComponent
	
func process_logic(delta:float) -> void:
	if (entity.has_die() == false):
		entity.sprite_component.play("Move")
		if entity.global_position.distance_to(entity.followTargetComponent.target.global_position)< entity.distance_before_attack && entity.abilities_controller.attack_ability.is_executing == false :
			entity.followTargetComponent.update_look_at_direction(entity)
			entity.weapon_slot_component.look_at(entity.global_position + entity.followTargetComponent.get_current_direction()) 
			entity.abilities_controller.attack_ability.execute(delta)
			pass
		elif (entity.abilities_controller.attack_ability.is_executing == entity ):
			entity.followTargetComponent.follow_target(entity, delta)
			entity.velocity_component.move(entity)
			entity.weapon_slot_component.look_at(entity.global_position + entity.followTargetComponent.get_current_direction()) 
	else:
		entity.velocity_component.decelerate(delta)
	#queue_redraw()

func die_logic () -> void:
	return

func hurt_logic() -> void:
	return
