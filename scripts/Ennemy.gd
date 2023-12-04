extends Entity

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent = $FollowTargetComponent
@onready var animationTree:AnimationTree  = $AnimationTree
@onready var hitbox_component: HitboxComponent = $HitboxComponent

func _ready() -> void:
	init(stats_controller,upgrades_controller)
	if target != null :
		followTargetComponent.set_node_to_follow(target)
	
func _process(delta: float) -> void :
	if (has_die() == false):
		followTargetComponent.follow_target(self, delta)
		velocity_component.move(self)
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
	super()
	var state_machine = animationTree.get("parameters/playback")
	state_machine.travel("die_animation")
	hurtbox_component.queue_free()
	hitbox_component.queue_free()
	state_machine.travel("die_animation")
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
