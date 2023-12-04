extends Node2D
class_name WeaponSlotComponent

@export var weapon_equiped: Weapon;
var stats_controller:StatsControllerWeapon
var upgrades_controller:UpgradesController
var weapon_info:WeaponInfo

signal attack_has_end()
signal attack_ready()
signal hit(attack :Attack)

func init(weapon_info_init: WeaponInfo,upgrades_controller_init:UpgradesController) -> void:
	set_stats(weapon_info_init.stats_controller)
	set_upgrades_controller(upgrades_controller_init)
	set_weapon_info(weapon_info_init)
	var new_weapon = weapon_info.scene.instantiate()
	equip(new_weapon)

func set_upgrades_controller(upgrades_controller_init: UpgradesController)-> void:
	upgrades_controller = upgrades_controller_init
	
func set_stats(stats_controller_init: StatsControllerWeapon)-> void:
	stats_controller = stats_controller_init
	
func set_weapon_info(weapon_info_init: WeaponInfo)-> void:
	weapon_info = weapon_info_init
	
func _listen_weapon_hit()-> void:
	if weapon_equiped.has_signal("hit"):
		weapon_equiped.connect("hit",_hit_someone)
	if weapon_equiped.has_signal("attack_has_end"):
		weapon_equiped.connect("attack_has_end",emit_attack_has_end)
	if weapon_equiped.has_signal("attack_ready"):
		weapon_equiped.connect("attack_ready",emit_attack_ready)
		
func has_weapon_equiped()-> bool:
	return weapon_equiped != null
	
func equip(weapon: Weapon)-> void:
	weapon_equiped = weapon
	weapon_equiped.init(weapon_info,upgrades_controller)
	add_child(weapon)
	_listen_weapon_hit()

func unequip()-> void:
	remove_child(weapon_equiped)

func prepare_attack(attack_speed_value: float)->float:
	if has_weapon_equiped() :
		return weapon_equiped.prepare_attack(attack_speed_value)
	return 0.0
	
func start_attack(attack_speed_value: float)->void:
	if has_weapon_equiped() :
		weapon_equiped.start_attack(attack_speed_value)

func end_attack()-> void:
	if has_weapon_equiped():
		weapon_equiped.end_attack(null)

func attack_start_to_hurt()-> void:
	if has_weapon_equiped() :
		weapon_equiped.attack_start_to_hurt()

func start_recovery_attack()-> void:
	if has_weapon_equiped() :
		weapon_equiped.start_recovery_attack()
		
func _hit_someone(attack :Attack)-> void:
	hit.emit(attack)
	
func emit_attack_has_end()-> void:
	attack_has_end.emit()
	
func emit_attack_ready()-> void:
	attack_ready.emit()
