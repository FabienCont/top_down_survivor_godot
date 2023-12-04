extends Entity

class_name Player

@onready var controller_component: TopDownControllerComponent = $TopDownControllerComponent
@onready var interaction_component: InteractionComponent = $InteractionComponent
@onready var weapon_slot_component: WeaponSlotComponent = $WeaponSlotComponent
@onready var lifebar_component: LifebarComponent = $LifebarComponent
@onready var collector_component: CollectorComponent = $CollectorComponent
@onready var prepare_attack_ui_component:TextureProgressBar = $PrepareAttackUIComponent

@export var player_info: PlayerInfo = PlayerInfo.new()

@onready var attack_speed_stat: StatModel

@onready var is_attacking := false
@onready var attack_ready := false

@onready var is_dashing := false
@onready var dash_shadow_count:=0
@onready var dash_timer:=Timer.new()
@onready var dash_ready:=true
@onready var dash_cooldown:= 2.0


func init_player(player_info_init :PlayerInfo) -> void:
	init(player_info.stats_controller,player_info.upgrades_controller)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	collector_component.init(collector_distance)
	var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	lifebar_component.init(life_stat,max_life_stat)
	set_sprite(player_info.character.sprite.instantiate())
	weapon_slot_component.init(player_info.weapon_info,player_info.upgrades_controller)
	weapon_slot_component.attack_has_end.connect(end_attack)
	weapon_slot_component.attack_ready.connect(start_attack)
	attack_speed_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.attack_speed)
	dash_timer.timeout.connect(refresh_dash)
	add_child(dash_timer)

func set_sprite(new_sprite):
	new_sprite.scale = Vector2(0.5,0.5)
	sprite.replace_by(new_sprite)
	sprite = new_sprite
	
func _physics_process(delta: float) -> void:
	if has_die() == true:
		sprite.play("Idle")
		return
	if is_dashing == true:
		update_dash(delta)
		return 
	velocity_component.update_velocity(velocity)
	controller_component.updateControl(delta)
	velocity_component.move(self)
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
	if controller_component.has_dash() == true && can_dash():
		dash(delta)
	
	if controller_component.has_prepare_attack() == true : 
		prepare_attack()
	if controller_component.has_attack() == true:
		start_attack()

func get_current_direction() -> Vector2:
	return controller_component.get_current_direction()
	
func hurt(attack :Attack):
	SoundManager.playImpactSound()
	var direction = (global_position - attack.attack_position).normalized()
	velocity_component.accelerate_in_direction(direction * attack.knockback_force,0.1)
	for hurt_effect in hurt_effects:
		hurt_effect.trigger_effect(self,attack)

func refresh_dash() -> void:
	dash_ready=true
	
func end_dash()->void:
	velocity_component.update_velocity(Vector2.ZERO )
	is_dashing = false
	dash_timer.start(dash_cooldown)
	
func create_ghost(_delta:float) -> void:
	DashGhostHelper.create_ghost(self,sprite)

func can_dash() -> bool:
	return is_dashing == false && is_attacking == false && dash_ready == true

func update_dash(delta: float) -> void:
	if(dash_shadow_count%2==0):
		create_ghost(delta)
	dash_shadow_count+=1
	velocity_component.move(self)
	
func dash(_delta:float)->void:
	dash_shadow_count=0
	is_dashing = true
	dash_ready=false
	var direction = controller_component.get_current_direction()
	velocity_component.update_velocity(direction * 165 )
	velocity_component.move(self)
	var timer = Timer.new()
	timer.one_shot=true
	timer.timeout.connect(end_dash)
	add_child(timer)
	timer.start(0.165)


func prepare_attack():
	if has_die() != true && is_attacking == false:
		var time = weapon_slot_component.prepare_attack(attack_speed_stat.value)
		#prepareAttackUIComponent.show()
		prepare_attack_ui_component.start(time)
	
func start_attack():
	if has_die() != true && is_attacking == false:
		is_attacking = true
		weapon_slot_component.start_attack(attack_speed_stat.value)
		prepare_attack_ui_component.end()
	
func end_attack():
	prepare_attack_ui_component.end()
	is_attacking = false

func die():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"scale",Vector2(1.0,0.5),0.2).from_current()
	controller_component.disable = true
	Signals.player_died.emit()
	weapon_slot_component.unequip()

func collect(loot : Loot):
	if has_die():
		return
	SoundManager.playLootSound()
	for upgrade in loot.item.upgrades:
		upgrades_controller.add_upgrade(upgrade)
	Signals.stats_update.emit(player_info)
