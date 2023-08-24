extends Camera2D

@export var LERP_FACTOR :float = 3.0
@export var shaekableArea: Area2D
@export var node_to_follow: Node2D

func _process(delta: float): 
	follow_node(delta)
	
func follow_node(delta: float):
	if node_to_follow != null :
		global_position = global_position.lerp(node_to_follow.global_position,delta *LERP_FACTOR) 


func add_trauma(trauma_amount: float):
	if shaekableArea.has_method("add_trauma"):
		shaekableArea.add_trauma(trauma_amount)

