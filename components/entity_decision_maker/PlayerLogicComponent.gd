extends EntityLogicComponent

class_name PlayerLogicComponent
	
func process_actions(delta:float) -> void:
	if entity.has_die() == true:
		entity.sprite.play("Idle")
		return
	if entity.abilities_controller.dash_ability.is_executing == true:
		entity.abilities_controller.dash_ability.update(delta)
		return 
	entity.velocity_component.update_velocity(entity.velocity)
	entity.controller_component.updateControl(delta)
	entity.abilities_controller.move_ability.execute(delta)

	if entity.controller_component.has_move() : 
		SoundManager.playFootstepSound()
		entity.sprite_component.play("Walk")
		if entity.velocity_component.current_velocity.x < 0 :
			entity.sprite_component.flip_h = true
		else: 
			entity.sprite_component.flip_h = false 
	else:
		entity.sprite_component.play("Idle")
	
	entity.weapon_slot_component.look_at(entity.global_position + entity.controller_component.get_look_direction()) 
	if entity.controller_component.has_dash() == true && entity.abilities_controller.dash_ability.can_be_used() && not entity.abilities_controller.attack_ability.is_executing :
		entity.abilities_controller.dash_ability.execute(delta)
	
	if entity.controller_component.has_prepare_attack() == true &&  not entity.abilities_controller.attack_ability.is_executing: 
		entity.abilities_controller.attack_ability.execute(delta)
