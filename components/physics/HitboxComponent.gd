extends Area2D
class_name HitboxComponent

signal hit(attack:Attack)

@onready var touched_ennemies= {}
@onready var attack_can_hurt : bool = true
@onready var player_info : PlayerInfo

func _ready():
	if get_parent().get("player_info") != null:
		player_info = get_parent().get("player_info")
		
func damage(hurtboxComponent :HurtboxComponent):
	var attack = Attack.new()
	attack.attack_damage = 4
	attack.knockback_force = 2
	attack.attack_position = global_position
	if player_info!=null:
		attack.attack_damage =  attack.attack_damage #+ player_info.stats_.attack.DAMAGE +
	
	hurtboxComponent.damage(attack)
	hit.emit(attack)
	
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index:int, _local_shape_index:int):
	if touched_ennemies.get(body_rid) != null || attack_can_hurt == false:
		return
	var body_shape_owner = body.shape_find_owner(body_shape_index)
	var body_shape_node = body.shape_owner_get_owner(body_shape_owner)
	#touched_ennemies[body_rid]=true
	if body_shape_node is HurtboxComponent:
		damage(body_shape_node)
