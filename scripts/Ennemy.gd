extends CharacterBody2D

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent = $FollowTargetComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var animationTree:AnimationTree  = $AnimationTree
@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var hurtbox_component:HurtboxComponent  = $HurtboxComponent
@onready var healthComponent:HealthComponent  = $HealthComponent

@export var hurt_effects: Array[Resource]
@export var die_effects: Array[Resource]

@export var stats: Stats = Stats.new()

func _ready() -> void:
	stats = stats.duplicate(true)
	if healthComponent != null:
		healthComponent.init(stats.life)
		
	if target != null:
		followTargetComponent.set_node_to_follow(target)
	velocityComponent.SPEED_FACTOR = stats.common.MOVEMENT_SPEED
	
func _process(delta: float) -> void :
	if (is_dead() == false):
		followTargetComponent.follow_target(self, delta)
		velocityComponent.move(self)
	else:
		velocityComponent.decelerate(delta)
	
func hurt(attack :Attack):
	if (is_dead() == false):
		SoundManager.playEnnemiesImpactSound()
		for hurt_effect in hurt_effects:
			hurt_effect.trigger_effect(self,attack)

func is_dead() -> bool:
	if stats.life.VALUE <= 0.0 :
		return true
	else:
		return false
	
func die():
	var state_machine = animationTree.get("parameters/playback")
	state_machine.travel("die_animation")
	hurtbox_component.queue_free()
	hitbox_component.queue_free()
	for effect in die_effects:
		effect.trigger_effect(self)
	await get_tree().create_timer(2.0).timeout 
	call_deferred("queue_free")
	
