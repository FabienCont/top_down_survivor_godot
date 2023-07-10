extends BoxContainer

@onready var button: Button = $Button
@export var upgrade = Upgrade

func _ready() -> void:
	button.text = upgrade.get_label()

func _on_button_pressed() -> void:
	Signals.upgrade_selected.emit(upgrade)
