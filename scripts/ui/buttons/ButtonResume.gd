extends Button

func _on_pressed() -> void:
	Signals.end_pause_menu.emit()
