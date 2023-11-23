extends Node2D
class_name WeaponSlotComponent

@export var weaponEquiped: Weapon;
@onready var parent:Node = get_parent()
var stats:StatsController
var effects:EffectsController
var weapon_info:WeaponInfo

signal attack_has_end

func init(stats_init: StatsController,weapon_info_init: WeaponInfo,effects_init:EffectsController) -> void:
	set_stats(stats_init)
	set_effects(effects_init)
	set_weapon_info(weapon_info_init)
	var new_weapon = weapon_info.scene.instantiate()
	equip(new_weapon)

func set_effects(effects_init: EffectsController)-> void:
	effects = effects_init
	
func set_stats(stats_init: StatsController)-> void:
	stats = stats_init
	
func set_weapon_info(weapon_info_init: WeaponInfo)-> void:
	weapon_info = weapon_info_init
	
func _listen_weapon_hit():
	if weaponEquiped.has_signal("hit"):
		weaponEquiped.connect("hit",_hit_someone)
	if weaponEquiped.has_signal("attack_has_end"):
		weaponEquiped.connect("attack_has_end",emit_attack_has_end)
		
func has_weapon_equiped():
	return weaponEquiped != null
	
func equip(weapon: Weapon):
	weaponEquiped = weapon
	weaponEquiped.init(stats,weapon_info,effects)
	add_child(weapon)
	_listen_weapon_hit()

func unequip():
	remove_child(weaponEquiped)
	
func start_attack():
	if has_weapon_equiped() :
		weaponEquiped.start_attack()

func end_attack():
	if has_weapon_equiped() :
		weaponEquiped.end_attack(null)

func attack_start_to_hurt():
	if has_weapon_equiped() :
		weaponEquiped.attack_start_to_hurt()

func start_recovery_attack():
	if has_weapon_equiped() :
		weaponEquiped.start_recovery_attack()
		
func _hit_someone(attack :Attack):
	if parent.has_method("hit"):
		parent.hit(attack)
		
func emit_attack_has_end():
	if parent.has_method("end_attack"):
		parent.end_attack()
