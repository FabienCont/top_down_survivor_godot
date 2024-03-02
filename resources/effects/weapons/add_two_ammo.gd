extends EffectHandler
class_name test_moi
static func trigger_effect(_node:Node2D,_data=null) -> Variant:
	var ammo_left = _node.duplicate()
	var ammo_right = _node.duplicate()
	ammo_left.global_rotation += deg_to_rad(-15.0)
	ammo_right.global_rotation += deg_to_rad(+15.0) 
	var new_node = Node2D.new()
	new_node.top_level = true
	new_node.add_child(_node)
	new_node.add_child(ammo_left)
	new_node.add_child(ammo_right)
	return new_node
