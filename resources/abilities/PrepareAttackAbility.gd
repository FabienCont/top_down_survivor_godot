extends Ability

var attack_speed_stat:StatModel
var weapon_slot_component: WeaponSlotComponent
func has_requirement() -> bool:
	return possessor.stats_controller is StatsControllerEntity && possessor.weapon_slot_component is WeaponSlotComponent
	
func init_ability(owner:Entity)-> void:
	super(owner)
	attack_speed_stat = possessor.stats_controller.get_current_stat(StatsConstEntity.names.attack_speed)
	weapon_slot_component = possessor.weapon_slot_component
	weapon_slot_component.attack_ready.connect(end)

func can_be_used()-> bool:
	return possessor.has_die() != true && is_executing == false	 && not weapon_slot_component.is_attack_ready()
	
func execute(delta:float)->void:
	super(delta)
	possessor.weapon_slot_component.prepare_attack(attack_speed_stat.value)
	
func end()-> void:
	is_executing = false
	ability_finished.emit()
	ability_is_ready.emit()
