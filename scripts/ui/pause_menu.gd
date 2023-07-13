extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var player: Player

@export var buttons: Array[Node]

func _ready() -> void :
	for button in buttons:
		button.connect("select_upgrade",finish_level_up)
	
func _on_visibility_changed() -> void:
	if animationPlayer != null:
		if visible == true :
			randomize_upgrade()
			animationPlayer.play("show_menu")
		else : 
			animationPlayer.play("hide_menu")

func randomize_upgrade():
	pass

func finish_level_up(upgrade: Upgrade):
	print("test")
	Signals.upgrade_selected.emit(player,upgrade)
