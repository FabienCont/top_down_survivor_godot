extends Control

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _on_visibility_changed() -> void:
	if animationPlayer != null:
		if visible == true :
			randomize_upgrade()
			animationPlayer.play("show_menu")
		else : 
			animationPlayer.play("hide_menu")


func randomize_upgrade():
	pass
