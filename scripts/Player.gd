extends CharacterBody2D

@onready var controllerComponent: TopDownControllerComponent = $TopDownControllerComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var interactionComponent: InteractionComponent = $InteractionComponent
@onready var weaponSlotComponent: WeaponSlotComponent = $WeaponSlotComponent
@onready var sprite :AnimatedSprite2D  = $character

@export var hurt_effects: Array[Resource]

func _physics_process(delta: float) -> void:
	velocityComponent.update_velocity(velocity)
	controllerComponent.updateControl(delta)
	velocityComponent.move(self)
	if controllerComponent.has_move() : 
		sprite.play("Walk")
		if velocityComponent.current_velocity.x < 0 :
			sprite.flip_h = true
		else:
			sprite.flip_h = false 
	else:
		sprite.play("Idle")
	
	var target = interactionComponent.find_closest_body()
	if target != null :
		weaponSlotComponent.look_at(target.global_position) 
	
func hurt(attack :Attack):
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func die():
	Signals.player_died.emit()
	queue_free()

func collect():
	Signals.xp_update.emit()

func _on_interaction_component_collectables_new_element_interact(body_shape_node) -> void:
	body_shape_node.target = self
	pass # Replace with function body.
