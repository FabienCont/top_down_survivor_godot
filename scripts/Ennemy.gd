extends CharacterBody2D

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent = $FollowTargetComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var animationTree:AnimationTree  = $AnimationTree

@export var hurt_effects: Array[Resource]
@export var die_effects: Array[Resource]

func _ready() -> void:
	if target != null:
		followTargetComponent.set_node_to_follow(target)

func _process(delta: float) -> void :
	followTargetComponent.follow_target(self, delta)
	velocityComponent.move(self)

func hurt(attack :Attack):
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func die():
	for effect in die_effects:
		effect.trigger_effect(self)
	animationTree.active = false
	call_deferred("queue_free")
	
