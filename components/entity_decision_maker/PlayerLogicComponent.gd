extends EntityLogicComponent

class_name PlayerLogicComponent

func process_logic(delta:float) -> void:
	if entity.has_die() == true:
		entity.sprite_component.play("Idle")
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

func die_logic () -> void:
	if entity.has_die():
		return
	entity.is_dead = true
	Signals.entity_died.emit(entity)
	var tween = entity.create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(entity,"scale",Vector2(1.0,0.5),0.2).from_current()
	entity.controller_component.disable = true
	Signals.player_died.emit()
	entity.weapon_slot_component.unequip()

func hurt_logic(attack: Attack) -> void:
	SoundManager.playImpactSound()
	var direction = (entity.global_position - attack.attack_position).normalized()
	entity.velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.1)
	for hurt_effect in entity.hurt_effects:
		hurt_effect.trigger_effect(entity,attack)

func collect_logic(loot : Loot) -> void:
	if entity.has_die():
		return
	SoundManager.playLootSound()
	var item = loot.item
	for upgrade in item.upgrades:
		if item.is_consumable == true:
			entity.upgrades_controller.add_upgrade(upgrade)
		else:
			entity.upgrades_controller.apply_upgrade(upgrade)
	Signals.stats_update.emit(entity.player_info)
