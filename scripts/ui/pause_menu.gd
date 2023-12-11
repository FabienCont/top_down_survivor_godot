extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var player: Player

@export var buttons: Array[Node]

func _on_visibility_changed() -> void:
	if animationPlayer != null:
		if visible == true :
			if buttons.size() > 0 :
				buttons[0].grab_focus()
			animationPlayer.play("show_menu")
			if not Engine.is_editor_hint():
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else :
			animationPlayer.play("hide_menu")
			if not Engine.is_editor_hint(): 
				Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
			
