extends TextureProgressBar


var time_elpased:float=0.0
var time_before_ready:float=1.0

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	
func _process(delta)-> void:
	if visible==true:
		time_elpased += delta
		value = (time_elpased/time_before_ready)*100
	
func start(time:float)-> void:
	time_elpased=0.0
	time_before_ready=time
	process_mode = Node.PROCESS_MODE_INHERIT

func end()-> void:
	value= 0.0
	process_mode = Node.PROCESS_MODE_DISABLED
	
