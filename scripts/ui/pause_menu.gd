extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var player: Player

@export var buttons: Array[Node]

func _on_visibility_changed() -> void:
	if animationPlayer != null:
		if visible == true :
			buttons[0].grab_focus()
			animationPlayer.play("show_menu")
		else : 
			animationPlayer.play("hide_menu")
