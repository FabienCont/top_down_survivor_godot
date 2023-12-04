class_name DashGhostHelper

static func create_ghost(node:Node,sprite:AnimatedSprite2D):
	var tween := node.create_tween()
	var new_sprite:AnimatedSprite2D = sprite.duplicate()
	new_sprite.global_position = node.global_position
	new_sprite.top_level= true
	new_sprite.modulate.a = 0.5 
	new_sprite.z_index =-1
	#var material = ShaderMaterial.new()
	#material.shader = load("res://shaders/GreyFilter.tres")
	#new_sprite.material =material
	tween.tween_property(new_sprite,"modulate:a",0.0,0.5)
	tween.finished.connect(DashGhostHelper.remove_ghost.bind(node,new_sprite))
	node.add_child(new_sprite)
	tween.play()

static func remove_ghost(_node:Node,_sprite:AnimatedSprite2D):
	pass
	#sprite.queue_free()
