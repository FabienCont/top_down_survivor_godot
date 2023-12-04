extends Node2D

@export var player_char:Entity
@export var player_info:PlayerInfo
@onready var input_acc:SpinBox=$HBoxContainer/SpinBoxAcc
@onready var input_speed:SpinBox=$HBoxContainer/SpinBoxSpeed

var speed: StatModel
var acc: StatModel
# Called when the node enters the scene tree for the first time.
func _ready():
	player_char.init_player(player_info)
	acc = player_info.stats_controller.get_current_stat(StatsConstEntity.names.acceleration)
	speed = player_info.stats_controller.get_current_stat(StatsConstEntity.names.movement_speed)
	input_acc.value=acc.value
	input_speed.value=speed.value
	input_acc.value_changed.connect(_set_acc)
	input_speed.value_changed.connect(_set_speed)
	pass # Replace with function body.


func _set_acc(value):
	acc.value = float(value)
	
func _set_speed(value):
	speed.value = float(value)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		input_acc.release_focus()
		input_speed.release_focus()
	pass
