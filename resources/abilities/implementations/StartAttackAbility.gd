extends Ability

var attack_speed_stat:StatModel
var weapon_slot_component:WeaponSlotComponent

func has_requirement() -> bool:
	return entity.stats_controller is StatsController && entity.weapon_slot_component is WeaponSlotComponent
	
func init_ability(entity_init:Entity)-> void:
	super(entity_init)
	attack_speed_stat = entity.stats_controller.get_current_stat(StatsConstEntity.names.attack_speed)
	weapon_slot_component = entity.weapon_slot_component
	weapon_slot_component.attack_has_end.connect(end)

func can_be_used()-> bool:
	return entity.has_die() != true && is_executing == false	&& weapon_slot_component.is_attack_ready()
	
func execute(delta:float)->void:
	super(delta)
	weapon_slot_component.start_attack(attack_speed_stat.value)
