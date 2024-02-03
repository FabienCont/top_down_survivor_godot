extends TextureProgressBar

class_name PrepareAttackUIComponent2D

@export var weapon_slot_attack: WeaponSlotComponent

var time_elpased:float=0.0
var time_before_ready:float=1.0

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	if weapon_slot_attack is WeaponSlotComponent:
		weapon_slot_attack.attack_in_preparation.connect(start)
		weapon_slot_attack.attack_started.connect(end)
		weapon_slot_attack.attack_has_end.connect(end)
	
func _process(delta)-> void:
	if visible==true:
		time_elpased += delta
		value = (time_elpased/time_before_ready)*100
	
func start(time:float)-> void:
	time_elpased=0.0
	time_before_ready=time
	process_mode = Node.PROCESS_MODE_INHERIT

func end()-> void:
	value= 0.0
	process_mode = Node.PROCESS_MODE_DISABLED
	
