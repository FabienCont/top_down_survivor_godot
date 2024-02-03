extends Entity

class_name Player

@onready var controller_component: TopDownControllerComponent2D = $TopDownControllerComponent
@onready var interaction_component: InteractionComponent2D = $InteractionComponent
@onready var weapon_slot_component: WeaponSlotComponent = $WeaponSlotComponent
@onready var lifebar_component: LifebarComponent2D = $LifebarComponent
@onready var collector_component: CollectorComponent2D = $CollectorComponent
@onready var prepare_attack_ui_component: PrepareAttackUIComponent2D = $PrepareAttackUIComponent

@export var player_info: PlayerInfo

func init_player(player_info_init :PlayerInfo) -> void:
	init(player_info_init.stats_controller,player_info_init.upgrades_controller,player_info_init.abilities_controller)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	player_info.abilities_controller = abilities_controller
	var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	collector_component.init(collector_distance)
	var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	lifebar_component.init(life_stat,max_life_stat)
	set_sprite_component(player_info.character.sprite.instantiate())
	weapon_slot_component.init(player_info.weapon_info,player_info.upgrades_controller)
	Signals.player_ready.emit(self)

func _physics_process(delta: float) -> void:
	if has_die() == true:
		sprite_component.play("Idle")
		return
	if abilities_controller.dash_ability.is_executing == true:
		abilities_controller.dash_ability.update(delta)
		return 
	velocity_component.update_velocity(velocity)
	controller_component.updateControl(delta)
	abilities_controller.move_ability.execute(delta)

	if controller_component.has_move() : 
		SoundManager.playFootstepSound()
		sprite_component.play("Walk")
		if velocity_component.current_velocity.x < 0 :
			sprite_component.flip_h = true
		else: 
			sprite_component.flip_h = false 
	else:
		sprite_component.play("Idle")
	
	weapon_slot_component.look_at(global_position + controller_component.get_look_direction()) 
	if controller_component.has_dash() == true && abilities_controller.dash_ability.can_be_used() && not abilities_controller.attack_ability.is_executing :
		abilities_controller.dash_ability.execute(delta)
	
	if controller_component.has_prepare_attack() == true &&  not abilities_controller.attack_ability.is_executing: 
		abilities_controller.attack_ability.execute(delta)

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

func collect(loot : Loot) -> void:
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
