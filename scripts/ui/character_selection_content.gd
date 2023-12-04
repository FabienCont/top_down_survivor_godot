extends Control

@onready var player_info: PlayerInfo
@onready var buttonCancel: Button = $VBoxContainer/HBoxContainer3/ButtonCancel
@onready var buttonValidate: Button = $VBoxContainer/HBoxContainer3/ButtonValidate
@onready var characters_container: Control = $VBoxContainer/CharacterContainer
@onready var characters_button_group = ButtonGroup.new()

func _ready():
	player_info = PlayerInfo.new()
	var characters_cards = characters_container.get_children()
	characters_cards[0].grab_focus()
	for container in characters_cards as Array[Button]:
		container.button.button_group = characters_button_group
		container.connect("select_character",_select_character)

func _select_character(character_selected:Character) -> void:
	player_info.character = character_selected
	GlobalInfo.player_info = player_info
	_update_validate_button_status()

func _update_validate_button_status() -> void:
	if player_info.character != null:
		buttonValidate.disabled = false
