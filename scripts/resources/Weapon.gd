extends Node2D
class_name Weapon

@export var collider: CollisionShape2D 
@onready var touched_ennemies= {}
@onready var attack_can_hurt : bool = false

signal attack_has_end
signal hit(attack:Attack)

func start_attack():
	pass

func attack_start_to_hurt():
	pass

func start_recovery_attack():
	pass
	
func end_attack():
	attack_has_end.emit()
	pass
	
func damage(_hurtboxComponent :HurtboxComponent):
	pass	
