extends Camera2D

@export var nodeToFollow :Node2D
@export var LERP_FACTOR :float = 3.0

func _ready() -> void:
	global_position = nodeToFollow.global_position
	
func _process(delta: float): 
	follow_node(delta)
	
func follow_node(delta: float):
	if nodeToFollow != null :
		global_position = global_position.lerp(nodeToFollow.global_position,delta *LERP_FACTOR) 
