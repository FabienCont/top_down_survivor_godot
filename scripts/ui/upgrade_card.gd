extends BoxContainer

@onready var button: Button = $Button
@export var upgrade:Upgrade:
	set(value):
		upgrade= value
		update_upgrade()

signal select_upgrade(upgrade :Upgrade)
func _ready() -> void:
	update_upgrade()
	
func _on_button_pressed() -> void:
	select_upgrade.emit(upgrade)

func update_upgrade():
	if button != null:
		button.text = upgrade.label
