extends Resource

class_name EntityLogicInterface

var entity: Entity

func init_logic_component(entity_init):
	entity = entity_init
	
func process_logic(_delta:float) -> void:
	return

func die_logic () -> void:
	return

func hurt_logic(_attack: AttackInterface) -> void:
	return

func collect(_loot : Loot) -> void:
	return
