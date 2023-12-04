extends Node2D
@export var ammo_info: AmmoInfo =null

@onready var timer = $Timer
var mouse_position = Vector2(15,15)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout",instantiate_projectile)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pos = get_global_mouse_position()
	if pos != null:
		mouse_position= pos
	
	
func instantiate_projectile():
	var projectile_test = ammo_info.scene.instantiate()
	add_child(projectile_test)
	projectile_test.position = mouse_position
	projectile_test.init(ammo_info)
	var sprite = projectile_test.sprite

