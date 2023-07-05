extends Node2D
class_name WeaponSlotComponent

@export var weaponEquiped: Weapon;
@export var auto_attack: bool = true;
@onready var parent:Node = get_parent()
@onready var timer : SceneTreeTimer

func _ready() -> void:
	if has_weapon_equiped() :
		_listen_weapon_hit()
		if auto_attack == true:
			start_timer_auto_attack()

func start_timer_auto_attack():
		timer=get_tree().create_timer(1.0)
		timer.connect("timeout", start_attack)

func _listen_weapon_hit():
	if weaponEquiped.has_signal("hit"):
		weaponEquiped.connect("hit",_hit_someone)
		
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
