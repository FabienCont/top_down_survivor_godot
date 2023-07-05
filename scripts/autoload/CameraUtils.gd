extends Node

func shake_camera(node :Node, trauma_power:float):
	var camera := node.get_viewport().get_camera_2d()
	if camera is Camera2D && camera.has_method("add_trauma"):
		camera.add_trauma(trauma_power)
