extends CharacterBody2D

@onready var controllerComponent: TopDownControllerComponent = $TopDownControllerComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var interactionComponent: InteractionComponent = $InteractionComponent
@onready var weaponSlotComponent: WeaponSlotComponent = $WeaponSlotComponent
@onready var sprite :AnimatedSprite2D  = $character
@export var auto_attack :bool  = true
@export var hurt_effects: Array[Resource]
@export var look_at_target: Node2D
@export var player_info: Player = Player.new()
@onready var is_attacking := false

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
	
	look_at_target = interactionComponent.find_closest_body()
	if look_at_target != null :
		weaponSlotComponent.look_at(look_at_target.global_position) 
		if auto_attack == true:
			start_timer_auto_attack()
	
func hurt(attack :Attack):
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func start_timer_auto_attack():
	if is_attacking == false:
		is_attacking = true
		var timer=get_tree().create_timer(1.0)
		timer.connect("timeout", start_attack)

func start_attack():
	weaponSlotComponent.start_attack()
	
func end_attack():
	is_attacking = false
		
func die():
	Signals.player_died.emit()
	queue_free()

func collect(item : Loot):
	var attributes= LootEnum.LOOT_TYPE.keys()[item.type]
	player_info.stats[attributes] = player_info.stats[attributes] + item.value
	Signals.stats_update.emit(player_info.stats)

func _on_interaction_component_collectables_new_element_interact(body_shape_node) -> void:
	body_shape_node.target = self
