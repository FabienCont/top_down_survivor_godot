extends CharacterBody2D

class_name Entity

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component:HurtboxComponent  = $HurtboxComponent
@onready var sprite: AnimatedSprite2D  = $SpriteComponent

@export var hurt_effects: Array[Resource] =[]
@export var die_effects: Array[Resource] =[]

@export var stats_controller: StatsControllerEntity = StatsControllerEntity.new()
@export var upgrades_controller: UpgradesController = UpgradesController.new()

var is_dead:=false
var life_stat: StatEntity
	
func init_stat_controller(stats_controller_init :StatsControllerEntity,upgrades_controller_init: UpgradesController) -> void:
	stats_controller = stats_controller_init.duplicate(true)
	upgrades_controller = upgrades_controller_init.duplicate(true)
	stats_controller.set_upgrades_controller(upgrades_controller)
	stats_controller.init()
	
func init(stats_controller_init :StatsControllerEntity,upgrades_controller_init:UpgradesController) -> void:
	init_stat_controller(stats_controller_init,upgrades_controller_init)
	life_stat = stats_controller.get_current_stat(StatsConstEntity.names.life)
	var movement_speed_stat = stats_controller.get_current_stat(StatsConstEntity.names.movement_speed)
	var acceleration_stat = stats_controller.get_current_stat(StatsConstEntity.names.acceleration)
	velocity_component.init(movement_speed_stat,acceleration_stat)
	health_component.init(life_stat)

func set_sprite(new_sprite: AnimatedSprite2D):
	new_sprite.scale = Vector2(0.5,0.5)
	sprite.replace_by(new_sprite)
	sprite = new_sprite
	
func get_current_direction() -> Vector2:
	return Vector2(0,0)
	
func hurt(attack :Attack) -> void:
	SoundManager.playImpactSound()
	var direction = (global_position - attack.attack_position).normalized()
	velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.1)
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func has_die() -> bool: 
	return is_dead

func die() -> void:
	is_dead = true
	Signals.entity_died.emit(self)

func apply_attack_modifier(attack:Attack)->void:
	var damage_stat = stats_controller.get_current_stat(StatsConstEntity.names.damage)
	attack.damage += damage_stat.current_value 
	pass
