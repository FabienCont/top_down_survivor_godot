extends Area2D
class_name HitboxComponent

signal hit(attack:Attack)
signal hit_terrain()
@onready var touched_ennemies= {}
@onready var attack_can_hurt : bool = true
@onready var emiter 
	
func damage(hurtboxComponent :HurtboxComponent):
	var attack = Attack.new()
	attack.attack_damage = 4.0
	attack.knockback_force = 2.0
	attack.attack_position = global_position
	apply_emiter_attack_modifier(attack)
	hurtboxComponent.damage(attack)
	hit.emit(attack)
	
func apply_emiter_attack_modifier(attack:Attack):
	if emiter && emiter.has_method("apply_attack_modifier"):
		emiter.apply_attack_modifier(attack)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index:int, _local_shape_index:int):
	if body is TileMap:
		hit_terrain.emit()
		return
	if touched_ennemies.get(body_rid) != null || attack_can_hurt == false:
		return
	
	var body_shape_owner = body.shape_find_owner(body_shape_index)
	var body_shape_node = body.shape_owner_get_owner(body_shape_owner)
	#touched_ennemies[body_rid]=true
		
	if body_shape_node is HurtboxComponent:
		damage(body_shape_node)
	elif body_shape_owner.get_collision_layer_value(1):
		hit_terrain.emit()
