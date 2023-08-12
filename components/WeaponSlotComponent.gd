extends Node2D
class_name WeaponSlotComponent

@export var weaponEquiped: Weapon;
@onready var parent:Node = get_parent()
var player:Player

signal attack_has_end

func init(playerInit: Player) -> void:
	if has_weapon_equiped() :
		set_player(playerInit)
		_listen_weapon_hit()
		
func set_player(playerInit: Player)-> void:
	player = playerInit
	weaponEquiped.player = playerInit
		
func _listen_weapon_hit():
	if weaponEquiped.has_signal("hit"):
		weaponEquiped.connect("hit",_hit_someone)
	if weaponEquiped.has_signal("attack_has_end"):
		weaponEquiped.connect("attack_has_end",emit_attack_has_end)
		
func has_weapon_equiped():
	return weaponEquiped != null
	
func equip(weapon: Weapon):
	weaponEquiped = weapon
	add_child(weapon)
	_listen_weapon_hit()

func unequip():
	remove_child(weaponEquiped)
	
func start_attack():
	if has_weapon_equiped() :
		weaponEquiped.start_attack()

func end_attack():
	if has_weapon_equiped() :
		weaponEquiped.end_attack()


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
