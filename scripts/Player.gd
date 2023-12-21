extends Entity

class_name Player

@onready var controller_component: TopDownControllerComponent = $TopDownControllerComponent
@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var weapon_slot_component: WeaponSlotComponent = $WeaponSlotComponent
@onready var lifebar_component: LifebarComponent = $LifebarComponent
@onready var collector_component: CollectorComponent = $CollectorComponent
@onready var prepare_attack_ui_component:TextureProgressBar = $PrepareAttackUIComponent

@export var player_info: PlayerInfo

var dash_ability_scene = preload("res://scenes/abilities/DashAbility.gd")
var attack_ability_scene = preload("res://scenes/abilities/AttackAbility.gd")
var move_ability_scene = preload("res://scenes/abilities/MoveAbility.gd")
var dash_ability:Ability
var attack_ability:Ability
var move_ability:Ability

func init_player(player_info_init :PlayerInfo) -> void:
	init(player_info_init.stats_controller,player_info_init.upgrades_controller)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	collector_component.init(collector_distance)
	var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	lifebar_component.init(life_stat,max_life_stat)
	set_sprite(player_info.character.sprite.instantiate())
	weapon_slot_component.init(player_info.weapon_info,player_info.upgrades_controller)
	dash_ability = dash_ability_scene.new()
	attack_ability = attack_ability_scene.new()
	move_ability = move_ability_scene.new()
	add_child(dash_ability)
	add_child(attack_ability)
	add_child(move_ability)
	Signals.player_ready.emit(self)

func _physics_process(delta: float) -> void:
	if has_die() == true:
		sprite.play("Idle")
		return
	if dash_ability.is_executing == true:
		dash_ability.update(delta)
		return 
	velocity_component.update_velocity(velocity)
	controller_component.updateControl(delta)
	move_ability.execute(delta)

	if controller_component.has_move() : 
		SoundManager.playFootstepSound()
		sprite.play("Walk")
		if velocity_component.current_velocity.x < 0 :
			sprite.flip_h = true
		else: 
			sprite.flip_h = false 
	else:
		sprite.play("Idle")
	
	weapon_slot_component.look_at(global_position + controller_component.get_look_direction()) 
	if controller_component.has_dash() == true && dash_ability.can_be_used() && not attack_ability.is_executing :
		dash_ability.execute(delta)
	
	if controller_component.has_prepare_attack() == true &&  not attack_ability.is_executing : 
		attack_ability.execute(delta)

func get_current_direction() -> Vector2:
	return controller_component.get_current_direction()
	
func hurt(attack :Attack):
	SoundManager.playImpactSound()
	var direction = (global_position - attack.attack_position).normalized()
	velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.1)
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func die():
	if not has_die():
		super()
		var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(self,"scale",Vector2(1.0,0.5),0.2).from_current()
		controller_component.disable = true
		Signals.player_died.emit()
		weapon_slot_component.unequip()

func collect(loot : Loot):
	if has_die():
		return
	SoundManager.playLootSound()
	var item = loot.item
	for upgrade in item.upgrades:
		if item.is_consumable == true:
			upgrades_controller.add_upgrade(upgrade)
		else:
			upgrades_controller.apply_upgrade(upgrade)
	Signals.stats_update.emit(player_info)
