extends Camera2D

@export var nodeToFollow :Node2D
@export var LERP_FACTOR :float = 3.0

func _process(_delta: float): 
	if nodeToFollow != null :
		global_position = global_position.lerp(nodeToFollow.global_position,_delta *LERP_FACTOR) 
