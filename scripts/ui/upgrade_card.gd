extends BoxContainer

@onready var button: Button = $Button
@export var upgrade:Upgrade

signal select_upgrade
func _ready() -> void:
	button.text = upgrade.label
	
func _on_button_pressed() -> void:
	select_upgrade.emit(upgrade)
