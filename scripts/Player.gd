extends Entity

class_name Player

@onready var controller_component: TopDownControllerComponent2D = $TopDownControllerComponent
@onready var interaction_component: InteractionComponent2D = $InteractionComponent
@onready var weapon_slot_component: WeaponSlotComponent = $WeaponSlotComponent
@onready var lifebar_component: LifebarComponent2D = $LifebarComponent
@onready var collector_component: CollectorComponent2D = $CollectorComponent
@onready var prepare_attack_ui_component: PrepareAttackUIComponent2D = $PrepareAttackUIComponent

@export var player_info: PlayerInfo

func init_player(player_info_init :PlayerInfo) -> void:
	init_entity(player_info_init.stats_controller,player_info_init.upgrades_controller,player_info_init.abilities_controller,player_info_init.logic_component)
	player_info = player_info_init
	player_info.stats_controller = stats_controller
	player_info.upgrades_controller = upgrades_controller
	player_info.abilities_controller = abilities_controller
	var collector_distance= stats_controller.get_current_stat(StatsConstEntity.names.collector_distance)
	collector_component.init(collector_distance)
	var max_life_stat = player_info.stats_controller.get_current_stat(StatsConstEntity.names.max_life)
	lifebar_component.init(life_stat,max_life_stat)
	set_sprite_component(player_info.character.sprite.instantiate())
	weapon_slot_component.init(player_info.weapon_info,player_info.upgrades_controller)
	Signals.player_ready.emit(self)

func _process(delta: float) -> void:
	logic_component.process_logic(delta)

func get_current_direction() -> Vector2:
	return controller_component.get_current_direction()
	
func hurt(attack :Attack):
	logic_component.hurt_logic(attack)

func die():
	logic_component.die_logic()

func collect(loot : Loot) -> void:
	logic_component.collect_logic(loot)
