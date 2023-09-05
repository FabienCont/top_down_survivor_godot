extends CharacterBody2D

@onready var controllerComponent: TopDownControllerComponent = $TopDownControllerComponent
@onready var velocityComponent: VelocityComponent = $VelocityComponent
@onready var interactionComponent: InteractionComponent = $InteractionComponent
@onready var weaponSlotComponent: WeaponSlotComponent = $WeaponSlotComponent
@onready var healthComponent: HealthComponent = $HealthComponent
@onready var collectorComponent: CollectorComponent = $CollectorComponent
@onready var sprite :AnimatedSprite2D  = $character
@export var auto_attack :bool  = true
@export var hurt_effects: Array[Resource]
@export var look_at_target: Node2D
@export var player: Player = Player.new()
@onready var is_attacking := false

func _ready() -> void:
	Signals.stats_update_node.connect(_update_stats)

func init(playerInit :Player) -> void:
	var stats = player.stats.duplicate(true)
	player = playerInit
	player.stats = stats
	collectorComponent.init(player.stats.common)
	healthComponent.init(player.stats.life)
	var character = player.character
	var newSprite = character.sprite.instantiate()
	newSprite.scale = Vector2(0.5,0.5)
	sprite.replace_by(newSprite)
	sprite= newSprite
	weaponSlotComponent.init(player)
	velocityComponent.SPEED_FACTOR = player.stats.common.MOVEMENT_SPEED
	
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
	
	look_at_target = interactionComponent.find_closest_body()
	if look_at_target != null :
		weaponSlotComponent.look_at(look_at_target.global_position) 
		if auto_attack == true:
			start_timer_auto_attack()
	
func hurt(attack :Attack):
	SoundManager.playImpactSound()
	var force = attack.attack_position - global_position
	velocityComponent.accelerate_in_direction(force * attack.knockback_force,0.1)
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func start_timer_auto_attack():
	if is_attacking == false:
		is_attacking = true
		start_attack()

func start_attack():
	if _is_dead() != true:
		weaponSlotComponent.start_attack()
	
func end_attack():
	is_attacking = false
		
func _is_dead() -> bool: 
	return player.stats.life.VALUE <= 0.0

func die():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"scale",Vector2(1.0,0.5),0.2).from_current()
	controllerComponent.disable = true
	Signals.player_died.emit()

func collect(item : Loot):
	if _is_dead():
		return
	var attributes= LootEnum.LOOT_TYPE.keys()[item.type]
	var _multiplier_attributes = attributes+"_MULTIPLIER"
	var value_added = item.value
	
	SoundManager.playLootSound()
	
	#if player.stats.get(_multiplier_attributes) != null:	
	#	value_added =value_added * player.stats.get(_multiplier_attributes)
	
	if item.type == LootEnum.LOOT_TYPE.XP :
		player.stats.xp.VALUE = player.stats.xp.VALUE + (value_added * player.stats.xp.XP_MULTIPLIER)
	if item.type == LootEnum.LOOT_TYPE.LIFE :
		player.stats.life.VALUE = player.stats.life.VALUE + value_added
	if item.type == LootEnum.LOOT_TYPE.MAX_LIFE :
		player.stats.life.MAX_VALUE = player.stats.life.MAX_VALUE + value_added
	
	#player.stats[attributes] = player.stats[attributes] + value_added
	Signals.stats_update.emit(player)

func _on_interaction_component_collectables_new_element_interact(body_shape_node) -> void:
	body_shape_node.target = self

func _update_stats(player_update :Player):
	if player == player_update:
		velocityComponent.SPEED_FACTOR = player.stats.common.MOVEMENT_SPEED
