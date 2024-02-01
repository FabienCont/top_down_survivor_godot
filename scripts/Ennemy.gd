extends Entity

class_name Ennemy

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent = $FollowTargetComponent
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var weapon_slot_component: WeaponSlotComponent =$WeaponSlotComponent
@onready var weapon_info = preload("res://resources/weapon/BatWeaponInfo.tres")

@onready var distance_before_attack = 25.0

func init(stats_controller:StatsControllerEntity,upgrades_controller:UpgradesController,abilities_controller:AbilitiesController) -> void:
	super(stats_controller,upgrades_controller,abilities_controller)
	if target != null :
		followTargetComponent.set_node_to_follow(target)
	weapon_slot_component.init(weapon_info.duplicate(true),upgrades_controller)
	
func _process(delta: float) -> void :
	if (has_die() == false):
		sprite.play("Move")
		if global_position.distance_to(followTargetComponent.target.global_position)< distance_before_attack && abilities_controller.attack_ability.is_executing == false :
			followTargetComponent.update_look_at_direction(self)
			weapon_slot_component.look_at(global_position + followTargetComponent.get_current_direction()) 
			abilities_controller.attack_ability.execute(delta)
			pass
		elif (abilities_controller.attack_ability.is_executing == false ):
			followTargetComponent.follow_target(self, delta)
			velocity_component.move(self)
			weapon_slot_component.look_at(global_position + followTargetComponent.get_current_direction()) 
	else:
		velocity_component.decelerate(delta)
	queue_redraw()
	
func hurt(attack :Attack):
	if (has_die() == false):
		SoundManager.playEnnemiesImpactSound()
		var direction = (global_position - attack.attack_position).normalized()
		velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.2)
		for hurt_effect in hurt_effects:
			hurt_effect.trigger_effect(self,attack)

func die():
	if not has_die():
		super()
		sprite.play("Die")
		hurtbox_component.queue_free()
		hitbox_component.queue_free()
		for effect in die_effects:
			effect.trigger_effect(self)
		await get_tree().create_timer(2.0).timeout 
		call_deferred("queue_free")

func _draw() -> void:
	#_draw_debug()
	pass
	
func _draw_debug()->void:
	#var pos = global_position
	draw_line(Vector2.ZERO,velocity_component.last_velocity,Color.RED,2.0)
	draw_line(Vector2.ZERO,(velocity_component.current_velocity),Color.BLUE,2.0)
