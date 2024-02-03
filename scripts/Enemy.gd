extends Entity

class_name Enemy

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent2D = $FollowTargetComponent
@onready var hitbox_component: HitboxComponent2D = $HitboxComponent
@onready var weapon_slot_component: WeaponSlotComponent =$WeaponSlotComponent
@onready var weapon_info = preload("res://resources/weapon/BatWeaponInfo.tres")


@export var enemy_info: EnemyInfo
@onready var distance_before_attack = 25.0

func _ready() -> void: 
	init(enemy_info.stats_controller,enemy_info.upgrades_controller,enemy_info.abilities_controller)
	enemy_info.stats_controller = stats_controller
	enemy_info.upgrades_controller = upgrades_controller
	enemy_info.abilities_controller = abilities_controller
	weapon_info = enemy_info.weapon_info
	if target != null :
		followTargetComponent.set_node_to_follow(target)
	weapon_slot_component.init(weapon_info.duplicate(true),upgrades_controller)
	set_sprite_component(enemy_info.sprite.instantiate() as AnimatedSprite2D)
	
func init_enemy(enemy_info_init) -> void:
	enemy_info = enemy_info_init
	
func _process(delta: float) -> void :
	if (has_die() == false):
		sprite_component.play("Move")
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
	#queue_redraw()
	
func hurt(attack :Attack):
	if (has_die() == false):
		SoundManager.playEnemiesImpactSound()
		var direction = (global_position - attack.attack_position).normalized()
		velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.2)
		for hurt_effect in hurt_effects:
			hurt_effect.trigger_effect(self,attack)

func die():
	if not has_die():
		super()
		sprite_component.play("Die")
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
