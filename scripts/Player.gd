extends CharacterBody2D

@onready var controllerComponent: TopDownControllerComponent = $TopDownControllerComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var interactionComponent: InteractionComponent = $InteractionComponent
@onready var weaponSlotComponent: WeaponSlotComponent = $WeaponSlotComponent
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var lifebarComponent: LifebarComponent = $LifebarComponent
@onready var collectorComponent: CollectorComponent = $CollectorComponent
@onready var sprite :AnimatedSprite2D  = $character
@export var auto_attack :bool  = false
@export var hurt_effects: Array[Resource]
@export var look_at_target: Node2D
@export var player: Player = Player.new()
@onready var is_attacking := false


func init(player_init :Player) -> void:
	var stats: StatsController = player.stats.duplicate(true)
	stats.init()
	player = player_init
	player.stats = stats
	collectorComponent.init(player.stats)
	healthComponent.init(player.stats)
	lifebarComponent.init(player.stats)
	var newSprite = player.character.sprite.instantiate()
	newSprite.scale = Vector2(0.5,0.5)
	sprite.replace_by(newSprite)
	sprite = newSprite
	weaponSlotComponent.init(player.stats,player.weapon_info,player.effects)
	velocityComponent.init(player.stats)
	
func _physics_process(delta: float) -> void:
	if _is_dead() == true:
		sprite.play("Idle")
		return
	velocityComponent.update_velocity(velocity)
	controllerComponent.updateControl(delta)
	velocityComponent.move(self)
	if controllerComponent.has_move() : 
		SoundManager.playFootstepSound()
		sprite.play("Walk")
		if velocityComponent.current_velocity.x < 0 :
			sprite.flip_h = true
		else: 
			sprite.flip_h = false 
	else:
		sprite.play("Idle")
	
	weaponSlotComponent.look_at(controllerComponent.get_look_direction()) 
	if controllerComponent.has_dash() == true :
		dash(delta)
		
	if controllerComponent.has_attack() == true:
		start_attack()
		
func hurt(attack :Attack):
	SoundManager.playImpactSound()
	var force = attack.attack_position - global_position
	velocityComponent.accelerate_in_direction(force * attack.knockback_force,0.1)
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func dash(delta):
	var direction = controllerComponent.get_current_direction()
	var dash_velocity = Vector2(direction.x * 10000,direction.y * 10000)
	print("velocity",velocity)
	velocity = velocity.move_toward(dash_velocity,delta)
	print("velocity",velocity)
	move_and_slide()
	#velocityComponent.accelerate_in_direction(direction, delta * 500)
	#velocityComponent.move(self)
	
func start_attack():
	if _is_dead() != true && is_attacking == false:
		is_attacking = true
		weaponSlotComponent.start_attack()
	
func end_attack():
	is_attacking = false
		
func _is_dead() -> bool: 
	return player.stats.get_current_stat(stats_const.names.life).value <= 0.0

func die():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"scale",Vector2(1.0,0.5),0.2).from_current()
	controllerComponent.disable = true
	Signals.player_died.emit()
	weaponSlotComponent.unequip()

func collect(item : Loot):
	if _is_dead():
		return
	SoundManager.playLootSound()
	var stats = player.stats
	player.stats.add_modifiers(item.modifiers)
	Signals.stats_update.emit(player)

func _on_interaction_component_collectables_new_element_interact(body_shape_node) -> void:
	body_shape_node.target = self
