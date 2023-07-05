extends Area2D
class_name InteractionComponent

signal new_element_interact(body_shape_node: HurtboxComponent)

@onready var collide_bodies= {}

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index:int, _local_shape_index:int):
	if collide_bodies.get(body_rid) != null :
		return
	var body_shape_owner = body.shape_find_owner(body_shape_index)
	var body_shape_node = body.shape_owner_get_owner(body_shape_owner)
	collide_bodies[body_rid] = body
	new_element_interact.emit(body_shape_node)

func find_closest_body():
	var min_distance = 1000000000
	var closest_body = null
	var body_rid_to_remove = []
	for body_rid in collide_bodies :
		var body = collide_bodies[body_rid]
		if body != null:
			var distance = body.global_position.distance_to(global_position) 
			if min_distance > distance :
				min_distance = distance
				closest_body = body
		else :
			body_rid_to_remove.push_back(body_rid)
			
	for body_rid in body_rid_to_remove:
		collide_bodies.erase(body_rid)
	
	return closest_body
