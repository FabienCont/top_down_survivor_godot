extends EntityLogicComponent

class_name EnemyLogicComponent

@export var distance_before_attack :float = 25

func process_logic(delta:float) -> void:
	if (entity.has_die() == false):
		entity.sprite_component.play("Move")
		if entity.global_position.distance_to(entity.followTargetComponent.target.global_position)< distance_before_attack && entity.abilities_controller.attack_ability.is_executing == false :
			entity.followTargetComponent.update_look_at_direction(entity)
			entity.weapon_slot_component.look_at(entity.global_position + entity.get_current_direction()) 
			entity.abilities_controller.attack_ability.execute(delta)
			pass
		elif (entity.abilities_controller.attack_ability.is_executing == false ):
			entity.followTargetComponent.follow_target(entity, delta)
			entity.velocity_component.move(entity)
			entity.weapon_slot_component.look_at(entity.global_position + entity.get_current_direction()) 
	else:
		entity.velocity_component.decelerate(delta)
	#queue_redraw()

func die_logic () -> void:
	if entity.has_die():
		return
	entity.is_dead = true
	Signals.entity_died.emit(entity)
	entity.sprite_component.play("Die")
	entity.hurtbox_component.queue_free()
	entity.hitbox_component.queue_free()
	for effect in entity.die_effects:
		effect.trigger_effect(entity)
	await entity.get_tree().create_timer(2.0).timeout 
	entity.call_deferred("queue_free")

func hurt_logic(attack: Attack) -> void:
	if entity.has_die():
		return
	SoundManager.playEnemiesImpactSound()
	var direction = (entity.global_position - attack.attack_position).normalized()
	entity.velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.2)
	for hurt_effect in entity.hurt_effects:
		hurt_effect.trigger_effect(entity,attack)
