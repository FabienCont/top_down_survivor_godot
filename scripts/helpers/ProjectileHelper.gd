extends Resource
class_name ProjectileHelper

static func multiply_projectile2D(node: Node2D,copy_number: float,rotation_between_node:float) -> Node2D:
	var new_node = Node2D.new()
	new_node.top_level = true
	if copy_number == 1:
		new_node.add_child(node)
		return new_node
		
	var offset = 0
	if int(copy_number) % 2 != 0 :
		offset += rotation_between_node * 0.5
	offset -=  (copy_number/ 2)  * rotation_between_node
	for i in range(0,copy_number):
		new_node.add_child(copy_and_rotate(node,offset + (rotation_between_node * i) ))
	return new_node

static func copy_node(node):
	return node.duplicate()
	
static func rotate_node2D(node: Node2D,rotation_deg):
	var radian = deg_to_rad(rotation_deg) 
	node.global_rotation += radian
	
static func copy_and_rotate(node: Node2D,rotation_deg: float):
	var copy = copy_node(node)
	rotate_node2D(copy,rotation_deg)
	return copy
