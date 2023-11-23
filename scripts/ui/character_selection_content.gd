extends Control

@onready var player: Player
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var characters_container: Control = $VBoxContainer/CharacterContainer
@onready var characters_button_group = ButtonGroup.new()

func _ready():
	player = Player.new()
	for container in characters_container.get_children() as Array[Button]:
		container.button.button_group = characters_button_group
		container.connect("select_character",_select_character)

func _select_character(character_selected:Character) -> void:
	player.character = character_selected
	GlobalInfo.player = player
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player.character != null:
		buttonValidate.disabled = false
