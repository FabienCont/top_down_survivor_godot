extends Node2D

@export var effects: Array[Resource]

@onready var timer = $Timer
var mouse_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",_trigger_effect)
	pass # Replace with function body.


func _trigger_effect():
	for effect in effects:
		effect.trigger_effect(self)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_mouse_position()
	if pos != null:
		mouse_position = pos 
		position=mouse_position
	pass
