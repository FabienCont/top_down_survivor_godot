extends CharacterBody2D

@export var target :Node2D  
@onready var pathFindComponent: PathFindComponent = $PathFindComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var animationTree:AnimationTree  = $AnimationTree

@export var hurt_effects: Array[Resource]
@export var die_effects: Array[Resource]

func _process(delta: float) -> void :
	if target != null:
		pathFindComponent.set_target_position_node(target)
		pathFindComponent.follow_path(self, delta)
	#velocityComponent.move(self)

func hurt(attack :Attack):
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func die():
	for effect in die_effects:
		effect.trigger_effect(self)
	animationTree.active = false
	call_deferred("queue_free")
	
