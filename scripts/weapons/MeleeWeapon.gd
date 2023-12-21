extends Weapon

class_name MeleeWeapon

var ammo_info :AmmoInfo
@export var hitbox_component :HitboxComponent
var is_attack_ready = false

func init(collision_layer_init:int,collision_mask_init:int,weapon_info_init: WeaponInfo,upgrades_controller_init: UpgradesController,emiter_init) -> void:
	weapon_sprite = $Sprite2D
	animation_player = $Sprite2D/AnimationPlayer
	super.init(collision_layer_init,collision_mask_init,weapon_info_init,upgrades_controller_init,emiter_init)
	if hitbox_component is HitboxComponent:
		hitbox_component.collision_layer = collision_layer
		hitbox_component.collision_mask = collision_mask

func start_attack(attack_speed_value: float):
	if is_attack_ready == false:
		end_attack(null)
		return
	animation_player.speed_scale = attack_speed_value
	attack(null)

func prepare_attack(attack_speed_value: float) -> float:
	animation_player.speed_scale = attack_speed_value
	animation_player.play("PrepareAttack")
	if not animation_player.animation_finished.is_connected(finish_attack_prepare):
		animation_player.animation_finished.connect(finish_attack_prepare)
	return animation_player.current_animation_length / animation_player.speed_scale

func finish_attack_prepare(_arg):
	is_attack_ready = true
	attack_ready.emit()
	if animation_player.animation_finished.is_connected(finish_attack_prepare):
		animation_player.animation_finished.disconnect(finish_attack_prepare)
	
func attack(_ar):
	if animation_player.animation_finished.is_connected(attack):
		animation_player.animation_finished.disconnect(attack)
	if not animation_player.animation_finished.is_connected(end_attack):
		animation_player.animation_finished.connect(end_attack)
	animation_player.play("Attack")
	SoundManager.playFireArrowSound()
	
func end_attack(_arg):
	super(_arg)
	if hitbox_component is HitboxComponent:
		weapon_sprite.modulate.a = 0.0
		weapon_sprite.scale = Vector2.ZERO
		hitbox_component.monitorable = false
		hitbox_component.monitoring = false

func idle(_arg):
	is_attack_ready = false
	animation_player.play("Idle")
