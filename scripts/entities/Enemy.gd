extends Entity

class_name Enemy

@export var target :Node2D  
@onready var followTargetComponent: FollowTargetComponent2D = $FollowTargetComponent
@onready var hitbox_component: HitboxComponent2D = $HitboxComponent
@onready var weapon_slot_component: WeaponSlotComponent =$WeaponSlotComponent
@onready var weapon_info # = preload("res://resources/weapon/BatWeaponInfo.tres")

@export var enemy_info: EnemyInfo

func _ready() -> void: 
	if enemy_info :
		prepare_enemy()
	
func prepare_enemy() -> void :
	init_entity(enemy_info.stats_controller,enemy_info.upgrades_controller,enemy_info.abilities_controller,enemy_info.logic_component)
	enemy_info.stats_controller = stats_controller
	enemy_info.upgrades_controller = upgrades_controller
	enemy_info.abilities_controller = abilities_controller
	logic_component = enemy_info.logic_component
	weapon_info = enemy_info.weapon_info
	if target != null :
		followTargetComponent.set_node_to_follow(target)
	weapon_slot_component.init(weapon_info.duplicate(true),upgrades_controller)
	set_sprite_component(enemy_info.sprite.instantiate() as AnimatedSprite2D)

func init_enemy(enemy_info_init) -> void:
	enemy_info = enemy_info_init
	if is_node_ready():
		prepare_enemy()
	
func _process(delta: float) -> void :
	logic_component.process_logic(delta)
	return
	
func hurt(attack :AttackInterface) -> void:
	logic_component.hurt_logic(attack)

func die() -> void:
	logic_component.die_logic()

func get_current_direction() -> Vector2:
	return followTargetComponent.get_current_direction() 
